Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRI3SRt>; Sun, 30 Sep 2001 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273703AbRI3SRg>; Sun, 30 Sep 2001 14:17:36 -0400
Received: from [194.213.32.137] ([194.213.32.137]:7428 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273900AbRI3SRP>;
	Sun, 30 Sep 2001 14:17:15 -0400
Date: Thu, 27 Sep 2001 14:03:13 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [PATCH] invalidate buffers on blkdev_put
Message-ID: <20010927140312.A35@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0109242333240.21827-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0109242118540.29038-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0109242118540.29038-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Sep 24, 2001 at 09:21:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OK, not exactly nay, but...  What you are trying to do is a workaround
> > for problem that can be solved in somewhat saner way.  Namely, we can
> > make getblk() return buffres backed by pages from device page cache.
> 
> I now have the patches for this, but I have to fix up fs/block_dev.c to
> also honour the block size thing because otherwise the two are still not
> in sync.
> 
> I'll send out a test-patch later this evening, I hope.
> 
> > It's solvable, but not obvious.  It _does_ solve coherency problems between
> > device page cache and buffer cache (thus killing update_buffers() and its
> > ilk), but the last issue (new access path to page-private buffer_heads)
> > may be rather nasty.
> 
> It's certainly solvable, but it is also certainly very fraught with tons
> of small details. I'll be very happy if people end up looking through the
> patches _very_ critically (and don't even bother testing them if you don't
> have a machine where you can lose a filesystem or two).

Time to rename 2.4.10 to 2.5.0? ;-)
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

