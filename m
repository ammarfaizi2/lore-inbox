Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286181AbRLJHrX>; Mon, 10 Dec 2001 02:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286183AbRLJHrO>; Mon, 10 Dec 2001 02:47:14 -0500
Received: from [209.195.52.114] ([209.195.52.114]:39173 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S286181AbRLJHrA>;
	Mon, 10 Dec 2001 02:47:00 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Stevie O <stevie@qrpff.net>, linux-kernel@vger.kernel.org
Date: Sun, 9 Dec 2001 23:21:23 -0800 (PST)
Subject: Re: "Colo[u]rs"
In-Reply-To: <20011209232859.I25754@work.bitmover.com>
Message-ID: <Pine.LNX.4.40.0112092319020.4915-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry, I thought that direct mapped caches had full mapping from any cache
address to any physical address while the N-way mapped caches were more
limited. modern caches are N-way instead of direct mapped becouse it's
much more expensive (transistor count wise) for the direct mapped
approach.

If I'm mistaken about my termonology (very possible :-) what is the term
for what I am refering to as direct mapped?

David Lang



 On Sun, 9 Dec 2001, Larry McVoy wrote:

> Date: Sun, 9 Dec 2001 23:28:59 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: Stevie O <stevie@qrpff.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: "Colo[u]rs"
>
> On Mon, Dec 10, 2001 at 02:07:06AM -0500, Stevie O wrote:
> > After a few failed web searches (combos like 'linux cache color' just gave
> > me a bunch of references to video), I am resorting to this list for this
> > question.
> >
> > What exactly do y'all mean by these "colors"? Task colors, cache colors,
> > and probably a few other colors i've missed/forgotten about. What do these
> > colors represent? How are they used to group tasks/cache entries? Is what
> > they're actually for?
>
> Coloring usually means the laying out of data such that the data will
> not collide in the cache, usually the second (or third) level cache.
>
> Data references are virtual, most caches are physically tagged.  That
> means that where data lands in the cache is a function of the physical
> page address and offset within that page.  If the cache is what is called
> direct mapped, which means each address has exactly one place it can be
> in the cache, then page coloring becomes beneficial.  More on that in
> a second.  Most caches these days are set associative, which means there
> are multiple places the same cache line could be.  A 2 way set associative
> cache means there are 2 places, 4 way means there are 4, and so on.  The
> trend is that the last big cache before memory is at least 2 way and more
> typically 4 way set associative.  There is a cost with making it N-way
> associative, you have to run all the tag comparitors in parallel or
> you have unacceptable performance.  With shrinking transistors and high
> yields we are currently enjoying, the costs are somewhat reduced.
>
> So what's page coloring?  Suppose we have a 10 page address space and
> we touch each page.  As we touch them, the OS takes a page fault, grabs
> a physical page, and makes it part of our address space.  The actual
> physical addresses of those pages determine where the cache lines
> will land in the cache.  If the pages are allocated at random, worst
> case is that all 10 pages will map to the same location in the cache,
> reducing the cache effectiveness by 10x assuming a direct mapped cache,
> where there is only one place to go.   Page coloring is the careful
> allocation of pages such that each virtual page maps to a physical page
> which will be at a different location in the cache.  Linus doesn't like
> it because it adds cost to the page free/page alloc paths, they now have
> to go put/get the page from the right bucket.  He also says it's pointless
> because the caches are becoming enough associative that there is no need
> and he's mostly right.  Life can really suck on small cache systems that
> are direct mapped, as are some embedded systems, but that's life.  It's
> a tradeoff.
> --
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
