Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTBQWpx>; Mon, 17 Feb 2003 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTBQWpx>; Mon, 17 Feb 2003 17:45:53 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:58505 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267628AbTBQWpv>; Mon, 17 Feb 2003 17:45:51 -0500
Date: Mon, 17 Feb 2003 18:01:38 -0500
To: linux-kernel@vger.kernel.org
Subject: oom running aim7 on 2.5.61-mm1
Message-ID: <20030217230138.GA11613@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During AIM7 shared workload with 384 processes on 
machine with 384 MB ram:

Out of Memory: Killed process 16168 (multitask).
Out of Memory: Killed process 16168 (multitask).

This test creates memory pressure, but shouldn't OOM:

Used the default (anticipatory) scheduler.

Here is vmstat 60 before oom on 2.5.61-mm1:

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
135 250  2  77440   2192     64    896 1105  220  1432   286 1475  1252 93  7  0
124 260  9  82820   3144     56    864  804  456  1340   632 1345   602 91  9  0
 8 376 23 115200   2972     72   1152 1134  876  1634  1113 1332   665 88 12  0
 3 381  1  99204   3388     60    800 1950  302  1985   315 1422   794 95  5  0
 2 382  2  83180  13364     68    772 1126  269  1212   272 1179   939 96  4  0
108 276  1  75264   4044    112   1956  502  143   774   262 1275   534 92  8  0
162 222  6 110896   2172     88   1160 1108 1560  2051  2019 2167  1074 83 17  0
34 351  1 149808   2460     56    668 2229 1031  2563  1253 1917  1801 88 12  0
 3 381  0 137080   3672     56    728 2129  370  2187   381 1284   809 89 11  0
13 371  2 121816   2360     56    748 2102  329  2123   330 1316   840 94  6  0
17 367  1 110032   3648     56    736 1967  309  2014   311 1284   715 95  5  0
26 358  4 105600   2412     64    780 1683  379  1773   405 1331   773 95  5  0
53 331  5  99344   3240     64    760 1673  312  1732   316 1231  1617 95  5  0
232 152  9  88828   2512     72   1436 1635  517  2253   674 1765   701 90 10  0
58 326  8  79924  17432     92    968 1009  103  1026   103 1175   263 98  2  0


For comparison, this is 2.5.59-mjb1 from about the same point in the test.  
This one is typical.  Some swap i/o,  but nothing crazy.

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
385  0  0  71844  71280    208   2188    5    0     6    13  101     8 95  5  0
384  0  0  71844  56816    208   2196    8    0     8     2  101     8 95  5  0
384  0  0  71844  36928    208   2556   10    0    10     8  102     8 95  5  0
384  0  0  71844  31936    208   2208    7    0     7     2  101     9 97  3  0
384  0  0  71844  13440    208   3036    1    0     1     2  101     8 97  3  0
373 11  0  71840   5172    184   1620    3    2     3    18  101     9 98  2  0
384  0  0  97824   4264     84    904   13  471    55   491  119    20 93  7  0
380  4  0 103628   4488     88   1676   86  179   113   181  112    14 98  2  0
384  0  0 102224   9236    100   1700  487  581   576   603  153    69 96  4  0
384  0  0  99088   4952    104   1584   93   83    98    90  109    17 98  2  0
384  0  0 100068   3116     76   1596   58   97    62   139  110    19 97  3  0
381  3  0 133628   3904     80    804  449  901   506   907  158    80 94  6  0
381  3  1 115160   2196     64    804  271   70   301    72  121    40 98  2  0
384  0  0 112348   8384     72   1728  151   77   181    78  116    24 99  1  0
384  0  0 106976  20136    100   1972  151    0   155     1  109    19 98  2  0
384  0  0 104696  25152    112   2112   68    0    68     2  104    11 98  2  0
384  0  0 103100  30040    116   2004   33    0    33     5  102     9 98  2  0
384  0  0 101020  42008    136   2652   65    0    65     2  103    11 98  2  0
384  0  0  97952  46584    144   2020   70    0    70    13  103    10 97  3  0
384  0  0  95136  56196    156   3244   71    0    71    23  103    11 96  4  0
384  0  0  92624  67536    156   2176   54    0    55     3  103    10 96  4  0


Hardware is uniprocessor K6/2 with 384 MB ram.
2.5.61 locked up during tiobench, which runs before the AIM7 test.  The
2.5.61 lockup wasn't an OOM.

I'll try 2.5.61-mm1 with elevator=cfq.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

