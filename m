Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVLaPuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVLaPuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVLaPuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:50:03 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18572 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751334AbVLaPuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:50:02 -0500
Subject: Re: [2.6.15-rc7-rt1] check_monotonic_clock: monotonic
	inconsistency detected!
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
References: <5.2.1.1.2.20051231152916.00bd5fd0@pop.gmx.net>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:49:48 -0500
Message-Id: <1136044188.6039.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 16:00 +0100, Mike Galbraith wrote:
> Greetings,
> 
> After running just fine for most of the day, my PIII/500 coughed up 
> attached fur-ball as I tried to start my ancient (au) sound 
> server.  Subsequent repeated starting and stopping of same did not induce a 
> repeat (but then all zillion sound modules were loaded).  If any other info 
> is needed, just holler.

[inlining the attachment]

check_monotonic_clock: monotonic inconsistency detected!
	from     191c7872fef6 (27610070580982) to     191c7872dd13 (27610070572307).
softirq-hrtimer/8[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
 [<c0104063>] dump_stack+0x23/0x30 (20)
 [<c011db1a>] __WARN_ON+0x6a/0xa0 (44)
 [<c013c8d2>] check_monotonic_clock+0xe2/0x100 (52)
 [<c013cd85>] get_monotonic_clock+0xe5/0x120 (80)
 [<c0135b16>] hrtimer_forward+0x36/0xf0 (80)
 [<c0120cbb>] it_real_fn+0x6b/0x80 (28)
 [<c0136345>] run_hrtimer_softirq+0x65/0x150 (52)
 [<c0122826>] ksoftirqd+0x116/0x1c0 (60)
 [<c01325b9>] kthread+0xa9/0xf0 (52)
 [<c0101245>] kernel_thread_helper+0x5/0x10 (671293468)
------------------------------
| showing all locks held by: |  (softirq-hrtimer/8 [d7fcabb0,  98]):
------------------------------

[end inline]

This looks like it probably has nothing to do with your module.  The
monotonic clock went backwards.  Also, it will only print once per boot,
even if the event happens again.

Is your system SMP? Could you also send your config.  And John will
probably want to see your dmesg output.

-- Steve


