Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVKCSuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVKCSuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVKCSuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:50:46 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:26071 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1030430AbVKCSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:50:40 -0500
Date: Thu, 3 Nov 2005 19:51:04 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs for /dev/console with udev?
Message-ID: <20051103185104.GY23316@pengutronix.de>
References: <20051102222030.GP23316@pengutronix.de> <200511022140.25268.rob@landley.net> <20051103064727.GR23316@pengutronix.de> <200511031138.10414.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200511031138.10414.rob@landley.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 11:38:09AM -0600, Rob Landley wrote:
> No, you just need a statically linked init program.  (Which can be a shell 
> script using a statically linked shell.  For testing purposes it can be 
> statically linked against glibc, it'll just be a bloated pig.)

I'll try that. 

> You also have the option of putting a single static node (console) in the /dev 
> directory you're going to overmount.  It shouldn't hurt anything at present.  
> And if nothing else, it'll confirm where it's trying to get the sucker 
> from...

Well, that only works with root permissions.

> > Seems 
> > like I'll have to do some deeper investigation of klibc; last time I
> > looked it didn't even compile for ARCH=um.
> 
> Klibc didn't, or the kernel didn't?

The kernel works pretty good with 2.6.14; I can now do 'make world' in
PTXdist and get a rootfs for the ARM and do 'make world NATIVE=1' and
'make run NATIVE=1' and the same thing builds for x86 and starts in a
console. klibc didn't compile for ARCH=um. 

> > Is there any other known possibility to get just these two device nodes
> > in an automatic way?
> 
> From initramfs, you could try:
> 
> mount -t sysfs /sys /sys
> CDEV=`cat /sys/class/tty/console`
> mknod /dev/console c $(echo $CDEV | sed 's/:.*//') \
>   $(echo $CDEV | sed 's/.*://')
> 
> Bit of a chicken and egg problem if it refuses to run /init if it's not 
> already there, though.  We're heading towards fully dynamic devices, but not 
> quite there yet...

All that means that I need some libc and tools linking against it (or
static tools)... 

> > I'm trying to get rid of devfs, and udev works just 
> > fine. The only thing not solved yet is how to get the beast started
> > without /dev/console and /dev/null. I don't want to create the nodes
> > statically, because that's only possible with root permissions.
> 
> You don't need root access to make an initramfs configuration text file. :)

That was the idea ;) But it seems that if I buy initramfs I'll have to
buy doing the mknod and rootfs mounting stuff from early userspace as
well... 

> > Some background: I'm building root filesystems for embedded systems with
> > PTXdist; the user is able to build the whole thing without root
> > permissions; either with a cross compiler and mount it via NFS or build
> > a JFFS2 image, or, with one switch, build and run it with an uml kernel.
> 
> I did something like that, only from scratch:
> http://www.landley.net/code/firmware
> 
> I'll probably release version 0.8.10 later today.  (Still need to make an 
> installer for the bootable version before I can call it 0.9...)

I'll have a look :)

Thx, 

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

