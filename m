Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRISVRP>; Wed, 19 Sep 2001 17:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274195AbRISVRK>; Wed, 19 Sep 2001 17:17:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60143 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274194AbRISVRA>;
	Wed, 19 Sep 2001 17:17:00 -0400
Date: Wed, 19 Sep 2001 17:17:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010919225505.P720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109191655560.901-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
> > There certainly _are_ differences  (e.g. in handling the moment
> > when you close them).
> 
> there aren't difference, only thing that matters is: "is that an fs
> or a blkdev". SWAP/RAW/FILE is useless.

fsync_dev() is not needed for raw devices or swap.  It _is_ needed for
file access.

> > > (infact I never had a single report), but well we'll verify that in
> > 
> > Richard, is that you?  What had you done with real Andrea?
> 
> You also screwup things sometime (think the few liner you posts to l-k
> after your cleanups).  Those are minor bugs, so I'm not going to panic

Certainly.

> on them (ramdisk works not by luck), this is what I meant, and they will

Sorry, it just sounded so..., well, familiar... Couldn't resist ;-) (BTW,
Richard, _what_ political whatever could be found in that?)

> be fixed shortly somehow, and many thanks for the further auditing.

Andrea, had you seen the off-list mail (cc: to you and Linus)?  The main
problem I have right now is that I don't see how you manage to guarantee
that during the last ->release() no requests are going in.  Old code
did unconditional invalidate_buffers() to wipe out all buffer_heads when
device is finally closed.  Absense of pagecache sources was guaranteed
by umount() - by the time when we release ->s_bdev all pages are gone.
How do you deal with that in the current code?

