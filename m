Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRISMHe>; Wed, 19 Sep 2001 08:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274040AbRISMHY>; Wed, 19 Sep 2001 08:07:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273358AbRISMHH>;
	Wed, 19 Sep 2001 08:07:07 -0400
Date: Wed, 19 Sep 2001 08:07:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre11aa1
In-Reply-To: <Pine.GSO.4.21.0109190420510.28824-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109190800590.28824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I can add one more into the mix: what the hell had happened in rd.c?
> 
> a) you reintroduced the crap with rd_inodes[]
> b) just try to call ioctl(fd, BLKFLSBUF) twice. Oops...
> c) WTF with acrobatics around initrd_bd_op?  FWIW, initrd has no business
> being a block device and both old and new variants are ugly, but what's
> the point of adding extra tricks?
> d) call ioctl(fd, BLKFLSBUF) and open the thing one more time before
> closing fd.  Watch what happens.  It's broken by design.
> 
> I realize that you had that file modified in your tree, but bloody hell,
> it doesn't mean "ignore any changes that happened in mainline kernel
> without even looking at them".  As for the BLKFLSBUF...  How was it supposed
> to work?


BTW, what's to stop shrink_cache() from picking a page out of ramdisk
pagecache and calling ->writepage() on it?  The thing will immediately
get dirtied again, AFAICS (blkdev_writepage() -> submit_bh() -> ... ->
rd_make_request() -> rd_blkdev_pagecache(WRITE,...) -> SetPageDirty()).

If you get a lot of stuff in ramdisks, things can get rather insteresting...

