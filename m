Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWG3ARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWG3ARI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWG3ARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:17:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:26091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750842AbWG3ARG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:17:06 -0400
X-Authenticated: #271361
Date: Sun, 30 Jul 2006 02:16:59 +0200
From: Edgar Toernig <froese@gmx.de>
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character
 driver)
Message-Id: <20060730021659.14a7c693.froese@gmx.de>
In-Reply-To: <20060729225138.GA22390@gnuppy.monkey.org>
References: <20060725204736.GK4608@hmsreliant.homelinux.net>
	<1153861094.1230.20.camel@localhost.localdomain>
	<44C6875F.4090300@zytor.com>
	<1153862087.1230.38.camel@localhost.localdomain>
	<44C68AA8.6080702@zytor.com>
	<1153863542.1230.41.camel@localhost.localdomain>
	<20060729042820.GA16133@gnuppy.monkey.org>
	<20060729125427.GA6669@localhost.localdomain>
	<20060729204107.GA20890@gnuppy.monkey.org>
	<20060729234948.0768dbf4.froese@gmx.de>
	<20060729225138.GA22390@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
>
> > You mean something like this, /dev/itimer?
> > 
> >     http://marc.theaimsgroup.com/?m=115412412427996
> 
> [CCing Steve and Ingo on this thread]
> 
> It's a different topic than what Keith needs,

Hmm, actually, people with problems like Keith's are the target
audience, or at least were meant to be.  See the mmap example
I posted in the original thread.

> but this is useful for another set of purposes. It's something that's
> really useful in the RT patch since there isn't a decent API to get at
> high resolution timers in userspace.

The /dev/itimer wasn't meant for high resolution, only accurate and
reliable within the limits of the jiffy counter and easy to use. That
doesn't mean that it can't be improved to provide high resolution; only,
that this wasn't the design goal.  But I think, that the API is good
enough to provide high resolution at any time without changing user
space code.

(IMHO most people consider a resolution of 1 ms to be "high enough".)

> If itimer can be abstracted a bit so it serves more generically as a bidirection
> communication pipe, not just to a timer (although it's good for now), but
> possibly to bandwidth scheduler policies as a backend, then you have the
> possibility of this driver being a real winner. The blocking read can be a
> yield to get information on soft overruns for that allocation cycle and the
> write can be an intelligent yield for when scheduling wheel wraps around to
> soft skip a cycle or something. It'll depend on the semantics of the scheduling
> policy.

Hm... I'm not sure what you mean.  Sure, a blocking read may be a nice hint
to the scheduler because we know exactly how long we're gonna sleep.  But
I think that a blocking read is used very seldom.  Normally, the apps would
block via select/poll.  And then the hints become looser - you only know
the latest time when the process definitely wants to run again.

Another scheduling hint could be the set interval.  One could assume that
an app that sets an interval of 1/50th second does want to run regularly
every 1/50th second.  But that may be hard to use for scheduling decisions,
especially when an app starts to use more than one timer.

Ciao, ET.
