Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSLSVkn>; Thu, 19 Dec 2002 16:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSLSVkn>; Thu, 19 Dec 2002 16:40:43 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:4736 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266278AbSLSVkU> convert rfc822-to-8bit; Thu, 19 Dec 2002 16:40:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Fri, 20 Dec 2002 08:50:27 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212200850.32886.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

contest results, osdl hardware, scheduler tunable prio_bonus_ratio; default 
value (2.5.52-mm1) is 25; these results are interesting.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [8]          39.7    180     0       0       1.10
pri_bon00 [3]           40.6    180     0       0       1.12
pri_bon10 [3]           40.2    180     0       0       1.11
pri_bon30 [3]           39.7    181     0       0       1.10
pri_bon50 [3]           40.0    179     0       0       1.10

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          36.9    194     0       0       1.02
pri_bon00 [3]           37.6    194     0       0       1.04
pri_bon10 [3]           37.2    194     0       0       1.03
pri_bon30 [3]           36.9    194     0       0       1.02
pri_bon50 [3]           36.7    195     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.0    144     10      50      1.35
pri_bon00 [3]           47.5    152     9       41      1.31
pri_bon10 [3]           48.2    147     10      47      1.33
pri_bon30 [3]           50.1    141     12      53      1.38
pri_bon50 [3]           46.2    154     8       39      1.28
Seems to subtly affect the balance here.


ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          55.5    156     1       10      1.53
pri_bon00 [3]           44.6    165     0       5       1.23
pri_bon10 [3]           45.5    164     0       7       1.26
pri_bon30 [3]           52.0    154     1       10      1.44
pri_bon50 [3]           57.5    158     1       10      1.59
Seems to be a direct relationship; pb up, time up


xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          77.4    122     1       8       2.14
pri_bon00 [3]           60.6    125     0       7       1.67
pri_bon10 [3]           61.7    125     1       8       1.70
pri_bon30 [3]           74.8    128     1       9       2.07
pri_bon50 [3]           74.5    130     1       8       2.06
when pb goes up, time goes up, but maxes out

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          80.5    108     10      19      2.22
pri_bon00 [3]           120.3   94      22      24      3.32
pri_bon10 [3]           123.6   91      20      23      3.41
pri_bon30 [3]           95.8    84      14      20      2.65
pri_bon50 [3]           76.8    114     11      21      2.12
when pb goes up, time goes down (large effect)

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          60.1    131     7       18      1.66
pri_bon00 [3]           142.8   94      27      26      3.94
pri_bon10 [3]           116.5   93      22      26      3.22
pri_bon30 [3]           72.8    115     8       19      2.01
pri_bon50 [3]           99.8    97      15      22      2.76
similar to io_load, not quite linear


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.9    149     5       6       1.38
pri_bon00 [3]           48.3    154     2       3       1.33
pri_bon10 [3]           49.5    150     5       6       1.37
pri_bon30 [3]           50.7    148     5       6       1.40
pri_bon50 [3]           49.8    149     5       6       1.38

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          43.8    167     0       9       1.21
pri_bon00 [3]           43.7    168     0       7       1.21
pri_bon10 [3]           44.0    167     0       8       1.22
pri_bon30 [3]           44.0    166     0       9       1.22
pri_bon50 [3]           43.8    167     0       9       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          71.1    123     36      2       1.96
pri_bon00 [3]           78.8    98      33      2       2.18
pri_bon10 [3]           94.0    82      35      2       2.60
pri_bon30 [3]           108.6   74      36      2       3.00
pri_bon50 [3]           106.2   75      36      2       2.93
in the opposite direction to io_load; as pb goes up, time goes up, but 
mem_load achieves no more work.


Changing this tunable seems to shift the balance in either direction depending 
on the load. Most of the disk writing loads have shorter times as pb goes up, 
but under heavy mem_load the time goes up (without an increase in the amount 
of work done by the mem_load itself). The effect is quite large.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Aj8nF6dfvkL3i1gRAuJOAKCYVUsr4tii1akA996c/XVqdCizuQCfQi+a
QtX8sg1Q1KA2VI6eY+X5GtM=
=QlX7
-----END PGP SIGNATURE-----
