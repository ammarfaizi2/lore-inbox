Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbREOKex>; Tue, 15 May 2001 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbREOKem>; Tue, 15 May 2001 06:34:42 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:60432 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262728AbREOKe1>; Tue, 15 May 2001 06:34:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Getting FS access events
Date: Tue, 15 May 2001 12:33:35 +0200
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0105150252171.19333-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105150252171.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01051512333507.24410@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 08:57, Alexander Viro wrote:
> On Tue, 15 May 2001, Richard Gooch wrote:
> > > What happens if you create a buffer cache entry? Does that
> > > invalidate the page cache one? Or do you just allow invalidates
> > > one way, and not the other? And why=
> >
> > I just figured on one way invalidates, because that seems cheap and
> > easy and has some benefits. Invalidating the other way is costly,
> > so don't bother, even if there were some benefits.
>
> Cute.
> 	* create an instance in pagecache
> 	* start reading into buffer cache (doesn't invalidate, right?)
> 	* start writing using pagecache
> 	* lose the page
> 	* try to read it (via pagecache)
> Woops - just found a copy in buffer cache, let's pick data from it.
> Pity that said data is obsolete...

That's because you left out his invalidate:

 	* create an instance in pagecache
 	* start reading into buffer cache (doesn't invalidate, right?)
 	* start writing using pagecache (invalidate buffer copy)
 	* lose the page
 	* try to read it (via pagecache)

Everthing ok.  As an optimization, instead of 'lose the page', do 'move 
page blocks to buffer cache'.

--
Daniel
