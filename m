Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWATRv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWATRv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWATRv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:51:57 -0500
Received: from [63.81.120.158] ([63.81.120.158]:48879 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1750951AbWATRv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:51:57 -0500
Subject: BUG in check_monotonic_clock()
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain
Date: Fri, 20 Jan 2006 09:51:54 -0800
Message-Id: <1137779515.3202.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is off a dual P3 during boot with 2.6.15-rt6. I'll send the .config
privately . I had a fair amount of debugging on.


check_monotonic_clock: monotonic inconsistency detected!
        from        1a27e7384 (7021163396) to        19f92d748 (6972168008).
udev/238[CPU#1]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
 [<c0105b03>] dump_stack+0x23/0x30 (20)
 [<c0129e43>] __WARN_ON+0x63/0x80 (40)
 [<c0148584>] check_monotonic_clock+0xd4/0xe0 (52)
 [<c01489b8>] get_monotonic_clock+0xc8/0x100 (56)
 [<c014475d>] __hrtimer_start+0xdd/0x100 (40)
 [<c0400046>] schedule_hrtimer+0x46/0xd0 (48)
 [<c0144f0f>] hrtimer_nanosleep+0x5f/0x130 (104)
 [<c0145053>] sys_nanosleep+0x73/0x80 (36)
 [<c0104b2a>] syscall_call+0x7/0xb (-4020)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
.....[<c0143e2a>] ..   ( <= lock_hrtimer_base+0x2a/0x60)
.. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
.....[<c0129df6>] ..   ( <= __WARN_ON+0x16/0x80)


