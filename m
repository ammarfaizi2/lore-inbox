Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272693AbRISQMC>; Wed, 19 Sep 2001 12:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274033AbRISQLw>; Wed, 19 Sep 2001 12:11:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63362 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272693AbRISQLl>;
	Wed, 19 Sep 2001 12:11:41 -0400
Date: Wed, 19 Sep 2001 12:11:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109191205580.28824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Linus Torvalds wrote:

> 
> On Tue, 18 Sep 2001, Alexander Viro wrote:
> >
> > It can be modified so that combination with lazy-bdev and pipefs-like tree
> > would work.  And yes, most of the ugliness would just go away.
> 
> That's the part I like about the page-cache bdev patch. It has a lot of
> fairly ugly warts, but all of them seem to be really fixable with _other_
> cleanups, at which point only the good parts remain.

It's actually quite broken in several areas (== bunch of panicable rmmod
races, broken wrt umount(), trivially oopsable in ioctl() on ramdisk,
very suspicious in swapoff(2), etc.).  It _might_ be fixable, but I
would really like to see the patch that went into -pre11 separately from
the rest.  Andrea, could you send it to me?  In particular, I'm deeply
suspicious about changes in blkdev_put() in case of BDEV_FILE.

