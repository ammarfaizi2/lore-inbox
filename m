Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292542AbSBVERq>; Thu, 21 Feb 2002 23:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292566AbSBVER1>; Thu, 21 Feb 2002 23:17:27 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:15491 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292542AbSBVERV>; Thu, 21 Feb 2002 23:17:21 -0500
Date: Thu, 21 Feb 2002 23:21:38 -0500
To: jamagallon@able.es
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCHSET] Linux 2.4.18-rc3-jam1
Message-ID: <20020222042138.GA10466@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> I have updatd my pathset with latest bits for 2.4.18-rc3.

I'm looking forward to trying your patchsets more in the 
future.  I was consolidating some results and it made 
sense to include 2.4.18-rc2-jam1.

2.4.18-rc2-jam1 was the only kernel of these three that had Andrew 
Morton's read_latency2 patch.  2.4.18-rc2-jam1 was compiled with
vm-24, vm_io-2, sched-O1-K3, sched-aa-fixes, lowlatency-mini, 
read-latency2, and sched-balance applied.

Tiobench read/write latency is where the biggest differences are.

K6-2 475 mhz, 384 MB ram, IDE disks.

dbench 128 processes
2.4.18-rc2-jam1      *****************************  14.9  MB/sec
2.4.18rc2aa2         *****************************  14.8  MB/sec
2.4.18-rc2           ***************   7.6  MB/sec

Unixbench-4.2.0                 2.4.18rc2aa2  2.4.18-rc2  2.4.18-rc2-jam1
Execl Throughput                       381.0       303.7        299.0 lps
Pipe Throughput                     389525.7    386034.4     324554.7 lps
Pipe-based Context Switching         94894.8     84108.7      82547.7 lps
Process Creation                      1398.1      1101.3       1239.3 lps
System Call Overhead                323473.1    335228.1     336939.0 lps
Shell Scripts (1 concurrent)           698.0       612.1        620.7 lpm
Shell Scripts (16 concurrent)           48.0        42.7         42.0 lpm
Shell Scripts (32 concurrent)           24.0        21.3         20.7 lpm
Shell Scripts (64 concurrent)           11.8        10.4         10.0 lpm


LMbench 2.0p2 average of 9 runs
-------------------------------
Processor, Processes - times in microseconds - smaller is better
                 null        open  selct  sig   sig   fork   exec     sh
                 I/O   stat  clos   TCP   inst  hndl  proc   proc    proc
2.4.18-rc2       0.72  3.10  4.78   39.0  1.48  3.33   913   3578   13555
2.4.18-rc2-jam1  0.78  3.05  4.46   37.3  1.70  3.09   887   3530   13434
2.4.18rc2aa2     0.76  3.15  4.94   59.4  1.43  3.10   740   2791   11178

Context switching - times in microseconds - smaller is better
                 2p/0K  2p/16K  2p/64K  8p/16K  8p/64K  16p/16K  16p/64K
                 ctxsw  ctxsw   ctxsw   ctxsw   ctxsw   ctxsw    ctxsw
2.4.18-rc2        2.73   22.57  194.41   56.61  207.56    60.40   225.63
2.4.18-rc2-jam1   1.21   18.68  180.87   51.49  205.42    56.37   220.32
2.4.18rc2aa2      1.42   22.81  184.62   57.22  206.74    59.03   226.33

*Local* Communication latencies in microseconds - smaller is better
                 Pipe    AF    UDP    RPC/   TCP    RPC/   TCP
                        UNIX           UDP           TCP   conn
2.4.18-rc2       10.87  21.70  41.55  141.2  83.87  190.0  290.36
2.4.18-rc2-jam1  12.93  20.95  42.77  145.4  79.17  203.0  305.82
2.4.18rc2aa2     10.86  20.40  38.09  129.3  77.17  194.2  259.29

File & VM system latencies in microseconds - smaller is better
                   0K    File     10K    File     Mmap    Prot   Page
                 Create  Delete  Create  Delete  Latency  Fault  Fault
2.4.18-rc2       126.85  184.96  639.46  262.70   2630.3   1.10    6.8
2.4.18-rc2-jam1  131.84  181.95  684.64  260.11   2648.1   1.02    7.0
2.4.18rc2aa2     122.44  174.66  611.18  248.13   2659.6   1.29    5.3

*Local* Communication bandwidths in MB/s - bigger is better
                 Pipe   AF   TCP    File   Mmap   Bcopy  Bcopy  Mem   Mem
                       UNIX        reread reread (libc) (hand)  read  write
2.4.18-rc2       70.10 42.07 60.04  61.66 237.60  59.32  60.48 237.48 85.32
2.4.18-rc2-jam1  65.96 45.27 48.45  59.49 237.50  59.06  60.21 237.52 84.75
2.4.18rc2aa2     64.89 36.07 53.51  62.22 237.66  59.17  60.33 237.51 84.83

Memory latencies in nanoseconds - smaller is better
                 Mhz   L1 $   L2 $   Main mem
