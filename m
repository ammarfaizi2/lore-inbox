Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265903AbSKBIxd>; Sat, 2 Nov 2002 03:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265904AbSKBIxd>; Sat, 2 Nov 2002 03:53:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265903AbSKBIxb>;
	Sat, 2 Nov 2002 03:53:31 -0500
Date: Sat, 2 Nov 2002 09:59:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
Message-ID: <20021102085947.GJ807@suse.de>
References: <20021031134315.GC6549@suse.de> <20021101113401.GE8428@suse.de> <3DC2D72B.B4D5707E@digeo.com> <20021101205532.GB1780@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101205532.GB1780@bjl1.asuk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01 2002, Jamie Lokier wrote:
> Andrew Morton wrote:
> > Jens Axboe wrote:
> > > 
> > > As expected, the stock version O(N) insertion scan really hurts. Even
> > > with 128 requests per list, rbtree version is far superior. Once bigger
> > > lists are used, there's just no comparison whatsoever.
> > > 
> > 
> > Jens,  the tree just makes sense.
> 
> Just a few comments about data structures - not important.
> 
> Technically I think that a priority queue, i.e. a heap (partially
> ordered tree) is sufficient for the request queue.  I don't know the
> request queue code well enough to be sure, though.

I looked into that as well, and I do have a generic binomial heap
implementation that I plan on test as well.

> If it was worth it (I suspect not), you can make a data structure
> which has O(1) amortised insertion time for a number of common cases,
> such as runs of ascending block numbers.  Seems a likely pattern for a
> filesystem...

Fibonacci heaps, for instance. I looked into that as well. However, it's
actually more important to have (if possible) O(1) extraction than
insert. Extraction is typically run from interrupt context, when a
driver wants to requeue more requests because it has completed one (or
some). That was a worry with the rbtree solution. The linked list may
have had sucky O(N) insert, but extraction was a nice O(1). So far I
haven't been able to notice any regression in this area, regardless.

> Implementing the latter would likely be a lot of work for little gain
> though.

Indeed

-- 
Jens Axboe

