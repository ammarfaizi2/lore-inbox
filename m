Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbREOG5a>; Tue, 15 May 2001 02:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbREOG5U>; Tue, 15 May 2001 02:57:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53386 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262662AbREOG5E>;
	Tue, 15 May 2001 02:57:04 -0400
Date: Tue, 15 May 2001 02:57:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105150252171.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Richard Gooch wrote:

> > What happens if you create a buffer cache entry? Does that
> > invalidate the page cache one? Or do you just allow invalidates one
> > way, and not the other? And why=
> 
> I just figured on one way invalidates, because that seems cheap and
> easy and has some benefits. Invalidating the other way is costly, so
> don't bother, even if there were some benefits.

Cute.
	* create an instance in pagecache
	* start reading into buffer cache (doesn't invalidate, right?)
	* start writing using pagecache
	* lose the page
	* try to read it (via pagecache)
Woops - just found a copy in buffer cache, let's pick data from it.
Pity that said data is obsolete...

> So what happens if I dd from the block device and also from a file on
> the mounted FS, where that file overlaps the bnums I dd'ed? Do we get
> two copies in the page cache? One for the block device access, and one
> for the file access?

Yes.

