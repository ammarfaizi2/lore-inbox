Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVDHPSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVDHPSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVDHPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:18:11 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:3285 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262848AbVDHPRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:17:47 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: 2.6.12-rc2-mm2
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
References: <20050408030835.4941cd98.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 17:17:41 +0200
Message-Id: <1112973461.16451.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-04-08 klockan 03:08 -0700 skrev Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> 

I got this running ./runltp -x 2, can't recall this happening before. It
bothers me a bit as it's a GFP_KERNEL allocation and there's lots of
swap available. I don't think I've learned to fully decipher these
oom-dumps fully yet (especially the active/inactive stat) but this looks
fishy to me.

Run with /proc/sys/vm/swappiness=1

After the killing /proc/meminfo reports lots of MemFree.

oom-killer: gfp_mask=0x80d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        8220kB (0kB HighMem)
Active:240716 inactive:2631 dirty:0 writeback:1162 unstable:0 free:2055 slab:5340 mapped:242023 pagetables:1441
DMA free:4100kB min:60kB low:72kB high:88kB active:172kB inactive:7956kB present:16384kB pages_scanned:363 all_unreclaimable? no
lowmem_reserve[]: 0 1007 1007
Normal free:4120kB min:4028kB low:5032kB high:6040kB active:962692kB inactive:2568kB present:1032128kB pages_scanned:6421 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 2*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4100kB
Normal: 32*4kB 1*8kB 1*16kB 2*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4120kB
HighMem: empty
Swap cache: add 921, delete 257, find 0/0, race 0+0
Free swap  = 4880036kB
Total swap = 4883720kB
Out of Memory: Killed process 2327 (firefox-bin).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        8112kB (0kB HighMem)
Active:224482 inactive:19068 dirty:0 writeback:285 unstable:0 free:2028 slab:5089 mapped:243275 pagetables:1407
DMA free:4088kB min:60kB low:72kB high:88kB active:6432kB inactive:1744kB present:16384kB pages_scanned:10438 all_unreclaimable? yes
lowmem_reserve[]: 0 1007 1007
Normal free:4024kB min:4028kB low:5032kB high:6040kB active:891496kB inactive:74528kB present:1032128kB pages_scanned:686 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4088kB
Normal: 6*4kB 4*8kB 0*16kB 4*32kB 2*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4024kB
HighMem: empty
Swap cache: add 2900, delete 2557, find 0/0, race 0+0
Free swap  = 4872120kB
Total swap = 4883720kB
Out of Memory: Killed process 2305 (evolution).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        8096kB (0kB HighMem)
Active:229514 inactive:14617 dirty:0 writeback:0 unstable:0 free:2024 slab:4233 mapped:244389 pagetables:1568
DMA free:4088kB min:60kB low:72kB high:88kB active:8228kB inactive:0kB present:16384kB pages_scanned:9771 all_unreclaimable? yes
lowmem_reserve[]: 0 1007 1007
Normal free:4008kB min:4028kB low:5032kB high:6040kB active:909060kB inactive:59364kB present:1032128kB pages_scanned:1623064 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4088kB
Normal: 0*4kB 1*8kB 2*16kB 0*32kB 4*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4008kB
HighMem: empty
Swap cache: add 125467, delete 125298, find 70/196, race 0+0
Free swap  = 4383340kB
Total swap = 4883720kB
Out of Memory: Killed process 2330 (gnome-pty-helpe).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        8224kB (0kB HighMem)
Active:88815 inactive:155432 dirty:0 writeback:244 unstable:0 free:2056 slab:4233 mapped:243992 pagetables:1561
DMA free:4088kB min:60kB low:72kB high:88kB active:8100kB inactive:128kB present:16384kB pages_scanned:9805 all_unreclaimable? yes
lowmem_reserve[]: 0 1007 1007
Normal free:4072kB min:4028kB low:5032kB high:6040kB active:347160kB inactive:621600kB present:1032128kB pages_scanned:63219 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4088kB
Normal: 0*4kB 1*8kB 0*16kB 1*32kB 5*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4072kB
HighMem: empty
Swap cache: add 126311, delete 125768, find 70/198, race 0+0
Free swap  = 4380112kB
Total swap = 4883720kB
Out of Memory: Killed process 2331 (bash).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        8192kB (0kB HighMem)
Active:200715 inactive:43662 dirty:0 writeback:0 unstable:0 free:2048 slab:4027 mapped:244172 pagetables:1818
DMA free:4088kB min:60kB low:72kB high:88kB active:8228kB inactive:0kB present:16384kB pages_scanned:10298 all_unreclaimable? yes
lowmem_reserve[]: 0 1007 1007
Normal free:4040kB min:4028kB low:5032kB high:6040kB active:794632kB inactive:174648kB present:1032128kB pages_scanned:1236 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4088kB
Normal: 0*4kB 5*8kB 2*16kB 0*32kB 4*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4040kB
HighMem: empty
Swap cache: add 283299, delete 280461, find 1810/2841, race 0+1
Free swap  = 3771728kB
Total swap = 4883720kB
Out of Memory: Killed process 2227 (XFree86).


