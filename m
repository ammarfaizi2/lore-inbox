Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbVJTGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbVJTGzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbVJTGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:55:39 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7871 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751775AbVJTGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:55:38 -0400
Date: Thu, 20 Oct 2005 02:55:26 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: john stultz <johnstul@us.ibm.com>
cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <1129747172.27168.149.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> 
 <1129734626.19559.275.camel@tglx.tec.linutronix.de>
 <1129747172.27168.149.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Oct 2005, john stultz wrote:
> > >
> > > Now here's the results that I got between two calls of do_get_ktime_mono
> > >
> > > 358.069795728 secs then later 355.981483177.  Should this ever happen?
> >
> > Definitely not. monotonic time must go forwards.
>
> Steven: What clocksource are you using? Could you send me your dmesg?

I have both a PIT/TSC and apic. So, as Thomas told me, the ktimer code
should figure out what to use. So that's pretty much all I can say on
clocksource ;)

As for the dmesg, there isn't really one. I have my own logging code that
flagged this, as well as a check that would BUG on the system when this
happened.  So my messages may not mean much to you.  I'm currently
compiling Ingo's -rt12 (with a fix to his checking) to see if I can
trigger it there too.  My custom kernel doesn't touch the ktimer/timeofday
code so I'm assuming that I can. But until I can trigger this on a kernel
that I didn't taint, I'll stop bothering you :-)


>
>
> > > I haven't look to see if this happens in vanilla -rt10 but I haven't
> > > touched your ktimer code except for my logging and the patch with the
> > > unlock_ktimer_base (since I was based off of -rt9)
> >
> > The ktimer code itself calls the timeofday code, which provides the
> > monotonic clock. I have no idea what might go wrong.
> >
> > Is this reproducible ?
>
> Last night I just caught a bug I accidentally introduced with the fixed
> interval math (oh, if only optimizations didn't dirty code so!), where
> time inconsistencies were possible when clocksources were changed. I'm
> not sure if that's the issue being seen above, but I'll wrap things up
> and send out a B8 release today if I can.
>

Hmm, I believe that the ktimers use the apic (when available) and let the
jiffies still be calculated via PIT/TSC.

Thomas, is the above correct?

Would that have triggered your bug?

Thanks,

-- Steve

