Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTI2V2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTI2V2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:28:23 -0400
Received: from 212.muaa.snjs.sfjca01r1.dsl.att.net ([12.98.126.212]:33806 "EHLO
	darkside.asicdesigners.com") by vger.kernel.org with ESMTP
	id S263050AbTI2V2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:28:21 -0400
Date: Mon, 29 Sep 2003 14:28:19 -0700
From: Dimitris Michailidis <dm@chelsio.com>
Message-Id: <200309292128.h8TLSJvU029056@darkside.asicdesigners.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this a few times with -test6 on a 2x Xeon system:

Badness in local_bh_enable at kernel/softirq.c:119
Call Trace:
 [<c01253d7>] local_bh_enable+0x93/0x96
 [<c032d0fb>] xprt_write_space+0xfb/0x158
 [<c02cf42a>] sock_wfree+0x48/0x4a
 [<c02cf3e2>] sock_wfree+0x0/0x4a
 [<c02d02df>] __kfree_skb+0x49/0xda
 [<c020bcc0>] __delay+0x14/0x18
 [<c02752a0>] e1000_clean_tx_irq+0x1f0/0x1f6
 [<c0273a07>] e1000_tx_flush+0x69/0xd0
 [<c0273d08>] e1000_watchdog+0xba/0x340
 [<c011be80>] scheduler_tick+0x5a6/0x5ac
 [<c0273c4e>] e1000_watchdog+0x0/0x340
 [<c0129846>] run_timer_softirq+0xe8/0x1cc
 [<c0116903>] smp_apic_timer_interrupt+0x147/0x14c
 [<c0125341>] do_softirq+0xc9/0xcc
 [<c01253ac>] local_bh_enable+0x68/0x96
 [<c02e63a2>] rt_run_flush+0xa4/0xda
 [<c031f95b>] fib_netdev_event+0x57/0x8b
 [<c012ea23>] notifier_call_chain+0x27/0x40
 [<c02d3e6b>] netdev_state_change+0x37/0x52
 [<c02de65a>] linkwatch_run_queue+0xce/0xe2
 [<c02de694>] linkwatch_event+0x26/0x2c
 [<c0131504>] worker_thread+0x212/0x314
 [<c02de66e>] linkwatch_event+0x0/0x2c
 [<c011c598>] default_wake_function+0x0/0x2e
 [<c01094b6>] ret_from_fork+0x6/0x14
 [<c011c598>] default_wake_function+0x0/0x2e
 [<c01312f2>] worker_thread+0x0/0x314
 [<c010739d>] kernel_thread_helper+0x5/0xc

It hapenned while NFS was having trouble communicating with the server.

---
Dimitris Michailidis			dm@chelsio.com
