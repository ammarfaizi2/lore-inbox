Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSKIBym>; Fri, 8 Nov 2002 20:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264612AbSKIBym>; Fri, 8 Nov 2002 20:54:42 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:5248 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264610AbSKIByk> convert rfc822-to-8bit; Fri, 8 Nov 2002 20:54:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sat, 9 Nov 2002 13:00:19 +1100
User-Agent: KMail/1.4.3
Cc: marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211091300.32127.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are some contest benchmarks of recent 2.4 kernels (this is mainly to test 
2.4.20-rc1/aa1):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.4.19 [5]              69.0    97      0       0       0.97
2.4.19-ck9 [2]          68.8    97      0       0       0.96
2.4.20-rc1 [3]          72.2    93      0       0       1.01
2.4.20-rc1aa1 [1]       71.9    94      0       0       1.01

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.4.19 [2]              68.0    99      0       0       0.95
2.4.19-ck9 [2]          66.1    99      0       0       0.93
2.4.20-rc1 [3]          67.2    99      0       0       0.94
2.4.20-rc1aa1 [1]       67.4    99      0       0       0.94

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.4.19 [3]              106.5   59      112     43      1.49
2.4.19-ck9 [2]          94.3    70      83      32      1.32
2.4.20-rc1 [3]          110.7   58      119     43      1.55
2.4.20-rc1aa1 [3]       110.5   58      117     43      1.55

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.4.19 [2]              106.5   70      1       8       1.49
2.4.19-ck9 [2]          110.5   71      1       9       1.55
2.4.20-rc1 [3]          102.1   72      1       7       1.43
2.4.20-rc1aa1 [3]       107.1   69      1       7       1.50

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.4.19 [1]              132.4   55      2       9       1.85
2.4.19-ck9 [2]          138.6   58      2       11      1.94
2.4.20-rc1 [3]          180.7   40      3       8       2.53
2.4.20-rc1aa1 [3]       166.6   44      2       7       2.33

First noticeable difference. With repeated extracting of tars while compiling 
kernels 2.4.20-rc1 seems to be slower and aa1 curbs it just a little.

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.4.19 [3]              492.6   14      38      10      6.90
2.4.19-ck9 [2]          140.6   49      5       5       1.97
2.4.20-rc1 [2]          1142.2  6       90      10      16.00
2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86

Well this is interesting. 2.4.20-rc1 seems to have improved it's ability to do 
IO work. Unfortunately it is now busy starving the scheduler in the mean 
time, much like the 2.5 kernels did before the deadline scheduler was put in.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.4.19 [2]              134.1   54      14      5       1.88
2.4.19-ck9 [2]          77.4    85      11      9       1.08
2.4.20-rc1 [3]          173.2   43      20      5       2.43
2.4.20-rc1aa1 [3]       150.6   51      16      5       2.11

Also a noticeable difference, repeatedly reading a large file while trying to 
compile a kernel has slowed down in 2.4.20-rc1 and aa1 blunts this effect 
somewhat.

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.4.19 [1]              89.8    77      1       20      1.26
2.4.19-ck9 [2]          85.2    79      1       22      1.19
2.4.20-rc1 [3]          88.8    77      0       12      1.24
2.4.20-rc1aa1 [1]       88.1    78      1       16      1.23

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.4.19 [3]              100.0   72      33      3       1.40
2.4.19-ck9 [2]          78.3    88      31      8       1.10
2.4.20-rc1 [3]          105.9   69      32      2       1.48
2.4.20-rc1aa1 [1]       106.3   69      33      3       1.49

It would seem most of the changes from 2.4.19 to 2.4.20-rc1 are consistent 
with increased IO throughput but this happens at the expense of doing other 
tasks. The -aa addons help with this but surprisingly not with mem_loading.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zGw5F6dfvkL3i1gRAsN8AKCMg2QvnGMhdMlGRdT7sR01ui6gogCbBrxy
imqAHOMc9ZXwAjoohbd9av4=
=Plvk
-----END PGP SIGNATURE-----

