Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRJRU2d>; Thu, 18 Oct 2001 16:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278128AbRJRU2N>; Thu, 18 Oct 2001 16:28:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18448 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278125AbRJRU2I>; Thu, 18 Oct 2001 16:28:08 -0400
Date: Thu, 18 Oct 2001 17:07:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork() failing
In-Reply-To: <Pine.LNX.4.33L.0110181813030.3690-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0110181705150.12429-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Rik van Riel wrote:

> On Thu, 18 Oct 2001, Marcelo Tosatti wrote:
> > On Thu, 18 Oct 2001, Rik van Riel wrote:
> 
> > > Actually, I guess we could define this to be the same point
> > > where we'd end up freeing memory in order to satisfy our
> > > allocation.
> >
> > Just remember that if we give __GFP_FAIL a "give me memory if its
> > available" meaning we simply can't use it for stuff like pagecache
> > prefetching --- its _too_ fragile.
> 
> IMHO it makes perfect sense, since at this point, one more
> allocation _will_ push us over the limit and let kswapd go
> to work to free up more memory.
> 
> We just need to make sure that the "wake up kswapd and maybe
> help free memory" point is EXACTLY the same as the __GFP_FAIL
> failure point.

Ok, great, that works fine. We can do that for 2.4, no problem.
 
> Unless off course I'm overlooking something ... in that case
> I'd appreciate it if you could point it out to me ;)

I would just like to have a _good_ scheme for this kind of "lazy
allocations" for 2.5 which can also be used by the page clustering code.

We really don't want the page clustering code to simply use a
"__GFP_FAIL" which fails so easily because we want performance.

Got my point? 

