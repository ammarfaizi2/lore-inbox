Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751713AbVLATJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbVLATJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbVLATJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:09:41 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:63481 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751708AbVLATJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:09:40 -0500
Subject: Re: [patch 00/43] ktimer reworked
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.61.0512011828150.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512010118200.1609@scrub.home>
	 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
	 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	 <20051201165144.GC31551@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0512011828150.1609@scrub.home>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:08:17 -0500
Message-Id: <1133464097.7130.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 18:44 +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 1 Dec 2005, Russell King wrote:
...
> > Hence, timers have the implication that they are _expected_ to expire.
> > Timeouts have the implication that their expiry is an exceptional
> > condition.
> 
> IOW a timeout uses a timer to implement an exceptional condition after a 
> period of time expires.
> 
> > So can we stop rehashing this stupid discussion?
> 
> The naming isn't actually my primary concern. I want a precise definition 
> of the expected behaviour and usage of the old and new timer system. If I 
> had this, it would be far easier to choose a proper name.
> E.g. I still don't know why ktimeout should be restricted to raise just 
> "error conditions", as the name implies.
> 

ktimeout may not need to be restricted to anything.

It should just be documented simply as: If you need to set some timed
event to happen that you don't expect to occur then use a ktimeout.
Where this timed event is an event that lets you know that another event
hasn't happened in a given time. (I want to know if x didn't happen by
this time).

If a timed event is expected to occur then use ktimer.  Where it is
mostly used for the event itself (I want x to happen at this time).

Now you could use ktimout on something that will always occur, but this
will just be inefficient, since ktimeout is optimized for removal and
not expiration.  Which usually happens when something "times out". 

And you could use ktimer on something that isn't going to occur.  But
again this is just inefficient.

So Roman, please have someone else speak up and let us know that they
are just as confused on these names as you are.  Currently, it seems
that you are the only one that doesn't understand the difference between
a timeout and a timer.  You seem very intelligent and that could be why
you are getting confused.  You're looking too deep into the
implementation of timers and timeouts, where they seem to use each
other.  You just need to take a step back and look at this at a higher
view.  Think about what to use when you need to implement being told
when something has timed out (timeout) or when you just want to do
something that happens a a certain time (timer).

-- Steve

