Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL3T4s>; Sat, 30 Dec 2000 14:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQL3T4i>; Sat, 30 Dec 2000 14:56:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:221 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130753AbQL3T4a>;
	Sat, 30 Dec 2000 14:56:30 -0500
Date: Sat, 30 Dec 2000 14:25:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre3 and poor reponse to RT-scheduled processes?
In-Reply-To: <92lbt4$rd$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012301414070.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 Dec 2000, Linus Torvalds wrote:

> There are other, equally likely, candidates for these kinds of stalls:
> 
>  - filesystem locks. Especially the ext2 superblock lock. You can easily
>    hit this one, as some ext2 functions actually do a lot of IO while
>    holding the lock.

Hmm... In 2.4 we can make the situation with superblock lock on ext2
much better. I didn't go the whole way down to spinlocks, but right now
I'm sitting on a box with modified ext2 that doesn't do _any_ IO in
protected parts of ext2_new_inode()/ext2_new_block(). I can try to
extract the relevant parts of the patch if you are interested (it also
got directories-in-pagecache stuff and better SMP threading of
get_block()/truncate()). The thing seems to be working fine and I see
no serious contention on lock_super(). Dunno if it's worth doing before
2.4.0, but since it has zero impact on the rest of tree (OK, zero except
that write_on_page() had been exported, but I could trivially get rid
of that)... Maybe 2.4.early would be a good idea.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
