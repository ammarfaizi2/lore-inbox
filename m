Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWDRQOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWDRQOj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWDRQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:14:39 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:38999 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751089AbWDRQOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:14:38 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0604181058430.12720@gandalf.stny.rr.com>
References: <1145324887.17085.35.camel@localhost.localdomain>
	 <1145362851.5447.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604180831390.9005@gandalf.stny.rr.com>
	 <1145365886.5447.28.camel@localhost.localdomain>
	 <1145368228.17085.85.camel@localhost.localdomain>
	 <1145369381.5447.40.camel@localhost.localdomain>
	 <1145370733.17085.110.camel@localhost.localdomain>
	 <1145371913.5447.48.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604181058430.12720@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 09:14:36 -0700
Message-Id: <1145376876.5447.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 11:06 -0400, Steven Rostedt wrote:
> On Tue, 18 Apr 2006, Daniel Walker wrote:
> 
> > On Tue, 2006-04-18 at 10:32 -0400, Steven Rostedt wrote:
> >
> > >
> > > Actually, where that BUG_ON was is the exiting of the chain walk. So it
> > > does stop.  It's the higher priority task that needs to be continuing
> > > the chain walk for that problem to occur.  So really, it already does
> > > what you suggest :)
> >
> > I bet you could test for that condition in some other spots too . Like
> > when it adds to the pi_waiters , you could test if the priorities are
> > out of sync ..
> 
> You mean the other places in rt_mutex_adjust_prio_chain?  It already
> checks once an iteration, anything more is just over kill.

Yeah, sounds good .

> Actually, I always thought that running PREEMPT_DESKTOP with soft and hard
> IRQS as threads was priority ceiling.  It's just that all locks have the
> priority of MAX_RT_PRIO (no preemption allowed).  OK, this doesn't apply
> to mutexes, but it does apply for spin_locks. :)

Interesting way to look at it .

Reminds me of the RT read/write locks, only one read or one writer at a
time, so it's really just a mutex ..

Daniel 

