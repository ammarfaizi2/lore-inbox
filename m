Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWFGVyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWFGVyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWFGVyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:54:32 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30434 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932432AbWFGVyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:54:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc6-mm1
Date: Wed, 7 Jun 2006 23:54:41 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060607104724.c5d3d730.akpm@osdl.org>
In-Reply-To: <20060607104724.c5d3d730.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606072354.41443.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 19:47, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
> 
> - Many more lockdep updates

Well, I've got this one (Asus L5D, x86_64 kernel):

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
hwinfo/3398 [HC0[0]:SC0[1]:HE1:SE0] takes:
 (&list->lock){++..}, at: [<ffffffff8046d301>] unix_stream_connect+0x371/0x440
{in-hardirq-W} state was registered at:
  [<ffffffff8024bdaa>] lock_acquire+0x8a/0xc0
  [<ffffffff8047347f>] _spin_lock_irqsave+0x3f/0x60
  [<ffffffff80406e72>] skb_dequeue+0x22/0x70
  [<ffffffff881c97b1>] hpsb_bus_reset+0x61/0xb0 [ieee1394]
  [<ffffffff8822e986>] ohci_irq_handler+0x416/0x830 [ohci1394]
  [<ffffffff8026208b>] handle_IRQ_event+0x2b/0x70
  [<ffffffff80263a03>] handle_level_irq+0xb3/0x120
  [<ffffffff8020c6ec>] do_IRQ+0x5c/0x80
  [<ffffffff80209d60>] common_interrupt+0x64/0x65
irq event stamp: 29916
hardirqs last  enabled at (29915): [<ffffffff802893f5>] kmem_cache_free+0xb5/0xd0
hardirqs last disabled at (29914): [<ffffffff802893d0>] kmem_cache_free+0x90/0xd0
softirqs last  enabled at (29912): [<ffffffff802342fe>] __do_softirq+0xbe/0xd0
softirqs last disabled at (29916): [<ffffffff80472ac1>] _spin_lock_bh+0x11/0x50

other info that might help us debug this:
1 lock held by hwinfo/3398:
 #0:  (&u->lock){--..}, at: [<ffffffff8046d093>] unix_stream_connect+0x103/0x440

stack backtrace:

Call Trace:
 [<ffffffff8020abd6>] show_trace+0xa6/0x220
 [<ffffffff8020af85>] dump_stack+0x15/0x20
 [<ffffffff8024a64c>] print_usage_bug+0x23c/0x250
 [<ffffffff8024a94f>] mark_lock+0x2ef/0x6a0
 [<ffffffff8024b1e6>] __lock_acquire+0x4e6/0xc80
 [<ffffffff8024bdab>] lock_acquire+0x8b/0xc0
 [<ffffffff80472ae4>] _spin_lock_bh+0x34/0x50
 [<ffffffff8046d301>] unix_stream_connect+0x371/0x440
 [<ffffffff80402077>] sys_connect+0x87/0xc0
 [<ffffffff8020982a>] system_call+0x7e/0x83
 [<00002ab066fc6472>]


Greetings,
Rafael
