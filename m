Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTBFPdG>; Thu, 6 Feb 2003 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTBFPdF>; Thu, 6 Feb 2003 10:33:05 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41880 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267330AbTBFPdE>; Thu, 6 Feb 2003 10:33:04 -0500
Date: Thu, 06 Feb 2003 07:42:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: gcc -O2 vs gcc -Os performance
Message-ID: <224770000.1044546145@[10.10.2.4]>
In-Reply-To: <336780000.1044313506@flay>
References: <336780000.1044313506@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled the kernel with gcc -O2 (default) vs -Os
(which people sometimes predict will be faster due to better
cache usage). Didn't bother to measure how much time the compile
itself took like that, but the resultant kernels were compared.
Summary ... -Os is a little slower (note system times on kernbench,
SDET and NUMAschedbench I consider within experimental error),
but not drastically. I wouldn't switch to it though ;-)

All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
with a puny cache if someone wants to try that out.

M.

sizes:

894822 Feb  5 23:50 /boot/vmlinuz-2.5.59-mjb3-Os
906203 Feb  5 22:46 /boot/vmlinuz-2.5.59-mjb3.old

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                   2.5.59-mjb3       45.66      565.33      110.18     1479.00
                2.5.59-mjb3-Os       45.58      565.38      111.42     1484.33

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                   2.5.59-mjb3       46.87      569.77      133.32     1499.67
                2.5.59-mjb3-Os       46.86      569.30      134.63     1501.50

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         4.1%
                2.5.59-mjb3-Os        95.1%         6.7%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         8.0%
                2.5.59-mjb3-Os       101.2%         5.8%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         6.2%
                2.5.59-mjb3-Os        99.4%        14.1%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         3.3%
                2.5.59-mjb3-Os       100.5%         2.2%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         3.2%
                2.5.59-mjb3-Os        98.9%         2.4%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         2.2%
                2.5.59-mjb3-Os        97.2%         1.6%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.59-mjb3       100.0%         0.4%
                2.5.59-mjb3-Os        99.9%         0.3%

SDET 128  (see disclaimer)
                                Throughput    Std. Dev

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.59-mjb3        0.00       34.62       90.63        0.91
                2.5.59-mjb3-Os        0.00       40.35       81.94        0.69

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.59-mjb3        0.00       52.16      266.45        1.51
                2.5.59-mjb3-Os        0.00       46.61      248.47        1.49

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.59-mjb3        0.00       57.38      845.30        3.58
                2.5.59-mjb3-Os        0.00       58.34      851.12        2.94

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.59-mjb3        0.00      118.05     1806.79        6.24
                2.5.59-mjb3-Os        0.00      115.85     1803.72        6.29

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                   2.5.59-mjb3        0.00      236.59     3627.47       15.24
                2.5.59-mjb3-Os        0.00      236.90     3631.11       15.35

