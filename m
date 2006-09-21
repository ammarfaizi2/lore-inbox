Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWIUKl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWIUKl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIUKl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:41:59 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:53384 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750773AbWIUKl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:41:59 -0400
Subject: -rt: lockdep warning mc_list_lock
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 21 Sep 2006 03:41:56 -0700
Message-Id: <1158835316.29177.28.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this warning yesterday.

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
softirq-timer/1/17 is trying to acquire lock:
 (&in_dev->mc_list_lock){--..}, at: [<c03e919e>] ip_check_mc+0x1e/0xb0

but task is already holding lock:
 (&in_dev->mc_list_lock){--..}, at: [<c03ec4a7>] igmp_ifc_timer_expire+0x17/0x2a0

other info that might help us debug this:
2 locks held by softirq-timer/1/17:
 #0:  (&in_dev->mc_list_lock){--..}, at: [<c03ec4a7>] igmp_ifc_timer_expire+0x17/0x2a0
 #1:  (&im->lock){--..}, at: [<c03ec5ff>] igmp_ifc_timer_expire+0x16f/0x2a0

stack backtrace:
 [<c0105dcb>] show_trace+0x1b/0x20
 [<c0105df4>] dump_stack+0x24/0x30
 [<c013e4fb>] __lock_acquire+0xb1b/0xe40
 [<c013eb82>] lock_acquire+0x62/0x80
 [<c041b736>] rt_read_lock+0x36/0x80
 [<c03e919e>] ip_check_mc+0x1e/0xb0
 [<c03bc3f5>] __ip_route_output_key+0x6b5/0x880
 [<c03bc5de>] ip_route_output_flow+0x1e/0x80
 [<c03bc664>] ip_route_output_key+0x24/0x30
 [<c03eaa91>] igmpv3_newpack+0x71/0x270
 [<c03ead2d>] add_grhead+0x9d/0x100
 [<c03eb17d>] add_grec+0x30d/0x450
 [<c03ec5da>] igmp_ifc_timer_expire+0x14a/0x2a0
 [<c012ae1a>] run_timer_softirq+0x10a/0xd40
 [<c0126235>] ksoftirqd+0x125/0x200
 [<c013561d>] kthread+0xfd/0x110
 [<c0100f25>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------


