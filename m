Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRCURRz>; Wed, 21 Mar 2001 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131702AbRCURRp>; Wed, 21 Mar 2001 12:17:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50075 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131669AbRCURRa>;
	Wed, 21 Mar 2001 12:17:30 -0500
Date: Wed, 21 Mar 2001 12:16:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
In-Reply-To: <99am8l$8mk$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0103211203090.739-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Mar 2001, Linus Torvalds wrote:

> The big case seems to be ext2_get_block(), we'll fix that early in
> 2.5.x. I think Al already has patches for it.

Since the last August ;-) Bitmaps handling is a separate story (it got
less testing) but with the ->gfp_mask in tree it will be much simpler.
I'll port these patches to current tree if anyone is interested - all
infrastructure is already there, so it's only code in fs/ext2/* is touched.

Obext2: <plug>
Guys, help with testing directories-in-pagecache patch. It works fine
here and I would really like it to get serious beating.
Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-b-S2.gz (against
2.4.2, but applies to 2.4.3-pre* too).
</plug>

(Linus, if you want me to mail it to you - just tell; comments on the
style would be _very_ welcome)

> As to lseek, that one should probably get the inode semaphore, not the
> kernel lock. 

lseek() is per-file, so ->i_sem seems to be strange... I really don't see
why do we want a blocking semaphore there - spinlock (heck, even global
spinlock) should be OK, AFAICS. All we really want is atomic assignment
for 64bit and atomic += for the same beast.
							Cheers,
								Al

