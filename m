Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289136AbSAVBlE>; Mon, 21 Jan 2002 20:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSAVBkz>; Mon, 21 Jan 2002 20:40:55 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:4236 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S289136AbSAVBku>; Mon, 21 Jan 2002 20:40:50 -0500
Date: Mon, 21 Jan 2002 20:44:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121204440.A10843@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.18pre2a2	aa vm and low-latency included
2.4.18-pre3
2.4.18-pre3ll	low-latency patch
2.4.18-pre3pelb	preempt and lockbreak patches

It appears 2.4.18pre2aa2 is the best overall, and the
low-latency patch does better than preempt in most cases.

7 lmbench runs run for each kernel.  Below are averages the averages.
Remember that "smaller is better" in the latency tests and "bigger is 
better" in the bandwidth tests.

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
OS                        Mhz  null  null        open  selct  sig   sig    fork    exec     sh
                               call  I/O   stat  clos  TCP    inst  hndl   proc    proc    proc
------------------------ ----  ----  ----  ----  ----  -----  ----  ----  ------  ------  ------
Linux 2.4.18pre2aa2            0.43    na  3.18  4.79   61.8  1.44  3.17     711    2839   11156
Linux 2.4.18-pre3              0.43    na  3.34  5.83   38.6  1.51  3.28     908    3656   13139
Linux 2.4.18pre3ll             0.43    na  3.39  4.98   41.5  1.49  3.19     884    3524   12829
Linux 2.4.18pre3pelb           0.43    na  4.46  5.98   41.5  1.57  3.94     919    3620   13155


Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
OS                        2p/0K  2p/16K  2p/64K  8p/16K  8p/64K  16p/16K 16p/64K
                          ctxsw  ctxsw   ctxsw   ctxsw   ctxsw   ctxsw   ctxsw
------------------------  -----  ------  ------  ------  ------  ------  ------
Linux 2.4.18pre2aa2       1.24   21.64   180.3   56.1    203.0    58.0   223.6
Linux 2.4.18-pre3         1.06   25.13   192.5   57.5    206.4    59.4   226.3
Linux 2.4.18pre3ll        1.74   23.71   192.3   57.6    207.7    59.1   225.5
Linux 2.4.18pre3pelb      2.55   25.36   187.3   61.8    207.2    62.2   227.0


*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
OS                       2p/0K  Pipe    AF    UDP    RPC/   TCP    RPC/   TCP
                         ctxsw         UNIX           UDP           TCP   conn
-----------------------  -----  -----  -----  -----  -----  -----  -----  -----
Linux 2.4.18pre2aa2      2.04  10.65  20.67     na     na  64.99     na  269.7
Linux 2.4.18-pre3        2.04  9.846  16.45     na     na  73.41     na  286.7
Linux 2.4.18pre3ll       2.04  9.763   18.7     na     na     78     na  293.5
Linux 2.4.18pre3pelb     2.04  16.38  17.95     na     na  67.98     na  312.5


File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
OS                          0K    File     10K    File     Mmap    Prot   Page
                          Create  Delete  Create  Delete  Latency  Fault  Fault
------------------------  ------  ------  ------  ------  -------  -----  -----
Linux 2.4.18pre2aa2        149.5   166.9     610   257.1    2683   1.194   5.6
Linux 2.4.18-pre3          148.6   172.7   637.3   257.7    5308   1.084   6.7
Linux 2.4.18pre3ll         153.1   177.9   636.9   274.7    3447   1.003   6.9
Linux 2.4.18pre3pelb       154.6   182.6   649.0   270.3    2753   0.618   7.0


*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
OS                        Pipe    AF     TCP   File    Mmap    Bcopy   Bcopy   Mem    Mem
                                 UNIX          reread  reread  (libc)  (hand)  read   write
