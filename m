Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbTBFU2x>; Thu, 6 Feb 2003 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTBFU2x>; Thu, 6 Feb 2003 15:28:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:45291 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267626AbTBFU2s>; Thu, 6 Feb 2003 15:28:48 -0500
Date: Thu, 06 Feb 2003 12:38:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc -O2 vs gcc -Os performance
Message-ID: <263740000.1044563891@[10.10.2.4]>
In-Reply-To: <1044553691.10374.20.camel@irongate.swansea.linux.org.uk>
References: <336780000.1044313506@flay>  <224770000.1044546145@[10.10.2.4]> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
>> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
>> with a puny cache if someone wants to try that out
> 
> gcc 3.2 is a lot smarter about -Os and it makes a very big size
> difference according to the numbers the from the ACPI guys.
> 
> Im not sure testing with a gcc from the last millenium is useful 8)

Still no use.
/me throws gcc-3.2 in the trash can.

2901299 vmlinux.O2
2667827 vmlinux.Os


Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
          2.5.59-mjb3-gcc32-O2       45.86      564.75      110.91     1472.67
          2.5.59-mjb3-gcc32-Os       45.74      563.96      111.06     1475.17

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
          2.5.59-mjb3-gcc32-O2       46.83      569.15      133.88     1500.50
          2.5.59-mjb3-gcc32-Os       46.90      568.17      134.58     1497.83

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         3.4%
          2.5.59-mjb3-gcc32-Os        99.8%         2.8%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         6.7%
          2.5.59-mjb3-gcc32-Os       101.2%         4.9%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         3.8%
          2.5.59-mjb3-gcc32-Os        95.1%         3.0%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         1.1%
          2.5.59-mjb3-gcc32-Os        98.1%         1.4%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         1.6%
          2.5.59-mjb3-gcc32-Os        97.7%         1.7%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         1.1%
          2.5.59-mjb3-gcc32-Os       103.7%         1.9%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
          2.5.59-mjb3-gcc32-O2       100.0%         1.4%
          2.5.59-mjb3-gcc32-Os        96.6%         9.7%

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
          2.5.59-mjb3-gcc32-O2        0.00       36.93       88.84        0.62
          2.5.59-mjb3-gcc32-Os        0.00       44.28       96.95        0.67

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
          2.5.59-mjb3-gcc32-O2        0.00       54.16      327.57        1.58
          2.5.59-mjb3-gcc32-Os        0.00       50.66      248.42        1.89

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
          2.5.59-mjb3-gcc32-O2        0.00       57.17      851.44        3.09
          2.5.59-mjb3-gcc32-Os        0.00       57.25      849.20        3.14

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
          2.5.59-mjb3-gcc32-O2        0.00      117.82     1808.42        6.34
          2.5.59-mjb3-gcc32-Os        0.00      130.02     1814.74        6.52

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
          2.5.59-mjb3-gcc32-O2        0.00      236.82     3616.04       15.17
          2.5.59-mjb3-gcc32-Os        0.00      241.34     3624.50       16.39

