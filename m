Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284542AbRLMS0k>; Thu, 13 Dec 2001 13:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284541AbRLMS0V>; Thu, 13 Dec 2001 13:26:21 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29090 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284603AbRLMS0I>; Thu, 13 Dec 2001 13:26:08 -0500
Date: Thu, 13 Dec 2001 11:26:02 -0700
Message-Id: <200112131826.fBDIQ2J28188@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <Pine.GSO.4.21.0112131242470.19799-100000@weyl.math.psu.edu>
In-Reply-To: <200112131724.fBDHOqu27735@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0112131242470.19799-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Thu, 13 Dec 2001, Richard Gooch wrote:
> 
> > Al, I came up with a proposed solution for this race days ago. After
> > switching to try_inc_mod_count() (based on your first comments), you
> > haven't responded with whether you still see a problem with this
> > approach (your first message implied there were multiple problems).
> 
> Sigh...  Please, take a look at sys_swapon() or get_sb_bdev() or
> devfs_open().  Any version starting with 2.3.46-pre<something> when
> devfs went into the tree.

Wait a minute. Before poking holes at other code paths, can you please
answer the question I'm asking? I repeat: for the devfs revalidate
code, do you see any remaining problems if I increment the module
usage count?

If you want to point out other problem paths, that's fine. But please
answer specific questions so that progress can be made.

> All of them have ->bd_op set from devfs handle and follow that with
> blkdev_get() - directly or indirectly via def_blk_fops.open().  That
> function blocks.  Think what will happen if entry is removed while
> blkdev_get() sleeps on semaphore.

When you say "entry is removed", are you actually referring to a devfs
entry being removed? Or are you talking more generally about the
module being removed?
For the case where devfs_open() is running, the devfs entry remains
valid over the lifetime of the open(). In fact, it remains valid over
the lifetime of the dentry.

> BTW, I'd described that to you several times - last one couple of
> months ago on l-k.

And since then the refcounting code has gone in, and many of your old
concerns have been addressed. I'm trying to engage you in a productive
dialogue to resolve any remaining issues.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