------------------------  -----  -----  -----  ------  ------  ------  ------  -----  -----
Linux 2.4.18pre2aa2        69.9   50.0   45.4    62.5   237.6    59.2    60.4  237.5   85.0
Linux 2.4.18-pre3          68.7   49.5   44.2    60.7   237.5    59.2    60.4  237.5   85.0
Linux 2.4.18pre3ll         65.0   45.0   50.4    59.8   237.3    59.2    60.4  237.4   85.1
Linux 2.4.18pre3pelb       68.5   41.9   44.2    61.7   237.4    59.2    60.4  237.3   85.1


Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
OS                         Mhz   L1 $   L2 $    Main mem
-------------------------  ----  -----  ------  --------
Linux 2.4.18pre2aa2         501   4.2     193      262
Linux 2.4.18-pre3           501   4.2   191.7    261.9
Linux 2.4.18pre3ll          501   4.2   194.8    261.9
Linux 2.4.18pre3pelb        501   4.2   191.8    262.3


dbench
------
2.4.18pre2aa2           Throughput 22.2399 MB/sec 64 procs
2.4.18pre3ll		Throughput 12.563  MB/sec 64 procs
2.4.18-pre3		Throughput 12.0448 MB/sec 64 procs
2.4.18pre3pelb		Throughput 11.9764 MB/sec 64 procs

2.4.18pre2aa2           Throughput 14.902  MB/sec 128 procs
2.4.18pre3ll		Throughput 7.93162 MB/sec 128 procs
2.4.18pre3pelb		Throughput 7.76489 MB/sec 128 procs
2.4.18-pre3		Throughput 7.72214 MB/sec 128 procs

2.4.18pre2aa2           Throughput 8.75662 MB/sec 192 procs
2.4.18pre3ll		Throughput 7.83356 MB/sec 192 procs
2.4.18-pre3		Throughput 7.32843 MB/sec 192 procs
2.4.18pre3pelb		Throughput 6.95136 MB/sec 192 procs


BYTE UNIX Benchmarks (Version 4.1.0)
                                2.4.18pre3ll  2.4.18pre3pelb  2.4.18pre3  2.4.18pre2aa2
Execl Throughput                        329.7        305.0          311.1         391.4
File Read 1024 bufsize 2000 maxb     164316.0     152915.0       171358.0      169157.0
File Write 1024 bufsize 2000 max      41825.0      38918.0        43153.0       44459.0
File Copy 1024 bufsize 2000 maxb      29279.0      28279.0        31533.0       31036.0
File Read 256 bufsize 500 maxblo     116575.0     102763.0       118511.0      116442.0
File Write 256 bufsize 500 maxbl      16163.0      15563.0        18021.0       17119.0
File Copy 256 bufsize 500 maxblo      12812.0      11072.0        13496.0       13932.0
File Read 4096 bufsize 8000 maxb     152353.0     150358.0       158244.0      150669.0
File Write 4096 bufsize 8000 max      62735.0      63425.0        66933.0       64480.0
File Copy 4096 bufsize 8000 maxb      40332.0      41387.0        43400.0       41999.0
Pipe Throughput                      319240.9     301399.6       384233.8      387119.6
Pipe-based Context Switching          95662.9      46867.6       103815.3      112401.9
Process Creation                       1182.9       1088.6         1182.1        1378.7
System Call Overhead                 303256.1     224553.0       335236.6      342022.3
Shell Scripts (1 concurrent)            634.1        624.7          615.0         692.7
Shell Scripts (8 concurrent)             86.0         84.3           84.0          97.7
Shell Scripts (16 concurrent)            43.0         42.0           42.0          49.0
Shell Scripts (32 concurrent)            21.0         21.0           21.0          24.0
Shell Scripts (64 concurrent)            10.0         10.0           10.0          12.0
Shell Scripts (96 concurrent)             6.6          6.3            6.3           8.3
C Compiler Throughput                   229.4        222.0          224.7         265.9
Dc: sqrt(2) to 99 decimal places      15045.9      13881.1        14874.8       20420.1
Recursion Test--Tower of Hanoi        14154.3      14152.5        14154.8       14151.6

More results at http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
-- 
Randy Hron

