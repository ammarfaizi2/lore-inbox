Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTD3ArN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTD3ArM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:47:12 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:17882 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261232AbTD3ArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:47:09 -0400
Date: Tue, 29 Apr 2003 20:59:02 -0400
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
Message-ID: <20030430005902.GA32599@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A run with deadline on mm would be nice to see. 

Summary:
Most benchmarks don't show much difference between 2.5.68-mm2 using
anticipatory vs deadline scheduler.  AIM7 had almost no difference.  
Tiobench has the most difference.

Quad P3 Xeon
RAID 0 LUN
All of these are ext2 filesystem
3.75 GB ram.

tiobench-0.3.3
Unit information
================
File size = 8192 megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

2.5.68 is here because both i/o schedulers in -mm2 did better at
random writes on ext2.

2.5.68-mm2-dl = deadline elevator.

For tiobench sequential reads on ext2, 2.5.68-mm2 with deadline has higher 
throughput and lower latency.  Note the kernels that use the most cpu time
have the best performance.

                Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel          Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
--------------- ---  ------------------------------------------------------------
2.5.68-mm2-dl     1   28.85 13.76%     0.403      635.44  0.00000  0.00000    210
2.5.68            1   28.77 13.23%     0.405      592.14  0.00000  0.00000    217
2.5.68-mm2        1   28.77 13.80%     0.404      659.18  0.00000  0.00000    208

2.5.68-mm2-dl     8   42.36 22.27%     2.147     1249.47  0.00000  0.00000    190
2.5.68            8   36.65 18.04%     2.542      945.37  0.00000  0.00000    203
2.5.68-mm2        8   23.96 11.15%     3.810     1219.85  0.00000  0.00000    215

2.5.68-mm2-dl    16   39.36 20.66%     4.534     1105.91  0.00000  0.00000    190
2.5.68           16   30.56 14.94%     6.080     1224.19  0.00000  0.00000    204
2.5.68-mm2       16   20.19  9.39%     8.953     2456.76  0.00000  0.00000    215

2.5.68-mm2-dl    32   36.47 18.93%     9.741     1412.80  0.00000  0.00000    193
2.5.68           32   27.74 13.84%    13.376     1498.48  0.00000  0.00000    200
2.5.68-mm2       32   20.15  9.50%    16.728     4424.53  0.00000  0.00000    212

2.5.68-mm2-dl    64   38.40 20.35%    17.873     4122.37  0.00000  0.00000    189
2.5.68           64   28.47 14.54%    25.294     6204.46  0.00005  0.00000    196
2.5.68-mm2       64   19.54  9.40%    32.600    12986.20  0.04410  0.00000    208

2.5.68-mm2-dl   128   39.11 20.61%    32.887    11232.22  0.02675  0.00000    190
2.5.68          128   29.87 14.99%    41.715    17752.22  0.10242  0.00000    199
2.5.68-mm2      128   19.28  9.21%    63.638    57459.95  1.27239  0.01006    209

2.5.68-mm2-dl   256   40.42 21.18%    58.473    36299.72  1.36814  0.00029    191
2.5.68          256   34.10 16.88%    64.697    51122.80  1.16358  0.01163    202
2.5.68-mm2      256   18.84  8.96%   125.350   164470.88  1.43795  0.14148    210


tiobench random reads on ext2 also has higher throughput and lower latency with
deadline.  Higher cpu utilization appears in the better performing kernels.

                Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel          Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
--------------- ---  ------------------------------------------------------------
2.5.68-mm2-dl     1    1.00  0.94%    11.687      108.48  0.00000  0.00000    107
2.5.68-mm2        1    0.95  0.88%    12.383      121.84  0.00000  0.00000    108
2.5.68            1    0.84  0.75%    14.003      120.98  0.00000  0.00000    111

2.5.68-mm2-dl     8    5.55  4.97%    16.053      122.95  0.00000  0.00000    112
2.5.68            8    4.56  4.29%    19.193      122.64  0.00000  0.00000    106
2.5.68-mm2        8    0.96  0.85%    95.108      715.00  0.00000  0.00000    113

2.5.68-mm2-dl    16    6.56  6.94%    25.925      228.94  0.00000  0.00000     95
2.5.68           16    4.34  3.95%    40.724      212.21  0.00000  0.00000    110
2.5.68-mm2       16    0.99  0.80%   178.652     1203.69  0.00000  0.00000    123

2.5.68-mm2-dl    32    5.65  5.78%    60.735      355.96  0.00000  0.00000     98
2.5.68           32    3.28  3.40%    98.453      335.85  0.00000  0.00000     96
2.5.68-mm2       32    0.94  0.76%   357.853     2151.68  0.00000  0.00000    124

2.5.68-mm2-dl    64    5.94  5.69%   108.393      553.00  0.00000  0.00000    104
2.5.68           64    4.20  3.87%   137.963      647.04  0.00000  0.00000    108
2.5.68-mm2       64    0.91  0.79%   677.313     3973.72  0.00000  0.00000    115

2.5.68-mm2-dl   128    7.13  7.08%   163.155     1793.65  0.00000  0.00000    101
2.5.68          128    4.18  4.03%   245.390     1693.66  0.00000  0.00000    104
2.5.68-mm2      128    0.90  0.76%  1275.112     7329.02 11.84476  0.00000    119

