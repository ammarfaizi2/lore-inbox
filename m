Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281194AbRKPCcu>; Thu, 15 Nov 2001 21:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKPCcl>; Thu, 15 Nov 2001 21:32:41 -0500
Received: from a23096.upc-a.chello.nl ([62.163.23.96]:22150 "EHLO ds9.galaxy")
	by vger.kernel.org with ESMTP id <S281194AbRKPCcb>;
	Thu, 15 Nov 2001 21:32:31 -0500
Date: Fri, 16 Nov 2001 03:32:24 +0100 (CET)
From: Jos Nouwen <josn@josn.myip.org>
To: Greg KH <greg@kroah.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: rootfs on USB storage device
In-Reply-To: <20011114210745.A8285@kroah.com>
Message-ID: <Pine.LNX.4.31.0111160320110.29875-100000@ds9.galaxy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Greg KH wrote:

> On Thu, Nov 15, 2001 at 04:22:33AM +0100, Jos Nouwen wrote:
> >
> > Does anybody have a clue as to what the USB bus has to do with
> > /dev/console?
>
> It's a timing issue, and has nothing to do with /dev/console.  If you
> sit and spin before you try to mount the root fs, the USB subsystem will
> have enough time to find the drive.  There's a few patches that do this
> in the lkml archives.
>
> thanks,
>
> greg k-h

It does not seem so. I included several seconds of mdelay() (and lots of
printk()'s) while I was debugging, and that didnt change a thing. I added
a.o. 4 seconds of mdelay() right before the open(), and 2 seconds right
after the open() and the two dup()'s. The storage device was detected at
the beginning of that last delay. Me thinks this is related to the open().
I added a total of 10 seconds of mdelay() between do_basic_setup() (where
the usb is initialized) and the open(). That is much more time than it
takes to init the USB storage device.

