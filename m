Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbREOGOQ>; Tue, 15 May 2001 02:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbREOGOG>; Tue, 15 May 2001 02:14:06 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43674 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262647AbREOGOB>; Tue, 15 May 2001 02:14:01 -0400
Date: Tue, 15 May 2001 00:13:23 -0600
Message-Id: <200105150613.f4F6DNW22399@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
In-Reply-To: <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Mon, 14 May 2001, Richard Gooch wrote:
> > 
> > Is there some fundamental reason why a buffer cache can't ever be
> > fast?
> 
> Yes.
> 
> Or rather, there is a fundamental reason why we must NEVER EVER look at
> the buffer cache: it is not coherent with the page cache. 
> 
> And keeping it coherent would be _extremely_ expensive. How do we
> know? Because we used to do that. Remember the small mindcraft
> benchmark? Yup. Double copies all over the place, double lookups, double
> everything.
> 
> You could think: "oh, we only need to look up the buffer cache when we
> create a new page cache mapping, so..".
> 
> You'd be wrong. We'd need to go the other way too: every time we create a
> new buffer cache entry, we'd need to make sure that it isn't mapped
> somewhere in the page cache (impossible), or otherwise we'd do the wrong
> thing sometimes (ie we might have two dirty copies, and we wouldn't know
> _which_ one is valid etc).
> 
> Aliasing is bad. Don't do it.

OK, this (combined with the other message) explains why we want to
keep away from the buffer cache. Thanks.

> You know, the mark of intelligence is realizing when you're making
> the same mistake over and over and over again, and not hitting your
> head in the wall five hundred times before you understand that it's
> not a clever thing to do.

But you didn't have to add this. Please note that I asked why not use
the buffer cache. I didn't proclaim that it was the ideal solution. I
did say what benefits it had, but I didn't assert that the benefits
outweighed the disadvantages.

> Please show some intelligence.

Well, frankly, I think I have. Things are obvious when you know them
already. Even if I'm ignorant, I'm not stupid!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
