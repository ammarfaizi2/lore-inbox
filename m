Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425486AbWLHMhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425486AbWLHMhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425485AbWLHMhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:37:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:33221 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425486AbWLHMhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:37:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bTwOOxpXuhTqlFudmBlGXag5Wsm+Cu66oknc+LFeUhgHTFSkj1ESiqi9vOnJK01g7dHpqdNFBLaUyegA/2tHkoYpdtF2vLAn+S18XQ0XGolKd2JyLu8jbpZS8FZXob/9zZpMjqrAAn5Ctp0wuSVz7vR6M5Bcp/dhGboNtOxeQKE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Lots of "swapper: page allocation failure" and other memory related messages - 2.6.16-xen0
Date: Fri, 8 Dec 2006 13:36:59 +0100
User-Agent: KMail/1.9.5
Cc: Jesper Juhl <jesper.juhl@gmail.com>, xen-devel@lists.xensource.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081336.59361.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on Cc when replying)

I have a server running Xen that regularly spews the following.
The box seems to survive fine regardless - just thought I'd let everyone know.

Dec  8 12:19:26 server kernel: 0x47/0x7a
Dec  8 12:19:26 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:26 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:26 server kernel:  [netif_be_start_xmit+166/431] netif_be_start_xmit+0xa6/0x1af
Dec  8 12:19:26 server kernel:  [dev_queue_xmit+520/679] dev_queue_xmit+0x208/0x2a7
Dec  8 12:19:26 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:26 server kernel:  [br_dev_queue_push_xmit+216/223] br_dev_queue_push_xmit+0xd8/0xdf
Dec  8 12:19:26 server kernel:  [br_forward_finish+61/65] br_forward_finish+0x3d/0x41
Dec  8 12:19:26 server kernel:  [br_nf_forward_finish+199/204] br_nf_forward_finish+0xc7/0xcc
Dec  8 12:19:26 server kernel:  [br_nf_forward_arp+274/285] br_nf_forward_arp+0x112/0x11d
Dec  8 12:19:26 server kernel:  [nf_iterate+63/109] nf_iterate+0x3f/0x6d
Dec  8 12:19:26 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:26 server kernel:  [nf_hook_slow+71/193] nf_hook_slow+0x47/0xc1
Dec  8 12:19:26 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:26 server kernel:  [__br_forward+70/87] __br_forward+0x46/0x57
Dec  8 12:19:26 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:26 server kernel:  [br_flood+116/207] br_flood+0x74/0xcf
Dec  8 12:19:26 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:26 server kernel:  [br_flood_forward+22/27] br_flood_forward+0x16/0x1b
Dec  8 12:19:26 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:26 server kernel:  [br_handle_frame_finish+134/252] br_handle_frame_finish+0x86/0xfc
Dec  8 12:19:26 server kernel:  [br_handle_frame+358/421] br_handle_frame+0x166/0x1a5
Dec  8 12:19:26 server kernel:  [netif_receive_skb+333/538] netif_receive_skb+0x14d/0x21a
Dec  8 12:19:26 server kernel:  [tg3_rx+732/957] tg3_rx+0x2dc/0x3bd
Dec  8 12:19:26 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:26 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:27 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:27 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:27 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:27 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:27 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:27 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:27 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:27 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:27 server kernel: Mem-info:
Dec  8 12:19:27 server kernel: DMA per-cpu:
Dec  8 12:19:27 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:27 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:27 server kernel: cpu 1 hot: high 90, batch 15 used:56
Dec  8 12:19:27 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:27 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:27 server kernel: Normal per-cpu: empty
Dec  8 12:19:27 server kernel: HighMem per-cpu: empty
Dec  8 12:19:27 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:27 server kernel: Active:12194 inactive:16772 dirty:70 writeback:0 unstable:0 free:194 slab:17017 mapped:5214 pagetables:115
Dec  8 12:19:27 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48776kB inactive:67088kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:27 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:27 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:27 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:27 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:27 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:27 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:27 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:27 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:27 server kernel: DMA32: empty
Dec  8 12:19:27 server kernel: Normal: empty
Dec  8 12:19:27 server kernel: HighMem: empty
Dec  8 12:19:27 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:27 server kernel: Free swap  = 3901244kB
Dec  8 12:19:27 server kernel: Total swap = 3903784kB
Dec  8 12:19:27 server kernel: Free swap:       3901244kB
Dec  8 12:19:27 server kernel: 67584 pages of RAM
Dec  8 12:19:27 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:27 server kernel: 18345 reserved pages
Dec  8 12:19:27 server kernel: 25617 pages shared
Dec  8 12:19:28 server kernel: 0 pages swap cached
Dec  8 12:19:28 server kernel: 70 pages dirty
Dec  8 12:19:28 server kernel: 0 pages writeback
Dec  8 12:19:28 server kernel: 5214 pages mapped
Dec  8 12:19:28 server kernel: 17017 pages slab
Dec  8 12:19:28 server kernel: 115 pages pagetables
Dec  8 12:19:28 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:28 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:28 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:28 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:28 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:28 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:28 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:28 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:28 server kernel:  [netif_be_start_xmit+166/431] netif_be_start_xmit+0xa6/0x1af
Dec  8 12:19:28 server kernel:  [dev_queue_xmit+520/679] dev_queue_xmit+0x208/0x2a7
Dec  8 12:19:28 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:28 server kernel:  [br_dev_queue_push_xmit+216/223] br_dev_queue_push_xmit+0xd8/0xdf
Dec  8 12:19:28 server kernel:  [br_forward_finish+61/65] br_forward_finish+0x3d/0x41
Dec  8 12:19:28 server kernel:  [br_nf_forward_finish+199/204] br_nf_forward_finish+0xc7/0xcc
Dec  8 12:19:28 server kernel:  [br_nf_forward_arp+274/285] br_nf_forward_arp+0x112/0x11d
Dec  8 12:19:28 server kernel:  [nf_iterate+63/109] nf_iterate+0x3f/0x6d
Dec  8 12:19:28 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:28 server kernel:  [nf_hook_slow+71/193] nf_hook_slow+0x47/0xc1
Dec  8 12:19:28 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:28 server kernel:  [__br_forward+70/87] __br_forward+0x46/0x57
Dec  8 12:19:28 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:28 server kernel:  [br_flood+116/207] br_flood+0x74/0xcf
Dec  8 12:19:28 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:28 server kernel:  [br_flood_forward+22/27] br_flood_forward+0x16/0x1b
Dec  8 12:19:28 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:28 server kernel:  [br_handle_frame_finish+134/252] br_handle_frame_finish+0x86/0xfc
Dec  8 12:19:28 server kernel:  forward+0x46/0x57
Dec  8 12:19:28 server kernel:  [br_forward_finish+0/65] br_forward_finish+0x0/0x41
Dec  8 12:19:28 server kernel:  [br_flood+116/207] br_flood+0x74/0xcf
Dec  8 12:19:28 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:28 server kernel:  [br_flood_forward+22/27] br_flood_forward+0x16/0x1b
Dec  8 12:19:28 server kernel:  [__br_forward+0/87] __br_forward+0x0/0x57
Dec  8 12:19:28 server kernel:  [br_handle_frame_finish+134/252] br_handle_frame_finish+0x86/0xfc
Dec  8 12:19:28 server kernel:  [br_handle_frame+358/421] br_handle_frame+0x166/0x1a5
Dec  8 12:19:28 server kernel:  [netif_receive_skb+333/538] netif_receive_skb+0x14d/0x21a
Dec  8 12:19:28 server kernel:  [tg3_rx+732/957] tg3_rx+0x2dc/0x3bd
Dec  8 12:19:28 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:29 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:29 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:29 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:29 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:29 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:29 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:29 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:29 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:29 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:29 server kernel: Mem-info:
Dec  8 12:19:29 server kernel: DMA per-cpu:
Dec  8 12:19:29 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:29 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:29 server kernel: cpu 1 hot: high 90, batch 15 used:56
Dec  8 12:19:29 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:29 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:29 server kernel: Normal per-cpu: empty
Dec  8 12:19:29 server kernel: HighMem per-cpu: empty
Dec  8 12:19:29 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:29 server kernel: Active:12194 inactive:16772 dirty:70 writeback:0 unstable:0 free:194 slab:17017 mapped:5214 pagetables:115
Dec  8 12:19:29 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48776kB inactive:67088kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:29 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:29 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:29 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:29 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:29 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:29 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:29 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:29 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:29 server kernel: DMA32: empty
Dec  8 12:19:29 server kernel: Normal: empty
Dec  8 12:19:29 server kernel: HighMem: empty
Dec  8 12:19:29 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:29 server kernel: Free swap  = 3901244kB
Dec  8 12:19:29 server kernel: Total swap = 3903784kB
Dec  8 12:19:29 server kernel: Free swap:       3901244kB
Dec  8 12:19:29 server kernel: 67584 pages of RAM
Dec  8 12:19:29 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:29 server kernel: 18345 reserved pages
Dec  8 12:19:29 server kernel: 25617 pages shared
Dec  8 12:19:29 server kernel: 0 pages swap cached
Dec  8 12:19:29 server kernel: 70 pages dirty
Dec  8 12:19:29 server kernel: 0 pages writeback
Dec  8 12:19:30 server kernel: 5214 pages mapped
Dec  8 12:19:30 server kernel: 17017 pages slab
Dec  8 12:19:30 server kernel: 115 pages pagetables
Dec  8 12:19:30 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:30 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:30 server kernel:  [arp_rcv+257/326] arp_rcv+0x101/0x146
Dec  8 12:19:30 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:30 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:30 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:30 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:30 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:30 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:30 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:30 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:30 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:30 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:30 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:30 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:30 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:30 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:30 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:30 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:30 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:30 server kernel: Mem-info:
Dec  8 12:19:30 server kernel: DMA per-cpu:
Dec  8 12:19:30 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:30 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:30 server kernel: cpu 1 hot: high 90, batch 15 used:56
Dec  8 12:19:30 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:30 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:30 server kernel: Normal per-cpu: empty
Dec  8 12:19:30 server kernel: HighMem per-cpu: empty
Dec  8 12:19:30 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:30 server kernel: Active:12194 inactive:16772 dirty:70 writeback:0 unstable:0 free:194 slab:17017 mapped:5214 pagetables:115
Dec  8 12:19:30 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48776kB inactive:67088kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:30 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:30 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:30 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:30 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:30 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:30 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:30 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:30 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:30 server kernel: DMA32: empty
Dec  8 12:19:30 server kernel: Normal: empty
Dec  8 12:19:31 server kernel: HighMem: empty
Dec  8 12:19:31 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:31 server kernel: Free swap  = 3901244kB
Dec  8 12:19:31 server kernel: Total swap = 3903784kB
Dec  8 12:19:31 server kernel: Free swap:       3901244kB
Dec  8 12:19:31 server kernel: 67584 pages of RAM
Dec  8 12:19:31 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:31 server kernel: 18345 reserved pages
Dec  8 12:19:31 server kernel: 25617 pages shared
Dec  8 12:19:31 server kernel: 0 pages swap cached
Dec  8 12:19:31 server kernel: 70 pages dirty
Dec  8 12:19:31 server kernel: 0 pages writeback
Dec  8 12:19:31 server kernel: 5214 pages mapped
Dec  8 12:19:31 server kernel: 17017 pages slab
Dec  8 12:19:31 server kernel: 115 pages pagetables
Dec  8 12:19:31 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:31 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:31 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:31 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:31 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:31 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:31 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:31 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:31 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:31 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:31 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:31 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:31 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:31 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:31 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:31 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:31 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:31 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:31 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:31 server kernel: Mem-info:
Dec  8 12:19:31 server kernel: DMA per-cpu:
Dec  8 12:19:31 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:31 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:31 server kernel: cpu 1 hot: high 90, batch 15 used:56
Dec  8 12:19:31 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:31 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:31 server kernel: Normal per-cpu: empty
Dec  8 12:19:31 server kernel: HighMem per-cpu: empty
Dec  8 12:19:31 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:31 server kernel: Active:12194 inactive:16772 dirty:70 writeback:0 unstable:0 free:194 slab:17017 mapped:5214 pagetables:115
Dec  8 12:19:32 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48776kB inactive:67088kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:32 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:32 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:32 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:32 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:32 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:32 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:32 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:32 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:32 server kernel: DMA32: empty
Dec  8 12:19:32 server kernel: Normal: empty
Dec  8 12:19:32 server kernel: HighMem: empty
Dec  8 12:19:32 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:32 server kernel: Free swap  = 3901244kB
Dec  8 12:19:32 server kernel: Total swap = 3903784kB
Dec  8 12:19:32 server kernel: Free swap:       3901244kB
Dec  8 12:19:32 server kernel: 67584 pages of RAM
Dec  8 12:19:32 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:32 server kernel: 18345 reserved pages
Dec  8 12:19:32 server kernel: 25617 pages shared
Dec  8 12:19:32 server kernel: 0 pages swap cached
Dec  8 12:19:32 server kernel: 70 pages dirty
Dec  8 12:19:32 server kernel: 0 pages writeback
Dec  8 12:19:32 server kernel: 5214 pages mapped
Dec  8 12:19:32 server kernel: 17017 pages slab
Dec  8 12:19:32 server kernel: 115 pages pagetables
Dec  8 12:19:32 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:32 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:32 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:32 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:32 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:32 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:32 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:32 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:32 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:32 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:32 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:32 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:32 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:32 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:32 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:32 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:33 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:33 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:33 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:33 server kernel: Mem-info:
Dec  8 12:19:33 server kernel: DMA per-cpu:
Dec  8 12:19:33 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:33 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:33 server kernel: cpu 1 hot: high 90, batch 15 used:56
Dec  8 12:19:33 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:33 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:33 server kernel: Normal per-cpu: empty
Dec  8 12:19:33 server kernel: HighMem per-cpu: empty
Dec  8 12:19:33 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:33 server kernel: Active:12194 inactive:16772 dirty:70 writeback:0 unstable:0 free:194 slab:17017 mapped:5214 pagetables:115
Dec  8 12:19:33 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48776kB inactive:67088kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:33 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:33 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:33 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:33 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:33 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:33 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:33 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:33 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:33 server kernel: DMA32: empty
Dec  8 12:19:33 server kernel: Normal: empty
Dec  8 12:19:33 server kernel: HighMem: empty
Dec  8 12:19:33 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:33 server kernel: Free swap  = 3901244kB
Dec  8 12:19:33 server kernel: Total swap = 3903784kB
Dec  8 12:19:33 server kernel: Free swap:       3901244kB
Dec  8 12:19:33 server kernel: 67584 pages of RAM
Dec  8 12:19:33 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:33 server kernel: 18345 reserved pages
Dec  8 12:19:33 server kernel: 25617 pages shared
Dec  8 12:19:33 server kernel: 0 pages swap cached
Dec  8 12:19:34 server kernel: 70 pages dirty
Dec  8 12:19:34 server kernel: 0 pages writeback
Dec  8 12:19:34 server kernel: 5214 pages mapped
Dec  8 12:19:34 server kernel: 17017 pages slab
Dec  8 12:19:34 server kernel: 115 pages pagetables
Dec  8 12:19:34 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:34 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:34 server kernel:  [arp_rcv+257/326] arp_rcv+0x101/0x146
Dec  8 12:19:34 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:34 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:34 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:34 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:34 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:34 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:34 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:34 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:34 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:34 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:34 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:34 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:34 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:34 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:34 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:34 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:34 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:34 server kernel: Mem-info:
Dec  8 12:19:34 server kernel: DMA per-cpu:
Dec  8 12:19:34 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:34 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:34 server kernel: cpu 1 hot: high 90, batch 15 used:57
Dec  8 12:19:34 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:34 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:34 server kernel: Normal per-cpu: empty
Dec  8 12:19:34 server kernel: HighMem per-cpu: empty
Dec  8 12:19:34 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:34 server kernel: Active:12209 inactive:16785 dirty:73 writeback:1 unstable:0 free:194 slab:16986 mapped:5214 pagetables:115
Dec  8 12:19:34 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48836kB inactive:67140kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:34 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:34 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:34 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:35 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:35 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:35 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:35 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:35 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:35 server kernel: DMA32: empty
Dec  8 12:19:35 server kernel: Normal: empty
Dec  8 12:19:35 server kernel: HighMem: empty
Dec  8 12:19:35 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:35 server kernel: Free swap  = 3901244kB
Dec  8 12:19:35 server kernel: Total swap = 3903784kB
Dec  8 12:19:35 server kernel: Free swap:       3901244kB
Dec  8 12:19:35 server kernel: 67584 pages of RAM
Dec  8 12:19:35 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:35 server kernel: 18345 reserved pages
Dec  8 12:19:35 server kernel: 25652 pages shared
Dec  8 12:19:35 server kernel: 0 pages swap cached
Dec  8 12:19:35 server kernel: 73 pages dirty
Dec  8 12:19:35 server kernel: 1 pages writeback
Dec  8 12:19:35 server kernel: 5214 pages mapped
Dec  8 12:19:35 server kernel: 16986 pages slab
Dec  8 12:19:35 server kernel: 115 pages pagetables
Dec  8 12:19:35 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:35 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:35 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:35 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:35 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:35 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:35 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:35 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:35 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:35 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:35 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:35 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:35 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:35 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:35 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:35 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:35 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:35 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:35 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:36 server kernel: Mem-info:
Dec  8 12:19:36 server kernel: DMA per-cpu:
Dec  8 12:19:36 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:36 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:36 server kernel: cpu 1 hot: high 90, batch 15 used:57
Dec  8 12:19:36 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:36 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:36 server kernel: Normal per-cpu: empty
Dec  8 12:19:36 server kernel: HighMem per-cpu: empty
Dec  8 12:19:36 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:36 server kernel: Active:12209 inactive:16785 dirty:73 writeback:1 unstable:0 free:194 slab:16986 mapped:5214 pagetables:115
Dec  8 12:19:36 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48836kB inactive:67140kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:36 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:36 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:36 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:36 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:36 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:36 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:36 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:36 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:36 server kernel: DMA32: empty
Dec  8 12:19:36 server kernel: Normal: empty
Dec  8 12:19:36 server kernel: HighMem: empty
Dec  8 12:19:36 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:36 server kernel: Free swap  = 3901244kB
Dec  8 12:19:36 server kernel: Total swap = 3903784kB
Dec  8 12:19:36 server kernel: Free swap:       3901244kB
Dec  8 12:19:36 server kernel: 67584 pages of RAM
Dec  8 12:19:36 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:36 server kernel: 18345 reserved pages
Dec  8 12:19:36 server kernel: 25652 pages shared
Dec  8 12:19:36 server kernel: 0 pages swap cached
Dec  8 12:19:36 server kernel: 73 pages dirty
Dec  8 12:19:36 server kernel: 1 pages writeback
Dec  8 12:19:36 server kernel: 5214 pages mapped
Dec  8 12:19:36 server kernel: 16986 pages slab
Dec  8 12:19:36 server kernel: 115 pages pagetables
Dec  8 12:19:36 server kernel: swapper: page allocation failure. order:0, mode:0x20
Dec  8 12:19:37 server kernel:  [__alloc_pages+593/611] __alloc_pages+0x251/0x263
Dec  8 12:19:37 server kernel:  [kmem_getpages+57/136] kmem_getpages+0x39/0x88
Dec  8 12:19:37 server kernel:  [cache_grow+188/372] cache_grow+0xbc/0x174
Dec  8 12:19:37 server kernel:  [cache_alloc_refill+366/439] cache_alloc_refill+0x16e/0x1b7
Dec  8 12:19:37 server kernel:  [kmem_cache_alloc+71/122] kmem_cache_alloc+0x47/0x7a
Dec  8 12:19:37 server kernel:  [alloc_skb_from_cache+70/243] alloc_skb_from_cache+0x46/0xf3
Dec  8 12:19:37 server kernel:  [__dev_alloc_skb+70/92] __dev_alloc_skb+0x46/0x5c
Dec  8 12:19:37 server kernel:  [tg3_rx+432/957] tg3_rx+0x1b0/0x3bd
Dec  8 12:19:37 server kernel:  [tg3_poll+119/356] tg3_poll+0x77/0x164
Dec  8 12:19:37 server kernel:  [net_rx_action+164/368] net_rx_action+0xa4/0x170
Dec  8 12:19:37 server kernel:  [__do_softirq+116/240] __do_softirq+0x74/0xf0
Dec  8 12:19:37 server kernel:  [do_softirq+63/99] do_softirq+0x3f/0x63
Dec  8 12:19:37 server kernel:  [do_IRQ+31/37] do_IRQ+0x1f/0x25
Dec  8 12:19:37 server kernel:  [evtchn_do_upcall+132/192] evtchn_do_upcall+0x84/0xc0
Dec  8 12:19:37 server kernel:  [hypervisor_callback+44/52] hypervisor_callback+0x2c/0x34
Dec  8 12:19:37 server kernel:  [xen_idle+97/127] xen_idle+0x61/0x7f
Dec  8 12:19:37 server kernel:  [cpu_idle+76/97] cpu_idle+0x4c/0x61
Dec  8 12:19:37 server kernel:  [start_kernel+370/372] start_kernel+0x172/0x174
Dec  8 12:19:37 server kernel: Mem-info:
Dec  8 12:19:37 server kernel: DMA per-cpu:
Dec  8 12:19:37 server kernel: cpu 0 hot: high 90, batch 15 used:14
Dec  8 12:19:37 server kernel: cpu 0 cold: high 30, batch 7 used:25
Dec  8 12:19:37 server kernel: cpu 1 hot: high 90, batch 15 used:57
Dec  8 12:19:37 server kernel: cpu 1 cold: high 30, batch 7 used:1
Dec  8 12:19:37 server kernel: DMA32 per-cpu: empty
Dec  8 12:19:37 server kernel: Normal per-cpu: empty
Dec  8 12:19:37 server kernel: HighMem per-cpu: empty
Dec  8 12:19:37 server kernel: Free pages:         776kB (0kB HighMem)
Dec  8 12:19:37 server kernel: Active:12209 inactive:16785 dirty:73 writeback:1 unstable:0 free:194 slab:16986 mapped:5214 pagetables:115
Dec  8 12:19:37 server kernel: DMA free:776kB min:2076kB low:2592kB high:3112kB active:48836kB inactive:67140kB present:270336kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:37 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:37 server kernel: DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:37 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:37 server kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:37 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:37 server kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Dec  8 12:19:37 server kernel: lowmem_reserve[]: 0 0 0 0
Dec  8 12:19:37 server kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 776kB
Dec  8 12:19:37 server kernel: DMA32: empty
Dec  8 12:19:37 server kernel: Normal: empty
Dec  8 12:19:38 server kernel: HighMem: empty
Dec  8 12:19:38 server kernel: Swap cache: add 635, delete 635, find 0/0, race 0+0
Dec  8 12:19:38 server kernel: Free swap  = 3901244kB
Dec  8 12:19:38 server kernel: Total swap = 3903784kB
Dec  8 12:19:38 server kernel: Free swap:       3901244kB
Dec  8 12:19:38 server kernel: 67584 pages of RAM
Dec  8 12:19:38 server kernel: 0 pages of HIGHMEM
Dec  8 12:19:38 server kernel: 18345 reserved pages
Dec  8 12:19:38 server kernel: 25652 pages shared
Dec  8 12:19:38 server kernel: 0 pages swap cached
Dec  8 12:19:38 server kernel: 73 pages dirty
Dec  8 12:19:38 server kernel: 1 pages writeback
Dec  8 12:19:38 server kernel: 5214 pages mapped
Dec  8 12:19:38 server kernel: 16986 pages slab
Dec  8 12:19:38 server kernel: 115 pages pagetables

