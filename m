Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSBFCAO>; Tue, 5 Feb 2002 21:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289972AbSBFCAG>; Tue, 5 Feb 2002 21:00:06 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:63153 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289954AbSBFB7t>; Tue, 5 Feb 2002 20:59:49 -0500
Date: Tue, 5 Feb 2002 21:04:10 -0500
To: Momchil Velikov <velco@fadata.bg>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020206020410.GA18035@earthlink.net>
In-Reply-To: <20020202192334.GA21556@earthlink.net> <877kpuw37k.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877kpuw37k.fsf@fadata.bg>
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I've got different results with bonnie++, are you sure you didn't
> swap the results :)

I am curious if the small followup patch to 2.5.3-dj1 makes radix-tree
more like 2.4.17-ratpagecache.  (overall, it seems that radix-tree did
better in I/O without the small followup patch).

Benchmarks on 2.5.3-dj1, 2.5.3-dj1 with radix-tree (rat) 
and small followup patch (rat2).

dbench 64 processes
2.5.3-dj1rat         **************************  13.1  MB/sec
2.5.3-dj1            **********************  11.1  MB/sec
2.5.3-dj1rat2        **********************  11.1  MB/sec

dbench 192 processes
2.5.3-dj1rat         *************   6.8  MB/sec
2.5.3-dj1rat2        *************   6.7  MB/sec
2.5.3-dj1            *************   6.6  MB/sec


Unixbench-4.1.0
                                 2.5.3-dj1   2.5.3-dj1rat  2.5.3-dj1rat2
Execl Throughput                    316.7          298.5         324.8 lps 
Pipe Throughput                  307626.1       308399.0      284619.1 lps
Pipe-based Context Switching      95502.3        93398.1       76470.1 lps
Process Creation                   1320.7         1280.5        1398.3 lps 
System Call Overhead             245040.7       239410.7      251300.1 lps
Shell Scripts (1 concurrent)        643.2          639.0         636.1 lpm 
Shell Scripts (8 concurrent)         89.3           88.0          86.9 lpm 
Shell Scripts (16 concurrent)        44.7           44.0          44.0 lpm 
Shell Scripts (32 concurrent)        22.7           22.0          22.0 lpm 
Shell Scripts (64 concurrent)        10.9           10.7          10.7 lpm 
Shell Scripts (96 concurrent)         7.1            7.1           6.9 lpm 
Shell Scripts (128 concurrent)        5.3            5.1           5.1 lpm 
C Compiler Throughput               220.6          225.2         217.1 lpm 
Dc: sqrt(2) to 99 decimal places  15838.5        15465.6       15854.2 lpm 
Recursion Test--Tower of Hanoi    14157.1        14156.8       14156.2 lps 


LMbench-2.0p2 average of 9 samples.
Processor, Processes - times in microseconds - smaller is better
OS                    null        open  selct  sig   sig   fork  exec  sh
                      call  stat  clos  TCP    inst  hndl  proc  proc  proc
--------------------  ----  ----  ----  -----  ----  ----  ----  ----  -----
Linux 2.5.3-dj1       0.60  3.56  5.42   39.0  1.49  3.10   777  3250  12082
Linux 2.5.3-dj1rat    0.60  4.65  6.61   37.5  1.44  3.03   809  3294  12580
Linux 2.5.3-dj1rat2   0.59  4.52  7.82   59.5  1.42  3.23   788  3431  12943


Context switching - times in microseconds - smaller is better
OS                   2p/0K  2p/16K  2p/64K  8p/16K  8p/64K  16p/16K 16p/64K
                     ctxsw  ctxsw   ctxsw   ctxsw   ctxsw   ctxsw   ctxsw
-------------------  -----  ------  ------  ------  ------  ------  ------
Linux 2.5.3-dj1      1.04   18.98   190.4   55.5    207.3    59.0   224.3
Linux 2.5.3-dj1rat   0.43   19.57   183.7   56.6    204.0    58.1   225.0
Linux 2.5.3-dj1rat2  1.02   20.39   184.9   58.0    212.3    59.5   227.1


