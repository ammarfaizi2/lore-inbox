Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWIVH1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWIVH1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWIVH1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:27:21 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:22742 "EHLO csg-cluster.dwd.de")
	by vger.kernel.org with ESMTP id S1750835AbWIVH1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:27:21 -0400
Date: Fri, 22 Sep 2006 07:27:18 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-net <linux-net@vger.kernel.org>
Subject: 2.6.1[78] page allocation failure. order:3, mode:0x20
Message-ID: <Pine.LNX.4.64.0609220655550.13396@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I get some of the "page allocation failure" errors. My hardware is 4 CPU
Opteron with one quad + one dual intel e1000 cards. Kernel is plain 2.6.18
and for two cards MTU is set to 9000.

    Sep 21 21:03:15 athena kernel: vsftpd: page allocation failure. order:3, mode:0x20
    Sep 21 21:03:15 athena kernel:
    Sep 21 21:03:15 athena kernel: Call Trace:
    Sep 21 21:03:15 athena kernel:  <IRQ> [<ffffffff8024e516>] __alloc_pages+0x282/0x29b
    Sep 21 21:03:15 athena kernel:  [<ffffffff8807aa93>] :ip_tables:ipt_do_table+0x1eb/0x318
    Sep 21 21:03:15 athena kernel:  [<ffffffff8026614b>] cache_grow+0x134/0x33d
    Sep 21 21:03:15 athena kernel:  [<ffffffff8026664c>] cache_alloc_refill+0x189/0x1d7
    Sep 21 21:03:15 athena kernel:  [<ffffffff80266724>] __kmalloc+0x8a/0x94
    Sep 21 21:03:15 athena kernel:  [<ffffffff803b5438>] __alloc_skb+0x5c/0x123
    Sep 21 21:03:15 athena kernel:  [<ffffffff803b5f2e>] __netdev_alloc_skb+0x12/0x2d
    Sep 21 21:03:15 athena kernel:  [<ffffffff8033cb22>] e1000_alloc_rx_buffers+0x6f/0x2f3
    Sep 21 21:03:15 athena kernel:  [<ffffffff803d1234>] ip_local_deliver+0x173/0x23b
    Sep 21 21:03:15 athena kernel:  [<ffffffff8033d29a>] e1000_clean_rx_irq+0x4f4/0x514
    Sep 21 21:03:15 athena kernel:  [<ffffffff8033c08b>] e1000_clean+0x2a8/0x394
    Sep 21 21:03:15 athena kernel:  [<ffffffff803bad58>] net_rx_action+0x77/0x15c
    Sep 21 21:03:15 athena kernel:  [<ffffffff8033ca9f>] e1000_intr+0xd5/0xe9
    Sep 21 21:03:15 athena kernel:  [<ffffffff8022fcb4>] __do_softirq+0x5e/0xd6
    Sep 21 21:03:15 athena kernel:  [<ffffffff80215fda>] end_level_ioapic_vector+0x9/0x16
    Sep 21 21:03:15 athena kernel:  [<ffffffff8020a9fc>] call_softirq+0x1c/0x28
    Sep 21 21:03:15 athena kernel:  [<ffffffff8020c4b9>] do_softirq+0x2c/0x7f
    Sep 21 21:03:15 athena kernel:  [<ffffffff8020c484>] do_IRQ+0x6a/0x73
    Sep 21 21:03:15 athena kernel:  [<ffffffff80209d21>] ret_from_intr+0x0/0xa
    Sep 21 21:03:15 athena kernel:  <EOI> [<ffffffff802d8ae2>] copy_user_generic_c+0x8/0x1a
    Sep 21 21:03:15 athena kernel:  [<ffffffff803b63f4>] memcpy_toiovec+0x36/0x66
    Sep 21 21:03:15 athena kernel:  [<ffffffff803b683c>] skb_copy_datagram_iovec+0x4f/0x1e8
    Sep 21 21:03:15 athena kernel:  [<ffffffff803dca2d>] tcp_recvmsg+0x62b/0xb05
    Sep 21 21:03:15 athena kernel:  [<ffffffff803b13d9>] sock_common_recvmsg+0x2d/0x42
    Sep 21 21:03:15 athena kernel:  [<ffffffff803af0a1>] do_sock_read+0x9b/0x9f
    Sep 21 21:03:15 athena kernel:  [<ffffffff803af7ba>] sock_aio_read+0x4f/0x5e
    Sep 21 21:03:15 athena kernel:  [<ffffffff8026b2ea>] do_sync_read+0xc7/0x104
    Sep 21 21:03:15 athena kernel:  [<ffffffff8023eb01>] hrtimer_start+0xbb/0xcd
    Sep 21 21:03:15 athena kernel:  [<ffffffff8023c720>] autoremove_wake_function+0x0/0x2e
    Sep 21 21:03:15 athena kernel:  [<ffffffff8040b1e5>] thread_return+0x0/0xd4
    Sep 21 21:03:15 athena kernel:  [<ffffffff8040abf0>] __sched_text_start+0x150/0x745
    Sep 21 21:03:15 athena kernel:  [<ffffffff8026baf3>] vfs_read+0xb9/0x104
    Sep 21 21:03:15 athena kernel:  [<ffffffff8026be77>] sys_read+0x45/0x6e
    Sep 21 21:03:15 athena kernel:  [<ffffffff80209826>] system_call+0x7e/0x83
    Sep 21 21:03:15 athena kernel:
    Sep 21 21:03:15 athena kernel: Mem-info:
    Sep 21 21:03:15 athena kernel: Node 0 DMA per-cpu:
    Sep 21 21:03:15 athena kernel: cpu 0 hot: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 0 cold: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 1 hot: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 1 cold: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 2 hot: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 2 cold: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 3 hot: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: cpu 3 cold: high 0, batch 1 used:0
    Sep 21 21:03:15 athena kernel: Node 0 DMA32 per-cpu:
    Sep 21 21:03:15 athena kernel: cpu 0 hot: high 186, batch 31 used:182
    Sep 21 21:03:15 athena kernel: cpu 0 cold: high 62, batch 15 used:59
    Sep 21 21:03:15 athena kernel: cpu 1 hot: high 186, batch 31 used:176
    Sep 21 21:03:15 athena kernel: cpu 1 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 2 hot: high 186, batch 31 used:178
    Sep 21 21:03:15 athena kernel: cpu 2 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 3 hot: high 186, batch 31 used:180
    Sep 21 21:03:15 athena kernel: cpu 3 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: Node 0 Normal per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 0 HighMem per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 1 DMA per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 1 DMA32 per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 1 Normal per-cpu:
    Sep 21 21:03:15 athena kernel: cpu 0 hot: high 186, batch 31 used:163
    Sep 21 21:03:15 athena kernel: cpu 0 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 1 hot: high 186, batch 31 used:7
    Sep 21 21:03:15 athena kernel: cpu 1 cold: high 62, batch 15 used:48
    Sep 21 21:03:15 athena kernel: cpu 2 hot: high 186, batch 31 used:156
    Sep 21 21:03:15 athena kernel: cpu 2 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 3 hot: high 186, batch 31 used:170
    Sep 21 21:03:15 athena kernel: cpu 3 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: Node 1 HighMem per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 2 DMA per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 2 DMA32 per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 2 Normal per-cpu:
    Sep 21 21:03:15 athena kernel: cpu 0 hot: high 186, batch 31 used:170
    Sep 21 21:03:15 athena kernel: cpu 0 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 1 hot: high 186, batch 31 used:170
    Sep 21 21:03:15 athena kernel: cpu 1 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 2 hot: high 186, batch 31 used:18
    Sep 21 21:03:15 athena kernel: cpu 2 cold: high 62, batch 15 used:55
    Sep 21 21:03:15 athena kernel: cpu 3 hot: high 186, batch 31 used:155
    Sep 21 21:03:15 athena kernel: cpu 3 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: Node 2 HighMem per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 3 DMA per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 3 DMA32 per-cpu: empty
    Sep 21 21:03:15 athena kernel: Node 3 Normal per-cpu:
    Sep 21 21:03:15 athena kernel: cpu 0 hot: high 186, batch 31 used:169
    Sep 21 21:03:15 athena kernel: cpu 0 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 1 hot: high 186, batch 31 used:172
    Sep 21 21:03:15 athena kernel: cpu 1 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 2 hot: high 186, batch 31 used:154
    Sep 21 21:03:15 athena kernel: cpu 2 cold: high 62, batch 15 used:0
    Sep 21 21:03:15 athena kernel: cpu 3 hot: high 186, batch 31 used:155
    Sep 21 21:03:15 athena kernel: cpu 3 cold: high 62, batch 15 used:60
    Sep 21 21:03:15 athena kernel: Node 3 HighMem per-cpu: empty
    Sep 21 21:03:15 athena kernel: Free pages:      654488kB (0kB HighMem)
    Sep 21 21:03:15 athena kernel: Active:1351719 inactive:440448 dirty:105021 writeback:0 unstable:0 free:163622 slab:94084 mapped:11424 pagetables:3165
    Sep 21 21:03:15 athena kernel: Node 0 DMA free:1808kB min:16kB low:20kB high:24kB active:0kB inactive:0kB present:12016kB pages_scanned:0 all_unreclaimable? yes
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 2003 2003 2003
    Sep 21 21:03:15 athena kernel: Node 0 DMA32 free:95492kB min:2852kB low:3564kB high:4276kB active:1432704kB inactive:435520kB present:2051744kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 0 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 1 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 1 Normal free:75860kB min:2876kB low:3592kB high:4312kB active:1569988kB inactive:327416kB present:2068480kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 1 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 2 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 2 Normal free:172028kB min:2876kB low:3592kB high:4312kB active:1256216kB inactive:524508kB present:2068480kB pages_scanned:13 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 2 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 3 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 2020 2020
    Sep 21 21:03:15 athena kernel: Node 3 Normal free:320576kB min:2876kB low:3592kB high:4312kB active:1147740kB inactive:463360kB present:2068480kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 3 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
    Sep 21 21:03:15 athena kernel: lowmem_reserve[]: 0 0 0 0
    Sep 21 21:03:15 athena kernel: Node 0 DMA: 4*4kB 4*8kB 2*16kB 4*32kB 1*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1808kB
    Sep 21 21:03:15 athena kernel: Node 0 DMA32: 19481*4kB 2482*8kB 17*16kB 1*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 98212kB
    Sep 21 21:03:15 athena kernel: Node 0 Normal: empty
    Sep 21 21:03:15 athena kernel: Node 0 HighMem: empty
    Sep 21 21:03:15 athena kernel: Node 1 DMA: empty
    Sep 21 21:03:15 athena kernel: Node 1 DMA32: empty
    Sep 21 21:03:15 athena kernel: Node 1 Normal: 10672*4kB 4024*8kB 121*16kB 1*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 76976kB
    Sep 21 21:03:15 athena kernel: Node 1 HighMem: empty
    Sep 21 21:03:15 athena kernel: Node 2 DMA: empty
    Sep 21 21:03:15 athena kernel: Node 2 DMA32: empty
    Sep 21 21:03:15 athena kernel: Node 2 Normal: 24795*4kB 8355*8kB 381*16kB 1*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 172276kB
    Sep 21 21:03:15 athena kernel: Node 2 HighMem: empty
    Sep 21 21:03:15 athena kernel: Node 3 DMA: empty
    Sep 21 21:03:15 athena kernel: Node 3 DMA32: empty
    Sep 21 21:03:15 athena kernel: Node 3 Normal: 47395*4kB 14417*8kB 926*16kB 96*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 322932kB
    Sep 21 21:03:15 athena kernel: Node 3 HighMem: empty
    Sep 21 21:03:15 athena kernel: Swap cache: add 53, delete 53, find 0/0, race 0+0
    Sep 21 21:03:15 athena kernel: Free swap  = 33214052kB
    Sep 21 21:03:15 athena kernel: Total swap = 33214264kB
    Sep 21 21:03:15 athena kernel: Free swap:       33214052kB
    Sep 21 21:03:15 athena kernel: 2097152 pages of RAM
    Sep 21 21:03:15 athena kernel: 32970 reserved pages
    Sep 21 21:03:15 athena kernel: 1640568 pages shared
    Sep 21 21:03:15 athena kernel: 0 pages swap cached

With 2.6.16.x there where no issues. I am not sure, but this seems to indicate
some error in the e1000 driver and there was a major update between 2.6.16
and 2.6.18. I have also tried 2.6.17, it has the same issue. So I need to
go back to 2.6.16.

What can I do to remove those errors?

Holger
-- 

