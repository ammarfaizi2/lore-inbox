Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265452AbRGSRZs>; Thu, 19 Jul 2001 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265488AbRGSRZj>; Thu, 19 Jul 2001 13:25:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:27910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265452AbRGSRYm>; Thu, 19 Jul 2001 13:24:42 -0400
Date: Thu, 19 Jul 2001 10:23:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <200107191659.f6JGxYh13394@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0107191020350.8055-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 19 Jul 2001, Richard Gooch wrote:
> Linus Torvalds writes:
> > Note that the unfair aging (apart from just being a natural
> > requirement of higher allocation pressure) actually has some other
> > advantages too: it ends up being aload balancing thing. Sure, it
> > might throw out some things that get "unfairly" treated, but once we
> > bring them in again we have a better chance of bringing them into a
> > zone that _isn't_ under pressure.
>
> What about moving data to zones with free pages? That would save I/O.

Well, remember that we _are_ talking about pages that have been aged (just
a bit more aggressively than some other pages), and are not being used.
Dropping them may well be the right thing to do, and migrating them is
potentially very costly indeed (and can cause oscillating patterns etc
horror-schenarios).

Yes, true page migration might eventually be something we have to start
thinking about for NUMA machines, but I'd really really prefer just about
any alternative. Getting a good balance would be _much_ preferable to
having to take out the sledgehammer..

			Linus

