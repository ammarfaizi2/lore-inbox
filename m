Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265474AbSJSCIs>; Fri, 18 Oct 2002 22:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265476AbSJSCIr>; Fri, 18 Oct 2002 22:08:47 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:4520 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265474AbSJSCIJ>; Fri, 18 Oct 2002 22:08:09 -0400
Date: Fri, 18 Oct 2002 22:17:38 -0400
To: praka@san.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Message-ID: <20021019021738.GA31909@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> short introduction, Andrew Vasquez, Linux driver development at
> QLogic.

I'd like to see the QLogic 6.x driver in the Linus and Marcelo
trees.  In the tests I've run, it has better throughput and
lower latency than the standard driver.  The improvement
on journaled filesystems and synchronous I/O is where the 6.x
driver shines.

How about the latest final 6.x driver for 2.4.21-pre,
and the 6.x beta driver for 2.5.x? :)

For people who like numbers...

tiobench-0.3.3 is a multithreaded I/O benchmark.

Unit information
================
File size = 12888 megabytes
Blk Size  = 4096 bytes
Num Thr   = number of threads
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load


2.4.19-pre10-aa4 has QLogic 6.x driver
2.4.19-pre10-aa4-oql has old (standard) QLogic driver.

Ext3 fs has dramatic improvements in throughput and generally
much lower average and maximum latency with the QLogic 6.x driver.

Sequential Reads ext3
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1   50.34 28.23%    0.230     159.48  0.00000  0.00000  178
2.4.19-pre10-aa4-oql   1   49.26 28.80%    0.235     305.75  0.00000  0.00000  171

2.4.19-pre10-aa4      32    7.24  4.34%   50.964   10279.10  1.72278  0.00000  167
2.4.19-pre10-aa4-oql  32    5.00  2.90%   73.941   16359.07  1.99270  0.00000  173

2.4.19-pre10-aa4      64    7.13  4.32%  102.581   21062.55  2.13490  0.00000  165
2.4.19-pre10-aa4-oql  64    4.79  2.78%  152.879   32394.43  2.12285  0.00318  172

2.4.19-pre10-aa4     128    6.92  4.20%  209.363   41943.96  2.22813  1.24283  165
2.4.19-pre10-aa4-oql 128    4.56  2.68%  317.688   66597.95  2.25661  1.98520  170

2.4.19-pre10-aa4     256    6.82  4.09%  418.905   87535.80  2.27172  2.11080  167
2.4.19-pre10-aa4-oql 256    4.43  2.62%  645.476  133976.17  2.30475  2.13893  169


Random Reads ext3
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1    0.64  0.73%   18.338     111.72  0.00000  0.00000   87
2.4.19-pre10-aa4-oql   1    0.63  0.64%   18.482      99.78  0.00000  0.00000  100

2.4.19-pre10-aa4      32    2.38  2.58%  122.580   14073.47  0.65000  0.00000   92
2.4.19-pre10-aa4-oql  32    1.60  1.64%  179.073   19904.25  0.75000  0.00000   98

2.4.19-pre10-aa4      64    2.36  3.05%  202.490   15891.16  3.04939  0.00000   78
2.4.19-pre10-aa4-oql  64    1.60  2.00%  292.337   25545.70  3.20061  0.00000   80

2.4.19-pre10-aa4     128    2.38  2.72%  355.104   17775.10  6.07358  0.00000   88
2.4.19-pre10-aa4-oql 128    1.56  2.25%  536.262   27685.78  6.95565  0.00000   69

2.4.19-pre10-aa4     256    2.39  3.66%  667.890   18035.51 13.02083  0.00000   65
2.4.19-pre10-aa4-oql 256    1.59  2.19%  995.664   27016.55 15.13020  0.00000   73


Sequential Writes ext3
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1   44.19 56.57%    0.243    5740.37  0.00003  0.00000   78
2.4.19-pre10-aa4-oql   1   36.93 47.25%    0.291    6984.53  0.00010  0.00000   78

2.4.19-pre10-aa4      32   20.07 130.9%    8.552   11636.29  0.04701  0.00000   15
2.4.19-pre10-aa4-oql  32   18.21 120.4%   10.188   14347.38  0.09546  0.00000   15

