Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRGWWJu>; Mon, 23 Jul 2001 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268350AbRGWWJk>; Mon, 23 Jul 2001 18:09:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8452 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267937AbRGWWJ3>; Mon, 23 Jul 2001 18:09:29 -0400
Date: Tue, 24 Jul 2001 00:09:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010724000933.I16919@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com> <3B5C8C96.FE53F5BA@nortelnetworks.com> <20010723231136.E16919@athlon.random> <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Jul 23, 2001 at 03:50:54PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 03:50:54PM -0600, Richard Gooch wrote:
> Andrea Arcangeli writes:
> > cases if the code breaks in the actual usages of xtime it is likely that
> > gcc is doing something stupid in terms of performance. but GCC if it
> > wants to is allowed to compile this code:
> > 
> > 	printf("%lx\n", xtime.tv_sec);
> > 
> > as:
> > 
> > 	unsigned long sec = xtime.tv_sec;
> > 	if (sec != xtime.tv_sec)
> > 		BUG();
> > 	printf("%lx\n", sec);
> 
> And if it does that, it's stupid. Why on earth would GCC add extra
> code to check if a value hasn't changed? I want it to produce

GCC will obviously _never_ introduce a BUG(), I never said that, the
above example is only meant to show what GCC is _allowed_ to do and what
we have to do to write correct C code.

The real life case of the BUG() is when gcc optimize `case' with a jump
table the equivalent of BUG() will be you derferencing a dangling
pointer at runtime. Same can happen in other cases but don't ask me the
other cases as I'm not a gcc developer and I've no idea what they plans
to do for other things (ask Honza for those details).

> efficient code. What's next? Wrap checking?
>     printk ("You've just wrapped an integer: press [ENTER] to confirm,
> 	    [NT] to ignore   ");
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca


Andrea
