Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTBCXD4>; Mon, 3 Feb 2003 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBCXD4>; Mon, 3 Feb 2003 18:03:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5273 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266964AbTBCXDp>;
	Mon, 3 Feb 2003 18:03:45 -0500
Date: Mon, 03 Feb 2003 15:05:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: gcc 2.95 vs 3.21 performance
Message-ID: <336780000.1044313506@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People keep extolling the virtues of gcc 3.2 to me, which I'm
reluctant to switch to, since it compiles so much slower. But
it supposedly generates better code, so I thought I'd compile
the kernel with both and compare the results. This is gcc 2.95
and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
tests still use 2.95 for the compile-time stuff.

The results below leaves me distinctly unconvinced by the supposed 
merits of modern gcc's. Not really better or worse, within experimental
error. But much slower to compile things with.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                        2.5.59       46.08      563.88      118.38     1480.00
                 2.5.59-gcc3.2       45.86      563.63      119.58     1489.33

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                        2.5.59       47.45      568.02      143.17     1498.17
                 2.5.59-gcc3.2       47.15      567.41      143.72     1507.50

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         0.8%
                 2.5.59-gcc3.2        95.3%         5.2%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         0.6%
                 2.5.59-gcc3.2        91.9%         7.1%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         5.7%
                 2.5.59-gcc3.2        98.8%         5.3%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         1.4%
                 2.5.59-gcc3.2       105.3%         4.7%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         1.7%
                 2.5.59-gcc3.2       103.1%         1.8%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         1.5%
                 2.5.59-gcc3.2       101.0%         1.6%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.59       100.0%         0.7%
                 2.5.59-gcc3.2       103.1%         1.1%

SDET 128  (see disclaimer)
                                Throughput    Std. Dev

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       38.88       82.78        0.65
                 2.5.59-gcc3.2        0.00       41.80      107.76        0.73

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       49.30      247.80        1.93
                 2.5.59-gcc3.2        0.00       38.00      229.83        2.11

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       57.37      843.12        3.77
                 2.5.59-gcc3.2        0.00       57.28      839.21        2.85

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00      116.99     1805.79        6.05
                 2.5.59-gcc3.2        0.00      118.44     1788.09        6.25

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00      235.18     3632.73       15.45
                 2.5.59-gcc3.2        0.00      234.55     3633.76       15.02



------------------------------------------------------------------------------


And with the same kernel, comparing the compile times for gcc 2.95 to 3.2

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                        gcc2.95      46.08      563.88      118.38     1480.00
                        gcc3.21      69.93      923.17      114.36     1483.17

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                        gcc2.95      47.45      568.02      143.17     1498.17
                        gcc3.21      71.44      926.45      134.89     1485.33

pft.

