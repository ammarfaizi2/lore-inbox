Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSEYEJS>; Sat, 25 May 2002 00:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEYEJR>; Sat, 25 May 2002 00:09:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5649 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313384AbSEYEJQ>; Sat, 25 May 2002 00:09:16 -0400
Date: Fri, 24 May 2002 21:08:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <3CEF0911.425C00E7@opersys.com>
Message-ID: <Pine.LNX.4.44.0205242059410.4177-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Karim Yaghmour wrote:
>
> There is no reason that what happens _now_ shouldn't have memory protection
> and what happens later should.

Sure there is.

What happens _now_ happens in an interrupt, which means that it had better
be in a kernel module. And yes, you can (and apparently do) add low-level
task switching etc, at the expense of a slower interrupt response time.

Most people don't need that. In fact, most people could probably do
perfectly well with just soft realtime, and to a lot of those people "hard
realtime" is just a marketing term.

It all tends to boil down to a device driver in the end, and the amount of
support you're willing to give it. Soft realtime can handle the rest.

Personally, I'm _not_ interested in making device drivers look like
user-level. They aren't, they shouldn't be, and microkernels are just
stupid.

> Sure. I'm not contesting the merits of using GPL modules. True, this
> is the best way to go. However, not everyone has this option and my
> claim is that this is one of the facts that is putting Linux out in the
> cold in front of the competition in regards to rt.

You know what? I don't care. If the RTAI people are trying to make it easy
for non-GPL module people, I have absolutely zero interest.

In contrast, I _am_ interested if the kernel module is required to be (a)
small, (b) clear (c) GPL. You seem to not care about any of the three
things _I_ care about.

That's ok. The GPL means that you don't have to agree with me.

> Again, from a purely technical standpoint, there are many advantages in
> having the hard-rt tasks in user-space.

That's simply not true.

In user space, you'll never get the kinds of low overheads for the _true_
hard realtime, and to me that just says that what you're talking about is
really mostly just a slightly hardened soft-realtime.

			Linus

