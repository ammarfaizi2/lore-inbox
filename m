Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWGaPoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWGaPoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWGaPoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:44:39 -0400
Received: from thunk.org ([69.25.196.29]:60376 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030198AbWGaPoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:44:38 -0400
Date: Mon, 31 Jul 2006 11:40:25 -0400
From: Theodore Tso <tytso@mit.edu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Nicholas Miell <nmiell@comcast.net>, Edgar Toernig <froese@gmx.de>,
       Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060731154025.GA28788@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Nicholas Miell <nmiell@comcast.net>, Edgar Toernig <froese@gmx.de>,
	Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, a.zummo@towertech.it,
	jg@freedesktop.org, Keith Packard <keithp@keithp.com>,
	Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
References: <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de> <20060729225138.GA22390@gnuppy.monkey.org> <1154216151.2467.5.camel@entropy> <20060730010020.GA23288@gnuppy.monkey.org> <1154222579.2467.12.camel@entropy> <20060730013936.GA23571@gnuppy.monkey.org> <20060730143341.GD23279@thunk.org> <20060730222052.GA3335@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730222052.GA3335@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 03:20:52PM -0700, Bill Huey wrote:
> > sched_policy).  At least, that's the theory.  The exact semantics of
> > what would actually be useful to application is I believe a little
> > unclear, and of course there is the question of whether there is
> 
> It's really up to the RT application to decide what it really wants. The
> role of the kernel is to give it what it has requested within reason.

Yes, but what is somewhat unclear is what knobs/parameters should be
made available to the application so it can clearly express what it
wants (i.e., can the thread be woken up early?  late?  How much leeway
should be allowed in terms of early/late triggering of the thread?
How does the scheduling of these cyclic threads interact with
non-cyclic SCHED_FIFO/SCHED_RR threads at other priorities?  etc.)  As
you say, this has been a somewhat researchy subject, and everyone has
different control knobs....

> > In any case, I don't think this is particularly interesting to the X
> > folks, although there may very well be real-time applications that
> > would find this sort of thing useful.
> 
> Right, the original topic has shifted. It's more interesting to me now. :)

Heh.  OK, so what are your requirements for this sort of feature, and
which application writers would be able to contribute their wishlist
for frequency-based scheduling?  I will say that the RTSJ document
does define Java interfaces for FBS, so that's one possible user of
such a feature.  But, I wouldn't want RTSJ to be the only thing
driving development of such a feature.  (Also, I should mention that
it's not something we've been asked for up until now, so we haven't
paid much attention to up until now.)

							- Ted
