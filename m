Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270699AbRHKATE>; Fri, 10 Aug 2001 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270698AbRHKASz>; Fri, 10 Aug 2001 20:18:55 -0400
Received: from rj.SGI.COM ([204.94.215.100]:30694 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S270702AbRHKASt>;
	Fri, 10 Aug 2001 20:18:49 -0400
Message-Id: <200108110018.f7B0I7W12128@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ben LaHaise <bcrl@redhat.com>
cc: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
Subject: Re: [PATCH] 64 bit scsi read/write 
In-Reply-To: Message from Ben LaHaise <bcrl@redhat.com> 
   of "Fri, 10 Aug 2001 16:02:29 EDT." <Pine.LNX.4.33.0108101557480.5531-100000@touchme.toronto.redhat.com> 
Content-Transfer-Encoding: 8bit
Date: Fri, 10 Aug 2001 19:18:07 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 10 Aug 2001, Ragnar Kjxrstad wrote:
> 
> > * >1TB devices over scsi.
> >   * /proc/partitions report incorrect sizes
> 
> Okay, interesting, I'll have to dig through that.
> 
> >   * mkreiserfs fails: "mkreiserfs: can not create filesystem on that
> >     small device (0 blocks)."
> >   * mkfs.xfs fails: "warning - cannot set blocksize on block device
> >     /dev/sdb: Invalid argument"
> 
> Someone needs to patch reiserfs/xfs.

XFS should continue with the mkfs after this, this is a 'warning' not an
error. We do use the BLKGETSIZE ioctl to get the device size. The function
which needs modifying is findsize() in cmd/xfsprogs/libxfs/init.c

Steve

> 
> >   I assume both mkreiserfs and mkfs.xfs use ioctl to get the size
> >   of the device, and that ioctl uses an unsigned int? How is
> >   userspace supposed to get the devicesize of >2GB devices with
> >   your code?
> 
> See the e2fsprogs patch (again, below).
> 
> >   * mkfs.ext2 makes the machine panic after a while.
> >     Unfortenately I don't have the panic message anymore, and at the
> >     moment I don't have the hardware to redo the test.
> 
> That would've been a useful bug report.
> 
> >   * fdisk bails out with 'Unable to read /dev/sdb'
> 
> MS-DOS partitions do not work on huge devices, so at best we can make it
> report a more informative message.
> 
> The amount of response I've received is absolutely dismal for a feature
> lots of people are clamouring on about needing.  At this rate, I doubt
> we'll have any of it decently tested before we start advertising it as a
> supported feature in 2.6.
> 
> 		-ben
> 
> -- 
> "The world would be a better place if Larry Wall had been born in
> Iceland, or any other country where the native language actually
> has syntax" -- Peter da Silva
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


