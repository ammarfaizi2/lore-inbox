Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWFGVYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWFGVYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWFGVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:23:59 -0400
Received: from smtp.ono.com ([62.42.230.12]:24420 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932156AbWFGVX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:23:59 -0400
Date: Wed, 7 Jun 2006 23:23:45 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060607232345.3fcad56e@werewolf.auna.net>
In-Reply-To: <20060607104724.c5d3d730.akpm@osdl.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.2.2cvs1 (GTK+ 2.9.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 10:47:24 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> 
> - Many more lockdep updates
> 

One missing ;)

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
idle/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&list->lock){++..}, at: [<c02f194f>] packet_rcv+0x1b1/0x2fe
{in-hardirq-W} state was registered at:
  [<c0134b9b>] lock_acquire+0x54/0x6a
  [<c02f5447>] _spin_lock_irqsave+0x3f/0x4f
  [<c02a5249>] skb_dequeue+0x12/0x50
  [<f88349d3>] hpsb_bus_reset+0x62/0xa6 [ieee1394]
  [<f884fd96>] ohci_irq_handler+0x82f/0x995 [ohci1394]
  [<c013de72>] handle_IRQ_event+0x2e/0x63
  [<c013efb3>] handle_fasteoi_irq+0x6b/0xac
  [<c0104dd7>] do_IRQ+0x6c/0xa5
irq event stamp: 547564
hardirqs last  enabled at (547564): [<c015c4cc>] kmem_cache_alloc+0x56/0x67
hardirqs last disabled at (547563): [<c015c488>] kmem_cache_alloc+0x12/0x67
softirqs last  enabled at (547552): [<c011fdd4>] __do_softirq+0xe6/0xf7
softirqs last disabled at (547557): [<c0104cfc>] do_softirq+0x5a/0xc9

other info that might help us debug this:
no locks held by idle/0.

stack backtrace:
 [<c01034ba>] show_trace+0x12/0x14
 [<c0103b9f>] dump_stack+0x19/0x1b
 [<c0132ad0>] print_usage_bug+0x20b/0x215
 [<c01333c9>] mark_lock+0x450/0x5bd
 [<c0133e56>] __lock_acquire+0x1ca/0xbee
 [<c0134b9b>] lock_acquire+0x54/0x6a
 [<c02f56de>] _spin_lock+0x36/0x43
 [<c02f194f>] packet_rcv+0x1b1/0x2fe
 [<c02aa61d>] netif_receive_skb+0x185/0x2bc
 [<c02ac01c>] process_backlog+0x9d/0x14d
 [<c02ac1eb>] net_rx_action+0xd2/0x281
 [<c011fd72>] __do_softirq+0x84/0xf7
 [<c0104cfc>] do_softirq+0x5a/0xc9
 =======================
 [<c011fe30>] irq_exit+0x4b/0x4d
 [<c0104dde>] do_IRQ+0x73/0xa5
 [<c0102ec1>] common_interrupt+0x25/0x2c
 [<c010164e>] cpu_idle+0x63/0x80
 [<c0100598>] rest_init+0x33/0x3b
 [<c03dc7af>] start_kernel+0x339/0x3aa
 [<c0100210>] 0xc0100210

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam20 (gcc 4.1.1 20060518 (prerelease)) #1 SMP PREEMPT Wed
