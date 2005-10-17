Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVJQR0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJQR0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVJQR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:26:46 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:33735 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751231AbVJQR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:26:45 -0400
Date: Mon, 17 Oct 2005 13:26:12 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Tim Bird <tim.bird@am.sony.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <4353D60E.70901@am.sony.com>
Message-ID: <Pine.LNX.4.58.0510171312030.10443@localhost.localdomain>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
 <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org> <Pine.LNX.4.61.0510171511010.1386@scrub.home>
 <4353D60E.70901@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Tim Bird wrote:

> >
> >
> > It's rather simple:
> > - "timer API" vs "timeout API": I got absolutely no acknowlegement that
> > this might be a little confusing and in consequence "process timer" may be
> > a better name.
>
> I agree with Thomas on this one.  Maybe "timer" and "timeout" are too
> close, but I think they are the most descriptive names.
>   - timeout is something used for a timeout.  Timeouts only actually
>   expire infrequently, so they have a host of attributes associated
>   with that characteristic.
>   - timer is something used to time something.  They almost always
>   expire as part of their normal behaviour.  In the ktimer code they
>   have a host of attributes related to this characteristic.
>
> Thomas answered the suggestion to use "process timer" as an alternative
> name, but I didn't see a reply after that from Roman (I may have missed it.)
>

I can add to this.  After this was brought up, I did a little
non-scientific survey. I walked around and asked various engineers here at
my customer's site, what it meant to them if I had two types of timer
APIs, one for "timers" and one for "timeouts".  All 100% of 8 people that
I asked (not a lot, but still), had no confusion with what they meant.  I
asked them to explain what these names mean to them, and every one said
basically, timeouts are for situations that are for things that lasted too
long, and timers and for things where they want to be notified of an
event that takes place at some time.

They all agreed with me that timeouts were for exceptions and not expected
to be triggered, and timers were the other way around and should always be
triggered.

Not only that, I also asked if these timers would make sense if we called
them "kernel" timers and "process" timers.  These names confused them
because they use both timers in their kernel modules.

That convinced me enough to think that Thomas' naming convention is not
confusing.

-- Steve

