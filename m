Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSEIVq1>; Thu, 9 May 2002 17:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314398AbSEIVq0>; Thu, 9 May 2002 17:46:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55194 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314396AbSEIVpd>;
	Thu, 9 May 2002 17:45:33 -0400
Date: Thu, 9 May 2002 17:45:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@zip.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
In-Reply-To: <20020509213624.GF1988@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0205091744510.14806-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 May 2002, Pavel Machek wrote:

> Hi!
> 
> > > Well, I'm doing it during boot, and this is swap partition; it should
> > > not have been accessed previously.
> > > 
> > > > >         bdev = bdget(kdev_t_to_nr(dev));
> > > > >         if (!bdev) {
> > > > >                 printk("No block device for %s\n", __bdevname(dev));
> > > > >                 BUG();
> > > > >         }
> > > > >         printk("C");
> > 
> > blkdev_open(bdev, FMODE_READ, O_RDONLY, BDEV_RAW)
> 
> blkdev_open is 

grr...  s/open/get/ - sorry.

> fs.h:extern int blkdev_open(struct inode *, struct file *);
> 
> ... I can't see how to use it in this context.
> 
> > > > >         if (!bh || (!bh->b_data)) {
> > > > >                 return -1;
> > 
> > However, I would really suggest to open the bugger once, do all IO and
> > then close it.  See how raw.c and friends deal with these problems.
> 
> Performance should not matter here.

Yeah, but amount of places that mess with kdev_t should.

