Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbREZBuS>; Fri, 25 May 2001 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbREZBuJ>; Fri, 25 May 2001 21:50:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15410 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262526AbREZBtx>; Fri, 25 May 2001 21:49:53 -0400
Date: Sat, 26 May 2001 03:49:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
Message-ID: <20010526034922.O9634@athlon.random>
In-Reply-To: <20010526032741.M9634@athlon.random> <Pine.LNX.4.33.0105252133210.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252133210.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 09:38:36PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 09:38:36PM -0400, Ben LaHaise wrote:
> You're missing a few subtle points:
> 
> 	1. reservations are against a specific zone

A single zone is not used only for one thing, period. In my previous
email I enlighted the only conditions under which a reserved pool can
avoid a deadlock.

> 	2. try_to_free_pages uses the swap reservation

try_to_free_pages has an huge stacking under it, bounce
bufferes/loop/nbd/whatever being just some of them.

> 	3. irqs can no longer eat memory allocations that are needed for
> 	   swap

you don't even need irq to still deadlock.

> Note that with this patch the current garbage in the zone structure with
> pages_min (which doesn't work reliably) becomes obsolete.

The "garbage" is just an heuristic to allow atomic allocation to work in
the common case dynamically. Anything deadlock related cannot rely on
pages_min.

I am talking about fixing the thing, of course I perfectly know you can
hide it pretty well, but I definitely hate those kind of hiding patches.

> > The only case where a reserved pool make sense is when you know that
> > waiting (i.e. running a task queue, scheduling and trying again to
> > allocate later) you will succeed the allocation for sure eventually
> > (possibly with a FIFO policy to make also starvation impossible, not
> > only deadlocks). If you don't have that guarantee those pools
> > atuomatically become only a sourcecode and runtime waste, possibly they
> > could hide core bugs in the allocator or stuff like that.
> 
> You're completely wrong here.

I don't think so.

Andrea
