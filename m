Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVBIM4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVBIM4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 07:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVBIM4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 07:56:47 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:10401 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261816AbVBIM4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 07:56:44 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: William Weston <weston@sysex.net>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
References: <20050204100347.GA13186@elte.hu>
	 <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1107953301.17568.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Feb 2005 07:48:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 16:58, William Weston wrote:
> Hi Ingo,
> 
> Great work on the -RT kernel!  Here's a status report from my Athlon box
> w/ kernel -RT-2.6.11-rc3-V0.7.38-03, realtime-lsm-0.8.5, jack-0.99.48, 
> alsa-1.0.8, and latencytest-0.5.5:
<snip>
> A couple BUGs are being logged (see below), but without any ill effect
> other than taking up space on my /var.
<snip>
> Network interface (via rhine) startup triggers these two BUGs:
> 
> BUG: sleeping function called from invalid context ksoftirqd/0(2) at 
> kernel/rt.c:1448
> in_atomic():1 [00000001], irqs_disabled():0
>  [<c0103e77>] dump_stack+0x17/0x20 (12)
>  [<c0119f89>] __might_sleep+0xd9/0xf0 (40)
>  [<c0134816>] __spin_lock+0x36/0x50 (24)
>  [<c0147914>] kmem_cache_alloc+0x34/0x120 (44)
>  [<c01d3143>] sel_netif_lookup+0x63/0x150 (28)
>  [<c01d32cd>] sel_netif_sids+0x2d/0xb0 (28)
>  [<c01d01bc>] selinux_socket_sock_rcv_skb+0xac/0x230 (144)

I'm not sure I understand, as sel_netif_lookup passes GFP_ATOMIC to
kmalloc.

>  [<c02fd248>] udp_queue_rcv_skb+0xb8/0x280 (28)
>  [<c02fd8e2>] udp_rcv+0x192/0x3e0 (100)
>  [<c02dc224>] ip_local_deliver+0x64/0x1c0 (32)
>  [<c02dc595>] ip_rcv+0x215/0x3f0 (56)
>  [<c02c201c>] netif_receive_skb+0x12c/0x160 (40)
>  [<c02c20ce>] process_backlog+0x7e/0x110 (32)
>  [<c02c21d2>] net_rx_action+0x72/0x130 (24)
>  [<c0122428>] ___do_softirq+0x48/0xd0 (40)
>  [<c012254b>] _do_softirq+0x1b/0x30 (8)
>  [<c0122920>] ksoftirqd+0xa0/0xf0 (28)
>  [<c01312fb>] kthread+0x8b/0xc0 (36)
>  [<c01012f5>] kernel_thread_helper+0x5/0x10 (537116692)
> ---------------------------
> | preempt count: 00000002 ]
> | 2-level deep critical section nesting:
> ----------------------------------------
> .. [<c013dd3f>] .... __do_IRQ+0xef/0x180
> .....[<c0105306>] ..   ( <= do_IRQ+0x56/0xa0)
> .. [<c0135240>] .... print_traces+0x10/0x40
> .....[<c0103e77>] ..   ( <= dump_stack+0x17/0x20)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

