Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSKAUtT>; Fri, 1 Nov 2002 15:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265778AbSKAUtT>; Fri, 1 Nov 2002 15:49:19 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:38070 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265777AbSKAUtS>;
	Fri, 1 Nov 2002 15:49:18 -0500
Date: Fri, 1 Nov 2002 20:55:32 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
Message-ID: <20021101205532.GB1780@bjl1.asuk.net>
References: <20021031134315.GC6549@suse.de> <20021101113401.GE8428@suse.de> <3DC2D72B.B4D5707E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC2D72B.B4D5707E@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > As expected, the stock version O(N) insertion scan really hurts. Even
> > with 128 requests per list, rbtree version is far superior. Once bigger
> > lists are used, there's just no comparison whatsoever.
> > 
> 
> Jens,  the tree just makes sense.

Just a few comments about data structures - not important.

Technically I think that a priority queue, i.e. a heap (partially
ordered tree) is sufficient for the request queue.  I don't know the
request queue code well enough to be sure, though.

Both heaps and trees are O(N log N), the difference being that an
rbtree does a bit more constant-time work to balance the tree while
maintaining a stricter ordering.

If it was worth it (I suspect not), you can make a data structure
which has O(1) amortised insertion time for a number of common cases,
such as runs of ascending block numbers.  Seems a likely pattern for a
filesystem...

Implementing the latter would likely be a lot of work for little gain
though.

-- Jamie
