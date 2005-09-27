Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVI0HOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVI0HOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVI0HOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:14:10 -0400
Received: from tornado.reub.net ([202.89.145.182]:51676 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964833AbVI0HOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:14:09 -0400
Message-ID: <4338F136.1020404@reub.net>
Date: Tue, 27 Sep 2005 19:13:58 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050926)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.14-rc2-mm1 (Oops, possibly Netfilter related?)
References: <20050921222839.76c53ba1.akpm@osdl.org>
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 22/09/2005 5:28 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/
> 
> - Added git tree `git-sas.patch': Luben Tuikov's SAS driver and its support.
> 
> - Various random other things - nothing major.

Just noticed this oops from about 4am this morning.  This would have been at 
about the time when the normal daily cronjobs are run, but shouldn't have been 
doing much else.


Sep 27 04:04:28 tornado kernel: smbd: page allocation failure. order:1, 
mode:0x80000020
Sep 27 04:04:28 tornado kernel:  [<c0103ad0>] dump_stack+0x17/0x19
Sep 27 04:04:28 tornado kernel:  [<c013f84a>] __alloc_pages+0x2d8/0x3ef
Sep 27 04:04:28 tornado kernel:  [<c0142b32>] kmem_getpages+0x2c/0x91
Sep 27 04:04:28 tornado kernel:  [<c0144136>] cache_grow+0xa2/0x1aa
Sep 27 04:04:28 tornado kernel:  [<c0144810>] cache_alloc_refill+0x279/0x2bb
Sep 27 04:04:28 tornado kernel:  [<c0144da9>] __kmalloc+0xc7/0xe7
Sep 27 04:04:28 tornado kernel:  [<c02ab386>] pskb_expand_head+0x4b/0x11a
Sep 27 04:04:28 tornado kernel:  [<c02afd34>] skb_checksum_help+0xcb/0xe5
Sep 27 04:04:28 tornado kernel:  [<c0302b0d>] ip_nat_fn+0x16d/0x1bf
Sep 27 04:04:28 tornado kernel:  [<c0302cdc>] ip_nat_local_fn+0x57/0x8d
Sep 27 04:04:28 tornado kernel:  [<c03068ef>] nf_iterate+0x59/0x7d
Sep 27 04:04:28 tornado kernel:  [<c030695d>] nf_hook_slow+0x4a/0x109
Sep 27 04:04:28 tornado kernel:  [<c02ca035>] ip_queue_xmit+0x23c/0x4f5
Sep 27 04:04:28 tornado kernel:  [<c02da477>] tcp_transmit_skb+0x3ce/0x713
Sep 27 04:04:29 tornado kernel:  [<c02db53b>] tcp_write_xmit+0x124/0x37b
Sep 27 04:04:29 tornado kernel:  [<c02db7b3>] __tcp_push_pending_frames+0x21/0x70
Sep 27 04:04:29 tornado kernel:  [<c02d0b45>] tcp_sendmsg+0x9cc/0xabc
Sep 27 04:04:29 tornado kernel:  [<c02ed3dd>] inet_sendmsg+0x2e/0x4c
Sep 27 04:04:29 tornado kernel:  [<c02a6691>] sock_sendmsg+0xbf/0xe3
Sep 27 04:04:29 tornado kernel:  [<c02a77be>] sys_sendto+0xa5/0xbe
Sep 27 04:04:29 tornado kernel:  [<c02a780d>] sys_send+0x36/0x38
Sep 27 04:04:29 tornado kernel:  [<c02a7ef7>] sys_socketcall+0x134/0x251
Sep 27 04:04:29 tornado kernel:  [<c0102b5b>] sysenter_past_esp+0x54/0x75
Sep 27 04:04:29 tornado kernel: Mem-info:
Sep 27 04:04:29 tornado kernel: DMA per-cpu:
Sep 27 04:04:29 tornado kernel: cpu 0 hot: low 0, high 12, batch 2 used:10
Sep 27 04:04:29 tornado kernel: cpu 0 cold: low 0, high 4, batch 1 used:3
Sep 27 04:04:29 tornado kernel: cpu 1 hot: low 0, high 12, batch 2 used:10
Sep 27 04:04:29 tornado kernel: cpu 1 cold: low 0, high 4, batch 1 used:3
Sep 27 04:04:29 tornado kernel: DMA32 per-cpu: empty
Sep 27 04:04:30 tornado kernel: Normal per-cpu:
Sep 27 04:04:30 tornado kernel: cpu 0 hot: low 0, high 384, batch 64 used:346
Sep 27 04:04:30 tornado kernel: cpu 0 cold: low 0, high 128, batch 32 used:115
Sep 27 04:04:30 tornado kernel: cpu 1 hot: low 0, high 384, batch 64 used:324
Sep 27 04:04:30 tornado kernel: cpu 1 cold: low 0, high 128, batch 32 used:112
Sep 27 04:04:30 tornado kernel: HighMem per-cpu:
Sep 27 04:04:30 tornado kernel: cpu 0 hot: low 0, high 96, batch 16 used:38
Sep 27 04:04:30 tornado kernel: cpu 0 cold: low 0, high 32, batch 8 used:27
Sep 27 04:04:30 tornado kernel: cpu 1 hot: low 0, high 96, batch 16 used:36
Sep 27 04:04:30 tornado kernel: cpu 1 cold: low 0, high 32, batch 8 used:5
Sep 27 04:04:30 tornado kernel: Free pages:       38404kB (2720kB HighMem)
Sep 27 04:04:31 tornado kernel: Active:139410 inactive:49515 dirty:135 
writeback:1 unstable:0 free:9601 slab:54525 mapped:88304 pagetables:776
Sep 27 04:04:31 tornado kernel: DMA free:5828kB min:68kB low:84kB high:100kB 
active:100kB inactive:944kB present:16384kB pages_scanned:0 all_unreclaimable? no
Sep 27 04:04:31 tornado kernel: lowmem_reserve[]: 0 0 880 1006
Sep 27 04:04:31 tornado kernel: DMA32 free:0kB min:0kB low:0kB high:0kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Sep 27 04:04:31 tornado kernel: lowmem_reserve[]: 0 0 880 1006
Sep 27 04:04:31 tornado kernel: Normal free:29856kB min:3756kB low:4692kB 
high:5632kB active:446760kB inactive:188768kB present:901120kB pages_scanned:0 
all_unreclaimable? no
Sep 27 04:04:31 tornado kernel: lowmem_reserve[]: 0 0 0 1009
Sep 27 04:04:32 tornado kernel: HighMem free:2720kB min:128kB low:160kB 
high:192kB active:110784kB inactive:8344kB present:129212kB pages_scanned:0 
all_unreclaimable? no
Sep 27 04:04:32 tornado kernel: lowmem_reserve[]: 0 0 0 0
Sep 27 04:04:32 tornado kernel: DMA: 803*4kB 167*8kB 50*16kB 15*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 5828kB
Sep 27 04:04:32 tornado kernel: DMA32: empty
Sep 27 04:04:32 tornado kernel: Normal: 6744*4kB 360*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 29856kB
Sep 27 04:04:32 tornado kernel: HighMem: 654*4kB 13*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2720kB
Sep 27 04:04:32 tornado kernel: Swap cache: add 40, delete 40, find 1/2, race 0+0
Sep 27 04:04:32 tornado kernel: Free swap  = 497820kB
Sep 27 04:04:32 tornado kernel: Total swap = 497936kB
Sep 27 04:04:32 tornado kernel: Free swap:       497820kB
Sep 27 04:04:32 tornado kernel: 261679 pages of RAM
Sep 27 04:04:32 tornado kernel: 32303 pages of HIGHMEM
Sep 27 04:04:32 tornado kernel: 3160 reserved pages
Sep 27 04:04:32 tornado kernel: 160186 pages shared
Sep 27 04:04:32 tornado kernel: 0 pages swap cached
Sep 27 04:04:33 tornado kernel: 135 pages dirty
Sep 27 04:04:33 tornado kernel: 1 pages writeback
Sep 27 04:04:33 tornado kernel: 88304 pages mapped
Sep 27 04:04:33 tornado kernel: 54527 pages slab
Sep 27 04:04:33 tornado kernel: 776 pages pagetables
Sep 27 04:04:59 tornado kernel: smtpd: page allocation failure. order:1, 
mode:0x80000020
Sep 27 04:04:59 tornado kernel:  [<c0103ad0>] dump_stack+0x17/0x19
Sep 27 04:04:59 tornado kernel:  [<c013f84a>] __alloc_pages+0x2d8/0x3ef
Sep 27 04:04:59 tornado kernel:  [<c0142b32>] kmem_getpages+0x2c/0x91
Sep 27 04:04:59 tornado kernel:  [<c0144136>] cache_grow+0xa2/0x1aa
Sep 27 04:04:59 tornado kernel:  [<c0144810>] cache_alloc_refill+0x279/0x2bb
Sep 27 04:04:59 tornado kernel:  [<c0144da9>] __kmalloc+0xc7/0xe7
Sep 27 04:04:59 tornado kernel:  [<c02ab386>] pskb_expand_head+0x4b/0x11a
Sep 27 04:04:59 tornado kernel:  [<c02afd34>] skb_checksum_help+0xcb/0xe5
Sep 27 04:04:59 tornado kernel:  [<c0302b0d>] ip_nat_fn+0x16d/0x1bf
Sep 27 04:04:59 tornado kernel:  [<c0302cdc>] ip_nat_local_fn+0x57/0x8d
Sep 27 04:04:59 tornado kernel:  [<c03068ef>] nf_iterate+0x59/0x7d
Sep 27 04:04:59 tornado kernel:  [<c030695d>] nf_hook_slow+0x4a/0x109
Sep 27 04:05:00 tornado kernel:  [<c02ca035>] ip_queue_xmit+0x23c/0x4f5
Sep 27 04:05:00 tornado kernel:  [<c02da477>] tcp_transmit_skb+0x3ce/0x713
Sep 27 04:05:00 tornado kernel:  [<c02db53b>] tcp_write_xmit+0x124/0x37b
Sep 27 04:05:00 tornado kernel:  [<c02db7b3>] __tcp_push_pending_frames+0x21/0x70
Sep 27 04:05:01 tornado kernel:  [<c02d0b45>] tcp_sendmsg+0x9cc/0xabc
Sep 27 04:05:01 tornado kernel:  [<c02ed3dd>] inet_sendmsg+0x2e/0x4c
Sep 27 04:05:01 tornado kernel:  [<c02a69c6>] sock_aio_write+0xbd/0xf6
Sep 27 04:05:01 tornado kernel:  [<c0159767>] do_sync_write+0xbb/0x10a
Sep 27 04:05:01 tornado kernel:  [<c01598f7>] vfs_write+0x141/0x148
Sep 27 04:05:02 tornado kernel:  [<c015999f>] sys_write+0x3d/0x64
Sep 27 04:05:02 tornado kernel:  [<c0102b5b>] sysenter_past_esp+0x54/0x75
Sep 27 04:05:02 tornado kernel: Mem-info:
Sep 27 04:05:02 tornado kernel: DMA per-cpu:
Sep 27 04:05:02 tornado kernel: cpu 0 hot: low 0, high 12, batch 2 used:4
Sep 27 04:05:02 tornado kernel: cpu 0 cold: low 0, high 4, batch 1 used:3
Sep 27 04:05:02 tornado kernel: cpu 1 hot: low 0, high 12, batch 2 used:10
Sep 27 04:05:03 tornado kernel: cpu 1 cold: low 0, high 4, batch 1 used:3
Sep 27 04:05:03 tornado kernel: DMA32 per-cpu: empty
Sep 27 04:05:03 tornado kernel: Normal per-cpu:
Sep 27 04:05:03 tornado kernel: cpu 0 hot: low 0, high 384, batch 64 used:23
Sep 27 04:05:04 tornado kernel: cpu 0 cold: low 0, high 128, batch 32 used:115
Sep 27 04:05:04 tornado kernel: cpu 1 hot: low 0, high 384, batch 64 used:383
Sep 27 04:05:04 tornado kernel: cpu 1 cold: low 0, high 128, batch 32 used:120
Sep 27 04:05:04 tornado kernel: HighMem per-cpu:
Sep 27 04:05:04 tornado kernel: cpu 0 hot: low 0, high 96, batch 16 used:89
Sep 27 04:05:04 tornado kernel: cpu 0 cold: low 0, high 32, batch 8 used:3
Sep 27 04:05:05 tornado kernel: cpu 1 hot: low 0, high 96, batch 16 used:5
Sep 27 04:05:05 tornado kernel: cpu 1 cold: low 0, high 32, batch 8 used:27
Sep 27 04:05:05 tornado kernel: Free pages:       39608kB (2144kB HighMem)
Sep 27 04:05:05 tornado kernel: Active:132565 inactive:56281 dirty:100 
writeback:1 unstable:0 free:9902 slab:54546 mapped:88341 pagetables:776
Sep 27 04:05:05 tornado kernel: DMA free:4704kB min:68kB low:84kB high:100kB 
active:224kB inactive:948kB present:16384kB pages_scanned:0 all_unreclaimable? no
Sep 27 04:05:05 tornado kernel: lowmem_reserve[]: 0 0 880 1006
Sep 27 04:05:05 tornado kernel: DMA32 free:0kB min:0kB low:0kB high:0kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Sep 27 04:05:05 tornado kernel: lowmem_reserve[]: 0 0 880 1006
Sep 27 04:05:05 tornado kernel: Normal free:32760kB min:3756kB low:4692kB 
high:5632kB active:418168kB inactive:216412kB present:901120kB pages_scanned:0 
all_unreclaimable? no
Sep 27 04:05:05 tornado kernel: lowmem_reserve[]: 0 0 0 1009
Sep 27 04:05:05 tornado kernel: HighMem free:2144kB min:128kB low:160kB 
high:192kB active:111868kB inactive:7764kB present:129212kB pages_scanned:0 
all_unreclaimable? no
Sep 27 04:05:05 tornado kernel: lowmem_reserve[]: 0 0 0 0
Sep 27 04:05:05 tornado kernel: DMA: 936*4kB 108*8kB 6*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4704kB
Sep 27 04:05:05 tornado kernel: DMA32: empty
Sep 27 04:05:05 tornado kernel: Normal: 7484*4kB 349*8kB 2*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 32760kB
Sep 27 04:05:05 tornado kernel: HighMem: 510*4kB 13*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2144kB
Sep 27 04:05:05 tornado kernel: Swap cache: add 40, delete 40, find 1/2, race 0+0
Sep 27 04:05:05 tornado kernel: Free swap  = 497820kB
Sep 27 04:05:05 tornado kernel: Total swap = 497936kB
Sep 27 04:05:05 tornado kernel: Free swap:       497820kB
Sep 27 04:05:05 tornado kernel: 261679 pages of RAM
Sep 27 04:05:05 tornado kernel: 32303 pages of HIGHMEM
Sep 27 04:05:05 tornado kernel: 3160 reserved pages
Sep 27 04:05:06 tornado kernel: 165825 pages shared
Sep 27 04:05:06 tornado kernel: 0 pages swap cached
Sep 27 04:05:06 tornado kernel: 100 pages dirty
Sep 27 04:05:06 tornado kernel: 1 pages writeback
Sep 27 04:05:06 tornado kernel: 88341 pages mapped
Sep 27 04:05:06 tornado kernel: 54546 pages slab
Sep 27 04:05:06 tornado kernel: 776 pages pagetables


reuben