2.4.19-pre10-aa4      64   17.02 115.5%   19.166   37065.25  0.30819  0.00019   15
2.4.19-pre10-aa4-oql  64   14.64 102.4%   21.978   28398.20  0.42292  0.00000   14

2.4.19-pre10-aa4     128   14.50 100.8%   44.053   51945.59  0.87108  0.00175   14
2.4.19-pre10-aa4-oql 128   11.34 86.43%   54.214   48119.96  1.15720  0.00410   13

2.4.19-pre10-aa4     256   11.70 78.84%  104.914   54905.07  2.27391  0.02009   15
2.4.19-pre10-aa4-oql 256    9.13 60.18%  131.867   60897.68  2.84818  0.03341   15


Random Writes ext3
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1    4.42  4.14%    0.086       1.57  0.00000  0.00000  107
2.4.19-pre10-aa4-oql   1    3.54  3.17%    0.086       1.17  0.00000  0.00000  112

2.4.19-pre10-aa4      32    4.24 11.74%    0.280      13.71  0.00000  0.00000   36
2.4.19-pre10-aa4-oql  32    3.47  9.46%    0.294      69.40  0.00000  0.00000   37

2.4.19-pre10-aa4      64    4.25 12.05%    0.283      10.86  0.00000  0.00000   35
2.4.19-pre10-aa4-oql  64    3.47 10.30%    0.356      41.28  0.00000  0.00000   34

2.4.19-pre10-aa4     128    4.38 105.7%   19.575    2590.92  0.75605  0.00000    4
2.4.19-pre10-aa4-oql 128    3.48 11.37%    0.433      97.01  0.00000  0.00000   31

2.4.19-pre10-aa4     256    4.19 11.36%    0.269       9.55  0.00000  0.00000   37
2.4.19-pre10-aa4-oql 256    3.44 10.09%    0.270       8.84  0.00000  0.00000   34

Sequential Reads ext2
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1   50.22 27.99%    0.231     916.73  0.00000  0.00000  179
2.4.19-pre10-aa4-oql   1   49.31 28.56%    0.235     671.86  0.00000  0.00000  173

2.4.19-pre10-aa4      32   40.58 25.30%    8.851   14977.86  0.13511  0.00000  160
2.4.19-pre10-aa4-oql  32   36.54 21.75%    9.534   33524.30  0.15471  0.00009  168

2.4.19-pre10-aa4      64   40.30 24.97%   17.409   29836.18  0.39867  0.00009  161
2.4.19-pre10-aa4-oql  64   36.75 22.04%   18.318   66908.84  0.17503  0.07566  167

2.4.19-pre10-aa4     128   40.58 25.06%   33.476   59144.35  0.40223  0.03750  162
2.4.19-pre10-aa4-oql 128   36.65 21.80%   35.286  116917.79  0.19392  0.16241  168

2.4.19-pre10-aa4     256   40.43 25.21%   64.505  116303.68  0.42705  0.36046  160
2.4.19-pre10-aa4-oql 256   36.67 22.05%   66.686  247490.25  0.22520  0.19671  166


Random Reads ext2
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1    0.73  0.79%   16.139     122.84  0.00000  0.00000   92
2.4.19-pre10-aa4-oql   1    0.74  0.71%   15.813     108.18  0.00000  0.00000  104

2.4.19-pre10-aa4      32    5.21  6.12%   65.858     263.66  0.00000  0.00000   85
2.4.19-pre10-aa4-oql  32    3.49  3.65%   96.096     622.30  0.00000  0.00000   96

2.4.19-pre10-aa4      64    5.34  8.04%  124.586    1666.34  0.00000  0.00000   66
2.4.19-pre10-aa4-oql  64    3.66  3.85%  161.338    9160.40  0.47883  0.00000   95

2.4.19-pre10-aa4     128    5.31  9.59%  188.362    6900.68  1.23488  0.00000   55
2.4.19-pre10-aa4-oql 128    3.69  5.39%  256.389   10303.55  3.70464  0.00000   68

2.4.19-pre10-aa4     256    5.35  7.01%  321.321    7466.05  4.06250  0.00000   76
2.4.19-pre10-aa4-oql 256    3.70  5.84%  445.043   11064.58  8.25521  0.00000   63


