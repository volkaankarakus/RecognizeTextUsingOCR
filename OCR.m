%% Read Image
image=imread('example.jpg');
figure(1)
imshow(image);
t=title('\color(red)Original Image','fontweight','bold','fontsize',16);
pause(2);

%% Convert to Gray Scale
if size(image,3)==3 % RGB Image
	image=rgb2gray(image);
end
figure(2)
imshow(image);
t=title('\color(red)Gray Scale Image','fontweight','bold','fontsize',16);
pause(2);

%% Blurring for Noise Reduction 
image=medfilt2(image,[2,2]);
figure(3)
imshow(image);
t=title('\color(red)Blurred Image','fontweight','bold','fontsize',16);
pause(2);

%% Histogram Equalization
image=imadjust(image);
figure(4)
imshow(image);
t=title('\color(red)Histogram Equalized Image','fontweight','bold','fontsize',16);
pause(2);

%% Applying Otsu's Threshold Method
[counts,x]=imhist(image,16);
stem(x,counts)
T=otsuthresh(counts);
BW=imbinarize(image,T);
figure(5)
imshow(BW);
t=title('\color(red)Applied Otsu Threshold Image','fontweight','bold','fontsize',16);
pause(2);

%% Matching the Location of Any Letter
results=ocr(BW,'TextLayout','Block');
regularExpr='\w';

% Get Bounding boxes around text that matches the regular expression
bboxes=locateText(results,regularExpr,'UseRegexp',true);
digits=regexp(results.Text,regularExpr,'match');

% Draw boxes around digits
Idigits=insertObjectAnnotation(image,'rectangle',bboxes,digits);
figure(6)
imshow(Idigits);
t=title('\color(yellow)Captured Letters','fontweight','bold','fontsize',16);

%% Writing to Text
word=[];
a=cell2mat(results.Words);
word=[a];
fid=fopen('text.txt','wt');
fprintf(fid,'%s\n',word);
fclose(fid);
winopen('text.txt');
