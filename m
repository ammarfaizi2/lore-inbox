Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVASFHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVASFHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVASFHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:07:40 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:39852 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261579AbVASFHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:07:30 -0500
Date: Tue, 18 Jan 2005 21:07:01 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119050701.GA19542@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106108467.4500.169.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 20:22]:
> On Tue, 2005-01-18 at 16:05 -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > Attached is the dynamic tick patch for x86 to play with
> > as I promised in few threads earlier on this list.[1][2]
> > 
> > The dynamic tick patch does following:
> >
> > .../...
> 
> Nice, that's exactly what I want on ppc to allow the laptops to have the
> CPU "nap" longer when idle ! I'll look into adding ppc support to your
> patch soon.

Great!

> BTW. Is it possible, when entering the "idle" loop, to quickly know an
> estimate of when the next tick shoud actually kick in ?

Yes, see next_timer_interrupt() for that. The interrupt loop should
be pretty much the same on all archs. Then calling the timer
interrupt from other interrupts removes any latency issues with the
timer. But that's pretty much all the patch does.

> Also, looking at the patch, I think it mixes a bit too much of x86
> things with generic stuffs... like pm_idle an x86 thing. 

Yes, the idle module should probably be in drivers/acpi or something
to allow loading other custom PM modules.

> Other implementation details comments: Do you need all those globals to
> be exported ? And give them better names than "ltt", that makes using of
> system.map quite annoying ;)

Oops, ltt, is probably left-over from low-tick-timer that I used
first as a name... I'll fix that :)

> I don't understand your comment about "we must have all processors idle"
> as well... 

Hmmm, maybe it's not needed any longer? Have to try it out. I had
some issues with SMP when I started doing the patch.

> So while the whole thing is interesting, I dislike the actual
> kernel/dyn-tick-timer.c implementation, which should be moved to arch
> stuff at this point imho.

Yeah, there's not much shared code yet, when I started I expected to
share more code between ARM and x86. But the timer framework is
quite arch specific. So far only registering and /sys control to 
enable seems common. Maybe some inline functions too, but a common 
header might be enough.

Regards,

Tony
