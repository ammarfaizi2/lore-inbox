Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbRCaAjb>; Fri, 30 Mar 2001 19:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131791AbRCaAjW>; Fri, 30 Mar 2001 19:39:22 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:38409 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131778AbRCaAjP>;
	Fri, 30 Mar 2001 19:39:15 -0500
Date: Sat, 31 Mar 2001 02:37:59 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Pavel Machek <pavel@suse.cz>, Russell King <rmk@arm.linux.org.uk>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010331023759.B6784@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local>; from jsimmons@linux-fbdev.org on Wed, Mar 28, 2001 at 07:54:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> >Are you using fbcon? If so, and if it goes away after starting X, then it
> >is the "fbcon kills interrupt latency" problem.
> 
> Ug!!! This is getting bad. Give me some time. I plan on releasing a new
> vesafb using MMX to help speed up the drawing routines. It will help alot
> with the latency issues. I also know using ARM assembly we can greatly
> reduce the latency issues.

On console speedups: back in the old days, scrolling a subregion of the
text console to be _really_ slow on some machines.  I am talking about
text mode now, not framebuffer mode.  On some cards, text mode is
actually very very slow and the framebuffer is faster.  It took *2
seconds* to scroll a 50 lines of text 50 times on my 200MHz PPro system
4 years ago.  So less "back one screen" took 2 seconds.  And Emacs uses
"scroll region by N lines" a lot.  In those days, "N lines" scrolls
actually did N x 1 line scrolls, so text mode was really a burden on
that machine.  I took to using X, with a single screen size xterm to
present the illusion of console mode.

Well, nowadays on my laptop we have the joy of the framebuffer console.
Nice penguin aside, it means I get a console on the full screen area.

But it is nearly as slow at scrolling as my old 200MHz PPro.

Probably the lack of hardware area copies has something to do with
this.  However, who isn't familiar with xterm "jump scroll" mode?
That's nice and fast.

Could such a thing be implemented in the console driver?

cheers,
-- Jamie
