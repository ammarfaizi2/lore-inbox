Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVBYCXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVBYCXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVBYCXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:23:45 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43142 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262598AbVBYCXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:23:18 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc4 OOM Killer - Kill the Innocent
Date: Thu, 24 Feb 2005 21:23:10 -0500
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502242123.10813.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.11-rc-4 on an x86_64 laptop with 768M RAM and 1G swap. Today, 
I started KDevelop and tried to import linux-2.6.10 sources. It started 
hogging the memory as expected and reached to a stage where top last updated 
the kdevelop process's VIRT as 1898M and RES as 634M. 5.8M RAM was free and 
all swap was used.

After that, the laptop completely froze - The only visibly active thing was 
the disk LED - it stayed active till I let it - abt 30 minutes or so. There 
was no way I could gain control over the machine. No telnet, no nothing.

After that I pushed poweroff button and rebooted to see if OOM killer had 
kicked in at all - To make me more nervous it had killed all innocent 
processes except the culprit - KDevelop.

What is so hosed with the OOM Killer? (I am nowhere near a VM expert but to me 
determining which process has gobbled  up all the memory should be something 
it should get right. I mean in this case above 88% memory was occupied by one 
process - KDevelop, not that there were 100 processes with each occupying 1% 
memory.)

Here is the OOM Killer report -

