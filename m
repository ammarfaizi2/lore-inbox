Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSEIVgY>; Thu, 9 May 2002 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314385AbSEIVgX>; Thu, 9 May 2002 17:36:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53007 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314381AbSEIVgV>; Thu, 9 May 2002 17:36:21 -0400
Date: Thu, 9 May 2002 23:36:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <akpm@zip.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
Message-ID: <20020509213624.GF1988@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020508225603.GA11842@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0205090039060.12789-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I'm doing it during boot, and this is swap partition; it should
> > not have been accessed previously.
> > 
> > > >         bdev = bdget(kdev_t_to_nr(dev));
> > > >         if (!bdev) {
> > > >                 printk("No block device for %s\n", __bdevname(dev));
> > > >                 BUG();
> > > >         }
> > > >         printk("C");
> 
> blkdev_open(bdev, FMODE_READ, O_RDONLY, BDEV_RAW)

blkdev_open is 

fs.h:extern int blkdev_open(struct inode *, struct file *);

... I can't see how to use it in this context.

> > > >         if (!bh || (!bh->b_data)) {
> > > >                 return -1;
> 
> However, I would really suggest to open the bugger once, do all IO and
> then close it.  See how raw.c and friends deal with these problems.

Performance should not matter here.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
