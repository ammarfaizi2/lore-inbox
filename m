Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263723AbRFDAYK>; Sun, 3 Jun 2001 20:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbRFDAQd>; Sun, 3 Jun 2001 20:16:33 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59520 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261978AbRFDADp>; Sun, 3 Jun 2001 20:03:45 -0400
Date: Sun, 3 Jun 2001 18:03:46 -0600
Message-Id: <200106040003.f5403kd07861@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Akash Jain <aki.jain@stanford.edu>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
In-Reply-To: <200105271321.f4RDLoM00342@mobilix.ras.ucalgary.ca>
	<Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Sun, 27 May 2001, Richard Gooch wrote:
> > 
> > I absolutely don't want this patch applied. It's bogus. It is entirely
> > safe to alloc 1 kB on the stack in this code, since it has a short and
> > well-controlled code path from syscall entry to the function.
> 
> IT IS NEVER EVER SAFE TO ALLOCATE 1kB OF STACK!

I can see you care about this ;-)

> Why?
>  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
>    noticeable portion of it. It doesn't matter if you "know" your caller
>    or not: you do not know what interrupts happen during this time, and
>    how much stack they want.

OK, that's a good point. Easy solution: disable interrupts in that
function.

Only kidding.

> Ergo: the simple rule of "don't allocate big structures of the
> stack" is always a good rule, and making excuses for it is bad.

OK, well, I can make the structure static instead, since the function
is single-threaded anyway.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
