Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVJTKFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVJTKFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 06:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVJTKFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 06:05:15 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:64763 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751032AbVJTKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 06:05:14 -0400
Date: Thu, 20 Oct 2005 06:05:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu>
 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu>
 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu>
 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Steven Rostedt wrote:

>
> On Thu, 20 Oct 2005, Ingo Molnar wrote:
>
> >
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > static inline nsec_t __get_nsec_offset(void)
> > > {
> > > 	cycle_t cycle_now, cycle_delta;
> > > 	nsec_t ns_offset;
> > >
> > > 	/* read clocksource */
> > > 	cycle_now = read_clocksource(clock);
> > >
> > > 	/* calculate the delta since the last timeofday_periodic_hook */
> > > 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
> > >
> > > 	/* convert to nanoseconds */
> > > 	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
> > >
> > > 	/* Special case for jiffies tick/offset based systems
> > > 	 * add arch specific offset
> > > 	 */
> > > 	ns_offset += arch_getoffset();
> > >
> > > 	return ns_offset;
> > > }
> > >
> > > cycle_now is 32 bits.  If the clocksource overflows (which it can in
> > > 30 seconds) the cyclec_delta will be wrong.
> >
> > isnt cycle_t 64 bits?
> >
>
> Not anymore.
>
> include/linux/time.h:
>
> /* timeofday base types */
> typedef s64 nsec_t;
> typedef unsigned long cycle_t;
>

FYI,

I just switched cycle_t to u64 and hackbench no longer makes the time go
backwards.

John, would this cause any problems to keep cycle_t at s64?

-- Steve
