Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTADBux>; Fri, 3 Jan 2003 20:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTADBux>; Fri, 3 Jan 2003 20:50:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22982 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262500AbTADBuv>; Fri, 3 Jan 2003 20:50:51 -0500
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200212311429.04382.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
	<200212021629.39060.efocht@ess.nec.de>
	<200212181721.39434.efocht@ess.nec.de> 
	<200212311429.04382.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 17:58:31 -0800
Message-Id: <1041645514.21653.29.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 05:29, Erich Focht wrote:
> Here comes the minimal NUMA scheduler built on top of the O(1) load
> balancer rediffed for 2.5.53 with some changes in the core part. As
> suggested by Michael, I added the cputimes_stat patch, as it is
> absolutely needed for understanding the scheduler behavior.

Thanks for this latest patch.  I've managed to cobble together
a 4 node NUMAQ system (16 700 MHZ PIII procs, 16GB memory) and
ran kernbench and schedbench on this, along with the 2.5.50 and
2.5.52 versions.  Results remain fairly consistent with what
we have been obtaining on earlier versions.

Kernbench:
                        Elapsed       User     System        CPU
             sched50     29.96s   288.308s    83.606s    1240.8%
             sched52    29.836s   285.832s    84.464s    1240.4%
             sched53    29.364s   284.808s    83.174s    1252.6%
             stock50    31.074s   303.664s    89.194s    1264.2%
             stock53    31.204s   306.224s    87.776s    1263.2%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
             sched50      22.00      35.50      88.04       0.86
             sched52      22.04      34.77      88.18       0.75
             sched53      22.16      34.39      88.66       0.74
             stock50      27.18      45.99     108.75       0.87
             stock53       0.00      41.96     133.85       1.07

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
             sched50      32.05      46.81     256.45       1.81
             sched52      32.75      50.33     262.07       1.63
             sched53      30.56      46.58     244.59       1.67
             stock50      44.75      63.68     358.09       2.55
             stock53       0.00      59.64     318.63       2.40

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
             sched50      55.34      70.74     885.61       4.09
             sched52      50.64      62.30     810.50       4.31
             sched53      54.04      70.01     864.84       3.68
             stock50      65.36      80.72    1045.94       5.92
             stock53       0.00      78.01     947.06       6.70

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
             sched50      59.47     139.77    1903.37      10.24
             sched52      58.37     132.90    1868.30       7.45
             sched53      57.35     132.30    1835.49       9.29
             stock50      84.51     194.89    2704.83      12.44
             stock53       0.00     182.95    2612.83      12.46

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
             sched50      63.55     276.81    4067.65      21.58
             sched52      66.75     293.31    4272.72      21.06
             sched53      62.38     276.99    3992.97      19.90
             stock50      99.68     422.06    6380.04      25.92
             stock53       0.00     441.42    6723.01      26.83

Note that the 0.00 in the AvgUser column for stock53 was due to
me not applying the cputime patch (03--cputimes_stat-2.5.53.patch).
Not sure how I managed to forget that one.  I'll rerun this on
a kernel with that patch on Monday.

-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

