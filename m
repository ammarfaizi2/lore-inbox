Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274021AbRISItJ>; Wed, 19 Sep 2001 04:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274022AbRISIs7>; Wed, 19 Sep 2001 04:48:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60873 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274021AbRISIsy>;
	Wed, 19 Sep 2001 04:48:54 -0400
Date: Wed, 19 Sep 2001 04:49:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre11aa1
In-Reply-To: <20010918230242.F720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109190420510.28824-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> Thanks also to Marcelo for promptly finding a problem in the vm rewrite,
> to Al Viro for having spotted promptly a silly bug in the
> blkdev-pagecache patch (see details on l-k) and for all the people
> who provided feedback over the last day.

I can add one more into the mix: what the hell had happened in rd.c?

a) you reintroduced the crap with rd_inodes[]
b) just try to call ioctl(fd, BLKFLSBUF) twice. Oops...
c) WTF with acrobatics around initrd_bd_op?  FWIW, initrd has no business
being a block device and both old and new variants are ugly, but what's
the point of adding extra tricks?
d) call ioctl(fd, BLKFLSBUF) and open the thing one more time before
closing fd.  Watch what happens.  It's broken by design.

I realize that you had that file modified in your tree, but bloody hell,
it doesn't mean "ignore any changes that happened in mainline kernel
without even looking at them".  As for the BLKFLSBUF...  How was it supposed
to work?