Sequential Writes ext2
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1   44.74 29.79%    0.237   10862.42  0.00022  0.00000  150
2.4.19-pre10-aa4-oql   1   39.82 26.00%    0.266   12820.23  0.00136  0.00000  153

2.4.19-pre10-aa4      32   37.54 46.78%    8.435   12528.86  0.02540  0.00000   80
2.4.19-pre10-aa4-oql  32   32.76 38.44%    9.718   12559.96  0.12649  0.00000   85

2.4.19-pre10-aa4      64   37.22 46.35%   16.613   21438.79  0.54842  0.00000   80
2.4.19-pre10-aa4-oql  64   32.77 38.17%   18.967   29070.67  0.52241  0.00003   86

2.4.19-pre10-aa4     128   37.11 45.77%   32.377   48430.99  0.55281  0.00200   81
2.4.19-pre10-aa4-oql 128   32.71 38.04%   37.046   56332.65  0.52779  0.00315   86

2.4.19-pre10-aa4     256   36.97 46.31%   62.846   84414.17  0.58346  0.42848   80
2.4.19-pre10-aa4-oql 256   33.06 38.38%   70.013   93041.19  0.53021  0.45341   86


Random Writes ext2
                     Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel               Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
-------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4       1    4.60  3.73%    0.071      11.32  0.00000  0.00000  123
2.4.19-pre10-aa4-oql   1    3.71  2.38%    0.063       1.39  0.00000  0.00000  156

2.4.19-pre10-aa4      32    4.62  8.18%    0.183      17.48  0.00000  0.00000   56
2.4.19-pre10-aa4-oql  32    3.85  6.81%    0.184      13.01  0.00000  0.00000   56

2.4.19-pre10-aa4      64    4.62  8.75%    0.179      11.23  0.00000  0.00000   53
2.4.19-pre10-aa4-oql  64    3.83  6.01%    0.185      11.79  0.00000  0.00000   64

2.4.19-pre10-aa4     128    4.49  7.82%    0.181      11.25  0.00000  0.00000   57
2.4.19-pre10-aa4-oql 128    3.90  7.64%    0.186      13.04  0.00000  0.00000   51

2.4.19-pre10-aa4     256    4.41  8.92%    0.180      10.56  0.00000  0.00000   49
2.4.19-pre10-aa4-oql 256    3.70  7.32%    0.178      11.26  0.00000  0.00000   51



Sequential Reads reiserfs
                      Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel                Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
--------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4        1   47.63 30.34%    0.244     150.93  0.00000  0.00000  157
2.4.19-pre10-aa4-oql    1   47.99 30.42%    0.242     153.50  0.00000  0.00000  158

2.4.19-pre10-aa4       32   36.75 25.80%    9.761   12904.09  0.08792  0.00000  142
2.4.19-pre10-aa4-oql   32   30.68 20.76%   11.026   47422.16  0.15427  0.00591  148

2.4.19-pre10-aa4       64   34.26 24.31%   20.720   22812.18  0.60685  0.00000  141
2.4.19-pre10-aa4-oql   64   31.50 20.98%   20.887   74077.79  0.17828  0.09984  150

2.4.19-pre10-aa4      128   35.94 25.46%   37.882   50116.12  0.53921  0.00388  141
2.4.19-pre10-aa4-oql  128   32.41 21.82%   39.056  137240.55  0.20548  0.17551  149

2.4.19-pre10-aa4      256   35.28 25.17%   74.221  102660.73  0.59475  0.48787  140
2.4.19-pre10-aa4-oql  256   31.67 21.85%   73.905  248764.61  0.26824  0.23384  145


Random Reads reiserfs
                      Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel                Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
--------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4        1    0.59  0.86%   19.727     129.29  0.00000  0.00000   69
2.4.19-pre10-aa4-oql    1    0.60  0.75%   19.634     124.21  0.00000  0.00000   79

2.4.19-pre10-aa4       32    4.23  5.23%   80.588     363.42  0.00000  0.00000   81
2.4.19-pre10-aa4-oql   32    2.98  3.50%  107.835     352.72  0.00000  0.00000   85