2.5.68-mm2-dl   256    7.33  7.18%   249.025     4519.38  0.00000  0.00000    102
2.5.68          256    4.96  4.47%   285.231     6121.11  0.78125  0.00000    111
2.5.68-mm2      256    0.86  0.86%  2160.203    40955.72 32.13542  3.67187     99


For tiobench random writes on ext2, something in -mm2 gives both elevators an edge 
over 2.5.68.  Possibly from CONFIG_SCSI_QLOGIC_ISP_NEW=y.

                Num                    Avg       Maximum     Lat%     Lat%    CPU
Kernel          Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
--------------- ---  ------------------------------------------------------------
2.5.68-mm2-dl     1    4.54  3.73%     0.076       20.17  0.00000  0.00000    122
2.5.68-mm2        1    4.48  3.94%     0.077       22.02  0.00000  0.00000    114
2.5.68            1    2.86  2.73%     1.059       60.94  0.00000  0.00000    105

2.5.68-mm2-dl     8    4.55  6.24%     0.800      186.48  0.00000  0.00000     73
2.5.68-mm2        8    4.09  3.91%     1.984      488.24  0.00000  0.00000    104
2.5.68            8    3.73  4.39%     1.176       81.25  0.00000  0.00000     85

2.5.68-mm2-dl    16    4.49  6.12%     2.378      241.77  0.00000  0.00000     73
2.5.68-mm2       16    4.00  4.45%     3.510      969.07  0.00000  0.00000     90
2.5.68           16    3.69  4.21%     1.872      189.26  0.00000  0.00000     88

2.5.68-mm2-dl    32    4.41  6.50%     1.871      324.33  0.00000  0.00000     68
2.5.68-mm2       32    4.03  5.62%     4.660     1455.09  0.00000  0.00000     72
2.5.68           32    3.71  4.89%     2.102      352.52  0.00000  0.00000     76

2.5.68-mm2-dl    64    4.44  7.49%     1.768      235.32  0.00000  0.00000     59
2.5.68-mm2       64    4.26  7.39%     2.334     1483.77  0.00000  0.00000     58
2.5.68           64    3.71  5.68%     2.266      701.86  0.00000  0.00000     65

2.5.68-mm2-dl   128    4.42  8.27%     1.640     1477.07  0.00000  0.00000     53
2.5.68-mm2      128    4.35  8.14%     0.853      275.49  0.00000  0.00000     53
2.5.68          128    3.79  6.87%     1.343     1042.66  0.00000  0.00000     55

2.5.68-mm2-dl   256    4.37  8.75%     0.689     1039.17  0.00000  0.00000     50
2.5.68-mm2      256    4.36  8.87%     2.487     3519.76  0.00000  0.00000     49
2.5.68          256    3.79  6.70%     0.304       79.07  0.00000  0.00000     57


Anticipatory scheduler had more throughtput on dbench 192 on ext2.  

dbench 192 processes		Average		High		Low
2.5.68-mm2               	203.79		215.85		192.65 MB/sec
2.5.68-mm2-dl            	198.72		212.53		182.85 MB/sec



bonnie++-1.02a on ext2, 8 1024 MB files.  The new qlogic driver may be the
difference between -mm and 2.5.68.

                 --------------------- Sequential Output ------------------   
                 ---- Per Char -----  ------ Block -----  ---- Rewrite ----   
Kernel           MB/sec   %CPU   Eff  MB/sec   %CPU  Eff  MB/sec  %CPU  Eff   
2.5.68-mm2         9.42   99.0  9.51   71.61   57.0  126   17.52  19.0   92   
2.5.68-mm2-dl      9.37   99.0  9.47   71.79   57.0  126   17.00  18.0   94   
2.5.68             9.50   99.0  9.60   68.62   53.3  129   15.92  17.0   94   


deadline elevator does much better on bonnie++ random seek test.

                  -------- Sequential Input ----------   ----- Random -----
                  ---- Per Char ---  ----- Block -----   ----- Seeks  -----
Kernel            MB/sec  %CPU  Eff  MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.5.68              9.38  99.0  9.5   26.98  19.3  140   502.5  3.00  16750
2.5.68-mm2          9.28  98.0  9.5   27.29  20.0  136   203.9  1.00  20393
2.5.68-mm2-dl       9.34  98.0  9.5   27.62  20.0  138   553.1  3.67  15084


Not much difference on the bonnie++ small files tests.

                        ---------Sequential ------------------
                        ----- Create -----    ---- Delete ---- 
                 files   /sec  %CPU    Eff    /sec  %CPU   Eff 
2.5.68           65536    151  99.0    153   61933  99.3  6234 
2.5.68-mm2       65536    155  99.0    156   60020  99.0  6062 
2.5.68-mm2-dl    65536    147  99.0    148   61431  99.7  6163 


                    -------------------Random -----------
                    ----- Create ----    ---- Delete ----
                     /sec  %CPU   Eff    /sec  %CPU   Eff
2.5.68                155 100.0   155     536 100.0   536
2.5.68-mm2            152  99.0   153     525  99.0   530
2.5.68-mm2-dl         151  99.0   153     518  99.0   523

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

