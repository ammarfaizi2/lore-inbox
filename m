Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLZI0b>; Thu, 26 Dec 2002 03:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbSLZI0b>; Thu, 26 Dec 2002 03:26:31 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:34707 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S262662AbSLZI0Y>;
	Thu, 26 Dec 2002 03:26:24 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.53-mm1 with contest
Date: Thu, 26 Dec 2002 19:34:33 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212261934.36086.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are some contest results for 2.5.53-mm1 with osdl hardware:
Share pagetables is on.

Uniprocessor:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              70.2    96      0       0       1.05
2.5.52-mm1 [7]          74.7    96      0       0       1.12
2.5.52-mm2 [7]          74.6    96      0       0       1.12
2.5.53 [7]              70.1    96      0       0       1.05
2.5.53-mm1 [7]          71.0    96      0       0       1.06
The slowdown that occurred noload and cacherun at 2.5.52-mm1/2 seems to have 
gone away. I have NFI why it happened. Probably just a hardware anomaly at 
the time unless someone else noticed it also?


cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              67.5    99      0       0       1.01
2.5.52-mm1 [7]          71.9    99      0       0       1.08
2.5.52-mm2 [7]          72.0    99      0       0       1.08
2.5.53 [7]              67.6    99      0       0       1.01
2.5.53-mm1 [7]          68.5    99      0       0       1.03

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              84.4    79      17      19      1.26
2.5.52-mm1 [7]          91.0    79      18      19      1.36
2.5.52-mm2 [7]          90.3    79      18      19      1.35
2.5.53 [7]              86.9    77      18      21      1.30
2.5.53-mm1 [7]          117.1   58      47      40      1.75
Big change in the balance here in process_load. Probably a better balance 
really given that process_load runs 4*num_cpus processes, and the kernel 
compile is make -j (4*num_cpus)


ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              109.8   81      2       8       1.64
2.5.52-mm1 [7]          112.2   81      3       9       1.68
2.5.52-mm2 [7]          109.6   81      2       9       1.64
2.5.53 [7]              107.4   81      3       9       1.61
2.5.53-mm1 [7]          103.1   79      3       10      1.54

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              161.4   69      3       8       2.42
2.5.52-mm1 [7]          127.9   70      2       7       1.92
2.5.52-mm2 [7]          125.0   70      2       7       1.87
2.5.53 [7]              151.0   69      3       8       2.26
2.5.53-mm1 [7]          150.2   66      2       7       2.25
Seems to correlate with 2.5.53 vanilla time here instead of the mm* of the 
past


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              120.9   60      13      12      1.81
2.5.52-mm1 [7]          143.9   55      18      13      2.16
2.5.52-mm2 [7]          129.3   61      14      12      1.94
2.5.53 [7]              113.9   63      12      12      1.71
2.5.53-mm1 [7]          133.1   57      23      17      1.99
Whereas this correlates with mm*


io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              94.9    76      7       10      1.42
2.5.52-mm1 [7]          115.5   67      11      11      1.73
2.5.52-mm2 [7]          93.3    79      7       9       1.40
2.5.53 [7]              99.5    73      8       10      1.49
2.5.53-mm1 [7]          107.7   70      18      17      1.61
Slightly longer time here with significantly more loads done.


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              88.1    80      15      7       1.32
2.5.52-mm1 [7]          97.0    78      15      6       1.45
2.5.52-mm2 [7]          93.6    80      15      6       1.40
2.5.53 [7]              88.2    80      15      6       1.32
2.5.53-mm1 [7]          89.6    80      12      6       1.34

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              81.0    86      0       9       1.21
2.5.52-mm1 [7]          86.8    85      0       9       1.30
2.5.52-mm2 [7]          86.3    85      0       9       1.29
2.5.53 [7]              81.5    85      0       9       1.22
2.5.53-mm1 [7]          82.1    85      0       9       1.23

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              100.0   78      45      2       1.50
2.5.52-mm1 [7]          117.5   69      45      1       1.76
2.5.52-mm2 [7]          108.0   77      46      2       1.62
2.5.53 [7]              98.7    80      44      2       1.48
2.5.53-mm1 [7]          110.9   67      41      1       1.66