2.4.19-pre10-aa4       64    4.28  5.16%  139.187    7890.49  0.45363  0.00000   83
2.4.19-pre10-aa4-oql   64    3.12  5.36%  184.145   10398.28  0.78125  0.00000   58

2.4.19-pre10-aa4      128    4.51  6.99%  213.281    8206.57  1.71370  0.00000   65
2.4.19-pre10-aa4-oql  128    3.13  4.57%  296.529   12265.36  4.43549  0.00000   68

2.4.19-pre10-aa4      256    4.51  7.61%  378.383    8946.18  6.09375  0.00000   59
2.4.19-pre10-aa4-oql  256    3.10  6.34%  539.497   13397.75 10.57291  0.00000   49


Sequential Writes reiserfs
                      Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel                Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
--------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4        1   30.24 49.54%    0.373   33577.32  0.00201  0.00124   61
2.4.19-pre10-aa4-oql    1   28.25 46.58%    0.400   37683.70  0.00204  0.00137   61

2.4.19-pre10-aa4       32   35.33 158.8%    8.978   27421.64  0.13778  0.00102   22
2.4.19-pre10-aa4-oql   32   30.49 145.0%   10.526   48710.93  0.14690  0.00973   21

2.4.19-pre10-aa4       64   32.43 156.6%   19.320   88360.82  0.29164  0.02301   21
2.4.19-pre10-aa4-oql   64   29.31 126.4%   21.320   75316.32  0.33388  0.01316   23

2.4.19-pre10-aa4      128   32.93 140.0%   35.576   95977.80  0.43586  0.11368   24
2.4.19-pre10-aa4-oql  128   29.18 116.8%   40.995   92350.00  0.46883  0.15281   25

2.4.19-pre10-aa4      256   31.38 138.1%   68.583  175532.20  0.67412  0.22071   23
2.4.19-pre10-aa4-oql  256   28.33 117.1%   79.807  128832.50  0.75308  0.32549   24


Random Writes reiserfs
                      Num                   Avg      Maximum     Lat%     Lat%  CPU
Kernel                Thr   Rate  (CPU%)  Latency    Latency       2s      10s  Eff
--------------------- ---  --------------------------------------------------------
2.4.19-pre10-aa4        1    4.29  4.12%    0.094       0.26  0.00000  0.00000  104
2.4.19-pre10-aa4-oql    1    3.47  3.33%    0.095       0.93  0.00000  0.00000  104

2.4.19-pre10-aa4       32    4.36 10.78%    0.256     107.72  0.00000  0.00000   40
2.4.19-pre10-aa4-oql   32    3.51  8.38%    0.226       8.23  0.00000  0.00000   42

2.4.19-pre10-aa4       64    4.41 11.08%    0.231       7.93  0.00000  0.00000   40
2.4.19-pre10-aa4-oql   64    3.52  8.87%    0.231       7.92  0.00000  0.00000   40

2.4.19-pre10-aa4      128    4.36 10.60%    0.244      55.45  0.00000  0.00000   41
2.4.19-pre10-aa4-oql  128    3.61  9.54%    0.378     434.79  0.00000  0.00000   38

2.4.19-pre10-aa4      256    4.21 10.46%    0.857     494.67  0.00000  0.00000   40
2.4.19-pre10-aa4-oql  256    3.40  8.78%    0.665     711.39  0.00000  0.00000   39


Dbench improves 4-15% with QLogic 6.x driver.

2.4.19-pre10-aa4 has QLogic 6.x driver.
2.4.19-pre10-aa4-oql has old qlogic driver.

dbench reiserfs 192 processes		average (5 runs)
2.4.19-pre10-aa4         		 47.98 
2.4.19-pre10-aa4-oql     		 45.24 

dbench reiserfs 64 processes		average
2.4.19-pre10-aa4         		 65.19 
2.4.19-pre10-aa4-oql     		 61.84 

dbench ext3 192 processes		average
2.4.19-pre10-aa4         		 71.62 
2.4.19-pre10-aa4-oql     		 66.19 

dbench ext3 64 processes		Average
2.4.19-pre10-aa4         		 91.68 
2.4.19-pre10-aa4-oql     		 86.16 

