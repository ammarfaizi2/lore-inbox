Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284477AbRLMRsJ>; Thu, 13 Dec 2001 12:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284479AbRLMRr7>; Thu, 13 Dec 2001 12:47:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16847 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284477AbRLMRrx>;
	Thu, 13 Dec 2001 12:47:53 -0500
Date: Thu, 13 Dec 2001 12:47:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <200112131724.fBDHOqu27735@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0112131242470.19799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Dec 2001, Richard Gooch wrote:

> Al, I came up with a proposed solution for this race days ago. After
> switching to try_inc_mod_count() (based on your first comments), you
> haven't responded with whether you still see a problem with this
> approach (your first message implied there were multiple problems).

Sigh...  Please, take a look at sys_swapon() or get_sb_bdev() or devfs_open().
Any version starting with 2.3.46-pre<something> when devfs went into the
tree.

All of them have ->bd_op set from devfs handle and follow that with
blkdev_get() - directly or indirectly via def_blk_fops.open().  That
function blocks.  Think what will happen if entry is removed while
blkdev_get() sleeps on semaphore.

BTW, I'd described that to you several times - last one couple of
months ago on l-k.

