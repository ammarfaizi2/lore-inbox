Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136037AbRBFAHV>; Mon, 5 Feb 2001 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136096AbRBFAHL>; Mon, 5 Feb 2001 19:07:11 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:9226 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S136090AbRBFAHA>; Mon, 5 Feb 2001 19:07:00 -0500
Date: Mon, 5 Feb 2001 18:06:46 -0600
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
Message-ID: <20010205180646.B32155@cadcamlab.org>
In-Reply-To: <3A7E1942.5090903@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7E1942.5090903@goingware.com>; from crawford@goingware.com on Mon, Feb 05, 2001 at 03:08:50AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Michael D. Crawford]
> I found I could mount three partitions on /mnt

Yes.  New feature, appeared in the 2.4.0test series, or shortly before.

> and they'd all show up as mounted at /mnt in the "mount" command, but
> if I unmounted one of them (only tried with the currently visible
> one), then it appeared that there were no filesystems mounted there,
> but I could continue umounting until the other two were gone.

util-linux gets rather confused by this feature.  They say newer
versions fix this.

> But I had the 2.10r util-linux sources on my machine and installed
> mount and umount from it, and I find that it gets it right mostly
> when I mount and unmount multiple things, with the exception that if
> /dev/sda5 was mounted before /dev/sda1, then if I give the command
> "umount /dev/sda5", sda1 is the one that gets unmounted rather than
> sda5, so it takes the most recently mounted filesystem rather than
> the one you specify.

I think this is a kernel limitation.  'umount' takes '/dev/sda5' and
turns it into '/mnt/test' and calls umount("/mnt/test").  The kernel
then unmounts whatever is on "top" of /mnt/test.

I don't think there's anything umount can do about this behavior.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
