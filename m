Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTBTEPz>; Wed, 19 Feb 2003 23:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBTEPz>; Wed, 19 Feb 2003 23:15:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16554 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264822AbTBTEPy>; Wed, 19 Feb 2003 23:15:54 -0500
Date: Wed, 19 Feb 2003 20:25:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: Performance of partial object-based rmap
Message-ID: <7490000.1045715152@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The performance delta between 2.5.62-mjb1 and 2.5.62-mjb2 is caused
by the partial object-based rmap patch (written by Dave McCracken).
I expect this patch to have an increasing impact on workloads with
more processes, and it should give a substantial space saving as 
well as a performance increase. Results from 16x NUMA-Q system ... 

Profile comparison:

before
	15525 page_remove_rmap
	6415 page_add_rmap

after
	2055 page_add_rmap
	1983 page_remove_rmap

(performance of 62 was equivalent to 61)

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                        2.5.61       45.77      561.71      118.87     1486.50
                   2.5.62-mjb1       45.81      564.41      112.76     1478.00
                   2.5.62-mjb2       44.88      563.64       98.29     1474.50

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                        2.5.61       47.46      565.70      144.77     1496.33
                   2.5.62-mjb1       47.21      569.17      139.55     1500.67
                   2.5.62-mjb2       46.09      568.19      121.83     1496.67

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         4.5%
                   2.5.62-mjb1        95.2%         3.0%
                   2.5.62-mjb2        97.1%         4.6%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         4.3%
                   2.5.62-mjb1        93.4%         6.6%
                   2.5.62-mjb2        99.4%         6.1%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         2.4%
                   2.5.62-mjb1       101.9%         7.1%
                   2.5.62-mjb2       116.9%         1.5%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         7.4%
                   2.5.62-mjb1       111.1%         1.8%
                   2.5.62-mjb2       121.8%         5.9%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         2.0%
                   2.5.62-mjb1       105.0%         2.2%
                   2.5.62-mjb2       107.0%         2.1%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         7.9%
                   2.5.62-mjb1       112.4%         1.2%
                   2.5.62-mjb2       116.8%         0.9%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                        2.5.61       100.0%         1.2%
                   2.5.62-mjb1       111.0%         0.7%
                   2.5.62-mjb2       116.0%         0.9%

