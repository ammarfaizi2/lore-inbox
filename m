Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUB0VAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUB0U4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:56:52 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:253 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263101AbUB0Uyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:54:44 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Michael Frank" <mhf@linuxmail.org>, "Matt Mackall" <mpm@selenic.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Date: Fri, 27 Feb 2004 14:53:45 -0600
X-Mailer: KMail [version 1.2]
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <20040227185555.GJ3883@waste.org> <opr31mmcvk4evsfm@smtp.pacific.net.th>
In-Reply-To: <opr31mmcvk4evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Message-Id: <04022714534500.12104@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 13:19, Michael Frank wrote:
> On Fri, 27 Feb 2004 12:55:55 -0600, Matt Mackall <mpm@selenic.com> wrote:
> > On Fri, Feb 27, 2004 at 09:44:44AM -0800, Grover, Andrew wrote:
> >> > From: Helge Hafting [mailto:helgehaf@aitel.hist.no]
> >> >
> >> > Grover, Andrew wrote:
> >> > > Is the assumption that hardirq handlers are superfast also
> >> >
> >> > the reason
> >> >
> >> > > why Linux calls all handlers on a shared interrupt, even if
> >> >
> >> > the first
> >> >
> >> > > handler reports it was for its device?
> >> >
> >> > No, it is the other way around.  hardirq handlers have to be superfast
> >> > because linux usually _have to_ call all the handlers of a shared irq.
> >> >
> >> > The fact that one device did indeed have an interrupt for us
> >> > doesn't mean
> >> > that the others didn't.  So all of them have to be checked to be safe.
> >>
> >> If a device later in the handler chain is also interrupting, then the
> >> interrupt will immediately trigger again. The irq line will remain
> >> asserted until nobody is asserting it.
> >>
> >> If the LAST guy in the chain is the one with the interrupt, then you
> >> basically get today's ISR "call each handler" behavior, but it should be
> >> possible to in some cases to get less time spent in do_IRQ.
> >
> > Let's imagine you have n sources simultaneously interrupting on a
> > given descriptor. Check the first, it's happening, acknowledge it,
> > exit, notice interrupt still asserted, check the first, nope, check
> > the second, yep, exit, etc. By the time we've made it to the nth ISR,
> > we've banged on the first one n times, the second n-1 times, etc. In
> > other words, early chain termination has an O(n^2) worst case.
>
> With level triggered you can just walk the chain, exit at the end of the
> first cycle and  should the IRQ still be asserted you just incur the
> overhead of exit and reentry of the ISR.
>
> Even with edge, I would not check alwasy from the beginning of the chain...

You should... after all that first entry in the chain has the highest priority
