Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVASFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVASFpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVASFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:45:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:39650 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261593AbVASFpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:45:40 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119052118.GA19591@atomide.com>
References: <20050119000556.GB14749@atomide.com>
	 <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com>
	 <20050119052118.GA19591@atomide.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 16:44:26 +1100
Message-Id: <1106113466.4533.178.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 21:21 -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [050118 21:08]:
> > * Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 20:22]:
> > >
> > > BTW. Is it possible, when entering the "idle" loop, to quickly know an
> > > estimate of when the next tick shoud actually kick in ?
> > 
> > Yes, see next_timer_interrupt() for that.
> 
> Hmmm, or maybe you mean _quick_estimate_ instead of 
> next_timer_interrupt()?
> 
> I don't think there's any faster way to estimate the skippable ticks
> without going through the list like next_timer_interrupt already does.
> Does anybody have any ideas for that?

No, that's fine, we already have to call it before entering the PM
state, so I'll just pass it along and, at the low level, decide how
deep to sleep based on that.

I think I should also add some stats on the amount of interrupts, since
it would be fairly inefficient to keep entering deep PM state on a
machine with typically little timer interrupts but high HW interrupt
(Rusty mentions case of packet forwarding routers or that kind of thing)

Ben.


