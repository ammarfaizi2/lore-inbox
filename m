Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277868AbRJRUJx>; Thu, 18 Oct 2001 16:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278118AbRJRUJo>; Thu, 18 Oct 2001 16:09:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11278 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277868AbRJRUJe>; Thu, 18 Oct 2001 16:09:34 -0400
Date: Thu, 18 Oct 2001 16:48:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork() failing
In-Reply-To: <Pine.LNX.4.33L.0110181803540.3690-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0110181647000.12429-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Rik van Riel wrote:

> On Thu, 18 Oct 2001, Marcelo Tosatti wrote:
> 
> > Imagine people changing the point where the
> >
> > 	if ((gfp_mask & __GFP_FAIL))
> > 		return;
> >
> > check is done (inside the freeing routines).
> >
> > I would like to have a _defined_ meaning for a "fail easily" allocation,
> > and a simple unique __GFP_FAIL flag can't give us that IMO.
> 
> Actually, I guess we could define this to be the same point
> where we'd end up freeing memory in order to satisfy our
> allocation.
> 
> This would result in __GFP_FAIL meaning "give me memory if
> it's available, but don't waste time freeing memory if we
> don't have enough free memory now".
> 
> Space-wise these semantics could change (say, pages_low
> vs. pages_min), but they'll stay the same when you look at
> "how hard to try" or "how much effort to spend".

Just remember that if we give __GFP_FAIL a "give me memory if its
available" meaning we simply can't use it for stuff like pagecache
prefetching --- its _too_ fragile.

Thats why I think we need the freeing levels, and thats why I think we
should left all of that for 2.5. :)



