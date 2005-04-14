Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVDNVti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVDNVti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 17:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDNVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 17:49:37 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:29830 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261387AbVDNVsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 17:48:38 -0400
Date: Thu, 14 Apr 2005 23:48:28 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: E1000 - page allocation failure - saga continues :(
Message-ID: <20050414214828.GB9591@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today I tried 2.6.11.7 kernel with hoping that allocation failures disappear.
Unfortunately they did not.

Default min_free_kb is 3200kB.

Here is stack trace:

swapper: page allocation failure. order:0, mode:0x20
 [<c0139783>] __alloc_pages+0x2b3/0x420
 [<c013c4f1>] kmem_getpages+0x31/0xa0
 [<c013d22e>] cache_grow+0xae/0x160
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c013d45b>] cache_alloc_refill+0x17b/0x230
 [<c013d7d8>] __kmalloc+0x88/0xa0
 [<c0327ce7>] alloc_skb+0x47/0xf0
 [<c02bff97>] e1000_alloc_rx_buffers+0x57/0x100
 [<c02bfc3f>] e1000_clean_rx_irq+0x1bf/0x4c0
 [<c02bf99e>] e1000_clean_tx_irq+0x14e/0x230
 [<c02bf79d>] e1000_clean+0x4d/0x100
 [<c032e6e1>] net_rx_action+0x81/0x110
 [<c011d5aa>] __do_softirq+0xba/0xd0
 [<c011d5ed>] do_softirq+0x2d/0x30
 [<c011d6b9>] irq_exit+0x39/0x40
 [<c01030dc>] apic_timer_interrupt+0x1c/0x24
 [<c0100513>] default_idle+0x23/0x30
 [<c01005bf>] cpu_idle+0x5f/0x70
 [<c04dc988>] start_kernel+0x158/0x180
 [<c04dc390>] unknown_bootoption+0x0/0x1e0
swapper: page allocation failure. order:0, mode:0x20
 [<c0139783>] __alloc_pages+0x2b3/0x420
 [<c013c4f1>] kmem_getpages+0x31/0xa0
 [<c013d22e>] cache_grow+0xae/0x160
 [<c02b80d8>] as_next_request+0x38/0x50
 [<c013d45b>] cache_alloc_refill+0x17b/0x230
 [<c02df727>] scsi_put_command+0x77/0xb0
 [<c013d7d8>] __kmalloc+0x88/0xa0
 [<c0327ce7>] alloc_skb+0x47/0xf0
 [<c02bff97>] e1000_alloc_rx_buffers+0x57/0x100
 [<c02bfc3f>] e1000_clean_rx_irq+0x1bf/0x4c0
 [<c02bf99e>] e1000_clean_tx_irq+0x14e/0x230
 [<c02bf79d>] e1000_clean+0x4d/0x100
 [<c032e6e1>] net_rx_action+0x81/0x110
 [<c011d5aa>] __do_softirq+0xba/0xd0
 [<c011d5ed>] do_softirq+0x2d/0x30
 [<c011d6b9>] irq_exit+0x39/0x40
 [<c01030dc>] apic_timer_interrupt+0x1c/0x24
 [<c0100513>] default_idle+0x23/0x30
 [<c01005bf>] cpu_idle+0x5f/0x70
 [<c04dc988>] start_kernel+0x158/0x180
 [<c04dc390>] unknown_bootoption+0x0/0x1e0
