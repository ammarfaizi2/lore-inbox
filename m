Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQLaCpp>; Sat, 30 Dec 2000 21:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLaCpg>; Sat, 30 Dec 2000 21:45:36 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:17085 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S131023AbQLaCpW>; Sat, 30 Dec 2000 21:45:22 -0500
Date: Sun, 31 Dec 2000 03:09:33 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Eric W. Biederman" <ebiederman@uswest.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <20001231020234.A15179@athlon.random>
Message-ID: <Pine.GSO.4.10.10012310241300.8887-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 31 Dec 2000, Andrea Arcangeli wrote:

> > estimate than just the data blocks it should not be hard to add an
> > extra callback to the filesystem.  
> 
> Yes, I was thinking at this callback too. Such a callback is nearly the only
> support we need from the filesystem to provide allocate on flush.

Actually the getblock function could be split into 3 functions:
- alloc_block: mostly just decrementing a counter (and quota)
- get_block: allocating a block from the bitmap
- commit_block: inserting the new block into the inode

This would be really useful for streaming, one could get as fast as
possible the block number and the data could be very quickly written,
while keeping the cache usage low. Or streaming directly from a device
to disk also wants to get rid of the data as fast as possible.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
