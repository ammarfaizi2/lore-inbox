Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSITHlW>; Fri, 20 Sep 2002 03:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSITHlW>; Fri, 20 Sep 2002 03:41:22 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:51409 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261291AbSITHlT>; Fri, 20 Sep 2002 03:41:19 -0400
Subject: Re: Dont understand hdc=ide-scsi behaviour.
From: Miles Lane <miles.lane@attbi.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Reg Clemens <reg@dwf.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200209201646.00202.bhards@bigpond.net.au>
References: <200209192108.g8JL8iT6010419@orion.dwf.com>
	 <200209201646.00202.bhards@bigpond.net.au>
Content-Type: text/plain
Organization: 
Message-Id: <1032533179.4526.102.camel@firehose.megapathdsl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Sep 2002 07:46:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 23:46, Brad Hards wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 20 Sep 2002 07:08, Reg Clemens wrote:
> > I dont understand the behaviour of kernel 2.4.18 (and probably all others)
> > when I put the line
> > 		hdc=ide-scsi
> > on the load line.
> >
> > I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead
> > get it for BOTH hdc and hdd, the cdwriter and the zip drive.
> >
> > After starting this way (with hdc=ide-scsi), I find that
> > 	/dev/cdrom2 -> /dev/scd0
> > and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)
> There are two slightly different things happening, I think.
> 
> 1. When you say hdc=ide-scsi, you are telling the IDE system that you don't 
> want to use the normal IDE interfaces to userland (such as ide-cdrom), but 
> instead want all access to this device to be accessed through the SCSI 
> midlayer (and associated SCSI interfaces, like the sg and scd drivers). So 
> ide-scsi becomes the driver, instead of ide-cdrom. You should be able to see 
> this in /proc/ide/hdc/driver
> 
> 2. ide-scsi is greedy, and will grab any IDE device without a driver. ATAPI 
> floppy devices (hopefully) like your zip drive need the IDE floppy device 
> driver, which is probably not loaded. What does CONFIG_BLK_DEV_IDEFLOPPY 
> equal in your kernel config?
> 
> > I would EXPECT to get to them via /dev/hdd1 or /dev/hdd4.
> And you will, with the right driver loaded :-)
> 
> > Did I miss something or is this a bug????
> If you load ide-floppy before ide-scsi, and it still doesn't work, then there 
> is a bug.

Well, aren't things going to get even more confusing when we 
try to support devices like the Lacie DVD/CD Rewritable 
combo drive?  Are we going to do a better job of simply making 
all usable interfaces available, so we no longer need to switch
between drivers or twiddle driver load order?

	Miles

