Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVJTRGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVJTRGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVJTRGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:06:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:61397 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932492AbVJTRGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:06:02 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510201253430.30996@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
	 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
	 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
	 <20051020073416.GA28581@elte.hu>
	 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
	 <20051020080107.GA31342@elte.hu>
	 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
	 <20051020085955.GB2903@elte.hu>
	 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
	 <1129826750.27168.163.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0510201253430.30996@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 10:05:53 -0700
Message-Id: <1129827953.27168.170.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 12:58 -0400, Steven Rostedt wrote:
> On Thu, 20 Oct 2005, john stultz wrote:
> 
> > > >
> > > > John, would this cause any problems to keep cycle_t at s64?
> > >
> > > I mean at u64.
> >
> > Performance would be the only concern. It had been a u64 before I
> > started optimizing the code a bit.
> >
> > The real problem however was the timeofday_perioidic_hook() was being
> > starved. Since not all clocksources are 64 bits wide (although most do
> > not overflow as fast as 32bits of the TSC) I'm not sure that will always
> > solve the issue.
> >
> > Ingo: Should the periodic_hook() call be converted to using the ktimer
> > or some other interface to ensure that it will be regularly run at some
> > frequency (currently 50ms, but that can be changed)?
> >
> 
> Thomas showed me a trick with the ktimers API, that I use to schedule my
> custom scheduler.  If you set periodic_hook to be called via ktimer with a
> prio of -1, it will force the timer to be run in the timer interrupt
> instead of a softirq task.
> 
> Now the issue is the latency this would cause and to make sure that
> periodic_hook only grabs raw locks. Ingo?


Ok, do let me know if its a problem spot. I've not been too thoughtful
in minimizing how long the lock is held for. I'll see if that cannot be
minimized.

Thanks for the thorough testing and feedback!
-john

