Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292360AbSBBTUN>; Sat, 2 Feb 2002 14:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292358AbSBBTTy>; Sat, 2 Feb 2002 14:19:54 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:11501 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292355AbSBBTTe>; Sat, 2 Feb 2002 14:19:34 -0500
Date: Sat, 2 Feb 2002 14:23:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020202192334.GA21556@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benchmark results on 2.4.17 and 2.4.17 with radix-tree
(ratpagecache) patch.  Identical results removed.  

dbench 192 was the same.  dbench 64 is virtually equal, 
considering dbench normal flucutation.

dbench 64 processes
2.4.17               *************************  12.5  MB/sec
2.4.17rat            ************************  12.1  MB/sec


Unixbench-4.1.0
                                    2.4.17   2.4.17rat
Pipe Throughput                   387881.3    379702.9
Pipe-based Context Switching      105911.3     91653.3
Process Creation                    1180.3      1197.4
System Call Overhead              304463.9    335158.8
Shell Scripts (1 concurrent)         617.4       615.6
C Compiler Throughput                225.7       227.7
Dc: sqrt(2) to 99 decimal places   13988.7     14360.6


LMbench 2.0p2

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
OS               null        open  selct  sig   sig   fork   exec    sh
                 call  stat  clos  TCP    inst  hndl  proc   proc   proc
---------------  ----  ----  ----  -----  ----  ----  -----  -----  -----
Linux 2.4.17     0.43  3.41  6.16   36.8  1.43  3.26    932   3717  13612
Linux 2.4.17rat  0.43  4.56  7.80   55.4  1.45  3.17    901   3580  13239


Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
OS               2p/0K  2p/16K  2p/64K  8p/16K  8p/64K  16p/16K 16p/64K
                 ctxsw  ctxsw   ctxsw   ctxsw   ctxsw   ctxsw   ctxsw
---------------- -----  ------  ------  ------  ------  ------  ------
Linux 2.4.17     1.20   24.07   188.7   56.5    209.0    59.2   223.3
Linux 2.4.17rat  1.21   22.93   187.9   58.0    208.8    61.8   226.4


*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
OS               2p/0K  Pipe    AF     TCP     TCP
                 ctxsw         UNIX            conn
---------------  -----  -----  -----   -----   -----
Linux 2.4.17     2.04  10.17  21.21   65.82   288.2
Linux 2.4.17rat  2.04  10.09  20.46   60.76   289.4


File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
OS                 0K    File     10K    File     Mmap    Prot   Page
                 Create  Delete  Create  Delete  Latency  Fault  Fault
---------------  ------  ------  ------  ------  -------  -----  -----
Linux 2.4.17      123.9   165.6   677.1   242.8    2602   1.076   8.0
Linux 2.4.17rat   128.9   169.7   618.8   256.2    2762   1.051   7.7

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
OS              Pipe   AF    TCP  File   Mmap   Bcopy  Bcopy  Mem   Mem
                      UNIX        reread reread (libc) (hand) read  write
--------------- ----- ----- ----- ------ ------ ------ ------ ----- -----
Linux 2.4.17     61.5  49.2  60.5   61.7  237.4   59.2   60.3 237.3  85.0
Linux 2.4.17rat  64.4  42.8  60.3   61.4  237.5   59.1   60.2 237.4  84.7


Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
OS                 Mhz   L1 $   L2 $    Main mem
-----------------  ----  -----  ------  --------
Linux 2.4.17        501   4.2   188.1    262.2
Linux 2.4.17rat     501   4.2   195.4    262.0


Threaded I/O Bench
Read, Write, and Seeks are MB/sec
CPU Effiency (CPU Eff) = (MB/sec) / CPU% (bigger is better)

 		Num     Seq Read    CPU    Rand Read   CPU   
 		Thr    Rate (CPU%)  Eff   Rate (CPU%)  Eff   
 		---  -------------------  -----------------  
2.4.17            1  13.23  43.2%  30.62  2.74  3.7%  73.88  
2.4.17rat         1  12.60  43.0%  29.30  2.75  3.8%  72.45  

2.4.17            2  11.56  29.9%  38.66  3.04  3.8%  79.89  
2.4.17rat         2  11.07  30.4%  36.41  3.06  4.3%  71.81  

2.4.17            4  11.03  25.9%  42.59  3.19  4.1%  78.26  
2.4.17rat         4  10.62  26.5%  40.08  3.15  4.2%  74.32  

2.4.17            8  10.62  22.8%  46.58  3.29  4.2%  77.99  
2.4.17rat         8  10.23  23.4%  43.72  3.26  4.5%  73.05  

 		Num    Seq Write    CPU    Rand Write   CPU
 		Thr   Rate (CPU%)   Eff    Rate (CPU%)  Eff
 		---  -------------------  -----------------
2.4.17            1  11.08  50.5%  21.94  0.69  1.6%  44.10
2.4.17rat         1   7.77  32.8%  23.69  0.53  1.1%  48.44

2.4.17            2  10.83  48.6%  22.28  0.69  1.5%  45.13
2.4.17rat         2   7.51  32.1%  23.38  0.52  1.1%  45.98

2.4.17            4  10.40  45.9%  22.66  0.68  1.5%  44.70
2.4.17rat         4   7.62  32.8%  23.25  0.53  1.2%  45.21

2.4.17            8  10.17  44.8%  22.70  0.67  1.5%  44.73
2.4.17rat         8   7.55  32.5%  23.24  0.53  1.2%  44.66


bonnie++
Version 1.02a     ---------------------Sequential Output--------------------
                  -----Per Char-----  ------Block-------  -----Rewrite------
Kernel      Size  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff
2.4.17      1024    3.41  98.0  3.48   14.56  65.6 22.19    8.83  51.0 17.32
2.4.17rat   1024    3.36  98.0  3.43   10.64  41.6 25.57    6.79  37.2 18.27

Version 1.02a     -----------Sequential Input-----------   ------Random-----
                  -----Per Char-----  ------Block-------   ------Seeks------
Kernel      Size  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff    /sec  %CPU   Eff
2.4.17      1024    3.98  97.2  4.10   16.39  60.6 27.05     132   2.0  6609
2.4.17rat   1024    3.92  96.0  4.08   15.46  57.0 27.12     126   2.0  6302

                 -------Sequential Create-----------
                 ------Create-----  -----Delete-----
           files  /sec  %CPU   Eff  /sec  %CPU   Eff
2.4.17     16384  4421  96.8  4567  4719  97.4  4845
2.4.17rat  16384  3973  97.6  4070  4531  95.0  4769

                 -------Random Create----------------
                 ------Create-----   -----Delete-----
           files  /sec  %CPU   Eff   /sec  %CPU   Eff
2.4.17     16384  4475  98.0  4566   4124  94.0  4387
2.4.17rat  16384  4203  98.0  4288   4005  94.4  4242


Build times.  Smaller is better - task completed faster.

		perl_build 	kernel_build
2.4.17		1620		1347
2.4.17rat	1629		1444

radix-tree saves 768k on 384M machine.

2.4.17rat  Memory: 385932k/393216k available (885k kernel code, 6900k reserved
2.4.17     Memory: 385164k/393216k available (884k kernel code, 7668k reserved

Results like these on more kernels at:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

-- 
Randy Hron

