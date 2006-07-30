Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWG3AYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWG3AYo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWG3AYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:24:44 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:18332
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750876AbWG3AYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:24:43 -0400
Date: Sat, 29 Jul 2006 17:24:22 -0700
To: Edgar Toernig <froese@gmx.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060730002422.GA22680@gnuppy.monkey.org>
References: <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de> <20060729225138.GA22390@gnuppy.monkey.org> <20060730021659.14a7c693.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730021659.14a7c693.froese@gmx.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 02:16:59AM +0200, Edgar Toernig wrote:
> Bill Huey (hui) wrote:
> > It's a different topic than what Keith needs,
> 
> Hmm, actually, people with problems like Keith's are the target
> audience, or at least were meant to be.  See the mmap example
> I posted in the original thread.
> 
> > but this is useful for another set of purposes. It's something that's
> > really useful in the RT patch since there isn't a decent API to get at
> > high resolution timers in userspace.
> 
> The /dev/itimer wasn't meant for high resolution, only accurate and
> reliable within the limits of the jiffy counter and easy to use. That
> doesn't mean that it can't be improved to provide high resolution; only,
> that this wasn't the design goal.  But I think, that the API is good
> enough to provide high resolution at any time without changing user
> space code.
> 
> (IMHO most people consider a resolution of 1 ms to be "high enough".)

Have you thought about making it an 'rtc' replacement and getting it to
conform to the API of it to what ever degree makes sense ? then it would
be a general replacement for 'rtc' if it could be opened multipule times
(as with generic event interfaces) with different timing scenarios per
thread.

> Hm... I'm not sure what you mean.  Sure, a blocking read may be a nice hint
> to the scheduler because we know exactly how long we're gonna sleep.  But
> I think that a blocking read is used very seldom.  Normally, the apps would
> block via select/poll.  And then the hints become looser - you only know
> the latest time when the process definitely wants to run again.
> 
> Another scheduling hint could be the set interval.  One could assume that
> an app that sets an interval of 1/50th second does want to run regularly
> every 1/50th second.  But that may be hard to use for scheduling decisions,
> especially when an app starts to use more than one timer.

Don't worry about what I just said, really. The fact that this driver exists
make it possible for heavy modification of just about any sort.

bill

