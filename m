Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWFSUrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFSUrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWFSUrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:47:39 -0400
Received: from spirit.analogic.com ([204.178.40.4]:16659 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932205AbWFSUrj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:47:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Jun 2006 20:47:37.0951 (UTC) FILETIME=[9989D6F0:01C693E1]
Content-class: urn:content-classes:message
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Date: Mon, 19 Jun 2006 16:47:37 -0400
Message-ID: <Pine.LNX.4.61.0606191627270.5064@chaos.analogic.com>
In-Reply-To: <20060619202354.GD26759@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
thread-index: AcaT4ZmTfO8J2KIpRnWNp9mMEQNJFA==
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Dave Jones wrote:

> On Mon, Jun 19, 2006 at 04:00:06PM -0400, linux-os (Dick Johnson) wrote:
>
> > > arch/i386/kernel/doublefault.c/doublefault_fn():
> > >
> > >        for (;;) /* nothing */;
> > > }
> > >
> > > Let's assume that we have a less than moderate fan failure that causes
> > > the CPU to heat up beyond the critical limit...
> > > That might result in - you guessed it - crashes or doublefaults.
> > > In which case we enter the corresponding handler and do... what?
> >
> > The double-fault is just a place-holder. The CPU will actually
> > reset without even executing this (try it).
>
> Wrong.
>
> Why do you think we go to the bother of installing a double fault handler if
> we're going to reset? Why would we go to the bother of printk'ing
> information about the double fault if we're about to reset faster than
> it would get to a serial console ?
>

I don't know why you go to the bother of installing such a handler.
Have you actually gotten it to print something? All my experience
with double-faults (and many with your RH Linux, BTW) result in
the screen going blank, the POST starting, and the machine re-booting.

Don't think so? Make a real double-fault, reset the paging bit
while executing somewhere that's not 1:1 mapped. Been there, done
that.

> The box intentionally locks up, so we have a chance to know wtf happened.
>
> > A CPU without a fan will go into
> > a cold, cold, shutdown, requiring a hardware reset to get it out of
> > that latched, no internal clock running, mode.
>
> Wrong.
>
> > Try it. I have had
> > broken plastic heat-sink hold-downs let the entire heat-sink fall off
> > the CPU. The machine just stops.
>
> Your single datapoint is just that, a single datapoint.
> There are a number of reported cases of CPUs frying themselves.
> Here's one: http://www.tomshardware.com/2001/09/17/hot_spot/page4.html
> Google no doubt has more.
>
> Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
> (as in broke in two pieces) under extreme heat.
>
> This _does_ happen.
>


Maybe it wasn't a FAN failure? The ceramic won't shatter even if
you play a burnz-o-matic blowtorch on it (don't try this at home).
It's a refractory material! To break the material, something
inside (the chip) probably exploded causing an overpressure that
cracked the device. This explosion could be caused by any number
of defects, including a bond failure.

> > Also, the CPU was only warm to the touch, having been completely shut down for the
> > several minutes it took to locate tools to remove the cover, even
> > though I deliberately left the power ON.
>
> So you got lucky. I've blistered a thumb on hot CPUs before now
> after fan failure.
>
> > In the first place, when the Intel and AMD CPUs overheat, they
> > shut down.
>
> Reality disagrees with you.
>

Then send the CPU back. It's in the specification. It's supposed
to shut down.

Further, if you `google` for intel cpu overheat shutdown, you
will find 144,000 results of complaints of the CPUs shutting
down because of over temperature.

> > For sure, it might be nicer to have some call-and-never-return
> > function for waiting with the rep-nop code, but it isn't necessary
> > for CPU protection.
>
> cpu_relax() and friends aren't going to save a box in light of
> a fan failure in my experience.
> However for a box which has locked up (intentionally)
> running instructions that do save power in a loop has obvious advantages.
>
> 		Dave
>
> --
> http://www.codemonkey.org.uk
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
