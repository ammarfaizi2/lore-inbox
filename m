Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWGCVbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWGCVbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGCVbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:31:13 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:54858 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWGCVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:31:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nGB5rgebbk0PRo7pvX+IbJC/4cgdAW0XMNnmK2+C+w/QyJtj6HcSQ94MlTVTIXsJYS8JSynLadyJXtJ7u2lElVSyrqS2dy7KeD3MwjzlFpKUWHTAakQTrz/gViuAUYmsZ5OFCFcUjR8bAVYKiKi6PYQ/LClX8FeFPYWcaKAaQEg=
Message-ID: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
Date: Mon, 3 Jul 2006 14:31:12 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
Subject: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC1[2]:HE0:SE0] takes:
 (&ei_local->page_lock){++..}, at: [<f935079f>] ei_interrupt+0x49/0x294 [8390]
{hardirq-on-W} state was registered at:
  [<c102d152>] lock_acquire+0x60/0x80
  [<c1200376>] _spin_lock+0x23/0x32
  [<f9350d30>] ei_start_xmit+0xa6/0x236 [8390]
  [<c11a2715>] dev_hard_start_xmit+0x1c4/0x221
  [<c11af1b5>] __qdisc_run+0xcc/0x185
  [<c11a411e>] dev_queue_xmit+0x140/0x22e
  [<f93a89f1>] mld_sendpack+0x1a0/0x26a [ipv6]
  [<f93a95cb>] mld_ifc_timer_expire+0x1d6/0x1fd [ipv6]
  [<c101dab2>] run_timer_softirq+0xf2/0x14a
  [<c101a691>] __do_softirq+0x55/0xb0
  [<c1004a8d>] do_softirq+0x58/0xbd
irq event stamp: 952615
hardirqs last  enabled at (952614): [<c1200800>]
_spin_unlock_irqrestore+0x36/0x59
hardirqs last disabled at (952615): [<c1002fcf>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (952574): [<c101a6e7>] __do_softirq+0xab/0xb0
softirqs last disabled at (952579): [<c1004a8d>] do_softirq+0x58/0xbd

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (&dev->_xmit_lock){-...}, at: [<c11af146>] __qdisc_run+0x5d/0x185

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102b7c7>] print_usage_bug+0x1cc/0x1d9
 [<c102bbbf>] mark_lock+0x8a/0x360
 [<c102c8ac>] __lock_acquire+0x38f/0x970
 [<c102d152>] lock_acquire+0x60/0x80
 [<c1200376>] _spin_lock+0x23/0x32
 [<f935079f>] ei_interrupt+0x49/0x294 [8390]
 [<f94983fa>] ei_irq_wrapper+0xb/0x1d [pcnet_cs]
 [<c103f133>] handle_IRQ_event+0x20/0x50
 [<c104026d>] handle_level_irq+0x76/0xc1
 [<c1004bc2>] do_IRQ+0xd0/0xf6
 [<c1002fd9>] common_interrupt+0x25/0x2c
