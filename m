Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRKOKnQ>; Thu, 15 Nov 2001 05:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKOKnG>; Thu, 15 Nov 2001 05:43:06 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:26541 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278959AbRKOKmv>; Thu, 15 Nov 2001 05:42:51 -0500
Message-Id: <5.1.0.14.2.20011115102535.03879510@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 15 Nov 2001 10:42:44 +0000
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011114225524.Z5739@lynx.no>
In-Reply-To: <20011115003434.A25883@node0.opengeometry.ca>
 <3BF23D01.F7E879E8@evision-ventures.com>
 <200111142041.fAEKfBN15594@oboe.it.uc3m.es>
 <20011115003434.A25883@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:55 15/11/01, Andreas Dilger wrote:
>On Nov 15, 2001  00:34 -0500, William Park wrote:
> > Judging by 'driver/block/nbd.c', it counts by BLOCK_SIZE=1204
> > (BLOCK_SIZE_BITS=10), even though you can set the block size to
> > [512,1024,...,PAGE_SIZE=4096].  Since NBD counts this 1KB block using
> > 'u64' integer, the ultimate size of filesystem is determined by the
> > kernel block device support.
> >
> > Looking at 'fs/block_dev.c', you can set the block size to
> > [512,1024,...,PAGE_SIZE=4096] also.  But, 'max_block()' returns block
> > count in whatever block size of the device, not in BLOCK_SIZE:
>
>Sadly, while you _might_ be able to change the BLOCK_SIZE to be something
>other than 1kB, there are probably so many places that assume a 1kB size
>that you will need a lot of fixing.  I'm not saying that fixing these
>things is bad (it would actually be good for many reasons), but just a
>heads-up that changing the BLOCK_SIZE define _probably_ won't get you 8TB
>devices (maybe a broken system, or corrupt fs instead).  Use caution.

I changed BLOCK_SIZE back in the 2.4.0-test8 to 512 and had to do some 
modifications to drivers/ide, drivers/scsi, fs/partitions and to fs/ext2 to 
get it to work (patch is 10kiB so not too bad but it doesn't deal with the 
MD driver nor with any of the devices/fs I don't actually use). It then 
worked nicely for me. (Only minor problem with floppy disk resulting in a 
block size error from ll_rw_block but it always went ahead and worked after 
outputting the error.)

And yes, the fixes needed are mostly because of assumptions about 
BLOCK_SIZE being 1024 bytes... If anyone is interested in having a look, 
the now outdated patch is available on the web:

http://www-stu.christs.cam.ac.uk/~aia21/linux/blksize512.patch

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

