Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263453AbVCEAg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbVCEAg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263433AbVCEAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:05:55 -0500
Received: from mailfe09.swip.net ([212.247.155.1]:12520 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263258AbVCDWQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:16:52 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: 2.6.11-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050304033215.1ffa8fec.akpm@osdl.org>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 23:16:33 +0100
Message-Id: <1109974593.9696.11.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-03-04 klockan 03:32 -0800 skrev Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/
> 
> 
> - Added the new bk-audit tree.  Contains updates to the kernel's audit
>   feature.  Maintained by David Woodhouse.
> 
> - The Dell keyboard problems should be fixed.  Testing needed.
> 
> - Dmitry's bk-dtor-input tree is no longer active and has been dropped.

Just booted up a box and tried to log onto ssh which didn't worked so I
looked at kernel log and behold, 128MB box with no swap, had just
booted. Couldn't get any access after this.
A few kernel debugging options were chosen notably CONFIG_DEBUG_SLAB &
CONFIG_DEBUG_PAGEALLOC

This is just as a note, I have no idea what happened. 


swapper: page allocation failure. order:0, mode:0x20
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c03468a4>] refill_skbs+0x24/0x50
[<c0346989>] find_skb+0x79/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c03468a4>] refill_skbs+0x24/0x50
[<c0346989>] find_skb+0x79/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c034693a>] find_skb+0x2a/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139f68>] __kmalloc+0x98/0xb0
[<c0338659>] alloc_skb+0x39/0xd0
[<c03468a4>] refill_skbs+0x24/0x50
[<c0346989>] find_skb+0x79/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0135a39>] __alloc_pages+0x259/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c034109d>] dst_alloc+0x2d/0x90
[<c034cf0a>] ip_route_input_slow+0x23a/0x710
[<c034f2f9>] ip_rcv+0x319/0x3e0
[<c033debb>] netif_receive_skb+0x12b/0x190
[<c033df9e>] process_backlog+0x7e/0x100
[<c033e085>] net_rx_action+0x65/0xe0
[<c011d8ba>] __do_softirq+0x7a/0x90
[<c0104fc4>] do_softirq+0x44/0x60
=======================
[<c0104ea1>] do_IRQ+0x61/0xa0
[<c0103726>] common_interrupt+0x1a/0x20
[<c01010f0>] cpu_idle+0x50/0x60
[<c045e79a>] start_kernel+0x12a/0x150
[<c010019f>] 0xc010019f
printk: 547 messages suppressed.
swapper: page allocation failure. order:0, mode:0x20
[<c0103b77>] dump_stack+0x17/0x20
[<c0135a3e>] __alloc_pages+0x25e/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c033863b>] alloc_skb+0x1b/0xd0
[<c03468a4>] refill_skbs+0x24/0x50
[<c0346989>] find_skb+0x79/0x80
[<c0346a3b>] netpoll_send_udp+0x2b/0x230
[<c03061ba>] write_msg+0x3a/0x50
[<c0119532>] __call_console_drivers+0x52/0x60
[<c011962f>] call_console_drivers+0x7f/0x100
[<c0119986>] release_console_sem+0x36/0xa0
[<c0119886>] vprintk+0xe6/0x120
[<c0119798>] printk+0x18/0x20
[<c0119dee>] __printk_ratelimit+0x7e/0x90
[<c0135a0f>] __alloc_pages+0x22f/0x3a0
[<c013806f>] kmem_getpages+0x2f/0x90
[<c01393e0>] cache_grow+0x90/0x110
[<c013999d>] cache_alloc_refill+0x17d/0x250
[<c0139e76>] kmem_cache_alloc+0x66/0x70
[<c033863b>] alloc_skb+0x1b/0xd0
[<c03008a6>] tulip_refill_rx+0xa6/0xf0
[<c0301631>] tulip_interrupt+0x961/0x970
[<c013065a>] handle_IRQ_event+0x2a/0x60
[<c0130734>] __do_IRQ+0xa4/0xf0
[<c0104e9a>] do_IRQ+0x5a/0xa0
=======================