swapper: page allocation failure. order:1, mode:0x20
 [<c0139783>] __alloc_pages+0x2b3/0x420
 [<c013c4f1>] kmem_getpages+0x31/0xa0
 [<c013d077>] alloc_slabmgmt+0x57/0x70
 [<c013d22e>] cache_grow+0xae/0x160
 [<c013d45b>] cache_alloc_refill+0x17b/0x230
 [<c013d7d8>] __kmalloc+0x88/0xa0
 [<c0327ce7>] alloc_skb+0x47/0xf0
 [<c0354541>] tcp_collapse+0xf1/0x390
 [<c0354904>] tcp_prune_queue+0x94/0x1e0
 [<c0353cd4>] tcp_data_queue+0x3e4/0xb60
 [<c0352b73>] tcp_ack+0x4b3/0x590
 [<c03552df>] tcp_rcv_established+0x22f/0x8d0
 [<c010cbf9>] mark_offset_tsc+0x1d9/0x2d0
 [<c035e46b>] tcp_v4_do_rcv+0x12b/0x130
 [<c035eb61>] tcp_v4_rcv+0x6f1/0x950
 [<c03848f5>] ip_nat_fn+0x75/0x1d0
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c03429ff>] ip_local_deliver_finish+0xcf/0x220
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c03392a1>] nf_hook_slow+0xf1/0x130
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c0342410>] ip_local_deliver+0x280/0x2b0
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342d49>] ip_rcv_finish+0x1f9/0x280
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c03392a1>] nf_hook_slow+0xf1/0x130
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c034284e>] ip_rcv+0x40e/0x4f0
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c032e4b8>] netif_receive_skb+0x148/0x1d0
 [<c02bfbdc>] e1000_clean_rx_irq+0x15c/0x4c0
 [<c02bf99e>] e1000_clean_tx_irq+0x14e/0x230
 [<c02bf79d>] e1000_clean+0x4d/0x100
 [<c032e6e1>] net_rx_action+0x81/0x110
 [<c011d5aa>] __do_softirq+0xba/0xd0
 [<c011d5ed>] do_softirq+0x2d/0x30
 [<c011d6b9>] irq_exit+0x39/0x40
 [<c0104b0e>] do_IRQ+0x1e/0x30
 [<c010304e>] common_interrupt+0x1a/0x20
 [<c0100513>] default_idle+0x23/0x30
 [<c01005bf>] cpu_idle+0x5f/0x70
 [<c04dc988>] start_kernel+0x158/0x180
 [<c04dc390>] unknown_bootoption+0x0/0x1e0
swapper: page allocation failure. order:1, mode:0x20
 [<c0139783>] __alloc_pages+0x2b3/0x420
 [<c013c4f1>] kmem_getpages+0x31/0xa0
 [<c013d077>] alloc_slabmgmt+0x57/0x70
 [<c013d22e>] cache_grow+0xae/0x160
 [<c013d45b>] cache_alloc_refill+0x17b/0x230
 [<c013d7d8>] __kmalloc+0x88/0xa0
 [<c0327ce7>] alloc_skb+0x47/0xf0
 [<c0354541>] tcp_collapse+0xf1/0x390
 [<c0354904>] tcp_prune_queue+0x94/0x1e0
 [<c0353cd4>] tcp_data_queue+0x3e4/0xb60
 [<c0352b73>] tcp_ack+0x4b3/0x590
 [<c03552df>] tcp_rcv_established+0x22f/0x8d0
 [<c035e46b>] tcp_v4_do_rcv+0x12b/0x130
 [<c035eb61>] tcp_v4_rcv+0x6f1/0x950
 [<c03848f5>] ip_nat_fn+0x75/0x1d0
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c03429ff>] ip_local_deliver_finish+0xcf/0x220
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c03392a1>] nf_hook_slow+0xf1/0x130
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c0342410>] ip_local_deliver+0x280/0x2b0
 [<c0342930>] ip_local_deliver_finish+0x0/0x220
 [<c0342d49>] ip_rcv_finish+0x1f9/0x280
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c03392a1>] nf_hook_slow+0xf1/0x130
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c034284e>] ip_rcv+0x40e/0x4f0
 [<c0342b50>] ip_rcv_finish+0x0/0x280
 [<c032e4b8>] netif_receive_skb+0x148/0x1d0
 [<c02bfbdc>] e1000_clean_rx_irq+0x15c/0x4c0
 [<c02bf99e>] e1000_clean_tx_irq+0x14e/0x230
 [<c02bf79d>] e1000_clean+0x4d/0x100
 [<c032e6e1>] net_rx_action+0x81/0x110
 [<c011d5aa>] __do_softirq+0xba/0xd0
 [<c011d5ed>] do_softirq+0x2d/0x30
 [<c011d6b9>] irq_exit+0x39/0x40
 [<c0104b0e>] do_IRQ+0x1e/0x30
 [<c010304e>] common_interrupt+0x1a/0x20
 [<c0100513>] default_idle+0x23/0x30
 [<c01005bf>] cpu_idle+0x5f/0x70
 [<c04dc988>] start_kernel+0x158/0x180
 [<c04dc390>] unknown_bootoption+0x0/0x1e0


-- 
Luká¹ Hejtmánek