The SMP results seem to fluctuate too much between runs even with the average 
of 7 runs. I'm wondering whether I should even bother with them any more as 
they dont add any useful information as far as I can see. Comments on this 
would be appreciated. Andrew?

SMP Results:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              39.3    181     0       0       1.09
2.5.52-mm1 [8]          39.7    180     0       0       1.10
2.5.52-mm2 [7]          39.2    181     0       0       1.08
2.5.53 [7]              39.4    181     0       0       1.09
2.5.53-mm1 [7]          40.2    181     0       0       1.11

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              36.5    194     0       0       1.01
2.5.52-mm1 [7]          36.9    194     0       0       1.02
2.5.52-mm2 [7]          36.5    194     0       0       1.01
2.5.53 [7]              36.6    194     0       0       1.01
2.5.53-mm1 [7]          37.4    194     0       0       1.03

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              48.7    144     10      49      1.34
2.5.52-mm1 [7]          49.0    144     10      50      1.35
2.5.52-mm2 [7]          46.5    152     8       41      1.28
2.5.53 [7]              47.4    149     9       44      1.31
2.5.53-mm1 [7]          53.3    134     13      59      1.47

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              56.1    161     1       10      1.55
2.5.52-mm1 [7]          55.5    156     1       10      1.53
2.5.52-mm2 [7]          52.8    154     1       10      1.46
2.5.53 [7]              56.2    159     1       10      1.55
2.5.53-mm1 [7]          53.4    159     1       10      1.47

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              83.1    138     1       9       2.29
2.5.52-mm1 [7]          77.4    122     1       8       2.14
2.5.52-mm2 [7]          76.1    124     1       8       2.10
2.5.53 [7]              82.9    129     1       9       2.29
2.5.53-mm1 [7]          69.5    129     1       8       1.92

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              73.1    111     10      19      2.02
2.5.52-mm1 [7]          80.5    108     10      19      2.22
2.5.52-mm2 [7]          74.5    112     11      20      2.06
2.5.53 [7]              80.0    104     12      21      2.21
2.5.53-mm1 [7]          96.4    94      16      22      2.66

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              75.1    120     10      21      2.07
2.5.52-mm1 [7]          60.1    131     7       18      1.66
2.5.52-mm2 [7]          59.9    134     6       18      1.65
2.5.53 [7]              73.6    123     10      21      2.03
2.5.53-mm1 [7]          67.8    122     11      22      1.87

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              49.4    151     5       7       1.36
2.5.52-mm1 [7]          49.9    149     5       6       1.38
2.5.52-mm2 [7]          50.5    147     5       6       1.39
2.5.53 [7]              50.7    151     5       7       1.40
2.5.53-mm1 [7]          51.2    149     5       6       1.41

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              43.2    167     0       9       1.19
2.5.52-mm1 [7]          43.8    167     0       9       1.21
2.5.52-mm2 [7]          43.7    167     0       9       1.21
2.5.53 [7]              43.7    166     0       9       1.21
2.5.53-mm1 [7]          44.1    167     0       9       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              63.5    148     38      3       1.75
2.5.52-mm1 [7]          71.1    123     36      2       1.96
2.5.52-mm2 [7]          66.0    141     39      3       1.82
2.5.53 [7]              63.2    144     37      3       1.75
2.5.53-mm1 [7]          82.6    105     35      2       2.28

The full archived results can be found here (you can see the variation between 
results if you look at each load log eg io_load.log):
http://www.osdl.org/projects/ctdevel/results/

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Cr8ZF6dfvkL3i1gRAirUAKCenx5t3ihTe8bbM9giwXg6pBBEjgCcDznd
JifHb2mieb8qCeQV3gbstuY=
=k6lg
-----END PGP SIGNATURE-----
