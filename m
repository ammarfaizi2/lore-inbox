Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTFECfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTFECfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:35:15 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:42488 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264376AbTFECfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:35:12 -0400
Date: Wed, 4 Jun 2003 22:49:40 -0400
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] AIM7 fserver regressed in 2.5.70*
Message-ID: <20030605024940.GA14406@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:
AIM7 fileserver workload behaviour changed with 2.5.70.
At low task counts (load average), 2.5.70* takes 40% 
longer than 2.5.69.  As task count increases, regression
disappears.

Hardware has (4) 700 mhz P3 Xeons.
3.75 GB RAM
RAID 0 LUN (hardware raid)

Background:
AIM7 fserver is the only regressed workload.  In general, 
2.5.70* has better numbers than 2.5.69* for a variety of
benchmarks.

Part of the improvement in 2.5.70 I/O benchmarks is
from a fiber channel configuration change.  2.5.70* has
two online fiber channels.  Earlier kernels had only one
fiber channel online.  

Tiobench and bonnie++ show about 10% improvement.  
LMbench microbenchmarks are generally improving or stable
in recent 2.5.x.  

So, it's strange that AIM7 fserver is regressed.  

The kernels below are listed in chronological order.

AIM7 database workloads show a nice 27-30% improvement
with 2.5.70*.

Real and CPU are time in seconds.

AIM7 dbase workload
kernel             Tasks  Jobs/Min      Real       CPU
2.5.69              32	 477.6	      398.0	 149.3
2.5.69-bk1          32	 476.3	      399.0	 143.1
2.5.69-mm3          32	 560.5	      339.1	 159.3
2.5.69-mm5          32	 560.9	      338.9	 164.0
2.5.70              32	 611.1	      311.0	 153.0
2.5.70-mjb1         32	 606.4	      313.5	 159.2
2.5.70-mm3          32	 685.8	      277.2	 161.8


2.5.69             256	 769.9	     1975.2	 982.2
2.5.69-bk1         256	 768.0	     1979.9	 977.9
2.5.69-mm3         256	 906.5	     1677.5	1132.8
2.5.69-mm5         256	 909.5	     1671.9	1088.4
2.5.70             256	1042.7	     1458.4	1036.3
2.5.70-mjb1        256	1030.0	     1476.4	1049.0
2.5.70-mm3         256	1186.4	     1281.8	1066.8


AIM7 fileserver is regressed about 40% at 4 tasks.
As the task load increases, the regression becomes less.
At 32 tasks, 2.5.70* is even or ahead of 2.5.69*.

AIM7 fserver workload
kernel             Tasks  Jobs/Min      Real       CPU
2.5.69               4	 120.9	      200.5	  32.8
2.5.69-bk1           4	 122.3	      198.2	  33.8
2.5.69-mm3           4	 122.3	      198.3	  37.9
2.5.69-mm5           4	 124.0	      195.5	  38.0
2.5.70               4	  79.0	      306.9	  34.2
2.5.70-mjb1          4	  83.4	      290.8	  33.6
2.5.70-mm3           4	  71.7	      338.0	  34.9
2.5.70-mm4	     4    73.9        328.0       33.9
 
 
2.5.69               8	 174.7	      277.5  	  61.1
2.5.69-bk1           8	 175.8	      275.8	  64.1
2.5.69-mm3           8	 179.4	      270.2	  65.7
2.5.69-mm5           8	 184.3	      263.0	  66.3
2.5.70               8	 136.6	      354.9	  58.8
2.5.70-mjb1          8	 137.3	      353.0	  57.0
2.5.70-mm3           8	 123.9	      391.3	  58.7
2.5.70-mm4	     8   118.4        409.4       57.5
 

2.5.69              32	 234.3	      827.6	 221.8
2.5.69-bk1          32	 236.0	      821.8	 220.8
2.5.69-mm3          32	 253.8	      764.0	 246.6
2.5.69-mm5          32	 254.8	      761.0	 248.3
2.5.70              32	 239.7	      809.1	 219.4
2.5.70-mjb1         32	 248.9	      779.2	 226.3
2.5.70-mm3          32	 231.3	      838.4	 224.9

AIM7 shared has a similar behavior.  At 64 tasks, 2.5.69*
is close to or a little ahead of 2.5.70*.

AIM7 shared workload
kernel             Tasks  Jobs/Min      Real       CPU
2.5.69              64	2121.2	      175.6	 167.5
2.5.69-bk1          64	2096.7	      177.7	 168.6
2.5.69-mm3          64	2422.3	      153.8	 179.2
2.5.69-mm5          64	2429.0	      153.3	 178.3
2.5.70              64	2123.1	      175.4	 170.0
2.5.70-mjb1         64	2163.9	      172.1	 175.5
2.5.70-mm3          64	2186.9	      170.3	 175.7

2.5.69             128	2257.8	      329.9	 333.9
2.5.69-bk1         128	2269.9	      328.2	 333.1
2.5.69-mm3         128	2700.6	      275.9	 352.9
2.5.69-mm5         128	2697.8	      276.1	 352.8
2.5.70             128	2410.4	      309.1	 338.2
2.5.70-mjb1        128	2580.1	      288.7	 354.7
2.5.70-mm3         128	2705.2	      275.4	 350.6

By 512 tasks, 2.5.70* is AIM7 shared is ahead of 2.5.69*
by 14-20%.

2.5.69             512	2314.7	     1287.3	1369.2
2.5.69-bk1         512	2319.4	     1284.7	1370.5
2.5.69-mm3         512	2574.1	     1157.6	1457.7
2.5.69-mm5         512	2698.3	     1104.3	1481.0
2.5.70             512	2788.0	     1068.8	1399.1
2.5.70-mjb1        512	2607.6	     1142.8	1670.8
2.5.70-mm3         512	3075.9	      968.8	1462.8


-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