Feb 24 20:42:46 localhost kernel: oom-killer: gfp_mask=0x1d2
Feb 24 20:42:50 localhost kernel: DMA per-cpu:
Feb 24 20:42:52 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Feb 24 20:42:52 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Feb 24 20:42:52 localhost kernel: Normal per-cpu:
Feb 24 20:42:52 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Feb 24 20:42:52 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Feb 24 20:42:52 localhost kernel: HighMem per-cpu: empty
Feb 24 20:42:52 localhost kernel: 
Feb 24 20:42:52 localhost kernel: Free pages:        7212kB (0kB HighMem)
Feb 24 20:42:52 localhost kernel: Active:88559 inactive:89260 dirty:0 
writeback:0 unstable:0 free:1803 slab:3997 mapped:176852 pagetables:3395
Feb 24 20:42:52 localhost kernel: DMA free:3076kB min:72kB low:88kB high:108kB 
active:4528kB inactive:4376kB present:16384kB pages_scanned:11541 
all_unreclaimable? yes
Feb 24 20:42:52 localhost kernel: lowmem_reserve[]: 0 751 751
Feb 24 20:42:56 localhost kernel: Normal free:4136kB min:3468kB low:4332kB 
high:5200kB active:349708kB inactive:352664kB present:769472kB 
pages_scanned:177784 all_unreclaimable? no
Feb 24 20:43:01 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:43:04 localhost kernel: HighMem free:0kB min:128kB low:160kB 
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Feb 24 20:43:12 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:43:15 localhost kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3076kB
Feb 24 20:43:20 localhost kernel: Normal: 20*4kB 77*8kB 1*16kB 1*32kB 1*64kB 
0*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 4136kB
Feb 24 20:43:24 localhost kernel: HighMem: empty
Feb 24 20:43:29 localhost kernel: Swap cache: add 271674, delete 271674, find 
1108/2001, race 0+0
Feb 24 20:43:40 localhost kernel: Free swap  = 0kB
Feb 24 20:43:42 localhost kernel: Total swap = 1052248kB
Feb 24 20:43:46 localhost kernel: Out of Memory: Killed process 19279 
(klauncher).
Feb 24 20:46:38 localhost kernel: oom-killer: gfp_mask=0x1d2
Feb 24 20:46:39 localhost kernel: DMA per-cpu:
Feb 24 20:46:39 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Feb 24 20:46:39 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Feb 24 20:46:39 localhost kernel: Normal per-cpu:
Feb 24 20:46:39 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Feb 24 20:46:39 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Feb 24 20:46:39 localhost kernel: HighMem per-cpu: empty
Feb 24 20:46:39 localhost kernel: 
Feb 24 20:46:39 localhost kernel: Free pages:        7276kB (0kB HighMem)
Feb 24 20:46:39 localhost kernel: Active:88590 inactive:89203 dirty:0 
writeback:0 unstable:0 free:1819 slab:3997 mapped:177070 pagetables:3333
Feb 24 20:46:39 localhost kernel: DMA free:3076kB min:72kB low:88kB high:108kB 
active:4496kB inactive:4432kB present:16384kB pages_scanned:10453 
all_unreclaimable? yes
Feb 24 20:46:40 localhost kernel: lowmem_reserve[]: 0 751 751
Feb 24 20:46:42 localhost kernel: Normal free:4200kB min:3468kB low:4332kB 
high:5200kB active:349864kB inactive:352380kB present:769472kB 
pages_scanned:26780 all_unreclaimable? no
Feb 24 20:46:42 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:46:44 localhost kernel: HighMem free:0kB min:128kB low:160kB 
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Feb 24 20:46:46 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:46:52 localhost kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3076kB
Feb 24 20:46:59 localhost kernel: Normal: 108*4kB 41*8kB 1*16kB 1*32kB 1*64kB 
0*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 4200kB
Feb 24 20:47:01 localhost kernel: HighMem: empty
Feb 24 20:47:06 localhost kernel: Swap cache: add 273738, delete 273730, find 
1160/2268, race 0+0
Feb 24 20:47:09 localhost kernel: Free swap  = 0kB
Feb 24 20:47:11 localhost kernel: Total swap = 1052248kB
Feb 24 20:47:14 localhost kernel: Out of Memory: Killed process 19296 (kwin).
Feb 24 20:47:20 localhost kernel: oom-killer: gfp_mask=0x1d2
Feb 24 20:47:22 localhost kernel: DMA per-cpu:
Feb 24 20:47:26 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Feb 24 20:47:29 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Feb 24 20:47:34 localhost kernel: Normal per-cpu:
Feb 24 20:47:41 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Feb 24 20:47:43 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Feb 24 20:47:52 localhost kernel: HighMem per-cpu: empty
Feb 24 20:47:56 localhost kernel: 
Feb 24 20:47:59 localhost kernel: Free pages:        6700kB (0kB HighMem)
Feb 24 20:48:01 localhost kernel: Active:88841 inactive:89283 dirty:0 
writeback:0 unstable:0 free:1675 slab:4004 mapped:177062 pagetables:3264
Feb 24 20:48:09 localhost kernel: DMA free:3076kB min:72kB low:88kB high:108kB 
active:4528kB inactive:4396kB present:16384kB pages_scanned:10908 
all_unreclaimable? yes
Feb 24 20:48:19 localhost kernel: lowmem_reserve[]: 0 751 751
Feb 24 20:48:25 localhost kernel: Normal free:3624kB min:3468kB low:4332kB 
high:5200kB active:350836kB inactive:352736kB present:769472kB 
pages_scanned:0 all_unreclaimable? no
Feb 24 20:48:31 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:48:39 localhost kernel: HighMem free:0kB min:128kB low:160kB 
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Feb 24 20:48:50 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:49:03 localhost kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3076kB
Feb 24 20:49:10 localhost kernel: Normal: 0*4kB 17*8kB 4*16kB 1*32kB 1*64kB 
0*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3624kB
Feb 24 20:49:10 localhost kernel: HighMem: empty
Feb 24 20:49:11 localhost kernel: Swap cache: add 274701, delete 274685, find 
1185/2337, race 0+0
Feb 24 20:49:12 localhost kernel: Free swap  = 0kB
Feb 24 20:49:13 localhost kernel: Total swap = 1052248kB
Feb 24 20:49:14 localhost kernel: Out of Memory: Killed process 19316 
(evolution-alarm).
Feb 24 20:49:16 localhost kernel: oom-killer: gfp_mask=0x1d2
Feb 24 20:49:16 localhost kernel: DMA per-cpu:
Feb 24 20:49:17 localhost kernel: cpu 0 hot: low 2, high 6, batch 1
Feb 24 20:49:19 localhost kernel: cpu 0 cold: low 0, high 2, batch 1
Feb 24 20:49:21 localhost kernel: Normal per-cpu:
Feb 24 20:49:22 localhost kernel: cpu 0 hot: low 32, high 96, batch 16
Feb 24 20:49:23 localhost kernel: cpu 0 cold: low 0, high 32, batch 16
Feb 24 20:49:26 localhost kernel: HighMem per-cpu: empty
Feb 24 20:49:27 localhost kernel: 
Feb 24 20:49:29 localhost kernel: Free pages:        6516kB (0kB HighMem)
Feb 24 20:49:33 localhost kernel: Active:88829 inactive:89111 dirty:0 
writeback:0 unstable:0 free:1629 slab:3969 mapped:177104 pagetables:3249
Feb 24 20:49:47 localhost kernel: DMA free:3076kB min:72kB low:88kB high:108kB 
active:4316kB inactive:4600kB present:16384kB pages_scanned:13623 
all_unreclaimable? yes
Feb 24 20:49:59 localhost kernel: lowmem_reserve[]: 0 751 751
Feb 24 20:50:04 localhost kernel: Normal free:3440kB min:3468kB low:4332kB 
high:5200kB active:351000kB inactive:351844kB present:769472kB 
pages_scanned:19654 all_unreclaimable? no
Feb 24 20:50:17 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:50:23 localhost kernel: HighMem free:0kB min:128kB low:160kB 
high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Feb 24 20:50:34 localhost kernel: lowmem_reserve[]: 0 0 0
Feb 24 20:50:42 localhost kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3076kB
Feb 24 20:50:50 localhost kernel: Normal: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 
0*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3440kB
Feb 24 20:51:07 localhost kernel: HighMem: empty
Feb 24 20:51:09 localhost kernel: Swap cache: add 281032, delete 281024, find 
2171/3889, race 0+0
Feb 24 20:51:14 localhost kernel: Free swap  = 0kB
Feb 24 20:51:22 localhost kernel: Total swap = 1052248kB
Feb 24 20:51:26 localhost kernel: Out of Memory: Killed process 19342 
(nautilus).
