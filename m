Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbSJKEID>; Fri, 11 Oct 2002 00:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbSJKEID>; Fri, 11 Oct 2002 00:08:03 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:44672 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262335AbSJKEIB> convert rfc822-to-8bit; Fri, 11 Oct 2002 00:08:01 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.41-mm2 with contest
Date: Fri, 11 Oct 2002 14:11:21 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210111411.25103.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the latest results for 2.5.41-mm2 with contest 
(http://contest.kolivas.net)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.5.38 [3]              72.0    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.40 [1]              72.5    93      0       0       1.08
2.5.41 [1]              73.8    93      0       0       1.10
2.5.41-mm1 [3]          73.3    92      0       0       1.09
2.5.41-mm2 [2]          74.2    92      0       0       1.10

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.59
2.5.38 [3]              89.5    74      34      28      1.33
2.5.39 [2]              91.2    73      36      28      1.36
2.5.40 [2]              82.8    80      25      23      1.23
2.5.41 [1]              91.1    73      38      30      1.36
2.5.41-mm1 [3]          88.8    75      32      27      1.32
2.5.41-mm2 [2]          91.7    75      37      27      1.37

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      7.33
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.39 [2]              423.9   18      30      11      6.31
2.5.40 [1]              315.7   25      22      10      4.70
2.5.41 [2]              607.5   13      47      12      9.04
2.5.41-mm1 [3]          307.7   26      18      10      4.58
2.5.41-mm2 [3]          294.3   26      17      10      4.38

Both the -mm results avoid the increased IO based slowdown that has come back 
in 2.5.41

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.49
2.5.38 [3]              107.3   70      34      3       1.60
2.5.39 [2]              103.1   72      31      3       1.53
2.5.40 [2]              102.5   72      31      3       1.53
2.5.41 [1]              101.6   73      30      3       1.51
2.5.41-mm1 [3]          144.6   50      37      2       2.15
2.5.41-mm2 [3]          139.2   52      36      2       2.07

You can see clearly how the lowered vm_swappiness present since 2.5.41-mm1 has 
made it slower under mem_load. It has relaxed slightly since the changes to 
- -mm2. Below is a set of results with -mm2 and my suggested autoregulation 
changes to vm_swappiness:

2.5.41-mm2v [2]         114.6   64      29      2       1.71

While it still is slower than vanilla, this modification makes for a far less 
swappy kernel except when it is heavily called upon.

Here are also the experimental loads:

tarc_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.59
2.5.38 [1]              97.2    79      1       6       1.45
2.5.39 [1]              91.8    83      1       6       1.37
2.5.40 [1]              96.9    80      1       6       1.44
2.5.41 [1]              93.3    81      1       6       1.39
2.5.41-mm1 [3]          91.6    81      1       5       1.36
2.5.41-mm2 [2]          91.0    81      1       5       1.35

tarx_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.97
2.5.38 [1]              120.5   63      2       8       1.79
2.5.39 [1]              108.3   69      1       6       1.61
2.5.40 [1]              110.7   68      1       6       1.65
2.5.41 [2]              138.8   53      2       8       2.07
2.5.41-mm1 [3]          188.4   43      2       7       2.80
2.5.41-mm2 [2]          195.3   38      2       7       2.91

This also seems to be detrimentally affected by decreased vm_swappiness, as 
autoregulation changes the results to this:

2.5.41-mm2v [2]         136.4   54      1       7       2.03

Which seems to bring it back into line with 2.5.41

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       2.00
2.5.38 [2]              100.5   76      9       5       1.50
2.5.39 [2]              101.3   74      14      6       1.51
2.5.40 [1]              101.5   73      13      5       1.51
2.5.41 [1]              101.1   75      7       4       1.51
2.5.41-mm1 [3]          106.8   70      5       3       1.59
2.5.41-mm2 [2]          104.2   71      6       4       1.55

lslr_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.34
2.5.38 [1]              99.1    71      1       20      1.48
2.5.39 [1]              101.3   70      2       24      1.51
2.5.40 [1]              97.0    72      1       21      1.44
2.5.41 [1]              93.6    75      1       18      1.39
2.5.41-mm1 [3]          96.8    72      1       21      1.44
2.5.41-mm2 [2]          97.4    72      1       21      1.45

Comments?
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9pk9pF6dfvkL3i1gRAh2kAJwO1GFsRij3Wj1r+T893DtgMZ8eRgCghu4Q
LKMO/ieLHpZdWBE1XW/S3+4=
=LfDR
-----END PGP SIGNATURE-----
