Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUDGGXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDGGXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:23:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:51109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264102AbUDGGXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:23:06 -0400
Date: Tue, 6 Apr 2004 23:22:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jaco Kroon <jkroon@cs.up.ac.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in  __alloc_pages on x86
Message-Id: <20040406232215.62d88593.akpm@osdl.org>
In-Reply-To: <40739A96.6010604@cs.up.ac.za>
References: <4072E822.9040304@kroon.co.za>
	<40739A96.6010604@cs.up.ac.za>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco Kroon <jkroon@cs.up.ac.za> wrote:
>
> And on 2.6.5:
> 
> ifconfig: page allocation failure. order:0, mode:0x20
> Call Trace:
> [<c013df67>] __alloc_pages+0x2d7/0x390
> [<c013e042>] __get_free_pages+0x22/0x60
> [<c014216f>] cache_grow+0x11f/0x470
> [<c014262f>] cache_alloc_refill+0x16f/0x4e0
> [<c014306f>] kmem_cache_alloc+0x19f/0x1c0
> [<c0260dfc>] alloc_skb+0x1c/0xe0
> [<c023cb41>] tulip_init_ring+0xa1/0x160
> [<c023c6f6>] tulip_open+0x36/0x50
> [<c0265437>] dev_open+0xb7/0xf0
> [<c0266cf8>] dev_change_flags+0x58/0x140
> [<c02a4b27>] devinet_ioctl+0x2b7/0x6a0
> [<c02a6cf0>] inet_ioctl+0xb0/0xf0
> [<c025d93c>] sock_ioctl+0xac/0x260
> [<c0174a1d>] sys_ioctl+0x8d/0x220
> [<c0107a77>] syscall_call+0x7/0xb
> 
> When configuring the network card upon boot.

I don't know why you'd fail an allocation on boot.  How much memory does
that machine have?

> Jaco Kroon wrote:
> 
> > Hello all
> >
> > I'm getting lot's of these today:
> >
> > kswapd0: page allocation failure. order:0, mode:0x20
> > Call Trace:
> > [<c0140447>] __alloc_pages+0x2d7/0x390
> > [<c0140522>] __get_free_pages+0x22/0x60
> > [<c014464f>] cache_grow+0x11f/0x470
> > [<c0144b0f>] cache_alloc_refill+0x16f/0x4e0
> > [<c014554f>] kmem_cache_alloc+0x19f/0x1c0
> > [<c0262eec>] alloc_skb+0x1c/0xe0
> > [<c023b731>] tulip_refill_rx+0x91/0x100
> > [<c023c45c>] tulip_interrupt+0x8cc/0x8e0
> > [<c0127153>] do_timer+0xf3/0x100
> > [<c010b433>] handle_IRQ_event+0x33/0x60
> > [<c010b92d>] do_IRQ+0x10d/0x2f0
> > [<c0109cc8>] common_interrupt+0x18/0x20
> > [<c013fe7d>] free_hot_cold_page+0x1d/0xf0
> > [<c01405fc>] __pagevec_free+0x1c/0x30
> > [<c0147f67>] __pagevec_release_nonlru+0x67/0x90
> > [<c013b9bd>] unlock_page+0xd/0x50
> > [<c01494ac>] shrink_list+0x61c/0x890
> > [<c0154ccd>] __pte_chain_free+0x3d/0x50
> > [<c01498f2>] shrink_cache+0x1d2/0x530
> > [<c014a5cf>] shrink_zone+0x6f/0xa0
> > [<c014a979>] balance_pgdat+0x159/0x1f0
> > [<c014aaee>] kswapd+0xde/0xf0
> > [<c011a2c0>] autoremove_wake_function+0x0/0x40
> > [<c011a2c0>] autoremove_wake_function+0x0/0x40
> > [<c014aa10>] kswapd+0x0/0xf0
> > [<c01070f5>] kernel_thread_helper+0x5/0x10

You should increase /proc/sys/vm/min_free_kbytes.

There's not a lot more we can do about this really, unless the driver is
actually buggy.  Perhaps the default min_free_kbytes could be increased for
however much memory you have.

