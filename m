Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRGSRlT>; Thu, 19 Jul 2001 13:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRGSRlJ>; Thu, 19 Jul 2001 13:41:09 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:37393 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265488AbRGSRkz>; Thu, 19 Jul 2001 13:40:55 -0400
Date: Thu, 19 Jul 2001 11:40:54 -0600
Message-Id: <200107191740.f6JHes713911@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33.0107191020350.8055-100000@penguin.transmeta.com>
In-Reply-To: <200107191659.f6JGxYh13394@mobilix.ras.ucalgary.ca>
	<Pine.LNX.4.33.0107191020350.8055-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus Torvalds writes:
> 
> On Thu, 19 Jul 2001, Richard Gooch wrote:
> > Linus Torvalds writes:
> > > Note that the unfair aging (apart from just being a natural
> > > requirement of higher allocation pressure) actually has some other
> > > advantages too: it ends up being aload balancing thing. Sure, it
> > > might throw out some things that get "unfairly" treated, but once we
> > > bring them in again we have a better chance of bringing them into a
> > > zone that _isn't_ under pressure.
> >
> > What about moving data to zones with free pages? That would save I/O.
> 
> Well, remember that we _are_ talking about pages that have been aged
> (just a bit more aggressively than some other pages), and are not
> being used.

Well, under memory pressure, those pages may be considered "old" but
in fact could be needed again soon.

> Dropping them may well be the right thing to do, and migrating them
> is potentially very costly indeed (and can cause oscillating
> patterns etc horror-schenarios).

If you move them, preserving the age and making sure not to evict
younger pages in the new zone, that should avoid the oscillations,
should it not?

Besides, I've seen plenty of oscillations when paging to/from the swap
device :-(

> Yes, true page migration might eventually be something we have to
> start thinking about for NUMA machines, but I'd really really prefer
> just about any alternative. Getting a good balance would be _much_
> preferable to having to take out the sledgehammer..

I agree that a good balancing algorithm is required. I'm just
suggesting that if you get to the point where you *have* to evict a
page from a zone, instead of just tossing it out, move it to another
zone if you can.

Note that I'm not necessarily suggesting writing dirty pages to
another zone instead of to swap. I was originally thinking of just
moving "clean" pages (i.e. those that can be freed without the need to
schedule I/O) so that potential subsequent I/O to pull them back in
may be avoided. Doing proper page migration is a more complex step
that needs further consideration.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