2.4.18-rc2       476   4.20  192.34  261.99
2.4.18-rc2-jam1  476   4.20  196.10  262.02
2.4.18rc2aa2     476   4.20  191.15  261.97



Tiobench average of 3 runs 
--------------------------
2048 MB worth of files on ext2 fs.
Read, write, and seek rates in MB/sec. 
Latency in milliseconds.
Percent of requests that took longer than 2 and 10 seconds.

Sequential Reads
                  Num                 Avg      Maximum     Lat%    Lat%  CPU
Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
----------------- --- ------------------------------------------------------
2.4.18-rc2          8  9.08 11.75%   10.271     688.32  0.00000  0.00000  77
2.4.18-rc2-jam1     8  9.32 11.99%   10.029     592.48  0.00000  0.00000  78
2.4.18rc2aa2        8  8.70 11.05%   10.721     717.32  0.00000  0.00000  79

2.4.18-rc2         16  9.15 11.49%   20.295    1181.92  0.00000  0.00000  80
2.4.18-rc2-jam1    16  9.66 12.19%   19.346     935.39  0.00000  0.00000  79
2.4.18rc2aa2       16  7.81  9.50%   23.910    1395.18  0.00000  0.00000  82

2.4.18-rc2         32  9.05 11.50%   38.686  137791.12  0.01105  0.00991  79
2.4.18-rc2-jam1    32  9.54 12.37%   39.121    1720.87  0.00000  0.00000  77
2.4.18rc2aa2       32  7.13  8.69%   41.084  573101.95  0.00630  0.00630  82

2.4.18-rc2         64  8.34 10.65%   66.858  372960.69  0.04826  0.04730  78
2.4.18-rc2-jam1    64  9.85 13.41%   75.739    3364.59  0.00000  0.00000  73
2.4.18rc2aa2       64  6.45  7.61%   77.403  605856.31  0.03337  0.03318  85

2.4.18-rc2        128  8.06 10.25%  117.062  496375.50  0.10891  0.10128  79
2.4.18-rc2-jam1   128  9.77 17.22%  150.658    6822.95  0.83160  0.00000  57
2.4.18rc2aa2      128  6.04  7.29%  144.083  730872.49  0.07763  0.07763  83

Random Reads
                  Num                 Avg      Maximum     Lat%    Lat%  CPU
Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
----------------- --- ------------------------------------------------------
2.4.18-rc2          8  0.48  1.26%  192.062     594.20  0.00000  0.00000  38
2.4.18-rc2-jam1     8  0.48  0.82%  193.114     586.86  0.00000  0.00000  59
2.4.18rc2aa2        8  0.47  1.14%  194.488     640.23  0.00000  0.00000  41

2.4.18-rc2         16  0.53  1.38%  343.392    1021.49  0.00000  0.00000  38
2.4.18-rc2-jam1    16  0.53  1.30%  341.295    1040.82  0.00000  0.00000  41
2.4.18rc2aa2       16  0.51  1.51%  354.999     965.62  0.00000  0.00000  34

2.4.18-rc2         32  0.57  1.21%  599.111    1927.88  0.00000  0.00000  47
2.4.18-rc2-jam1    32  0.57  1.46%  627.710    1887.15  0.00000  0.00000  39
2.4.18rc2aa2       32  0.50  1.60%  642.256    1439.27  0.00000  0.00000  31

2.4.18-rc2         64  0.60  1.92% 1000.255   58973.91  0.20161  0.20161  31
2.4.18-rc2-jam1    64  0.61  2.17% 1149.896    3079.41  0.00000  0.00000  28
2.4.18rc2aa2       64  0.49  1.33% 1197.580   79710.81  0.75606  0.75606  37

2.4.18-rc2        128  0.60  1.77% 1655.593   58576.80  4.91431  4.51109  34
2.4.18-rc2-jam1   128  0.63  3.36% 2177.767    5866.58  0.02520  0.00000  19
2.4.18rc2aa2      128  0.51  1.25% 1749.619   74096.20  5.29233  5.26713  41

Sequential Writes
                  Num                 Avg      Maximum     Lat%    Lat%  CPU
Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
----------------- --- ------------------------------------------------------
2.4.18-rc2          8 13.95 35.53%    6.368   10257.41  0.02461  0.00000  39
2.4.18-rc2-jam1     8 18.55 86.03%    4.501    8531.84  0.00267  0.00000  22
2.4.18rc2aa2        8 17.20 71.51%    4.523    3930.59  0.00000  0.00000  24

2.4.18-rc2         16 13.20 33.72%   13.478   19726.28  0.17261  0.00000  39
2.4.18-rc2-jam1    16 18.45 83.61%    8.865   15315.44  0.30327  0.00000  22
2.4.18rc2aa2       16 15.55 60.43%   10.153    6891.82  0.00172  0.00000  26

2.4.18-rc2         32 13.16 35.35%   25.744   33739.34  0.46578  0.00190  37
2.4.18-rc2-jam1    32 18.29 80.37%   16.850   31111.62  0.30365  0.00381  23
2.4.18rc2aa2       32 12.96 41.80%   24.453   11125.65  0.02250  0.00000  31

