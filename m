Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaCVx>; Sat, 30 Dec 2000 21:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135656AbQLaCVm>; Sat, 30 Dec 2000 21:21:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129436AbQLaCVb>;
	Sat, 30 Dec 2000 21:21:31 -0500
Date: Sat, 30 Dec 2000 20:50:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Eric W. Biederman" <ebiederman@uswest.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <20001231020234.A15179@athlon.random>
Message-ID: <Pine.GSO.4.21.0012302027540.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Andrea Arcangeli wrote:

> On Sat, Dec 30, 2000 at 03:00:43PM -0700, Eric W. Biederman wrote:
> > To get ENOSPC handling 99% correct all we need to do is decrement a counter,
> > that remembers how many disks blocks are free.  If we need a better
> 
> Yes, we need to add one field to the in-core superblock to do this accounting.

And its meaning for 2/3 of filesystems would be?

> > estimate than just the data blocks it should not be hard to add an
> > extra callback to the filesystem.  
> 
> Yes, I was thinking at this callback too. Such a callback is nearly the only
> support we need from the filesystem to provide allocate on flush. Allocate on
> flush is a pagecache issue, not really a filesystem issue. When a filesystem

I _doubt_ it. If it is a pagecache issue it should apply to NFS. It should
apply to ramfs. It should apply to helluva lot of filesystems that are not
block-based. Pagecache doesn't (and shouldn't) know about blocks.

> doesn't implement such callback we can simply get_block(create) at pagecache
> creation time as usual.

Umm... You do realize that get_block is _not_ visible on pagecache level?
Sure thing, filesystem should be free to use whatever functions it wants
for address_space methods. No arguments here. It should be able whatever
callbacks these functions expect. If filesystem doesn't implement reservation
it should use functions that do not expect such argument. That's it. No
need to invent new methods or shoehorn all block filesystems into the same
scheme.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
