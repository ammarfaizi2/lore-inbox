Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281197AbRKPDG5>; Thu, 15 Nov 2001 22:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281200AbRKPDGr>; Thu, 15 Nov 2001 22:06:47 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:17117 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281197AbRKPDGj>; Thu, 15 Nov 2001 22:06:39 -0500
Date: Thu, 15 Nov 2001 22:06:35 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200111160306.fAG36ZW05331@devserv.devel.redhat.com>
To: josn@josn.myip.org, Greg KH <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: rootfs on USB storage device
In-Reply-To: <mailman.1005878220.14858.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1005878220.14858.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Does anybody have a clue as to what the USB bus has to do with
> > > /dev/console?
> >
> > It's a timing issue, and has nothing to do with /dev/console.  If you
> > sit and spin before you try to mount the root fs, the USB subsystem will
> > have enough time to find the drive.  There's a few patches that do this
> > in the lkml archives.
> >
> > greg k-h
> 
> It does not seem so. I included several seconds of mdelay() (and lots of
> printk()'s) while I was debugging, and that didnt change a thing. I added
> a.o. 4 seconds of mdelay() right before the open(), and 2 seconds right
> after the open() and the two dup()'s. The storage device was detected at
> the beginning of that last delay. [...]

I think khubd needs to run to complete whole process and mdelay()
locks it out. You need something that calls schedule() for USB
detection to work. Try to use schedule_timeout() instead of mdelay().

-- Pete
