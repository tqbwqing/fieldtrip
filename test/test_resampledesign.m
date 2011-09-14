% TEST test_resampledesign resampledesign


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check that there are fac(N) permutations

for ntrial=1:10
  clear design
  design(1,:) = ones(1,ntrial);
  design(2,:) = 1:ntrial;
  
  cfg = [];
  cfg.ivar = 1;
  cfg.resampling = 'permutation';
  cfg.numrandomization = 'all';
  res = resampledesign(cfg, design);
  
  if size(res,1)~=max(cumprod(1:size(design,2)))
    error('incorrect number of permutations')
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the following is for Irina, who has a blocked fMRI experiment and wants
% to randomize the two conditions over the blocks, keeping the trials
% within a block together

clear design
design = [
  1 1 2 2 1 1 2 2 % condition number
  1 1 2 2 3 3 4 4 % block number
  ];

cfg = [];
cfg.ivar = 1; % condition number
cfg.wvar = 2;
cfg.resampling = 'permutation';
cfg.numrandomization = 'all';
res = resampledesign(cfg, design);

if any((res(:,2:2:end) - res(:,1:2:end)) ~= 1)
  error('trials within a block were not kept together');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear design
design = [
  1 1 2 2
  1 2 3 4 % block number
  ];

cfg = [];
cfg.ivar = 1; % condition number
cfg.wvar = 2;
cfg.resampling = 'permutation';
cfg.numrandomization = 'all';
res = resampledesign(cfg, design);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


design = [
  1 2 1 2 1 2 1 2 
  1 2 3 4 5 6 7 8
  ];
cfg = [];
cfg.ivar = 1;
cfg.wvar = 2;
cfg.numrandomization = 'all';
cfg.resampling = 'permutation';
res = resampledesign(cfg, design);


