Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSKKEA2>; Sun, 10 Nov 2002 23:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSKKEA2>; Sun, 10 Nov 2002 23:00:28 -0500
Received: from [195.223.140.107] ([195.223.140.107]:36741 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265426AbSKKEA1>;
	Sun, 10 Nov 2002 23:00:27 -0500
Date: Mon, 11 Nov 2002 05:06:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111040642.GA30193@dualathlon.random>
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF2BF5.5DD165DD@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:03:01PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > the slowdown happens in this case:
> > 
> >         queue 5 6 7 8 9
> > 
> > insert read 3
> > 
> >         queue 3 5 6 7 8 9
> 
> read-latency will not do that.

So what will it do? Must do something very much like what I described or
it is a noop period. Please elaborate.

>  
> > However I think even read-latency is more a workarond to a problem in
> > the I/O queue dimensions.
> 
> The problem is the 2.4 algorithm.  If a read is not mergeable or
> insertable it is placed at the tail of the queue.  Which is the
> worst possible place it can be put because applications wait on
> reads, not on writes.

O_SYNC/-osync waits on writes too, so are you saying writes must go to
the head because of that? reads should be not too bad at the end too if
only the queue wasn't that oversized when the merging is at its maximum.
Fix the oversizing of the queue, then read-latency will matter much
less.

Andrea
