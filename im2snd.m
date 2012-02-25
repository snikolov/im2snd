img = imread('tiling2.gif');
if numel(size(img)) == 3
  img = rgb2gray(img);
end
img = 255*double(img > 50);
img = img(1:100,1:100);
img = conv2(img, ones(25,25));
%img = imresize(img, 0.2);
nSamples = 50000;
snd = zeros(1,nSamples);
r = 10;
c = 10;
w = 300;
rh = ones(w,1);
ch = ones(w,1);
PLOT = 0;
if PLOT
  figure
end
for n = 1:nSamples
  randc = randi([0,2]) - 1;
  randr = randi([0,2]) - 1;
  rh = [rh; round((round(mean(rh)) + randr)/2)];
  ch = [ch; round((round(mean(ch)) + randc)/2)];
  rh = rh(2:w);
  ch = ch(2:w);
  snd(n) = .0001*img(r,c);
  r = mod(r - 1 + round((round(mean(rh)) + randr)/2), size(img,1)) + 1;
  c = mod(c - 1 + round((round(mean(ch)) + randc)/2), size(img,2)) + 1;
  if PLOT
    img(r,c) = 0;
    imagesc(img);
    drawnow
    %pause(0.001);
  end
end
snd = resample(double(img(:,100)),100,1);
wavwrite(snd, 4000, 8, 'test.wav')
system('mv test.wav ~/Public/test.wav')

% Intersting params
% Random walk: 
% * [Fs = 600], [Fs = 150]
% Resampling
% * resample(double(img(:,100)),100,1);, Fs = 600, N = 16
  
