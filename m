Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWALLKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWALLKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWALLKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:10:51 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36765 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964985AbWALLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:10:51 -0500
Subject: Re: [PATCH RT] fix or hrtimers (was: [ANNOUNCE] 2.6.15-rc5-hrt2 -
	hrtimers based high resolution patches)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1137034306.6197.142.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1136937547.6197.73.camel@localhost.localdomain>
	 <1137032072.6197.134.camel@localhost.localdomain>
	 <1137034306.6197.142.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 06:10:15 -0500
Message-Id: <1137064215.6197.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 21:51 -0500, Steven Rostedt wrote:
> On Wed, 2006-01-11 at 21:14 -0500, Steven Rostedt wrote:
> > Finally!  I did it.  I have an updated timer_stress test at 
> > http://www.kihontech.com/tests/rt/timer_stress.c
> > that triggers the deadlock that I have been mentioning (and hit once in
> > my kernel).  But this time I hit it in 2.6.15-rt4-sr1 and got the
> > following output:
> 
> OK, it's not like me to just show a problem, without at least having
> some type of fix for it.  Since my last fix, was turned down, and
> looking into it further, I now understand why.
> 
> The patch below now makes hrtimer_start cancel the timer and lock the
> base in one action. It also checks to see if the timer is running, and
> if it is, it doesn't do anything.  It basically, tests to see if it
> should cancel the timer.
> 
> This is now included in my rt maintenance patches at:
> 
> http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr2
> 
> But I'll include this patch here too so that you can look at what I've
> done.
> 
> My test at http://www.kihontech.com/tests/rt/timer_stress.c hasn't
> killed this kernel yet.  But I'll run it all night on both a UP machine
> with the -P (posix timers) and without -P on a SMP machine (setitimer).

FYI,

The tests ran all night without a bug!  Now I'm switching the tests
(without -P on UP and with -P on SMP).

-- Steve


