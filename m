Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751291AbWFESzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWFESzF (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWFESzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:55:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751291AbWFESzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:55:03 -0400
Date: Mon, 5 Jun 2006 11:54:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: mel@csn.ul.ie (Mel Gorman)
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605115456.c2b1e156.akpm@osdl.org>
In-Reply-To: <20060605175637.GA16186@skynet.ie>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605175637.GA16186@skynet.ie>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 18:56:37 +0100
mel@csn.ul.ie (Mel Gorman) wrote:

> 
> I am seeing more networking-related funniness with 2.6.17-rc5-mm3 on the
> same machine previously fixed by git-net-llc-fix.patch. The console log is
> below. I've done no investigation work in case it's a known problem.

It's not a known problem, afaik.

> ...
> Starting anacron: [  OK  ]
> Starting atd: [  OK  ]
> Starting Avahi daemon: [  OK  ]
> Starting cups-config-daemon: [  OK  ]
> Starting HAL daemon: [  OK  ]
> Fedora Core release 5 (Bordeaux)
> Kernel 2.6.17-rc5-mm2-autokern1 on an x86_64
> bl6-13.ltc.austin.ibm.com login: -- 0:conmux-control -- time-stamp -- Jun/05/06 10:47:46 --
> -- 0:conmux-control -- time-stamp -- Jun/05/06 10:51:12 --
> BUG: warning at include/net/dst.h:153/dst_release()
> Call Trace:
>  <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
>  [<ffffffff81199568>] tg3_poll+0x1a1/0x94f
>  [<ffffffff8122d80c>] net_rx_action+0xac/0x160
>  [<ffffffff81037904>] __do_softirq+0x48/0xb4
>  [<ffffffff8100a496>] call_softirq+0x1e/0x28
>  [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
>  [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
>  [<ffffffff81007807>] default_idle+0x0/0x54
>  [<ffffffff810097b8>] ret_from_intr+0x0/0xb
>  <EOI>
> Attempt to release alive inet socket ffff81003f8b2780
> BUG: warning at include/net/dst.h:153/dst_release()
> Call Trace:
>  <IRQ> [<ffffffff81228274>] __kfree_skb+0x3c/0xbd
>  [<ffffffff81268fc4>] icmp_rcv+0x17c/0x184
>  [<ffffffff812484ca>] ip_local_deliver+0xfe/0x1bf
>  [<ffffffff812489bf>] ip_rcv+0x434/0x475
>  [<ffffffff8122d615>] netif_receive_skb+0x2c6/0x2e5
>  [<ffffffff81199add>] tg3_poll+0x716/0x94f
>  [<ffffffff8122d80c>] net_rx_action+0xac/0x160<7>Losing some ticks... checking if CPU frequency changed.
>  [<ffffffff81037904>] __do_softirq+0x48/0xb4
>  [<ffffffff8100a496>] call_softirq+0x1e/0x28
>  [<ffffffff8100b84e>] do_softirq+0x2c/0x7e
>  [<ffffffff8100b6c8>] do_IRQ+0x50/0x59
>  [<ffffffff81007807>] default_idle+0x0/0x54
>  [<ffffffff810097b8>] ret_from_intr+0x0/0xb

There are quite a few changes in the net tree.  I guess the first thing to
investigate would be 2.6.17-rc5+origin.patch+git-net.patch.

