Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbREaLwP>; Thu, 31 May 2001 07:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbREaLwF>; Thu, 31 May 2001 07:52:05 -0400
Received: from [24.93.35.222] ([24.93.35.222]:33674 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S263079AbREaLvx>;
	Thu, 31 May 2001 07:51:53 -0400
Date: Thu, 31 May 2001 06:51:13 +0000 (GMT)
From: Jeff Meininger <jeffm@boxybutgood.com>
To: Jens Axboe <axboe@kernel.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: determining size of cdrom
In-Reply-To: <20010530231509.D25129@suse.de>
Message-ID: <Pine.LNX.4.21.0105310641120.296-100000@mangonel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > long sectors = 0;
> > ioctl(fd, BLKGETSIZE, &sectors);
> > /* sectors varies (never seems accurate) and is usually LONG_MAX */
> 
> At least this is the capacity as reported by the drive when we read the
> table of contents.

Am I interpreting the return value incorrectly?  I nearly always get
2147483647 (LONG_MAX?).



> > ioctl(fd, BLKSSZGET, &ssz);
> > /* ssz varies, and is usually 1024. (shouldn't it be 2048?)  */
> 
> Someone added a block size setting of 1024 to ide revalidate, and this
> has screwed us for a awhile (ie atapi dvd-ram breaks). Recent ac has the
> correct stuff to reset it.

I'd like my app to work with a wide variety of kernels, including 2.2
kernels, so I guess I'll have to avoid getting the sector size that
way.  Thanks for the tip.  :)



> > I didn't find anything that looked obvious to me in linux/cdrom.h, except
> > in the #ifdef __KERNEL__ section which I don't believe I can use from
> > user space.
> 
> You can do it from user space with CDROMREADTOCHDR/CDROMREATOCENTRY if
> you want, did you see those?

I've looked at those, but I don't see how I could calculate the disc size
from the information given in struct cdrom_tochdr and struct
cdrom_tocentry.  If I'm interpreting cdrom.h's interface correctly, the
best I'd be able to do is determine how many tracks, what type of data,
and where each track started (either in LBA or MSF).  



Any more ideas?  Perhaps I need to actually open /dev/cdrom and read it's
data to determine the size?  Maybe somewhere in the first 16 sectors (not
defined by iso9660) I can get the information I need?  It just seems that
I should be able to get the information from linux much more easily.

Thanks...
-Jeff M

