Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRIYEVZ>; Tue, 25 Sep 2001 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273769AbRIYEVQ>; Tue, 25 Sep 2001 00:21:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273783AbRIYEVH>; Tue, 25 Sep 2001 00:21:07 -0400
Date: Mon, 24 Sep 2001 21:21:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>
Subject: Re: [PATCH] invalidate buffers on blkdev_put
In-Reply-To: <Pine.GSO.4.21.0109242333240.21827-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109242118540.29038-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Sep 2001, Alexander Viro wrote:
>
> OK, not exactly nay, but...  What you are trying to do is a workaround
> for problem that can be solved in somewhat saner way.  Namely, we can
> make getblk() return buffres backed by pages from device page cache.

I now have the patches for this, but I have to fix up fs/block_dev.c to
also honour the block size thing because otherwise the two are still not
in sync.

I'll send out a test-patch later this evening, I hope.

> It's solvable, but not obvious.  It _does_ solve coherency problems between
> device page cache and buffer cache (thus killing update_buffers() and its
> ilk), but the last issue (new access path to page-private buffer_heads)
> may be rather nasty.

It's certainly solvable, but it is also certainly very fraught with tons
of small details. I'll be very happy if people end up looking through the
patches _very_ critically (and don't even bother testing them if you don't
have a machine where you can lose a filesystem or two).

Hopefully in another hour or two (but the first version is going to have
some ugly stuff in it still).

		Linus

