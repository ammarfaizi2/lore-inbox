Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTHaQyt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbTHaQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:54:49 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:14739 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262441AbTHaQyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:54:38 -0400
Date: Sun, 31 Aug 2003 12:57:53 -0400
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: LMbench as gcc performance regression test?
Message-ID: <20030831165753.GA6690@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For starters, just compiling the kernel with different compilers;
> I'll keep running LMBench compiled with the old compiler.

Below are the lmbench results I got.  One is from K6/2, and
one is from quad P3 Xeon.  The kernels called -falign=2 had
-falign-functions=2 -falign-jumps=2 -falign-labels=2 -falign-loops=2

First is the K6/2.  Second bunch of results is quad P3.
The numbers are the average of 25 runs.  These do not have high/low
results removed from the averages.

The kernel versions without a suffix are the default kernel compile options.

I also ran a bunch of other benchmarks on these kernels.
It seems to me the application/target platform may be the
final arbiter of "what is best".  I was hoping for a very 
general result like gcc-3.3.1 -Os -falign=2 is always clearly better,
but I don't see that.  (That generalization is partly true on
K6/2, but not on P3 Xeon - very different cache characteristics for
those chips).

BTW, gcc-3.3.1 -Os saved about 800k ram on 1GB athlon compared to gcc-2.95.3 -O2
for 2.6 kernel.  Most of the savings were in nop instructions.  There was also
a different mix of push/pop instructions.  -Os created more push/pops on athlon.

One thing that is clear.  gcc-3.3.1 takes longer to compile (roughly 2x).

Note: LMbench wasn't recompiled.  The compiler options only changed on the kernel.

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
                                     null     null                       open    signal   signal    fork    execve  /bin/sh
kernel                               call      I/O     stat    fstat    close   install   handle  process  process  process
-----------------------------      -------  -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3                           0.73  1.20351     5.89     1.60     7.07     1.99     5.04     1426     3272    13618
2.6.0-test3-gcc-2.96-Os               0.73  1.25547     4.17     1.71     7.22     1.99     4.43     1456     3416    13945
2.6.0-test3-gcc-3.3.1                 0.74  1.08099     4.15     1.56     6.73     2.02     4.28     1397     3146    13238
2.6.0-test3-gcc-3.3.1-Os              0.73  1.33862     4.64     1.92     7.11     2.00     4.88     1398     3453    13874
2.6.0-test3-gcc-3.3.1-Os-falign=2     0.71  1.24968     3.99     1.77     6.50     2.02     4.00     1413     3441    13814

File select - times in microseconds - smaller is better
-------------------------------------------------------
                                    select   select   select   select   select   select   select   select
kernel                               10 fd   100 fd   250 fd   500 fd   10 tcp  100 tcp  250 tcp  500 tcp
-----------------------------      -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3                           4.11    15.51    35.15    66.14     5.98  33.6829  83.6085  156.960
2.6.0-test3-gcc-2.96-Os               4.04    15.71    35.02    67.80     6.03  33.5566  79.2899  160.586
2.6.0-test3-gcc-3.3.1                 4.62    16.14    36.56    74.28     6.38  33.7929  79.8531  156.387
2.6.0-test3-gcc-3.3.1-Os              4.29    21.57    42.62    81.01     6.71  46.7026  98.9269  193.885
2.6.0-test3-gcc-3.3.1-Os-falign=2     3.64    15.20    33.43    65.21     6.23  39.4099  92.0308  178.482

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                    2proc/0k   4proc/0k   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                             1.87       7.71       8.97      10.71      12.91      14.45      15.24
2.6.0-test3-gcc-2.96-Os                 2.27       6.07       7.39       8.91      10.88      12.25      12.73
2.6.0-test3-gcc-3.3.1                   2.34       5.31       7.10       8.76      10.77      12.18      12.99
2.6.0-test3-gcc-3.3.1-Os                1.60       5.00       6.57       8.45      10.51      11.67      12.18
2.6.0-test3-gcc-3.3.1-Os-falign=2       1.25       3.60       5.45       7.15       9.29      10.65      11.19

Context switching with 4K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                    2proc/4k   4proc/4k   8proc/4k  16proc/4k  32proc/4k  64proc/4k  96proc/4k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                             5.72      23.35      24.98      26.33      28.22      29.56      29.97
2.6.0-test3-gcc-2.96-Os                 7.00      21.94      22.98      24.53      26.12      26.94      27.41
2.6.0-test3-gcc-3.3.1                   6.24      21.41      22.92      24.12      25.83      27.27      27.70
2.6.0-test3-gcc-3.3.1-Os                8.21      22.88      23.45      24.57      26.01      26.95      27.54
2.6.0-test3-gcc-3.3.1-Os-falign=2       8.41      24.30      25.56      26.98      28.93      29.94      30.51

