Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTARXAZ>; Sat, 18 Jan 2003 18:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTARXAX>; Sat, 18 Jan 2003 18:00:23 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:47294 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S265168AbTARXAS> convert rfc822-to-8bit; Sat, 18 Jan 2003 18:00:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] sched-2.5.59-A2
Date: Sun, 19 Jan 2003 00:09:32 +0100
User-Agent: KMail/1.4.3
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <148970000.1042831603@flay> <1042848809.24867.483.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1042848809.24867.483.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301190009.32245.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scan through a piece of the parameter space delivered quite
unconclusive results. I used the IDLE_NODE_REBALANCE_TICK multipliers
2, 5, 10, 20, 50 and the BUSY_NODE_REBALANCE_TICK multipliers 2, 5,
10, 20.

The benchmarks I tried were kernbench (average and error of 5 kernel
compiles) and hackbench (5 runs for each number of chatter groups
(10,25,50,100). The 2.5.59 scheduler result is printed first, then a
matrix with all combinations of idle and busy rebalance
multipliers. Each value is followed by its standard error (coming from
the 5 measurements). I didn't measure numa_bench, those values depend
mostly on the initial load balancing and showed no clear
tendency/difference.

The machine is an NEC TX7 (small version, 8 Itanium2 CPUs in 4 nodes).

The results:
- kernbench UserTime is best for the 2.5.59 scheduler (623s). IngoB0
best value 627.33s for idle=20ms, busy=2000ms.
- hackbench: 2.5.59 scheduler is significantly better for all
measurements.

I suppose this comes from the fact that the 2.5.59 version has the
chance to load_balance across nodes when a cpu goes idle. No idea what
other reason it could be... Maybe anybody else?

Kernbench:
==========
2.5.59  : Elapsed = 86.29(1.24)
ingo B0 : Elapsed
      idle      2            5            10           20           50
busy		     
2       86.25(0.45)  86.62(1.56)  86.29(0.99)  85.99(0.60)  86.91(1.09)
5       86.87(1.12)  86.38(0.82)  86.00(0.69)  86.14(0.39)  86.47(0.68)
10      86.06(0.18)  86.23(0.38)  86.63(0.57)  86.82(0.95)  86.06(0.15)
20      86.64(1.24)  86.43(0.74)  86.15(0.99)  86.76(1.34)  86.70(0.68)

2.5.59  : UserTime = 623.24(0.46)
ingo B0 : UserTime
      idle      2             5             10            20            50
busy
2       629.05(0.32)  628.54(0.53)  628.51(0.32)  628.66(0.23)  628.72(0.20)
5       628.14(0.88)  628.10(0.76)  628.33(0.41)  628.45(0.48)  628.11(0.37)
10      627.97(0.30)  627.77(0.23)  627.75(0.21)  627.33(0.45)  627.63(0.52)
20      627.55(0.36)  627.67(0.58)  627.36(0.67)  627.84(0.28)  627.69(0.59)

2.5.59  : SysTime = 21.83(0.16)
ingo B0 : SysTime
      idle      2            5            10           20           50
busy
2       21.99(0.26)  21.89(0.12)  22.12(0.16)  22.06(0.21)  22.44(0.51)
5       22.07(0.21)  22.29(0.54)  22.15(0.08)  22.09(0.26)  21.90(0.18)
10      22.01(0.20)  22.42(0.42)  22.28(0.23)  22.04(0.37)  22.41(0.26)
20      22.03(0.20)  22.08(0.30)  22.31(0.27)  22.03(0.19)  22.35(0.33)


Hackbench  10
=============
2.5.59 : 0.77(0.03)
ingo B0:
      idle      2           5           10          20          50
busy
2       0.90(0.07)  0.88(0.05)  0.84(0.05)  0.82(0.04)  0.85(0.06)
5       0.87(0.05)  0.90(0.07)  0.88(0.08)  0.89(0.09)  0.86(0.07)
10      0.85(0.06)  0.83(0.05)  0.86(0.08)  0.84(0.06)  0.87(0.06)
20      0.85(0.05)  0.87(0.07)  0.83(0.05)  0.86(0.07)  0.87(0.05)

Hackbench  25
=============
2.5.59 : 1.96(0.05)
ingo B0:
      idle      2           5           10          20          50
busy
2       2.20(0.13)  2.21(0.12)  2.23(0.10)  2.20(0.10)  2.16(0.07)
5       2.13(0.12)  2.17(0.13)  2.18(0.08)  2.10(0.11)  2.16(0.10)
10      2.19(0.08)  2.21(0.12)  2.22(0.09)  2.11(0.10)  2.15(0.10)
20      2.11(0.17)  2.13(0.08)  2.18(0.06)  2.13(0.11)  2.13(0.14)

Hackbench  50
=============
2.5.59 : 3.78(0.10)
ingo B0:
      idle      2           5           10          20          50
busy
2       4.31(0.13)  4.30(0.29)  4.29(0.15)  4.23(0.20)  4.14(0.10)
5       4.35(0.16)  4.34(0.24)  4.24(0.24)  4.09(0.18)  4.12(0.14)
10      4.35(0.23)  4.21(0.14)  4.36(0.24)  4.18(0.12)  4.36(0.21)
20      4.34(0.14)  4.27(0.17)  4.18(0.18)  4.29(0.24)  4.08(0.09)

Hackbench  100
==============
2.5.59 : 7.85(0.37)
ingo B0:
      idle      2           5           10          20          50
busy
2       8.21(0.42)  8.07(0.25)  8.32(0.30)  8.06(0.26)  8.10(0.13)
5       8.13(0.25)  8.06(0.33)  8.14(0.49)  8.24(0.24)  8.04(0.20)
10      8.05(0.17)  8.16(0.13)  8.13(0.16)  8.05(0.24)  8.01(0.30)
20      8.21(0.25)  8.23(0.24)  8.36(0.41)  8.30(0.37)  8.10(0.30)


Regards,
Erich

