Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbQLaRnS>; Sun, 31 Dec 2000 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbQLaRnJ>; Sun, 31 Dec 2000 12:43:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1030 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130151AbQLaRnA>; Sun, 31 Dec 2000 12:43:00 -0500
Date: Sun, 31 Dec 2000 09:12:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, Roman Zippel <zippel@fh-brandenburg.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.21.0012311147420.5932-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012310911240.3256-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Alexander Viro wrote:
> 
> On Sun, 31 Dec 2000, Linus Torvalds wrote:
> 
> > The other thing is that one of the common cases for writing is consecutive
> > writing to the end of the file. Now, you figure it out: if get_block()
> > really is a bottle-neck, why not cache the last tree lookup? You'd get a
> > 99% hitrate for that common case.
> 
> Because it is not a bottleneck. The _real_ bottleneck is in ext2_new_block().
> Try to profile it and you'll see.
> 
> We could diddle with ext2_get_block(). No arguments. But the real source of
> PITA is balloc.c, not inode.c. Look at the group descriptor cache code and
> weep. That, and bitmaps handling.

I'm not surprised. Just doign pre-allocation 32 blocks at a time would
probably help. But that code really should be re-written, I think.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
