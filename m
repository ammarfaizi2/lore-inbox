Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVASG0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVASG0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVASG0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:26:38 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:30359 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261560AbVASG0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:26:36 -0500
Date: Tue, 18 Jan 2005 22:26:07 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119062606.GA26932@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <20050119052118.GA19591@atomide.com> <1106113466.4533.178.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106113466.4533.178.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 21:45]:
> On Tue, 2005-01-18 at 21:21 -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [050118 21:08]:
> > > * Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 20:22]:
> > > >
> > > > BTW. Is it possible, when entering the "idle" loop, to quickly know an
> > > > estimate of when the next tick shoud actually kick in ?
> > > 
> > > Yes, see next_timer_interrupt() for that.
> > 
> > Hmmm, or maybe you mean _quick_estimate_ instead of 
> > next_timer_interrupt()?
> > 
> > I don't think there's any faster way to estimate the skippable ticks
> > without going through the list like next_timer_interrupt already does.
> > Does anybody have any ideas for that?
> 
> No, that's fine, we already have to call it before entering the PM
> state, so I'll just pass it along and, at the low level, decide how
> deep to sleep based on that.
> 
> I think I should also add some stats on the amount of interrupts, since
> it would be fairly inefficient to keep entering deep PM state on a
> machine with typically little timer interrupts but high HW interrupt
> (Rusty mentions case of packet forwarding routers or that kind of thing)

Maybe some HW timer interrupt mask could be used? Also it would be
nice to check for file IO.

Tony
