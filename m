Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVCWTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVCWTzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVCWTy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:54:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1763 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262873AbVCWTxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:53:12 -0500
Subject: OOM problems on 2.6.12-rc1 with many fsx tests
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       mjbligh@us.ibm.com
Cc: linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20050316183701.GB21597@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu>
	 <20050316003134.GY7699@opteron.random>
	 <20050316040435.39533675.akpm@osdl.org>
	 <20050316183701.GB21597@opteron.random>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 23 Mar 2005 11:53:04 -0800
Message-Id: <1111607584.5786.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea, Andrew,

I run into OOM problem again on 2.6.12-rc1. I run some(20) fsx tests on
2.6.12-rc1 kernel(and 2.6.11-mm4) on ext3 filesystem, after about 10
hours the system hit OOM, and OOM keep killing processes one by one. I
could reproduce this problem very constantly on a 2 way PIII 700MHZ with
512MB RAM. Also the problem could be reproduced on running the same test
on reiser fs.

The fsx command is:

./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &

I also see fsx tests start to generating report about read bad data
about the tests have run for about 9 hours(one hour before of the OOM
happen). 

I also logged the /proc/meminfo every 30 seconds from a remote machine.
I will attach the OOM message,  the /proc/meminfo at the beginning of
the test and the end(when OOM killed the logging process) here.

When I run the tests I don't know this is a known issue and don't know
if 2.6.12-rc1 contains the proposed fix from Andrea/Andrew or not. If
you have something that I could try, let me know.

Thanks!

Mingming


============================================================
OOM messages on console
============================================================

