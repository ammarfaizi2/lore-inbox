Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVJUR7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVJUR7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVJUR7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:59:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:58067 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965046AbVJUR7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:59:52 -0400
Subject: Re: False positive (well not really) on RT backward clock check
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129909935.15748.12.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
	 <1129902741.15748.4.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0510211142060.5770@localhost.localdomain>
	 <1129909935.15748.12.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 10:59:48 -0700
Message-Id: <1129917588.27168.215.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 17:52 +0200, Thomas Gleixner wrote:
> On Fri, 2005-10-21 at 11:46 -0400, Steven Rostedt wrote:
> > 
> > I think you're right about that.  Here it is.
> > 
> > Sorry for the late reply.  The original was from my custom kernel and I
> > wanted to get an output from Ingo's.  This is rc5-rt1.
> > 
> > -- Steve
> > 
> > isapnp: Scanning for PnP cards...
> > Time: tsc clocksource has been installed.
> > WARNING: non-monotonic time!
> > Ktimers: Switched to high resolution mode CPU 0
> > softirq-timer/1/14[CPU#1]: BUG in ktime_get at kernel/ktimers.c:101
> >  [<c0104433>] dump_stack+0x23/0x30 (20)
> >  [<c0121427>] __WARN_ON+0x67/0x80 (44)
> >  [<c013ad82>] ktime_get+0xd2/0x100 (48)
> >  [<c013c2b6>] ktimer_run_queues+0x56/0x130 (60)
> >  [<c012abbe>] run_timer_softirq+0x12e/0x450 (56)
> >  [<c01268b0>] ksoftirqd+0x120/0x1a0 (40)
> >  [<c01376eb>] kthread+0xbb/0xc0 (48)
> >  [<c01014a5>] kernel_thread_helper+0x5/0x10 (538427420)
> > ---------------------------
> > | preempt count: 00000001 ]
> > | 1-level deep critical section nesting:
> > ----------------------------------------
> > .. [<c0143edc>] .... add_preempt_count+0x1c/0x20
> > .....[<c01213db>] ..   ( <= __WARN_ON+0x1b/0x80)
> > 
> > Ktimers: Switched to high resolution mode CPU 1
> 
> This is at the moment where the clock source is switched over. I check
> what might be the reason.
> 
> John, any idea ?

This is using the B7 tod code, correct? If so, B8 corrected a problem
specifically with changing clocksources (most easily seen while changing
to the TSC based clocksource), so I would not be surprised if this is
the same bug.

thanks
-john

