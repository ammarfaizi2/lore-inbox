Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263945AbRFDHHi>; Mon, 4 Jun 2001 03:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264131AbRFDHH2>; Mon, 4 Jun 2001 03:07:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6529 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263945AbRFDHHV>; Mon, 4 Jun 2001 03:07:21 -0400
Date: Mon, 4 Jun 2001 01:07:14 -0600
Message-Id: <200106040707.f5477ET11421@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        aki.jain@stanford.edu (Akash Jain), linux-kernel@vger.kernel.org,
        su.class.cs99q@nntp.stanford.edu
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <E156o6c-0005AB-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
	<E156o6c-0005AB-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> >  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
> >    noticeable portion of it. It doesn't matter if you "know" your caller
> 
> Umm Linus on what platform - its 8K or more on all that I can think of

I assume he's referring to what's left after you take out the task
struct. More than 4 kiB, so 4 kiB is a conservative estimate.

> > Ergo: the simple rule of "don't allocate big structures of the stack" is
> > always a good rule, and making excuses for it is bad.
> 
> We have a very large number of violators of 1K of stack, and very
> few of 2K right now.

I guess we should ask the question as to what's an acceptable usage.
Theoretically, any amount could pose a problem, but that's hardly a
useful position to work from. Some decision or guideline about a
practical limit would be helpful. My gut feeling is that 1 kiB is
around the limit for functions with a well defined call path. The
limit should probably be less for generic functions and interrupt
handlers.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
