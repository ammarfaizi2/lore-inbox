Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWG3WVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWG3WVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWG3WVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:21:25 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:58854
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751397AbWG3WVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:21:24 -0400
Date: Sun, 30 Jul 2006 15:20:52 -0700
To: Theodore Tso <tytso@mit.edu>, Nicholas Miell <nmiell@comcast.net>,
       Edgar Toernig <froese@gmx.de>, Neil Horman <nhorman@tuxdriver.com>,
       Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Cc: "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060730222052.GA3335@gnuppy.monkey.org>
References: <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de> <20060729225138.GA22390@gnuppy.monkey.org> <1154216151.2467.5.camel@entropy> <20060730010020.GA23288@gnuppy.monkey.org> <1154222579.2467.12.camel@entropy> <20060730013936.GA23571@gnuppy.monkey.org> <20060730143341.GD23279@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730143341.GD23279@thunk.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 10:33:42AM -0400, Theodore Tso wrote:
> On Sat, Jul 29, 2006 at 06:39:36PM -0700, Bill Huey wrote:
> > No, I really ment scheduling.
> 
> Bill, 
> 
> Do you mean frequency-based scheduling?  This was mentioned, IIRC, in
> Gallmeister's book (Programming for the Real World, a must-read for
> those interested in Posix real-time interfaces) as a likely extension
> to the SCHED_RR/SCHED_FIFO scheduling policies and future additions to
> the struct sched_policy used by sched_setparam() at some future point.

Yes, I did.

> sched_policy).  At least, that's the theory.  The exact semantics of
> what would actually be useful to application is I believe a little
> unclear, and of course there is the question of whether there is

It's really up to the RT application to decide what it really wants. The
role of the kernel is to give it what it has requested within reason.

> sufficient reason to try to do this as part of a system-wide
> scheduler.  Alternatively, it might be sufficient to do this sort of

It's it's basic form yes. It's a complicated topic and frequency based
schedulers are only one type in a family of these schedulers. These kind
of scheduler are still research-ish in nature and there isn't a real way
of dealing with them in with regard to soft cycles effectively yet.

The control parameters to these systems vary from algorithm to algorithm
and they all have different control knobs outside of traditional Posix APIs.
People have written implementations based on EDF and stuff, but it seem
that folks can do a better job with scheduling decision if you had a thread
yield operation that was capable of telling the scheduler policy what to do
next with next cycle or chunk of time, especially for softer periods that
may give it's own allocated cycle to another process category. My
suggestion was that a modified 'itimer' could cover the semantic expression
of these kinds of schedulers, other kind of CPU bandwidth schedulers, as
well as be a replacement for '/dev/rtc' if it conformed that device's API.

The 'rtc' case would be a "harder", with respect time, expression of those
schedulers since that drive doesn't understand soft execution periods
and period of execution if strict. My terminology might need to be updated
or clarified and I'm open to that from others.

A new 'itimer' device with an extended API could also synchronously listen
to certain interrupts and deliver that as a latency critical event.
Another big topic of discussion.

> thing at the application level across cooperating threads, in which
> case it wouldn't be necessary to try to add this kind of complicated
> scheduling gorp into the kernel.

Scheduling policies are limited in Linux and that's probably going to
have to change in the future because of the RT patch and Xen, etc... Xen
is going to need a gang scheduler (think sleeping on a spin lock in a guest
OS).

> In any case, I don't think this is particularly interesting to the X
> folks, although there may very well be real-time applications that
> would find this sort of thing useful.

Right, the original topic has shifted. It's more interesting to me now. :)

bill

