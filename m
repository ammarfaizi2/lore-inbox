Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWATSiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWATSiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWATSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:38:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:16005 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751140AbWATSiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:38:19 -0500
Subject: Re: BUG in check_monotonic_clock()
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1137779515.3202.3.camel@localhost.localdomain>
References: <1137779515.3202.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:38:16 -0800
Message-Id: <1137782296.27699.253.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 09:51 -0800, Daniel Walker wrote:
> 
> This is off a dual P3 during boot with 2.6.15-rt6. I'll send the .config
> privately . I had a fair amount of debugging on.
> 
> 
> check_monotonic_clock: monotonic inconsistency detected!
>         from        1a27e7384 (7021163396) to        19f92d748 (6972168008).
> udev/238[CPU#1]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
>  [<c0105b03>] dump_stack+0x23/0x30 (20)
>  [<c0129e43>] __WARN_ON+0x63/0x80 (40)
>  [<c0148584>] check_monotonic_clock+0xd4/0xe0 (52)
>  [<c01489b8>] get_monotonic_clock+0xc8/0x100 (56)
>  [<c014475d>] __hrtimer_start+0xdd/0x100 (40)
>  [<c0400046>] schedule_hrtimer+0x46/0xd0 (48)
>  [<c0144f0f>] hrtimer_nanosleep+0x5f/0x130 (104)
>  [<c0145053>] sys_nanosleep+0x73/0x80 (36)
>  [<c0104b2a>] syscall_call+0x7/0xb (-4020)
> ---------------------------
> | preempt count: 00000002 ]
> | 2-level deep critical section nesting:
> ----------------------------------------
> .. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
> .....[<c0143e2a>] ..   ( <= lock_hrtimer_base+0x2a/0x60)
> .. [<c014cf1c>] .... add_preempt_count+0x1c/0x20
> .....[<c0129df6>] ..   ( <= __WARN_ON+0x16/0x80)

Hey Daniel,
	Thanks for the bug report. Could you tell me what clocksource was being
used at the time? I'm guessing its the TSC, but usually we'll see
separate TSC inconsistency messages in the log.

thanks
-john