*Local* Communication latencies in microseconds - smaller is better
OS                     Pipe    AF     TCP      TCP
                              UNIX             conn
-------------------    -----  -----   -----    -----
Linux 2.5.3-dj1       13.57  27.21    76.68    303.6
Linux 2.5.3-dj1rat    10.46  20.51    72.37    292.6
Linux 2.5.3-dj1rat2   11.41  20.04    75.18    304.6


File & VM system latencies in microseconds - smaller is better
OS                     0K    File     10K    File     Mmap    Prot   Page
                     Create  Delete  Create  Delete  Latency  Fault  Fault
-------------------  ------  ------  ------  ------  -------  -----  -----
Linux 2.5.3-dj1       132.3   195.5   709.7   285.9    2821   1.134   6.1
Linux 2.5.3-dj1rat    145.5   198.2   791.6   291.7    2699   1.495   5.6
Linux 2.5.3-dj1rat2   140.1   195.0   723.2   287.4    2792   1.588   5.6


*Local* Communication bandwidths in MB/s - bigger is better
OS                   Pipe  AF   TCP File   Mmap   Bcopy  Bcopy  Mem   Mem
                          UNIX      reread reread (libc) (hand) read  write
-------------------  ---- ---- ---- ------ ------ ------ ------ ----- -----
Linux 2.5.3-dj1      65.7 44.3 42.7   60.3  237.5   59.2  60.4  237.4  85.1
Linux 2.5.3-dj1rat   64.2 45.5 38.4   59.8  237.7   59.5  60.6  237.6  85.7
Linux 2.5.3-dj1rat2  67.0 46.0 45.3   60.1  237.6   59.4  60.5  237.4  85.4


Memory latencies in nanoseconds - smaller is better
OS                    Mhz   L1 $   L2 $    Main mem
-------------------  ----  -----  ------  --------
Linux 2.5.3-dj1       501   4.2   195.7    262.3
Linux 2.5.3-dj1rat    501   4.2   191.1    261.9
Linux 2.5.3-dj1rat2   501   4.2   189.9    262.1


Threaded I/O Bench
File Size is 384MB, Read, Write, and Seeks are MB/sec
CPU Effiency (CPU Eff) = (MB/sec) / CPU% (bigger is better)

Reads		  Num  Seq     Read    CPU  Rand  Read    CPU 
 		  Thr  Rate   (CPU%)   Eff  Rate (CPU%)   Eff 
 		  ---  -------------------  -----------------
2.5.3-dj1           1  12.92  42.7%  30.26  3.21  4.7%  68.63
2.5.3-dj1rat        1  12.99  44.8%  29.00  2.80  3.9%  71.17
2.5.3-dj1rat2       1  12.75  43.2%  29.51  2.75  4.6%  59.29

2.5.3-dj1           2  11.63  32.1%  36.23  3.34  4.4%  75.57
2.5.3-dj1rat        2  11.70  33.3%  35.14  3.00  4.5%  65.93
2.5.3-dj1rat2       2  11.42  32.3%  35.36  2.92  4.9%  59.75

2.5.3-dj1           4  11.26  28.8%  39.10  3.42  4.8%  71.70
2.5.3-dj1rat        4  11.22  30.0%  37.40  3.06  4.7%  65.18
2.5.3-dj1rat2       4  11.14  29.5%  37.76  3.00  4.9%  61.69

2.5.3-dj1           8  11.25  26.8%  41.98  3.61  5.1%  71.02
2.5.3-dj1rat        8  10.96  26.9%  40.74  3.19  4.6%  69.09
2.5.3-dj1rat2       8  10.94  26.9%  40.67  3.09  4.9%  62.91

Writes		  Num  Seq    Write    CPU  Rand  Write   CPU
 		  Thr  Rate   (CPU%)   Eff  Rate  (CPU%)  Eff
 		  ---  -------------------  -----------------