Context switching with 8K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                    2proc/8k   4proc/8k   8proc/8k  16proc/8k  32proc/8k  64proc/8k  96proc/8k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                            18.85      40.92      41.65      42.04      44.08      45.42      46.26
2.6.0-test3-gcc-2.96-Os                18.32      39.79      39.45      40.34      41.50      42.87      43.61
2.6.0-test3-gcc-3.3.1                  18.15      38.66      39.15      39.70      41.11      42.61      43.37
2.6.0-test3-gcc-3.3.1-Os               18.38      38.33      39.38      39.67      41.27      42.48      43.40
2.6.0-test3-gcc-3.3.1-Os-falign=2      18.67      41.22      41.94      42.71      44.51      45.99      46.75

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                   2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                            32.70      74.53      74.04      73.43      74.59      76.24      77.31
2.6.0-test3-gcc-2.96-Os                31.40      72.91      71.58      71.54      72.60      74.36      75.62
2.6.0-test3-gcc-3.3.1                  31.45      71.75      70.75      71.21      72.53      74.22      75.36
2.6.0-test3-gcc-3.3.1-Os               29.74      70.87      70.07      69.92      71.42      73.41      74.78
2.6.0-test3-gcc-3.3.1-Os-falign=2      32.24      75.09      74.88      74.67      75.23      76.83      78.08

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                   2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                           129.83     134.99     136.17     135.81     138.72     142.94     146.38
2.6.0-test3-gcc-2.96-Os               128.66     132.55     132.72     134.04     136.61     140.45     143.50
2.6.0-test3-gcc-3.3.1                 129.67     133.26     133.57     134.00     135.80     139.78     143.06
2.6.0-test3-gcc-3.3.1-Os              130.01     133.43     132.44     133.15     135.29     139.57     143.19
2.6.0-test3-gcc-3.3.1-Os-falign=2     129.63     135.77     136.05     135.82     138.48     142.42     145.80

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                   2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel                             ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------      ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3                           234.17     241.21     244.17     247.96     255.85     265.69     270.87
2.6.0-test3-gcc-2.96-Os               239.48     242.65     242.96     246.98     254.17     263.57     268.69
2.6.0-test3-gcc-3.3.1                 237.30     241.26     243.74     245.77     253.20     262.63     268.03
2.6.0-test3-gcc-3.3.1-Os              236.21     240.27     241.66     246.98     253.88     264.21     269.66
2.6.0-test3-gcc-3.3.1-Os-falign=2     241.20     244.36     246.88     250.26     257.55     267.07     272.12

File create/delete and VM system latencies in microseconds - smaller is better
----------------------------------------------------------------------------
                                     0K       0K       1K       1K       4K       4K      10K      10K     Mmap     Prot    Page
kernel                             Create   Delete   Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
------------------------------     -------  -------  -------  -------  -------  -------  -------  -------  -------  ------  ------
2.6.0-test3                          157.4     44.3    282.2     77.9    293.5     78.0    480.7     98.8     4281    0.11     8.7
2.6.0-test3-gcc-2.96-Os              160.1     39.1    283.4     74.0    291.8     74.0    474.3     92.0     3973    0.84     8.4
2.6.0-test3-gcc-3.3.1                152.9     35.2    263.4     64.9    271.0     65.3    450.8     84.1     3884    0.90     9.0
2.6.0-test3-gcc-3.3.1-Os             142.8     32.1    257.1     65.8    265.2     65.7    447.9     85.0     4600    0.37     9.8
2.6.0-test3-gcc-3.3.1-Os-falign=2    145.0     37.0    261.6     75.7    269.9     75.9    452.9     94.8     3981    0.67     8.9

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel                               Pipe   AF/Unix     UDP   RPC/UDP     TCP   RPC/TCP  TCPconn
-----------------------------      -------  -------  -------  -------  -------  -------  -------
2.6.0-test3                          23.91    28.95  79.4908  180.193  89.9243  213.264   379.17
2.6.0-test3-gcc-2.96-Os              16.72    24.36  61.8104  172.207  99.5137  213.399   384.39
2.6.0-test3-gcc-3.3.1                18.16    24.52  60.0927  156.112  85.7277  216.343   335.97
2.6.0-test3-gcc-3.3.1-Os             16.65    30.98  55.1646  159.562  97.5878  209.945   357.23
2.6.0-test3-gcc-3.3.1-Os-falign=2    15.69    25.77  64.9899  170.012  82.2858  210.149   344.43

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                                                 File     Mmap    Bcopy    Bcopy   Memory   Memory
kernel                               Pipe   AF/Unix    TCP     reread   reread   (libc)   (hand)     read    write
-----------------------------      -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3                           52.7     37.0     28.9     52.2    232.6     60.0     60.0    232.4     86.0
2.6.0-test3-gcc-2.96-Os               52.9     36.0     33.1     50.7    231.7     60.0     60.0    232.2     86.1
2.6.0-test3-gcc-3.3.1                 55.8     36.8     31.9     52.9    232.7     60.1     60.1    232.5     86.2
2.6.0-test3-gcc-3.3.1-Os              56.5     37.2     25.2     51.8    232.6     60.0     60.0    232.4     86.2
2.6.0-test3-gcc-3.3.1-Os-falign=2     54.3     35.9     29.3     50.7    232.6     60.0     60.0    232.3     86.1

