Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276984AbRJQRAb>; Wed, 17 Oct 2001 13:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJQRAU>; Wed, 17 Oct 2001 13:00:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276984AbRJQRAG>; Wed, 17 Oct 2001 13:00:06 -0400
Date: Wed, 17 Oct 2001 09:59:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <3BCAB9B1.2F85F523@yahoo.com>
Message-ID: <Pine.LNX.4.33.0110170949370.17757-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Oct 2001, Paul Gortmaker wrote:
>
> Oh, and prereading the dirs of both trees (vs. just one and letting
> normal execution read in the 2nd) seems to offer better improvements.
> (Steady stream of requests results in better merging perhaps?)

That doesn't make much sense, but I'll take your word for it. Does this
behaviour show up on 2.4.x too? It sounds like a performance buglet in the
kernel or some infrastructure, really.

The one problem with pre-reading is that it will now artificially touch
the data twice, and when running on 2.4.x it will activate the pages.
That's going to be exactly what _I_ want it to do on my machine, but
others are likely to be less happy about it.

Btw, why use "slurp()" and actually doing the memory allocations etc, only
to throw it away again? It would be better to either really keep the
allocation around (which would also fix the touch-twice issue but would
cause much more changes to 'diff'), or to just read into the same buffer
over and over again..

And I've for a long time thought about adding a "readahead()" system call.
There are just too many uses for it, it has come up in many different
areas..

> This was all running under a 2.2.x kernel btw; might have time to
> test on a 2.4.x one later.  Either way, it kind of makes you wonder
> why nobody had done this earlier (not to mention feeding the source
> to indent -kr -i8...)

Who's the maintainer for "diff" these days? This change seems small and
simple enough that they might accept it, and I'd love to see it. I'll
probably do this in my copy anyway, but it would be nicer to not have to
patch it specially..

As to using sane indentation - you're talking about a FSF-maintained
thing. Which means that they'll almost certainly not fix their horrible
problems with indentation ;(

		Linus

