Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279878AbRKBAkj>; Thu, 1 Nov 2001 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279879AbRKBAka>; Thu, 1 Nov 2001 19:40:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61196 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279878AbRKBAkY>; Thu, 1 Nov 2001 19:40:24 -0500
Date: Thu, 1 Nov 2001 16:37:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <200111012335.AAA29493@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.33.0111011634340.12377-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Nov 2001, Stephan von Krawczynski wrote:
>
> To clarify this one a bit:
> shrink_cache is thought to do what it says, it is given a number of
> pages it should somehow manage to free by shrinking the cache. What my
> patch does is go after the _whole_ list to fulfill that.

I would suggest a slight modification: make "max_mapped" grow as the
priority goes up.

Right now max_mapped is fixed at "nr_pages*10".

You could have something like

	max_mapped = nr_pages * 60 / priority;

instead, which might also alleviate the problem with not even bothering to
scan much of the inactive list simply because 99% of all pages are mapped.

That way you don't waste time on looking at the rest of the inactive list
until you _need_ to.

		Linus

