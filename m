Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbRGXJDY>; Tue, 24 Jul 2001 05:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbRGXJDO>; Tue, 24 Jul 2001 05:03:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28433 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267163AbRGXJDJ>; Tue, 24 Jul 2001 05:03:09 -0400
Date: Tue, 24 Jul 2001 11:02:16 +0200
From: Jan Hubicka <jh@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010724110216.C3955@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <3B5C8C96.FE53F5BA@nortelnetworks.com> <20010723231136.E16919@athlon.random> <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca> <20010724000933.I16919@athlon.random> <200107232347.f6NNl4u14416@vindaloo.ras.ucalgary.ca> <20010724020413.A29561@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010724020413.A29561@athlon.random>; from andrea@suse.de on Tue, Jul 24, 2001 at 02:04:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> If gcc caches there's no problem indeed, the problem is when it doesn't
> cache it which can happen, with volatile it will understand it must not
> make assumption for the variable to not change under it. Anyways as just
> said in another email in this thread I'm been told it wasn't just for
> 'case'. I think tomorrow Honza will comment this since he's the gcc
> developer who asked those kernel bugs to be fixed for gcc.
What I was concerned about is for example scenario:
1) cse realizes that given variable is constnat in some region of program
   (by seeing an conjump).
2) it replaces occurences of other same constants in the program by that variable
   (as costs says register is cheaper)
3) register allocator runs out of registers
4) reload optimizes and re-loads the variable from original place instead of
   spilling it.

This way you can effectivly change one constant to another for some region
of program.

At the moment gcc rarely exploits knowledge about the variable value, but
this is going to improve, as gcc envolve and we are riscing hard to debug
problems in kernel.

I am not sure volatile is sensible solution tought.

For instance gcc 3.1 now does load store motion that makes gcc to keep
global variables in registers much longer than it did originally making
such risk greater.

Honza
> 
> Andrea
