Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936691AbWLCL1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936691AbWLCL1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936692AbWLCL1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:27:22 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:15888 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S936691AbWLCL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:27:21 -0500
Date: Sun, 3 Dec 2006 11:27:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061203112706.GA12722@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203102108.GA1724@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 11:21:09AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > The other alternative has real _practical_ value in almost every case, 
> > > > which I very much prefer. What's wrong with that?
> > > 
> > > Lack of any type safety whatsoever, magic boilerplates in callback instances,
> > > rules more complex than "your callback should take a pointer, don't cast
> > > anything, it's just a way to arrange for a delayed call, nothing magical
> > > needed"?
> > 
> > I admit the compile check in SETUP_TIMER() is clever, but this way all the
> > magic is in this place and is it really worth it? You're only adding _one_ 
> > extra typecheck for mostly simple cases anyway.
> 
> Well, there are so many of these simple changes, that SETUP_TIMER()
> with its clever trick looks very useful.

I agree with Al, Matthew and Pavel.  The current timer stuff is a pita
and needs fixing, and it seems Al has come up with a good way to do it
without adding additional crap into every single user of timers.

There *are* times when having the additional space for storing a pointer
is cheaper (in terms of number of bytes) than code to calculate an offset,
and those who have read the assembly code probably know this all too well.

Al - I look forward to your changes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
