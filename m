Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274689AbRITXLp>; Thu, 20 Sep 2001 19:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274696AbRITXLf>; Thu, 20 Sep 2001 19:11:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52694 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274689AbRITXL0>;
	Thu, 20 Sep 2001 19:11:26 -0400
Date: Thu, 20 Sep 2001 19:11:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010921010340.L729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201905520.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Andrea Arcangeli wrote:

> 1) I am tentated to fix the initrd bug by just killing initrd blkdev,
> completly instead of going to mark PageSecure all the initrd pages.

Just put initrd_read(), initrd_release() and initrd_fops back and
switch file->f_op on rd_open() as it was in -pre10.  Maybe you
want to replace blkdev_put(inode->i_bdev, BDEV_FILE) in initrd_release()
with blkdev_close(inode, file), but that will be the same pretty soon.

It's really the simplest way to deal with that and it has a benefit
of being both straightforward and well-tested.

