Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282232AbRK2BHp>; Wed, 28 Nov 2001 20:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRK2BHg>; Wed, 28 Nov 2001 20:07:36 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:6340 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S282232AbRK2BHa>;
	Wed, 28 Nov 2001 20:07:30 -0500
Message-Id: <5.1.0.14.2.20011129004931.04945e30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 29 Nov 2001 01:07:33 +0000
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.5.1-pre2 bio offset by one error in VIA IDE
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011128165530.L856@lynx.no>
In-Reply-To: <5.1.0.14.2.20011128232246.00aea8f0@pop.cus.cam.ac.uk>
 <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
 <15364.3457.368582.994067@gargle.gargle.HOWL>
 <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
 <20011128132000.T23858@suse.de>
 <5.1.0.14.2.20011128232246.00aea8f0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:55 28/11/01, Andreas Dilger wrote:
>On Nov 28, 2001  23:31 +0000, Anton Altaparmakov wrote:
> > I just booted my Athlon VIA KT133 chipset box with 2.5.1-pre2 only to
> > discover it dropped me into single user mode because /dev/hda2 could 
> not be
> > mounted. (Rebooting into 2.5.0+viro patch everything is ok, back into
> > 2.5.1-pre2 is broken...)
> >
> > Looking with hexedit /dev/hda2 when booted into 2.5.1-pre2 the first 
> sector
> > contains junk, the second sector contains the real data that I see as the
> > first sector when booted into 2.5.0+viro fix.
> >
> > That suggests to me there is an off by one error in the VIA IDE driver in
> > the 2.5.10pre2 kernel causing the partition to start one sector earlier
> > than it should.
>
>It may be an issue with your particular partition table having /dev/hda1
>being an odd number of 512-byte sectors long, but Jens' code only doing
>math on 1kB blocks.  Just speculation of course.  What does "fdisk -ul"
>tell you under the two kernels?

Both exactly the same:

Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
Units = sectors of 1 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *        63  31471334  15735636   83  Linux
/dev/hda2      31471335  35680364   2104515   83  Linux
/dev/hda3      35680365  39889394   2104515   82  Linux swap
/dev/hda4      39889395  80405324  20257965    f  Win95 Ext'd (LBA)
/dev/hda5      39889458  71360729  15735636   83  Linux
/dev/hda6      71360793  75264524   1951866    7  HPFS/NTFS

So everything always starts on same sector. And yes, hda2 starts on an odd 
sector.

However, that is not the explanation as the ntfs partition hda6 also starts 
with an odd sector but that works fine (using NTFS TNG to mount it and also 
looking at start of partition with hexedit).

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