2.5.3-dj1           1  11.38  55.9%  20.36  0.76  2.0%  37.21
2.5.3-dj1rat        1  10.77  54.3%  19.83  0.70  2.0%  35.30
2.5.3-dj1rat2       1   9.01  42.5%  21.21  0.57  1.5%  37.75
                                                             
2.5.3-dj1           2  11.35  56.4%  20.12  0.77  2.0%  37.32
2.5.3-dj1rat        2  10.54  53.2%  19.81  0.70  2.0%  35.69
2.5.3-dj1rat2       2   7.92  37.0%  21.40  0.52  1.4%  38.15
                                                             
2.5.3-dj1           4  11.39  57.3%  19.88  0.78  2.1%  36.65
2.5.3-dj1rat        4  10.54  53.2%  19.81  0.71  2.0%  35.91
2.5.3-dj1rat2       4   7.71  36.1%  21.37  0.51  1.4%  37.56
                                                             
2.5.3-dj1           8  11.28  56.6%  19.93  0.79  2.2%  36.22
2.5.3-dj1rat        8  10.77  54.8%  19.65  0.73  2.0%  36.24
2.5.3-dj1rat2       8   7.93  37.3%  21.27  0.52  1.4%  37.16


bonnie++-1.02a summary
1024 MB file    ---------------------Sequential Output--------------------
                -----Per Char-----  ------Block-------  -----Rewrite------
Kernel          MB/sec  %CPU   Eff  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff
2.5.3-dj1         3.38  98.0  3.44   14.20  67.4 21.06    8.52  51.0 16.71
2.5.3-dj1rat      3.35  98.0  3.42   14.01  62.0 22.60    8.19  46.4 17.66
2.5.3-dj1rat2     3.38  98.0  3.44   13.06  56.2 23.24    7.66  42.6 17.98


                 -----------Sequential Input-----------  ------Random-----
                 -----Per Char-----  ------Block-------  ------Seeks------
Kernel           MB/sec  %CPU   Eff  MB/sec  %CPU   Eff   /sec  %CPU   Eff
2.5.3-dj1          3.96  97.4  4.07   15.26  57.2 26.68    129   2.0  6460
2.5.3-dj1rat       3.94  97.0  4.06   15.21  57.4 26.49    127   1.8  7051
2.5.3-dj1rat2      3.93  97.0  4.05   15.13  57.4 26.36    128   2.0  6415

bonnie++ small files (16384 files)
               --------Sequential Create------------
               ------Create-----    -----Delete-----
                /sec  %CPU   Eff    /sec  %CPU   Eff
2.5.3-dj1       4369  97.4  4485    4176  96.8  4313
2.5.3-dj1rat    4276  98.0  4364    4100  96.0  4271
2.5.3-dj1rat2   4293  97.0  4425    3880  94.4  4110

                ------------Random Create------------
                ------Create-----    -----Delete-----
                 /sec  %CPU   Eff    /sec  %CPU   Eff
 2.5.3-dj1       4334  98.2  4413    3782  96.4  3923
 2.5.3-dj1rat    4238  97.6  4341    3696  95.0  3890
 2.5.3-dj1rat2   4215  97.2  4336    3667  95.0  3860


Time to build/test/run in seconds
version        autoconf    perl    kernel  updatedb updatedb*5
2.5.3-dj1      1152        1636    1320    29       38        
2.5.3-dj1rat   1167        1684    1336    29       39        
2.5.3-dj1rat2  1162        1674    1356    29       37        

Memory Info - radix-tree saved 768k on 384MB machine.
version        available totalmem kern_code reserved
2.5.3-dj1rat     385860k  393216k      931k    6972k
2.5.3-dj1rat2    385860k  393216k      931k    6972k
2.5.3-dj1        385092k  393216k      930k    7740k

Details on system, testing method, and other results at:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
-- 
Randy Hron

