Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752004AbWG1PYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbWG1PYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbWG1PYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:24:32 -0400
Received: from mail.linicks.net ([217.204.244.146]:27847 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1752004AbWG1PYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:24:31 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: oom-killer: - error_code messages?
Date: Fri, 28 Jul 2006 16:24:23 +0100
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281624.23782.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just experienced a oom kill, (never seen before).  I was running 
sa-learn --spam on a 165M folder.

System: 2.6.16.18

free (after the oom).
             total       used       free     shared    buffers     cached
Mem:        257344      24656     232688          0       1180       9400
-/+ buffers/cache:      14076     243268
Swap:       136512      19824     116688

BTW, swap is set at this as the box was once a 64M machine, and I have never 
ever seen swap usage > 10M so I never added to it on RAM upgrades over the 
years - could this be the issue?

My question is this - should I be seeing the do_page_fault and error_code 
messages like this?

Thanks,

Nick

Jul 28 16:10:56 Linux233 kernel: oom-killer: gfp_mask=0x280d2, order=0
Jul 28 16:10:56 Linux233 kernel:  [out_of_memory+43/147] 
out_of_memory+0x2b/0x93
Jul 28 16:10:56 Linux233 kernel:  [<c0123e88>] out_of_memory+0x2b/0x93
Jul 28 16:10:56 Linux233 kernel:  [__alloc_pages+474/605] 
__alloc_pages+0x1da/0x25d
Jul 28 16:10:56 Linux233 kernel:  [<c0124ae6>] __alloc_pages+0x1da/0x25d
Jul 28 16:10:56 Linux233 kernel:  [do_anonymous_page+55/259] 
do_anonymous_page+0x37/0x103
Jul 28 16:10:56 Linux233 kernel:  [<c012b2f2>] do_anonymous_page+0x37/0x103
Jul 28 16:10:56 Linux233 kernel:  [__handle_mm_fault+165/349] 
__handle_mm_fault+0xa5/0x15d
Jul 28 16:10:56 Linux233 kernel:  [<c012b69a>] __handle_mm_fault+0xa5/0x15d
Jul 28 16:10:56 Linux233 kernel:  [do_page_fault+373/1213] 
do_page_fault+0x175/0x4bd
Jul 28 16:10:56 Linux233 kernel:  [<c0109f55>] do_page_fault+0x175/0x4bd
Jul 28 16:10:56 Linux233 kernel:  [do_page_fault+0/1213] 
do_page_fault+0x0/0x4bd
Jul 28 16:10:56 Linux233 kernel:  [<c0109de0>] do_page_fault+0x0/0x4bd
Jul 28 16:10:57 Linux233 kernel:  [error_code+79/96] error_code+0x4f/0x60
Jul 28 16:10:57 Linux233 kernel:  [<c01026cf>] error_code+0x4f/0x60
Jul 28 16:10:57 Linux233 kernel: Mem-info:
Jul 28 16:10:57 Linux233 kernel: DMA per-cpu:
Jul 28 16:10:57 Linux233 kernel: cpu 0 hot: high 0, batch 1 used:0
Jul 28 16:10:57 Linux233 kernel: cpu 0 cold: high 0, batch 1 used:0
Jul 28 16:10:57 Linux233 kernel: DMA32 per-cpu: empty
Jul 28 16:10:57 Linux233 kernel: Normal per-cpu:
Jul 28 16:10:57 Linux233 kernel: cpu 0 hot: high 90, batch 15 used:31
Jul 28 16:10:57 Linux233 kernel: cpu 0 cold: high 30, batch 7 used:23
Jul 28 16:10:57 Linux233 kernel: HighMem per-cpu: empty
Jul 28 16:10:57 Linux233 kernel: Free pages:        3388kB (0kB HighMem)
Jul 28 16:10:57 Linux233 kernel: Active:30920 inactive:30757 dirty:0 
writeback:0 unstable:0 free:847 slab:1464 mapped:61652 pagetables:163
Jul 28 16:10:57 Linux233 kernel: DMA free:1120kB min:128kB low:160kB 
high:192kB active:6208kB inactive:6440kB present:16384kB pages_scanned:4228 
all_unreclaimable? no
Jul 28 16:10:57 Linux233 kernel: lowmem_reserve[]: 0 0 240 240
Jul 28 16:10:57 Linux233 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jul 28 16:10:57 Linux233 kernel: lowmem_reserve[]: 0 0 240 240
Jul 28 16:10:57 Linux233 kernel: Normal free:2268kB min:1920kB low:2400kB 
high:2880kB active:117472kB inactive:116588kB present:245760kB 
pages_scanned:71592 all_unreclaimable? no
Jul 28 16:10:57 Linux233 kernel: lowmem_reserve[]: 0 0 0 0
Jul 28 16:10:57 Linux233 kernel: HighMem free:0kB min:128kB low:128kB 
high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Jul 28 16:10:57 Linux233 kernel: lowmem_reserve[]: 0 0 0 0
Jul 28 16:10:57 Linux233 kernel: DMA: 8*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 
0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1120kB
Jul 28 16:10:57 Linux233 kernel: DMA32: empty
Jul 28 16:10:57 Linux233 kernel: Normal: 77*4kB 9*8kB 2*16kB 0*32kB 1*64kB 
0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2268kB
Jul 28 16:10:57 Linux233 kernel: HighMem: empty
Jul 28 16:10:57 Linux233 kernel: Swap cache: add 34273, delete 34058, find 
6/23, race 0+0
Jul 28 16:10:57 Linux233 kernel: Free swap  = 0kB
Jul 28 16:10:57 Linux233 kernel: Total swap = 136512kB
Jul 28 16:10:57 Linux233 kernel: Free swap:            0kB
Jul 28 16:10:57 Linux233 kernel: 65536 pages of RAM
Jul 28 16:10:57 Linux233 kernel: 0 pages of HIGHMEM
Jul 28 16:10:57 Linux233 kernel: 1200 reserved pages
Jul 28 16:10:57 Linux233 kernel: 2072 pages shared
Jul 28 16:10:57 Linux233 kernel: 215 pages swap cached
Jul 28 16:10:57 Linux233 kernel: 0 pages dirty
Jul 28 16:10:57 Linux233 kernel: 0 pages writeback
Jul 28 16:10:57 Linux233 kernel: 61652 pages mapped
Jul 28 16:10:57 Linux233 kernel: 1464 pages slab
Jul 28 16:10:57 Linux233 kernel: 163 pages pagetables
Jul 28 16:10:57 Linux233 kernel: Out of Memory: Kill process 4809 (bash) score 
2904 and children.
Jul 28 16:10:57 Linux233 kernel: Out of memory: Killed process 4846 
(sa-learn).

-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
