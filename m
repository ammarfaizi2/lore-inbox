Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129083AbQJ3VXs>; Mon, 30 Oct 2000 16:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQJ3VXi>; Mon, 30 Oct 2000 16:23:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63375 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129083AbQJ3VXg>;
	Mon, 30 Oct 2000 16:23:36 -0500
Date: Mon, 30 Oct 2000 16:23:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.LNX.4.10.10010301256491.848-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0010301618160.1177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Linus Torvalds wrote:

> How about just changing ->sync_page() semantics to own the page lock? That
> sound slike the right thing anyway, no?

It would kill the ->sync_page(), but yes, _that_ might be the right thing ;-)

> I didn't actually miss it, I just looked at the users and decided that it
> looks like they should never have this issue. But I might have missed
> something. As far as I can tell, "read_cache_page()" is only used for
> meta-data like things that cannot be truncated.

invalidate_inode_pages().

> I'd really like to do these in the thing that locks the page, and make the
> rule be that the page locker needs to do the work. That's why I'd prefer
> to let the test be in the _caller_ of filemap_write_page(), as that's the
> point where we got the lock.

Fine with me, but then we would have to do it in try_to_swap_out() and
that would be Wrong Thing(tm) (e.g. because ->swapout() makes sense for
anonymous pages).

We could do it in filemap_swapout(), but the lock is taken by its caller,
so...
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
