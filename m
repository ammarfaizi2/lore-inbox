Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRCaAyl>; Fri, 30 Mar 2001 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRCaAyb>; Fri, 30 Mar 2001 19:54:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60680 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131809AbRCaAyX>; Fri, 30 Mar 2001 19:54:23 -0500
Date: Sat, 31 Mar 2001 02:53:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: James Simmons <jsimmons@linux-fbdev.org>, Pavel Machek <pavel@suse.cz>,
   Russell King <rmk@arm.linux.org.uk>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010331025341.B6086@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local> <20010331023759.B6784@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010331023759.B6784@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sat, Mar 31, 2001 at 02:37:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Are you using fbcon? If so, and if it goes away after starting X, then it
> > >is the "fbcon kills interrupt latency" problem.
> > 
> > Ug!!! This is getting bad. Give me some time. I plan on releasing a new
> > vesafb using MMX to help speed up the drawing routines. It will help alot
> > with the latency issues. I also know using ARM assembly we can greatly
> > reduce the latency issues.
> 
> On console speedups: back in the old days, scrolling a subregion of the
> text console to be _really_ slow on some machines.  I am talking about
> text mode now, not framebuffer mode.  On some cards, text mode is
> actually very very slow and the framebuffer is faster.  It took *2
> seconds* to scroll a 50 lines of text 50 times on my 200MHz PPro system
> 4 years ago.  So less "back one screen" took 2 seconds.  And Emacs uses
> "scroll region by N lines" a lot.  In those days, "N lines" scrolls
> actually did N x 1 line scrolls, so text mode was really a burden on
> that machine.  I took to using X, with a single screen size xterm to
> present the illusion of console mode.
> 
> Well, nowadays on my laptop we have the joy of the framebuffer console.
> Nice penguin aside, it means I get a console on the full screen area.
> 
> But it is nearly as slow at scrolling as my old 200MHz PPro.

You have same toshiba satellite as me, right?

> Probably the lack of hardware area copies has something to do with
> this.  However, who isn't familiar with xterm "jump scroll" mode?
> That's nice and fast.
> 
> Could such a thing be implemented in the console driver?

I believe so. It would be simple: if there's too much activit, defer
framebuffer updates and only update in-memory copy. Sync from time to
time. I'd certainly like to see that.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
