Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSKVWUu>; Fri, 22 Nov 2002 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSKVWUu>; Fri, 22 Nov 2002 17:20:50 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:9088 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S265320AbSKVWUt> convert rfc822-to-8bit; Fri, 22 Nov 2002 17:20:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.20-rc2-aa1 with contest
Date: Sat, 23 Nov 2002 09:29:22 +1100
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211230929.31413.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a partial run of contest (http://contest.kolivas.net) benchmarks for 
rc2aa1 with the disk latency hack

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       0.98
2.4.19 [5]              69.0    97      0       0       0.94
2.4.20-rc1 [3]          72.2    93      0       0       0.99
2.4.20-rc1aa1 [1]       71.9    94      0       0       0.98
2420rc2aa1 [1]          71.1    94      0       0       0.97

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.91
2.4.19 [2]              68.0    99      0       0       0.93
2.4.20-rc1 [3]          67.2    99      0       0       0.92
2.4.20-rc1aa1 [1]       67.4    99      0       0       0.92
2420rc2aa1 [1]          66.6    99      0       0       0.91

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.50
2.4.19 [3]              106.5   59      112     43      1.45
2.4.20-rc1 [3]          110.7   58      119     43      1.51
2.4.20-rc1aa1 [3]       110.5   58      117     43      1.51*
2420rc2aa1 [1]          212.5   31      412     69      2.90*

This load just copies data between 4 processes repeatedly. Seems to take 
longer.


ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.60
2.4.19 [2]              106.5   70      1       8       1.45
2.4.20-rc1 [3]          102.1   72      1       7       1.39
2.4.20-rc1aa1 [3]       107.1   69      1       7       1.46
2420rc2aa1 [1]          103.3   73      1       8       1.41

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.06
2.4.19 [1]              132.4   55      2       9       1.81
2.4.20-rc1 [3]          180.7   40      3       8       2.47
2.4.20-rc1aa1 [3]       166.6   44      2       7       2.28*
2420rc2aa1 [1]          217.7   34      4       9       2.97*

Takes longer. Is only one run though so may not be an accurate average.


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.48
2.4.19 [3]              492.6   14      38      10      6.73
2.4.20-rc1 [2]          1142.2  6       90      10      15.60
2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.47
2420rc2aa1 [1]          164.3   44      10      9       2.24

This was where the effect of the disk latency hack was expected to have an 
effect. It sure did.


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.40
2.4.19 [2]              134.1   54      14      5       1.83
2.4.20-rc1 [3]          173.2   43      20      5       2.37
2.4.20-rc1aa1 [3]       150.6   51      16      5       2.06
2420rc2aa1 [1]          140.5   51      13      4       1.92

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.23
2.4.19 [1]              89.8    77      1       20      1.23
2.4.20-rc1 [3]          88.8    77      0       12      1.21
2.4.20-rc1aa1 [1]       88.1    78      1       16      1.20
2420rc2aa1 [1]          99.7    69      1       19      1.36

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.41
2.4.19 [3]              100.0   72      33      3       1.37
2.4.20-rc1 [3]          105.9   69      32      2       1.45

Mem load hung the machine. I could not get rc2aa1 through this part of the 
benchmark no matter how many times I tried to run it. No idea what was going 
on. Easy to reproduce. Simply run the mem_load out of contest (which runs 
until it is killed) and the machine will hang. 

Con

P.S. I'm having mailserver trouble so respond to lkml where I may see 
responses
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE93q/IF6dfvkL3i1gRAqWCAKCp6eZ2MFe4Ag7LqoGwy4+0MbUqxQCgkkxl
AOUDUScNazCAJ2oZrdgDMuE=
=vHmI
-----END PGP SIGNATURE-----
