Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272483AbRIKPhd>; Tue, 11 Sep 2001 11:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272485AbRIKPhX>; Tue, 11 Sep 2001 11:37:23 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28434 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272483AbRIKPhO>; Tue, 11 Sep 2001 11:37:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 17:44:36 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109110808150.8078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109110808150.8078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911153729Z16241-1367+14@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 05:12 pm, Linus Torvalds wrote:
> On Mon, 10 Sep 2001, Rik van Riel wrote:
> > >
> > > Pre-loading your cache always depends on some limited portion of
> > > prescience.
> >
> > OTOH, agressively pre-loading metadata should be ok in a lot
> > of cases, because metadata is very small, but wastes about
> > half of our disk time because of the seeks ...
> 
> I actually agree to some degree here. The main reason I agree is that
> meta-data often is (a) known to be physically contiguous (so pre-fecthing
> is easy and cheap on most hardwate) and (b) meta-data _is_ small, so you
> don't have to prefetch very much (so pre-fetching is not all that
> expensive).
> 
> Trying to read two or more pages of inode data whenever we fetch an inode
> might not be a bad idea, for example. Either we fetch a _lot_ of inodes
> (in which case the prefetching is very likely to get a hit anyway), or we
> don't (in which case the prefetching is unlikely to hurt all that much
> either). You don't easily get into a situation where you prefetch a lot
> without gaining anything.
> 
> We might do other kinds of opportunistic pre-fetching, like have "readdir"
> start prefetching for the inode data it finds. That miht be a win for many
> loads (and it might be a loss too - there _are_ loads that really only
> care about the filename, although I suspect they are fairly rare).

But see my post in this thread where I created a simple test to show that, 
even when we pre-read *all* the inodes in a directory, there is no great 
performance win.

Thinking about it some more, I can see that some optimization is possible for 
the 20% or so of the work that was devoted to reading in the inodes, but such 
optimization has the nature of physical readahead in the inode table.  Which 
would apply equally well to the file data itself.

--
Daniel
