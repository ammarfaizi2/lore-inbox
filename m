Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVLBAa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVLBAa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVLBAa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:30:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60892 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932573AbVLBAa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:30:27 -0500
Date: Fri, 2 Dec 2005 01:29:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.61.0512020120180.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512010118200.1609@scrub.home>  <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
  <Pine.LNX.4.61.0512011352590.1609@scrub.home> 
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> 
 <20051201165144.GC31551@flint.arm.linux.org.uk>  <Pine.LNX.4.61.0512011828150.1609@scrub.home>
 <1133464097.7130.15.camel@localhost.localdomain> <Pine.LNX.4.61.0512012048140.1609@scrub.home>
 <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Steven Rostedt wrote:

> The name issue should never have been brought up,

Well, I haven't brought it up, I'm trying to get rid od it.


> > - reading time: to program a timer you have to read the time first,
> > reading jiffies is practically free, whereas reading the precise time can
> > be very expensive. With the right hardware it can be optimized to be quite
> > cheap, but if portability is important you may want to avoid the extra
> > cost.
> 
> If you are only concerned with ms resolution, then the added expense of
> precise time is pretty negligible.  And these times are still for usage
> with timers that are expected to expire.  Remember that timeouts are still
> using jiffies.
> 
> As for portablility, I believe John Stultz has some nice plugins coming
> to what timer source you want to use, so if there's a better way to get a
> time, these should make things easy to add.

These plugins can do no magic, if the hardware timer is slow, the whole 
thing gets slow.

> > - calculations: jiffies is a long integer whereas ktime_t is 64bit, so if
> > you need a lot of complex time calculation, you should take the cost for
> > 32bit archs into account.
> 
> Again, the cost is negligible for ms resolution.  And we're getting close
> to 2038 so we need to be thinking in 64 bits anyway ;)

That one is not really an issue in the kernel, unless you want an uptime 
of a hundred years.

> > - resolution: how precise must the timer be? jiffies can't represent time
> > values less than 1ms, but if time is e.g. measured in 10th of a second,
> > jiffies may be enough.
> 
> And they would be if that is all you need. But coming from an embedded
> point of view, that is not nearly enough.  I really see HighRes making it
> into the kernel soon, and any new code in this area really needs to take
> that into account.

I'm not against HR timer, I have a problem with using them as timer for 
everything.

> > - timer life time: if only a short interval is needed (e.g. a fraction of
> > a second) timer_list is often a lot cheaper.
> 
> And again, you are only limited to 1000 choices to go off in that fraction
> of a second if jiffies is the resolution (with jiffies an 1000HZ).

The point is still valid, short interval timer are cheaper using normal 
timer, independent of whether they are removed or they expire.

bye, Roman
