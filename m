Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLaACL>; Sat, 30 Dec 2000 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135244AbQLaAB7>; Sat, 30 Dec 2000 19:01:59 -0500
Received: from hermes.mixx.net ([212.84.196.2]:31506 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129348AbQLaABs>;
	Sat, 30 Dec 2000 19:01:48 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Generic deferred file writing
Date: Sun, 31 Dec 2000 00:12:03 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0012301628120.4082-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0012301628120.4082-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0012310029010A.00966@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2000, Alexander Viro wrote:
> Well, see above. I'm pretty nervous about breaking the ordering of metadata
> allocation. For pageout() we don't have such ordering. For write() we
> certainly do. Notice that reserving disk space upon write() and eating it
> later is _very_ messy job - you'll have to take care of situations when
> we reserve the space upon write() and get pageout do the real allocation.
> Not nice, since pageout has no way in hell to tell whether it is eating
> from a reserved area or just flushing the mmaped one. We could keep the
> per-bh "reserved" flag to fold that information into the pagecache, but
> IMO it's simply not worth the trouble. If some filesystems wants that -
> hey, it can do that right now. Just make ->prepare_write() do reservations
> and let ->commit_write() mark the page dirty. Then ->writepage() will
> eventually flush it.

This is a refinement of the idea and some abstraction like that is
clearly needed, and maybe that is exactly the right one.  For now I'm
interested in putting this on the table so that we can check the
stability and performance, maybe uncover come more bugs, then start
going after some of the things that need to be done to turn it into a
useful option.

P.S., I humbly apologize for writing (!offset && bytes == PAGE_SIZE)
when I could have just written (bytes == PAGE_SIZE).

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
