Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRGWXrg>; Mon, 23 Jul 2001 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbRGWXr0>; Mon, 23 Jul 2001 19:47:26 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65428 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265042AbRGWXrI>; Mon, 23 Jul 2001 19:47:08 -0400
Date: Mon, 23 Jul 2001 17:47:04 -0600
Message-Id: <200107232347.f6NNl4u14416@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010724000933.I16919@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
	<3B5C8C96.FE53F5BA@nortelnetworks.com>
	<20010723231136.E16919@athlon.random>
	<200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca>
	<20010724000933.I16919@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrea Arcangeli writes:
> On Mon, Jul 23, 2001 at 03:50:54PM -0600, Richard Gooch wrote:
> > Andrea Arcangeli writes:
> > > cases if the code breaks in the actual usages of xtime it is likely that
> > > gcc is doing something stupid in terms of performance. but GCC if it
> > > wants to is allowed to compile this code:
> > > 
> > > 	printf("%lx\n", xtime.tv_sec);
> > > 
> > > as:
> > > 
> > > 	unsigned long sec = xtime.tv_sec;
> > > 	if (sec != xtime.tv_sec)
> > > 		BUG();
> > > 	printf("%lx\n", sec);
> > 
> > And if it does that, it's stupid. Why on earth would GCC add extra
> > code to check if a value hasn't changed? I want it to produce
> 
> GCC will obviously _never_ introduce a BUG(), I never said that, the
> above example is only meant to show what GCC is _allowed_ to do and
> what we have to do to write correct C code.

I don't think it should be allowed to do that. That's a whipping
offence. I think that example is a red herring.

> The real life case of the BUG() is when gcc optimize `case' with a
> jump table the equivalent of BUG() will be you derferencing a
> dangling pointer at runtime. Same can happen in other cases but
> don't ask me the other cases as I'm not a gcc developer and I've no
> idea what they plans to do for other things (ask Honza for those
> details).

So grab a local snapshot of the variable, as Linus suggested. In fact,
the switch example is interesting, because one could argue the
opposite way, that declaring the switch variable as "volatile" means
that if GCC needs to internally re-"get" the variable, it should grab
it from memory, and thus definately fail. Without "volatile", GCC is
implicitely allowed to cache the variable (which is of course safe).

So, really, the switch example requires an "antivolatile"
declaration. Oh, wait! I get the same with " ".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
