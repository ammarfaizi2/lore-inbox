Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbQLaRWp>; Sun, 31 Dec 2000 12:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130306AbQLaRWf>; Sun, 31 Dec 2000 12:22:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11988 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130299AbQLaRWa>;
	Sun, 31 Dec 2000 12:22:30 -0500
Date: Sun, 31 Dec 2000 11:51:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Roman Zippel <zippel@fh-brandenburg.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012310812500.3084-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012311147420.5932-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Linus Torvalds wrote:

> The other thing is that one of the common cases for writing is consecutive
> writing to the end of the file. Now, you figure it out: if get_block()
> really is a bottle-neck, why not cache the last tree lookup? You'd get a
> 99% hitrate for that common case.

Because it is not a bottleneck. The _real_ bottleneck is in ext2_new_block().
Try to profile it and you'll see.

We could diddle with ext2_get_block(). No arguments. But the real source of
PITA is balloc.c, not inode.c. Look at the group descriptor cache code and
weep. That, and bitmaps handling.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