dbench ext2 192 processes		Average
2.4.19-pre10-aa4         		153.43 
2.4.19-pre10-aa4-oql     		147.71 

dbench ext2 64 processes		Average
2.4.19-pre10-aa4         		184.89 
2.4.19-pre10-aa4-oql     		178.27 


Bonnie++ average of 3 runs shows improvement in most metrics.
15% improvement in block writes on ext3.

2.4.19-pre10-aa4 has QLogic 6.x driver.
2.4.19-pre10-aa4-oql has old qlogic driver.

bonnie++-1.02a on ext2
                               -------- Sequential Output ----------  - Sequential Input -  ----- Random -----
                               ------ Block -----  ---- Rewrite ----    ----- Block -----   ----- Seeks  -----
Kernel                 Size    MB/sec   %CPU  Eff  MB/sec  %CPU  Eff    MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.4.19-pre10-aa4       8192     52.00   29.0  179   22.35  20.7  108     51.78  26.3  197   435.9  2.00  21797
2.4.19-pre10-aa4-oql   8192     47.36   26.0  182   21.85  20.0  109     50.68  25.0  203   440.9  1.67  26452

                              ---------Sequential ------------------  ------------- Random -----------------
                              ----- Create -----    ---- Delete ----  ----- Create ----     ---- Delete ----
                       files   /sec  %CPU    Eff    /sec  %CPU   Eff   /sec  %CPU   Eff     /sec  %CPU   Eff
2.4.19-pre10-aa4       65536    174  99.0    175   87563  98.7  8874    170  99.0   172      574  99.0   580
2.4.19-pre10-aa4-oql   65536    172  99.0    174   86867  99.0  8774    170  99.0   172      582  99.0   588

bonnie++-1.02a on ext3
                               -------- Sequential Output ----------  - Sequential Input -  ----- Random -----
                               ------ Block -----  ---- Rewrite ----    ----- Block -----   ----- Seeks  -----
Kernel                 Size    MB/sec   %CPU  Eff  MB/sec  %CPU  Eff    MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.4.19-pre10-aa4       8192     49.99   55.3   90   22.31  23.0   97     51.81  25.3  205   362.3  2.00  18115
2.4.19-pre10-aa4-oql   8192     42.36   46.0   92   21.12  21.7   97     50.75  25.0  203   363.4  1.67  21806

                              ---------Sequential ------------------  ------------- Random -----------------
                              ----- Create -----    ---- Delete ----  ----- Create ----     ---- Delete ----
                       files   /sec  %CPU    Eff    /sec  %CPU   Eff   /sec  %CPU   Eff     /sec  %CPU   Eff
2.4.19-pre10-aa4       65536    127  99.0    128   27237  96.0  2837    129  99.0   130      481  96.3   499
2.4.19-pre10-aa4-oql   65536    125  99.0    127   28173  96.3  2924    128  99.0   129      478  96.0   498

bonnie++-1.02a on reiserfs
                               -------- Sequential Output ----------  - Sequential Input -  ----- Random -----
                               ------ Block -----  ---- Rewrite ----    ----- Block -----   ----- Seeks  -----
Kernel                 Size    MB/sec   %CPU  Eff  MB/sec  %CPU  Eff    MB/sec  %CPU  Eff    /sec  %CPU   Eff
2.4.19-pre10-aa4       8192     32.98   49.0   67   22.65  24.7   92     49.03  28.0  175   363.0  2.00  18152
2.4.19-pre10-aa4-oql   8192     30.34   45.0   67   21.57  23.0   94     49.09  27.7  177   365.2  2.33  15650

                              ---------Sequential ------------------  ------------- Random -----------------
                              ----- Create -----    ---- Delete ----  ----- Create ----     ---- Delete ----
                       files   /sec  %CPU    Eff    /sec  %CPU   Eff   /sec  %CPU   Eff     /sec  %CPU   Eff
2.4.19-pre10-aa4      131072   3634  41.7   8722    2406  33.7  7147   3280  39.7  8270      977  18.3  5331
2.4.19-pre10-aa4-oql  131072   3527  40.3   8745    2295  32.0  7170   3349  40.7  8234      871  16.0  5446

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