*Local* More Communication bandwidths in MB/s - bigger is better
----------------------------------------------------------------
                                      File     Mmap  Aligned  Partial  Partial  Partial  Partial  
OS                                    open     open    Bcopy    Bcopy     Mmap     Mmap     Mmap    Bzero
                                     close    close   (libc)   (hand)     read    write   rd/wrt     copy     HTTP
-----------------------------      -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3                           53.0    175.8     59.5     66.2    241.9     86.1     86.1     86.0     2.99
2.6.0-test3-gcc-2.96-Os               51.6    176.8     59.5     66.2    241.9     86.1     86.1     86.0     2.91
2.6.0-test3-gcc-3.3.1                 52.3    178.0     59.5     66.2    242.1     86.2     86.2     86.2     3.21
2.6.0-test3-gcc-3.3.1-Os              52.8    165.6     59.5     66.2    242.1     86.3     86.3     86.2     3.08
2.6.0-test3-gcc-3.3.1-Os-falign=2     50.9    168.2     59.5     66.2    242.1     86.1     86.1     86.1     3.14

Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
kernel                              Mhz     L1 $     L2 $    Main mem
-----------------------------      -----  -------  -------  ---------
2.6.0-test3                          476     4.25   232.06      268.3
2.6.0-test3-gcc-2.96-Os              476     4.26   231.12      268.7
2.6.0-test3-gcc-3.3.1                476     4.25   231.13      268.2
2.6.0-test3-gcc-3.3.1-Os             476     4.25   227.97      267.7
2.6.0-test3-gcc-3.3.1-Os-falign=2    476     4.25   231.75      267.7


Quad Xeon

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
                                         null     null                       open    signal   signal    fork    execve  /bin/sh
kernel                                   call      I/O     stat    fstat    close   install   handle  process  process  process
-----------------------------          -------  -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3-mm2                           0.50  0.75332     4.35     1.36     5.94     1.56     5.13      257     1007     4506
2.6.0-test3-mm2-gcc-3.3.1                 0.51  0.76516     4.39     1.37     5.96     1.54     5.11      254      996     4444
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2     0.52  0.75901     4.28     1.37     5.83     1.56     5.44      264     1019     4492

File select - times in microseconds - smaller is better
-------------------------------------------------------
                                        select   select   select   select   select   select   select   select
kernel                                   10 fd   100 fd   250 fd   500 fd   10 tcp  100 tcp  250 tcp  500 tcp
-----------------------------          -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3-mm2                           3.98    22.31    53.07   106.21     5.02  33.4355  79.1707  159.488
2.6.0-test3-mm2-gcc-3.3.1                 3.94    23.22    54.85   108.65     4.94  32.8961  79.7636  159.520
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2     3.90    22.66    53.64   105.36     5.49  38.1446  91.8798  181.395

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                        2proc/0k   4proc/0k   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                             1.65       2.17       2.60       2.75       2.90       3.53       4.76
2.6.0-test3-mm2-gcc-3.3.1                   1.61       2.12       2.48       2.66       2.79       3.33       4.52
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2       2.00       2.62       3.39       3.44       3.53       3.92       5.00

Context switching with 4K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                        2proc/4k   4proc/4k   8proc/4k  16proc/4k  32proc/4k  64proc/4k  96proc/4k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                             2.66       3.76       4.31       4.39       4.58       6.78      10.27
2.6.0-test3-mm2-gcc-3.3.1                   2.25       4.14       4.47       4.47       4.56       6.54       9.67
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2       2.54       4.18       4.95       4.96       5.22       6.95      10.17

