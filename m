Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281856AbRKRGhv>; Sun, 18 Nov 2001 01:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281857AbRKRGhk>; Sun, 18 Nov 2001 01:37:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281856AbRKRGhi>; Sun, 18 Nov 2001 01:37:38 -0500
Date: Sun, 18 Nov 2001 07:37:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ehrhardt@mathematik.uni-ulm.de, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011118073730.C25232@athlon.random>
In-Reply-To: <20011118051023.A25232@athlon.random> <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 17, 2001 at 10:24:44PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 10:24:44PM -0800, Linus Torvalds wrote:
> 
> On Sun, 18 Nov 2001, Andrea Arcangeli wrote:
> >
> > I also agree the patch shouldn't matter, but one suspect thing is the
> > fact add_to_swap_cache goes to clobber in a non atomic manner the page
> > lock.
> 
> .. you mean __add_to_page_cache(), not add_to_swap_cache().
> 
> And nope, not really. It does use plain stores to page->flags, and I agree
> that it is ugly, but if the page was locked before calling it, all the
> stores will be with the PG_lock bit set - and even plain stores _are_
> documented to be atomic on x86 (and on all other reasonable architectures
> too).

I know all is right if GCC just overwrites the page->flags with data
that keeps PG_locked set. But GCC doesn't guarantee that.  GCC can as
well do:

	flags = page->flags;
	page->flags = 0;

	change flags here

	page->flags = flags

probably gcc doesn't, but that's still a kernel bug.

Andrea
