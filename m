Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbSJKOR7>; Fri, 11 Oct 2002 10:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbSJKOR6>; Fri, 11 Oct 2002 10:17:58 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:1664 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262465AbSJKORx> convert rfc822-to-8bit; Fri, 11 Oct 2002 10:17:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.41-mm3 +/- shared pagetables with contest
Date: Sat, 12 Oct 2002 00:21:08 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210120021.18790.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the contest (http://contest.kolivas.net) benchmarks for 2.5.41-mm3 
and 2.5.41-mm3 with shared 3rd level pagetables enabled (2.5.41-mm3s)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              73.8    93      0       0       1.10
2.5.41-mm1 [3]          73.3    92      0       0       1.09
2.5.41-mm2 [2]          74.2    92      0       0       1.10
2.5.41-mm3 [1]          74.4    93      0       0       1.11
2.5.41-mm3s [1]         74.0    93      0       0       1.10

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              91.1    73      38      30      1.36
2.5.41-mm1 [3]          88.8    75      32      27      1.32
2.5.41-mm2 [2]          91.7    75      37      27      1.37
2.5.41-mm3 [1]          95.5    75      31      28      1.42
2.5.41-mm3s [2]         96.1    74      42      28      1.43

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [2]              607.5   13      47      12      9.04
2.5.41-mm1 [3]          307.7   26      18      10      4.58
2.5.41-mm2 [3]          294.3   26      17      10      4.38
2.5.41-mm3 [1]          312.4   25      20      11      4.65
2.5.41-mm3s [2]         425.5   18      27      10      6.33

Here we see a difference with a bias towards more work being done by io 
loading at the expense of kernel compilation time.

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              101.6   73      30      3       1.51
2.5.41-mm1 [3]          144.6   50      37      2       2.15
2.5.41-mm2 [3]          139.2   52      36      2       2.07
2.5.41-mm3 [2]          107.1   68      27      2       1.59
2.5.41-mm3s [2]         116.5   62      28      2       1.73

Here we see a substantial improvement under mem_load with -mm3 compared to 
previous -mm kernels with the new vm_swappiness feature to close to that of 
vanilla 2.5.41. However adding shared pagetables seems to make the results a 
little worse.

Experimental loads:

tarc_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              93.3    81      1       6       1.39
2.5.41-mm1 [3]          91.6    81      1       5       1.36
2.5.41-mm2 [2]          91.0    81      1       5       1.35
2.5.41-mm3 [1]          92.1    81      1       5       1.37
2.5.41-mm3s [1]         92.8    80      1       5       1.38

tarx_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [2]              138.8   53      2       8       2.07
2.5.41-mm1 [3]          188.4   43      2       7       2.80
2.5.41-mm2 [2]          195.3   38      2       7       2.91
2.5.41-mm3 [1]          215.9   34      3       7       3.21
2.5.41-mm3s [1]         231.1   32      3       7       3.44

These seem to be suffering increasingly since vm_swappiness, and worse again 
with shared pagetables.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              101.1   75      7       4       1.51
2.5.41-mm1 [3]          106.8   70      5       3       1.59
2.5.41-mm2 [2]          104.2   71      6       4       1.55
2.5.41-mm3 [1]          102.0   74      6       4       1.52
2.5.41-mm3s [1]         105.2   72      7       4       1.57

lslr_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41 [1]              93.6    75      1       18      1.39
2.5.41-mm1 [3]          96.8    72      1       21      1.44
2.5.41-mm2 [2]          97.4    72      1       21      1.45
2.5.41-mm3 [1]          95.9    74      1       22      1.43
2.5.41-mm3s [1]         97.4    73      1       22      1.45


Performance under heavy mem load seems to have been improved substantially 
with -mm3. Performance under repeated tar x loading seems to be progressively 
dropping off. The shared pagetables seem to only disadvantage contest based 
benchmark results.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9pt5YF6dfvkL3i1gRAn6UAJ4rwBMf04cT1hOrSm4H2XbsMPrWZgCfUJgQ
Y0Zookbdk9VkmyuHYDn9Q0s=
=S94Y
-----END PGP SIGNATURE-----

