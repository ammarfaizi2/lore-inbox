Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131029AbQLaWDZ>; Sun, 31 Dec 2000 17:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbQLaWDQ>; Sun, 31 Dec 2000 17:03:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34059 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131029AbQLaWDH>; Sun, 31 Dec 2000 17:03:07 -0500
Date: Sun, 31 Dec 2000 13:32:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.10.10012312158050.23931-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10012311329100.1378-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Roman Zippel wrote:
> 
> On Sun, 31 Dec 2000, Linus Torvalds wrote:
> 
> > Let me repeat myself one more time:
> > 
> >  I do not believe that "get_block()" is as big of a problem as people make
> >  it out to be.
> 
> The real problem is that get_block() doesn't scale and it's very hard to
> do. A recursive per inode-semaphore might help, but it's still a pain to
> get it right.

Not true.

There's nothing unscalable in get_block() per se. The only lock we hold is
the per-page lock, which we must hold anyway. get_block() itself does not
need any real locking: you can do it with a simple per-inode spinlock if
you want to (and release the spinlock and try again if you need to fetch
non-cached data blocks).

Sure, the current ext2 _implementation_ sucks. Nobody has ever contested
that. 

Stop re-designing something just because you want to.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
