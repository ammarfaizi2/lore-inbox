Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSJMLYm>; Sun, 13 Oct 2002 07:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSJMLYm>; Sun, 13 Oct 2002 07:24:42 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:5504 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261494AbSJMLYk> convert rfc822-to-8bit; Sun, 13 Oct 2002 07:24:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.42-mm2 contest results
Date: Sun, 13 Oct 2002 21:27:47 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210132128.13752.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the surprisingly different results from 2.5.42-mm2 with the contest 
benchmark (http://contest.kolivas.net). This was run with pagetable sharing 
enabled. Older results hidden for clarity.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          74.4    93      0       0       1.11
2.5.42 [2]              72.5    93      0       0       1.08
2.5.42-mm2 [3]          79.0    92      0       0       1.18

Didn't believe it the first time so I ran it twice more and ran 2.5.42 again 
to make sure something didn't change on my machine, but definitely this was 
slower than 2.5.42. When the kernel compile starts on the flushed ram machine 
with no background load a lot more disk activity seems to occur for the first 
five or so seconds compared to other kernels. I'm not sure if this is related 
to the way the memory and swap is flushed prior to the test or just this 
kernel. This may have affected all the following results too.

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          95.5    75      31      28      1.42
2.5.42 [1]              98.0    69      44      33      1.46
2.5.42-mm2 [2]          104.5   72      31      30      1.56

Slower again, without an increase in the loads.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          92.1    81      1       5       1.37
2.5.42 [1]              96.7    80      1       7       1.44
2.5.42-mm2 [2]          102.3   79      1       6       1.52

Slower; lack resolution of number of loads makes it difficult to determine if 
it's significant. Same with a few of the other loads below.

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          215.9   34      3       7       3.21
2.5.42 [1]              112.7   66      1       7       1.68
2.5.42-mm2 [2]          195.0   41      2       6       2.90

Close to 2.5.41-mm3. Not enough runs to show if it is significant

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          312.4   25      20      11      4.65
2.5.42 [1]              849.1   9       69      12      12.64
2.5.42-mm2 [2]          250.7   34      15      10      3.73

This is showing an improvement with some of the better io load results shown 
by a 2.5 kernel.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          102.0   74      6       4       1.52
2.5.42 [1]              102.0   75      8       5       1.52
2.5.42-mm2 [2]          109.0   75      7       4       1.62

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [1]          95.9    74      1       22      1.43
2.5.42 [1]              97.5    71      1       20      1.45
2.5.42-mm2 [2]          105.3   72      1       24      1.57

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.41-mm3 [2]          107.1   68      27      2       1.59
2.5.42 [1]              104.0   72      30      3       1.55
2.5.42-mm2 [2]          121.2   65      30      2       1.80

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9qVizF6dfvkL3i1gRAm+/AJ9RTjhAPz+YeDa4kNyLgR2t3b8prACfQoAk
tb39kuDH4F9N7ROqwWl6RHU=
=/aJT
-----END PGP SIGNATURE-----

