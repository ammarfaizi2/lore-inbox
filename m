Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281040AbRKCVOJ>; Sat, 3 Nov 2001 16:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281041AbRKCVN6>; Sat, 3 Nov 2001 16:13:58 -0500
Received: from peace.netnation.com ([204.174.223.2]:5382 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S281040AbRKCVNr>; Sat, 3 Nov 2001 16:13:47 -0500
Date: Sat, 3 Nov 2001 13:13:42 -0800
From: Simon Kirby <sim@netnation.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Something broken in sys_swapon
Message-ID: <20011103131342.A15365@netnation.com>
In-Reply-To: <20011103122344.A12059@netnation.com> <Pine.GSO.4.21.0111031529490.18001-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0111031529490.18001-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 03, 2001 at 03:31:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 03:31:25PM -0500, Alexander Viro wrote:

> On Sat, 3 Nov 2001, Simon Kirby wrote:
> 
> >                 kdev_t dev = swap_inode->i_rdev;
> >                 struct block_device_operations *bdops;
> > 
> >                 p->swap_device = dev;
> >                 set_blocksize(dev, PAGE_SIZE);
> > 
> > I don't know much at all about the inode structure, but doesn't this set
> > the block size of the originating filesystem containing the inode rather
> > than the block device that inode happens to be pointing to?  That would
> 
> man 2 stat
> 
> i_rdev is equivalent of st_rdev, i_dev - of st_dev.

Okay, would you see any other reason why my root filesystem would
completely blow up after swapon /dev/hdb2 when /dev/hdb no longer exists?

All I did was remove /dev/hdb and forget to take the swap entry out of
/etc/fstab.  On boot I got "attempt to access beyond end of device"
messages looping endlessly.  I tried once with / mounted rw (it looks
like Debian still has / mounted ro when it turns on swap), and lots of
filesystem corruption resulted.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
