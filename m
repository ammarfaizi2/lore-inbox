Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274650AbRIUCmY>; Thu, 20 Sep 2001 22:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274637AbRIUCmO>; Thu, 20 Sep 2001 22:42:14 -0400
Received: from [195.223.140.107] ([195.223.140.107]:26615 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274590AbRIUCmB>;
	Thu, 20 Sep 2001 22:42:01 -0400
Date: Fri, 21 Sep 2001 04:42:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921044222.X729@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0109201905520.5631-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0109202146280.5631-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109202146280.5631-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 09:50:52PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 09:50:52PM -0400, Alexander Viro wrote:
> 	Andrea, what's the point of making blkdev_get() bump ->bd_count
> in case of success and blkdev_put() - drop it?  We _do_ grab a reference
> before calling blkdev_get() - any place where we don't is an immediately
> oopsable hole both in the old an in the new tree.  Notice that you
> do down(&bdev->bd_sem) before that increment of refcount, so if caller
> doesn't hold a reference we are toast.  What's going on there?

I just wanted to make sure the bdev couldn't be released under us by
owning a reference for the whole duration of the blkdev_get/put. But
requiring the caller to hold the reference for us seems saner since the
caller will have to pass the bdev as parameter anyways, so yes it seems
superflous.

Andrea
