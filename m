Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSKBUPq>; Sat, 2 Nov 2002 15:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSKBUPq>; Sat, 2 Nov 2002 15:15:46 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:61369 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261364AbSKBUPp>;
	Sat, 2 Nov 2002 15:15:45 -0500
Date: Sat, 2 Nov 2002 20:22:08 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
Message-ID: <20021102202208.GA5339@bjl1.asuk.net>
References: <20021031134315.GC6549@suse.de> <20021101113401.GE8428@suse.de> <3DC2D72B.B4D5707E@digeo.com> <20021101205532.GB1780@bjl1.asuk.net> <20021102085947.GJ807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102085947.GJ807@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> > If it was worth it (I suspect not), you can make a data structure
> > which has O(1) amortised insertion time for a number of common cases,
> > such as runs of ascending block numbers.  Seems a likely pattern for a
> > filesystem...
> 
> Fibonacci heaps, for instance. I looked into that as well. However, it's
> actually more important to have (if possible) O(1) extraction than
> insert. Extraction is typically run from interrupt context, when a
> driver wants to requeue more requests because it has completed one (or
> some). That was a worry with the rbtree solution. The linked list may
> have had sucky O(N) insert, but extraction was a nice O(1). So far I
> haven't been able to notice any regression in this area, regardless.

There's a skip list variant which offers O(1) extraction from the head
of the list, and probabilistic O(log n) insertion, fwiw.

-- Jamie