Context switching with 8K - times in microseconds - smaller is better
---------------------------------------------------------------------
                                        2proc/8k   4proc/8k   8proc/8k  16proc/8k  32proc/8k  64proc/8k  96proc/8k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                             4.65       5.74       5.76       5.83       6.51      12.94      21.74
2.6.0-test3-mm2-gcc-3.3.1                   4.53       6.03       5.96       5.90       6.36      12.49      21.53
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2       4.50       5.95       6.16       6.27       6.86      12.92      21.89

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                       2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                             9.14       9.07       8.90       8.99      14.06      39.74      49.45
2.6.0-test3-mm2-gcc-3.3.1                   8.21       8.33       8.40       8.96      14.51      39.50      50.52
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2       8.76       9.07       9.09       9.68      15.57      40.04      50.86

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                       2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                           15.740     15.347     14.779     19.616     57.711     87.463     88.771
2.6.0-test3-mm2-gcc-3.3.1                 14.584     14.636     14.619     20.376     57.226     87.183     88.533
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2     14.961     14.820     14.847     20.192     58.146     87.172     88.723

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
                                       2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel                                 ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-----------------------------          ---------  ---------  ---------  ---------  ---------  ---------  ---------
2.6.0-test3-mm2                            26.08      25.19      32.19     105.04     158.28     163.83     162.59
2.6.0-test3-mm2-gcc-3.3.1                  24.83      24.42      34.92     106.19     160.16     166.21     164.72
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2      26.00      25.57      32.14     102.00     157.90     162.73     163.06

File create/delete and VM system latencies in microseconds - smaller is better
----------------------------------------------------------------------------
                                         0K       0K       1K       1K       4K       4K      10K      10K     Mmap     Prot    Page
kernel                                 Create   Delete   Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
------------------------------         -------  -------  -------  -------  -------  -------  -------  -------  -------  ------  ------
2.6.0-test3-mm2                           56.2     10.5     89.1     22.0     89.0     22.0    130.8     30.5     4603    0.65     4.0
2.6.0-test3-mm2-gcc-3.3.1                 53.1      9.9     85.9     21.0     85.9     21.0    127.8     29.7     4603    0.70     4.0
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2     57.7     10.3     90.4     21.3     90.4     21.3    132.3     30.1     4725    0.61     4.1

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel                                   Pipe   AF/Unix     UDP   RPC/UDP     TCP   RPC/TCP  TCPconn
-----------------------------          -------  -------  -------  -------  -------  -------  -------
2.6.0-test3-mm2                          10.31    15.11  30.8128  65.4053  37.5467  76.3995    97.65
2.6.0-test3-mm2-gcc-3.3.1                10.23    15.34  29.5681  62.6713  35.9673  75.1441    97.27
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2    11.77    17.47  33.1430  67.9045  38.9957  78.8412    97.49

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                                                     File     Mmap    Bcopy    Bcopy   Memory   Memory
kernel                                   Pipe   AF/Unix    TCP     reread   reread   (libc)   (hand)     read    write
-----------------------------          -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3-mm2                          482.1    532.7    189.2    298.3    367.5    170.7    173.6    366.9    213.5
2.6.0-test3-mm2-gcc-3.3.1                480.6    546.2    167.3    296.8    362.3    170.5    173.1    362.6    212.4
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2    472.9    538.1    163.9    297.5    365.2    170.9    173.6    364.9    213.0

*Local* More Communication bandwidths in MB/s - bigger is better
----------------------------------------------------------------
                                          File     Mmap  Aligned  Partial  Partial  Partial  Partial  
OS                                        open     open    Bcopy    Bcopy     Mmap     Mmap     Mmap    Bzero
                                         close    close   (libc)   (hand)     read    write   rd/wrt     copy     HTTP
-----------------------------          -------  -------  -------  -------  -------  -------  -------  -------  -------
2.6.0-test3-mm2                          298.3    283.4    168.9    183.9    781.2    212.6    213.7    350.2    10.24
2.6.0-test3-mm2-gcc-3.3.1                296.5    280.1    168.6    182.9    782.7    211.9    212.2    350.6    10.24
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2    297.1    280.0    169.2    183.7    783.4    212.3    212.6    350.4    10.04

Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
kernel                                  Mhz     L1 $     L2 $    Main mem
-----------------------------          -----  -------  -------  ---------
2.6.0-test3-mm2                          698     4.33    12.98      164.4
2.6.0-test3-mm2-gcc-3.3.1                698     4.33    13.00      166.4
2.6.0-test3-mm2-gcc-3.3.1-Os-falign=2    698     4.31    12.93      164.8




-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

