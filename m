Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758155AbWK0Mpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbWK0Mpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758154AbWK0Mpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:45:47 -0500
Received: from fire.yars.free.net ([193.233.48.99]:10655 "EHLO fire.netis.ru")
	by vger.kernel.org with ESMTP id S1758155AbWK0Mpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:45:46 -0500
Date: Mon, 27 Nov 2006 15:44:44 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.6.18: memory leak(?)
Message-ID: <20061127124443.GA11569@night.netis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-NETIS-MailScanner-Information: Please contact NETIS Telecom for more information <info@netis.ru> (+7 0852 797709)
X-NETIS-MailScanner: Found to be clean
X-NETIS-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 6, autolearn=disabled, ALL_TRUSTED -1.00)
X-NETIS-MailScanner-From: lav@netis.ru
X-NETIS-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a while, a loaded http proxy gets many errors like below. It is
reproducible and happens again after reboot (in some time). It did not
happen with 2.6.17. I have also tested 2.6.18.3, the leak is there too.

swapper: page allocation failure. order:1, mode:0x20
 [<c012bc40>] __alloc_pages+0x253/0x267
 [<c013b12e>] cache_alloc_refill+0x243/0x3e7
 [<c013b317>] __kmalloc+0x45/0x51
 [<c01c11b8>] __alloc_skb+0x49/0xf4
 [<c01e2feb>] tcp_collapse+0x10f/0x2ca
 [<c01e32f5>] tcp_prune_queue+0x14f/0x20b
 [<c01e3550>] tcp_data_queue+0x19f/0x9e9
 [<c01ff7ea>] ipt_do_table+0x296/0x2c0
 [<c01e52ef>] tcp_rcv_established+0x533/0x5c4
 [<c01e9e2c>] tcp_v4_do_rcv+0x22/0x267
 [<c01ff88a>] ipt_hook+0x17/0x1d
 [<c01d04ad>] nf_iterate+0x30/0x61
 [<c01ebe08>] tcp_v4_rcv+0x751/0x7a5
 [<c01dd215>] tcp_prequeue_process+0x30/0x56
 [<c01d59a8>] ip_local_deliver+0x12f/0x1ab
 [<c01d5850>] ip_rcv+0x33f/0x368
 [<c01c4991>] netif_receive_skb+0x135/0x176
 [<c01c5da5>] process_backlog+0x6d/0xd2
 [<c01c5e5c>] net_rx_action+0x52/0xcb
 [<c0110463>] __do_softirq+0x35/0x75
 [<c01104c5>] do_softirq+0x22/0x26
 [<c0103b7f>] do_IRQ+0x45/0x4d
 [<c010266a>] common_interrupt+0x1a/0x20
 [<c0101506>] mwait_idle+0x20/0x33
 [<c01014d1>] cpu_idle+0x39/0x4e
 [<c02765f9>] start_kernel+0x275/0x277
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:21
cpu 0 cold: high 62, batch 15 used:59
HighMem per-cpu: empty
Free pages:       27156kB (0kB HighMem)
Active:165330 inactive:5001 dirty:18 writeback:283 unstable:0 free:6789 slab:48830 mapped:415 pagetables:278
DMA free:3548kB min:68kB low:84kB high:100kB active:2404kB inactive:0kB present:16384kB pages_scanned:357 all_unreclaimable? no
lowmem_reserve[]: 0 0 880 880
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 880 880
Normal free:23608kB min:3756kB low:4692kB high:5632kB active:658916kB inactive:20004kB present:901120kB pages_scanned:772 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 281*4kB 71*8kB 26*16kB 3*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 3548kB
DMA32: empty
Normal: 5726*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 23608kB
HighMem: empty
Swap cache: add 2143636, delete 2050596, find 187393/808790, race 0+0
Free swap  = 495296kB
Total swap = 1003972kB
Free swap:       495296kB
229376 pages of RAM
0 pages of HIGHMEM
2500 reserved pages
1450 pages shared
93040 pages swap cached
18 pages dirty
283 pages writeback
415 pages mapped
48830 pages slab
278 pages pagetables
