Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLDUZe>; Mon, 4 Dec 2000 15:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLDUZZ>; Mon, 4 Dec 2000 15:25:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23255 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129183AbQLDUZS>;
	Mon, 4 Dec 2000 15:25:18 -0500
Date: Mon, 4 Dec 2000 14:54:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks  Re: test12-pre4
In-Reply-To: <20001204181621.E8700@redhat.com>
Message-ID: <Pine.GSO.4.21.0012041448320.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Stephen C. Tweedie wrote:

> Agreed.  However, is there any reason to have this as a separate
> function?  bforget() should _always_ remove the buffer from any inode
> queue.  You can make that operation conditional on (bh->b_inode !=
> NULL) if you want to avoid taking the lru lock unnecessarily.

I doubt it. bforget() is called, for example, when we deal with the
changed branch in ext2_get_block() (the thing had been partially read,
but then we've noticed that it had been changed under us). And I don't
think that brelse() would be a good thing there...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