Mar 23 02:16:16 elm3b92 kernel: oom-killer: gfp_mask=0x80d2
Mar 23 02:16:18 elm3b92 kernel: DMA per-cpu:
Mar 23 02:16:18 elm3b92 kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 23 02:16:18 elm3b92 kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 23 02:16:18 elm3b92 kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 23 02:16:18 elm3b92 kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 23 02:16:18 elm3b92 kernel: Normal per-cpu:
Mar 23 02:16:18 elm3b92 kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 23 02:16:18 elm3b92 kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 23 02:16:18 elm3b92 kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 23 02:16:18 elm3b92 kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 23 02:16:18 elm3b92 kernel: HighMem per-cpu: empty
Mar 23 02:16:19 elm3b92 kernel:
Mar 23 02:16:20 elm3b92 kernel: Free pages:        5208kB (0kB HighMem)
Mar 23 02:16:20 elm3b92 kernel: Active:60624 inactive:60838 dirty:0
writeback:0 unstable:0 free:1302 slab:3208 mapped:196 pagetables:105
Mar 23 02:16:20 elm3b92 kernel: DMA free:2072kB min:88kB low:108kB
high:132kB active:4776kB inactive:3908kB present:16384kB
pages_scanned:15150 all_unreclaimable? yes
Mar 23 02:16:20 elm3b92 kernel: lowmem_reserve[]: 0 496 496
Mar 23 02:16:20 elm3b92 kernel: Normal free:3136kB min:2804kB low:3504kB
high:4204kB active:237968kB inactive:239200kB present:507904kB
pages_scanned:15151 all_unreclaimable? no
Mar 23 02:16:20 elm3b92 kernel: lowmem_reserve[]: 0 0 0
Mar 23 02:16:20 elm3b92 kernel: HighMem free:0kB min:128kB low:160kB
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Mar 23 02:16:20 elm3b92 kernel: lowmem_reserve[]: 0 0 0
Mar 23 02:16:20 elm3b92 kernel: DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2072kB
Mar 23 02:16:20 elm3b92 kernel: Normal: 58*4kB 25*8kB 1*16kB 2*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3200kB
Mar 23 02:16:20 elm3b92 kernel: HighMem: empty
Mar 23 02:16:20 elm3b92 kernel: Swap cache: add 284169, delete 283991,
find 105376/203154, race 2+25
Mar 23 02:16:20 elm3b92 kernel: Free swap  = 1042692kB
Mar 23 02:16:20 elm3b92 kernel: Total swap = 1052216kB
Mar 23 02:16:20 elm3b92 kernel: Out of Memory: Killed process 2115
(cupsd).
Mar 23 02:21:01 elm3b92 kernel: oom-killer: gfp_mask=0x1d2
Mar 23 02:21:03 elm3b92 kernel: DMA per-cpu:
Mar 23 02:21:03 elm3b92 kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 23 02:21:03 elm3b92 kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 23 02:21:03 elm3b92 kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 23 02:21:03 elm3b92 kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 23 02:21:03 elm3b92 kernel: Normal per-cpu:
Mar 23 02:21:03 elm3b92 kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 23 02:21:03 elm3b92 kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 23 02:21:03 elm3b92 kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 23 02:21:03 elm3b92 kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 23 02:21:03 elm3b92 kernel: HighMem per-cpu: empty
Mar 23 02:21:04 elm3b92 kernel:
Mar 23 02:21:08 elm3b92 kernel: Free pages:        4872kB (0kB HighMem)
Mar 23 02:21:10 elm3b92 kernel: Active:61061 inactive:60495 dirty:0
writeback:30 unstable:0 free:1218 slab:3159 mapped:272 pagetables:86
Mar 23 02:21:11 elm3b92 kernel: DMA free:2072kB min:88kB low:108kB
high:132kB active:4832kB inactive:3852kB present:16384kB
pages_scanned:18465 all_unreclaimable? yes
Mar 23 02:21:11 elm3b92 kernel: lowmem_reserve[]: 0 496 496
Mar 23 02:21:11 elm3b92 kernel: Normal free:2800kB min:2804kB low:3504kB
high:4204kB active:239492kB inactive:237988kB present:507904kB
pages_scanned:107346 all_unreclaimable? no
Mar 23 02:21:11 elm3b92 kernel: lowmem_reserve[]: 0 0 0
Mar 23 02:21:11 elm3b92 kernel: DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2072kB
Mar 23 02:21:11 elm3b92 kernel: Normal: 2*4kB 7*8kB 3*16kB 2*32kB 0*64kB
1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2864kB
Mar 23 02:21:11 elm3b92 kernel: HighMem: empty
Mar 23 02:21:11 elm3b92 kernel: Swap cache: add 292112, delete 291918,
find 107914/208530, race 2+28
Mar 23 02:21:11 elm3b92 kernel: Free swap  = 1044992kB
Mar 23 02:21:11 elm3b92 kernel: Total swap = 1052216kB
Mar 23 02:21:11 elm3b92 kernel: Out of Memory: Killed process 5638
(nscd).
Mar 23 02:21:19 elm3b92 kernel: oom-killer: gfp_mask=0x1d2
Mar 23 02:21:21 elm3b92 kernel: DMA per-cpu:
Mar 23 02:21:21 elm3b92 kernel: cpu 0 hot: low 2, high 6, batch 1
Mar 23 02:21:21 elm3b92 kernel: cpu 0 cold: low 0, high 2, batch 1
Mar 23 02:21:21 elm3b92 kernel: cpu 1 hot: low 2, high 6, batch 1
Mar 23 02:21:21 elm3b92 kernel: cpu 1 cold: low 0, high 2, batch 1
Mar 23 02:21:21 elm3b92 kernel: Normal per-cpu:
Mar 23 02:21:21 elm3b92 kernel: cpu 0 hot: low 32, high 96, batch 16
Mar 23 02:21:21 elm3b92 kernel: cpu 0 cold: low 0, high 32, batch 16
Mar 23 02:21:21 elm3b92 kernel: cpu 1 hot: low 32, high 96, batch 16
Mar 23 02:21:21 elm3b92 kernel: cpu 1 cold: low 0, high 32, batch 16
Mar 23 02:21:21 elm3b92 kernel: HighMem per-cpu: empty
Mar 23 02:21:21 elm3b92 kernel:
Mar 23 02:21:21 elm3b92 kernel: Free pages:        5296kB (0kB HighMem)
Mar 23 02:21:21 elm3b92 kernel: Active:60775 inactive:60649 dirty:28
writeback:0 unstable:0 free:1324 slab:3157 mapped:220 pagetables:81
Mar 23 02:21:21 elm3b92 kernel: DMA free:2072kB min:88kB low:108kB
high:132kB active:4864kB inactive:3820kB present:16384kB
pages_scanned:18855 all_unreclaimable? yes
Mar 23 02:21:21 elm3b92 kernel: lowmem_reserve[]: 0 496 496
Mar 23 02:21:21 elm3b92 kernel: Normal free:3224kB min:2804kB low:3504kB
high:4204kB active:238080kB inactive:238776kB present:507904kB
pages_scanned:52439 all_unreclaimable? no
Mar 23 02:21:21 elm3b92 kernel: lowmem_reserve[]: 0 0 0
Mar 23 02:21:21 elm3b92 kernel: HighMem free:0kB min:128kB low:160kB
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Mar 23 02:21:21 elm3b92 kernel: lowmem_reserve[]: 0 0 0
Mar 23 02:21:21 elm3b92 kernel: DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2072kB
Mar 23 02:21:21 elm3b92 kernel: Normal: 96*4kB 19*8kB 0*16kB 2*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3288kB
Mar 23 02:21:21 elm3b92 kernel: HighMem: empty
Mar 23 02:21:21 elm3b92 kernel: Swap cache: add 293172, delete 292990,
find 108239/209189, race 2+31
Mar 23 02:21:21 elm3b92 kernel: Free swap  = 1045004kB
Mar 23 02:21:21 elm3b92 kernel: Total swap = 1052216kB
Mar 23 02:21:21 elm3b92 kernel: Out of Memory: Killed process 2062
(portmap).



=======================================================
/proc/meminfo at the beginning of the fsx tests
=======================================================
+ cat /proc/meminfo
MemTotal:       510400 kB
MemFree:        397284 kB
Buffers:         23788 kB
Cached:          35712 kB
SwapCached:          0 kB
Active:          68592 kB
Inactive:        21312 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       510400 kB
LowFree:        397284 kB
SwapTotal:     1052216 kB
SwapFree:      1052216 kB
Dirty:            2312 kB
Writeback:           0 kB
Mapped:          23500 kB
Slab:            16412 kB
CommitLimit:   1307416 kB
Committed_AS:    74804 kB
PageTables:        572 kB
VmallocTotal:   516024 kB
VmallocUsed:      3700 kB
VmallocChunk:   512320 kB
+ sleep 30

===========================================
/proc/meminfo at the end of the log file
===========================================
+ cat /proc/meminfo
MemTotal:       510400 kB
MemFree:          5512 kB
Buffers:           500 kB
Cached:            584 kB
SwapCached:        344 kB
Active:         243580 kB
Inactive:       242248 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       510400 kB
LowFree:          5512 kB
SwapTotal:     1052216 kB
SwapFree:      1045984 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            804 kB
Slab:            12584 kB
CommitLimit:   1307416 kB
Committed_AS:    13560 kB
PageTables:        284 kB
VmallocTotal:   516024 kB
VmallocUsed:      3700 kB
VmallocChunk:   512320 kB
+ sleep 30