2.4.18-rc2         64 13.60 44.32%   46.701   50005.93  0.70420  0.04386  31
2.4.18-rc2-jam1    64 18.09 79.76%   30.954  105671.85  0.30422  0.16518  23
2.4.18rc2aa2       64 11.16 33.81%   56.135   18174.69  0.98952  0.00000  33

2.4.18-rc2        128 12.98 44.74%   86.349   67514.69  1.12170  0.25120  29
2.4.18-rc2-jam1   128 18.02 79.18%   55.833  115163.05  0.28268  0.26455  23
2.4.18rc2aa2      128 10.54 31.31%  113.671   26464.76  2.84768  0.00000  34

Random Writes
                  Num                 Avg      Maximum     Lat%    Lat%  CPU
Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
----------------- --- ------------------------------------------------------
2.4.18-rc2          8  0.56  1.08%    1.267     265.14  0.00000  0.00000  52
2.4.18-rc2-jam1     8  0.71  4.71%    0.190       3.53  0.00000  0.00000  15
2.4.18rc2aa2        8  0.57  1.02%    0.581    1534.89  0.00000  0.00000  56

2.4.18-rc2         16  0.57  1.13%    1.760     430.99  0.00000  0.00000  50
2.4.18-rc2-jam1    16  0.72  4.76%    0.192       4.02  0.00000  0.00000  15
2.4.18rc2aa2       16  0.57  1.10%    4.640    7059.08  0.15000  0.00000  52

2.4.18-rc2         32  0.60  1.18%    1.735     566.45  0.00000  0.00000  51
2.4.18-rc2-jam1    32  0.77  5.13%    0.192       5.28  0.00000  0.00000  15
2.4.18rc2aa2       32  0.58  1.28%   12.224   18987.85  0.22500  0.00000  45

2.4.18-rc2         64  0.65  1.40%    1.477     553.19  0.00000  0.00000  46
2.4.18-rc2-jam1    64  0.79  5.27%    0.190       3.63  0.00000  0.00000  15
2.4.18rc2aa2       64  0.59  1.17%   18.645   25314.00  0.17641  0.10080  51

2.4.18-rc2        128  0.67  1.87%    1.334     777.23  0.00000  0.00000  36
2.4.18-rc2-jam1   128  0.80  5.72%    0.190       3.68  0.00000  0.00000  14
2.4.18rc2aa2      128  0.61  1.39%   61.796   72674.58  0.32761  0.32761  44


bonnie++-1.02a on 1024 MB file
                 ---------------------Sequential Output--------------------
                 -----Per Char-----  ------Block-------  -----Rewrite------
                 MB/sec  %CPU   Eff  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff
2.4.18-rc2         3.43  98.0  3.50   13.88  57.0 24.35    8.04  44.3 18.13
2.4.18-rc2-jam1    3.16  87.0  3.63   15.27  81.0 18.85    6.35  30.0 21.17
2.4.18rc2aa2       3.41  96.3  3.53   15.30  88.3 17.32    6.62  22.3 29.64

                 -----------Sequential Input-----------   ------Random-----
                 -----Per Char-----  ------Block-------   ------Seeks------
                 MB/sec  %CPU   Eff  MB/sec  %CPU   Eff    /sec  %CPU   Eff
2.4.18-rc2         3.99  97.3  4.10   15.61  56.0 27.87     129   2.0  6451
2.4.18-rc2-jam1    3.42  82.0  4.17   13.75  17.3 79.35     122   2.0  6116
2.4.18rc2aa2       3.35  80.3  4.17   12.96  23.0 56.35     127   1.7  7596


Bonnie++ on 16384 small files
                -------Sequential Create------------   
                ------Create-----    -----Delete-----  
                 /sec  %CPU   Eff    /sec  %CPU   Eff  
2.4.18-rc2       4266  98.0  4353    4456  96.7  4609  
2.4.18-rc2-jam1  4502  97.7  4609    4592  99.0  4638  
2.4.18rc2aa2     4353  99.0  4397    4335  94.7  4579  


                ------------Random Create-------------
                ------Create-----     -----Delete-----
                 /sec  %CPU   Eff     /sec  %CPU   Eff
2.4.18-rc2       4216  98.0  4302     3826  91.0  4204
2.4.18-rc2-jam1  4534  99.0  4580     3830  91.7  4177
2.4.18rc2aa2     4392  98.0  4481     4277  99.7  4291


OSDB is the time in seconds to run the single and multi-user (5) open source 
database benchmark on postgresql-7.2.

Time to build/run    autoconf    perl    kernel  updatedb  updatedb5  OSDB
2.4.18rc2aa2         1087        1582    1372    40        43         7961
2.4.18-rc2-jam1      1180        1658    1333    31        46        10064
2.4.18-rc2           1187        1620    1391    30        45         8802

Memory usage         available  kern_code  reserved  data
2.4.18rc2aa2           384624k       895k     8208k  212k
2.4.18-rc2             384296k       887k     8536k  209k
2.4.18-rc2-jam1        384288k       891k     8544k  210k

Testing details and more results at:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

-- 
Randy Hron

