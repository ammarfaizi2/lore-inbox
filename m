Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277129AbRJIM6n>; Tue, 9 Oct 2001 08:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277132AbRJIM6e>; Tue, 9 Oct 2001 08:58:34 -0400
Received: from 103bus48.tampabay.rr.com ([24.94.103.48]:18948 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S277129AbRJIM6U>;
	Tue, 9 Oct 2001 08:58:20 -0400
Message-ID: <3BC2F4FA.B29F2546@leoninedev.com>
Date: Tue, 09 Oct 2001 09:00:42 -0400
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy with this patch too, as it stops my machine from crashing when switching to user-space.
I've run several LMbench tests against both 686-optimized and Athlon-optimized kernels.  The
results waver across multiple tests, one kernel winning some tests one time and losing the next,
but the values are all close.  I can post the results of any benchmarks 686 vs Athlon anyone wants
me to run if we can get this patch in soon!

Here's the dump of my LMbench runs, if anyone wants to oggle the numbers:
                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
Athlon-1  Linux 2.4.10-       i686-pc-linux-gnu 1333
Athlon-2  Linux 2.4.10-       i686-pc-linux-gnu 1333
i686-1    Linux 2.4.10-       i686-pc-linux-gnu 1333
i686-2    Linux 2.4.10-       i686-pc-linux-gnu 1333

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
Athlon-1  Linux 2.4.10- 1333 0.21 0.29 4.93 5.74  17.1 0.60 1.90 142. 770. 8593
Athlon-2  Linux 2.4.10- 1333 0.21 0.29 5.24 5.98  28.8 0.60 1.90 152. 823. 8771
i686-1    Linux 2.4.10- 1333 0.21 0.29 4.61 5.47  29.5 0.60 1.91 141. 776. 8670
i686-2    Linux 2.4.10- 1333 0.20 0.29 5.02 5.86  32.7 0.60 1.88 156. 870. 8871

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
Athlon-1  Linux 2.4.10- 1.030 1.2900   11.6 3.5800  125.5    20.2   126.7
Athlon-2  Linux 2.4.10- 0.820 1.3800   11.7 3.6200  125.8    27.4   126.2
i686-1    Linux 2.4.10- 0.820 1.3100   11.6 3.8400  125.8    24.6   125.9
i686-2    Linux 2.4.10- 0.590 1.2700   11.7 3.9100  125.5    20.7   126.1

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
Athlon-1  Linux 2.4.10- 1.030 3.227 5.41 9.664  21.8  12.1  32.7 49.5
Athlon-2  Linux 2.4.10- 0.820 4.015 6.78  10.4  23.0  14.0  33.9 50.8
i686-1    Linux 2.4.10- 0.820 3.510 6.01 9.569  21.5  12.2  33.4 599K
i686-2    Linux 2.4.10- 0.590 4.153 6.75  10.1  23.0  13.2  34.1 18.M

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
Athlon-1  Linux 2.4.10-   29.1   41.5  190.1   66.0    523.0 0.448 2.00000
Athlon-2  Linux 2.4.10-   30.9   43.9  199.3   64.2    537.0 0.429 2.00000
i686-1    Linux 2.4.10-   29.0   41.9  209.4   65.2    532.0 0.634 2.00000
i686-2    Linux 2.4.10-   31.0   44.1  187.1   64.5    610.0 0.436 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
Athlon-1  Linux 2.4.10- 847. 685. 311.  332.4  501.3  176.2  206.2 471. 342.5
Athlon-2  Linux 2.4.10- 882. 586. 187.  331.6  510.2  177.6  207.1 484. 343.5
i686-1    Linux 2.4.10- 863. 586. 299.  320.0  510.2  176.3  206.6 472. 342.6
i686-2    Linux 2.4.10- 874. 318. 199.  319.6  520.2  177.7  206.8 486. 343.5

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
Athlon-1  Linux 2.4.10-  1333 2.259   15.1  155.3
Athlon-2  Linux 2.4.10-  1333 2.259   15.1  155.4
i686-1    Linux 2.4.10-  1333 2.259   15.1  155.3
i686-2    Linux 2.4.10-  1333 2.259   15.1  155.3


