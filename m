Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbREZPjf>; Sat, 26 May 2001 11:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbREZPjZ>; Sat, 26 May 2001 11:39:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18194 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261471AbREZPjK>; Sat, 26 May 2001 11:39:10 -0400
Date: Sat, 26 May 2001 17:38:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526173847.C9634@athlon.random>
In-Reply-To: <20010526171459.Y9634@athlon.random> <Pine.LNX.4.21.0105260818150.3684-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105260818150.3684-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 26, 2001 at 08:23:00AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 08:23:00AM -0700, Linus Torvalds wrote:
> 
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> > 
> > I don't see where you fixed the deadlock in create_buffers, if you did
> > please show me which line of code is supposed to do that, I show you
> > below which lines of code in my patch should fix the wait_event deadlock
> > in create_buffers:
> 
> Andrea, look at the page_alloc() path, and the "don't loop forever if
> __GFP_IO isn't set and we're not making progress". That looks entirely
> sane.

yes, I was only talking about create_buffers, not __alloc_pages. That
patch can certainly address problems in alloc_pages.

> (and I like your patch that removes some more magic limits - I suspect the
> proper fix is the 5 lines from Rik's patch in page_alloc.c, and your patch
> together - amybody mind testing that out?)

Sounds the same to me.

> Oh, and I still _do_ think that we should rename the silly "async" flag as
> "can_do_io", and then use that to determine whether to do SLAB_KERNEL or
> SLAB_BUFFER. That would make more things able to do IO, which in turn
> should help balance things out.

getblk still needs to use SLAB_BUFFER, not sure how many callers will be
allowed to use SLAB_KERNEL, but certainly the "async" name was not very
appropriate to indicate if the bh allocation can fail or not.

Andrea
