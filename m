Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbTBSHiD>; Wed, 19 Feb 2003 02:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTBSHiD>; Wed, 19 Feb 2003 02:38:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268145AbTBSHiC>;
	Wed, 19 Feb 2003 02:38:02 -0500
Message-Id: <200302190754.h1J7sVY30494@es175.pdx.osdl.net>
To: akpm@digeo.com, willy@debian.org
cc: testdev@osdl.org, linux-kernel@vger.kernel.org
Subject: Qlogic FC, 2.5.62,-mm1 w/flock fix (plm# 1567)
Date: Tue, 18 Feb 2003 23:54:31 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Andrew and Matthew.
We can now actually *without* rebooting the machine,
start the database.
stop the database, and 
(gasp!) re-start the database without error. Progress. :)
(2.5.62 stock and 2.5.62-mm1 both fail this test)

Also,
we've run the OSDL dbt-2 workload on a 4-cpu machine,
(PIII @700mhz x4 w/3GB RAM Qlogic 2200 FC card)
using 

linux-2.5.62 + flock() fix (plm patch id#1567) 
	- disk using qlogicfc driver
linux-2.5.62-mm1 + flock() fix (plm patch id#1567)
	- disk using isp (new) driver

Results and bunch o' numbers at:
http://www.osdl.org/archive/cliffw/flock/flock-mm1
http://www.osdl.org/archive/cliffw/flock/flock-62

Caveats: This data is one run from each kernel,
results from repeated runs may vary, harmful or fatal if
swallowed. Merge of plm 1567 w/-mm1 performed by unskilled
labor. We have *not* tested this on the several other
wierdasp SCSI devices in house, more results maybe.

Quick observations: 
DBT numbers are about the same (+/- 10%), but vmstat differs:
- There are certainly tunables, especially in /proc/vm/sys
	that we haven't tried yet. Any suggestions on tunables
	most appreciated. 
- more procssess are runing w/-mm1 in each sample..
- this a cached run, io occurs mostly during load, except for db log io

If you want some numbers Right Now, these are from the midpoint 
of each run, full files at above web link:
-----vmstat 60second interval, Linux-2.5.62-flk----------
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  8  0    992 298672  35192 1241232    0    0   165 12960 1945  5748 95  4  1
 4  0  0    992 292888  35668 1241664    0    0   183  1159 1173  3487 95  2  3
 5  0  0    992 284368  36324 1242108    0    0   185  1047 1162  3543 95  2  3
 5  1  0    992 276816  36636 1242496    0    0   172  1028 1157  3438 95  2  3
 5  0  0    992 269336  36972 1242896    0    0   160  1056 1160  3562 95  2  3
 4  0  0    992 262048  37276 1243288    0    0   155  1041 1158  3480 95  2  3
 4  1  0    992 254552  37756 1243716    0    0   144  1051 1158  3474 95  2  3
 4  0  0    992 247776  38412 1244160    0    0   137  1061 1158  3473 95  2  3
----vmstat 60 second interval, Linux-2.5.62-mm1-flk---------
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 6  2  1   1100   9968  29624 1522312    0    0   209  1174 1276  3841 95  2  3
13  3  1   1100  10176  29696 1514056    0    0   190  1135 1268  3823 95  2  3
 8  1  1   1100   9960  29852 1506376    0    0   190  1131 1266  3744 95  2  3
 4  5  3   1100  10176  29884 1499152    0    0   155  1109 1260  3689 95  2  3
 7  1  1   1100  10184  29972 1492920    0    0   156  1138 1262  3753 95  2  3
 7  1  1   1100   9720  30244 1486636    0    0   150  1150 1266  3690 95  2  3
 8  1  1   1100  14008  30220 1476588    0    0   131  1133 1260  3739 95  2  3
11  5  1   1100  10048  30392 1474692    0    0   123  7871 1768  5311 95  3  2
--------------------------

cliffw
cliffw@osdl.org




