Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSANW7o>; Mon, 14 Jan 2002 17:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289149AbSANW7Z>; Mon, 14 Jan 2002 17:59:25 -0500
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:30117 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289140AbSANW7S>; Mon, 14 Jan 2002 17:59:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Alexander Viro <viro@math.psu.edu>
Subject: Re: Hardwired drivers are going away?
Date: Mon, 14 Jan 2002 09:57:16 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020114131050.E14747@thyrsus.com> <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu> <20020114151748.B19776@thyrsus.com>
In-Reply-To: <20020114151748.B19776@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114225917.YZIK8351.femail35.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 03:17 pm, Eric S. Raymond wrote:
> Alexander Viro <viro@math.psu.edu>:
> > But it still leaves you with tristate - instead of yes/module/no it's
> > yes/yes, but don't put it on initramfs/no.  However, dependencies become
> > simpler - all you need is "I want this, that and that on initramfs" and
> > the rest can be found by depmod (i.e. configurator doesn't have to deal
> > with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
> > (== can't be M)").
>
> Actually I think we may no longer be in tristate-land.  Instead, some
> devices have the property "This belongs in initramfs if it's configured
> at all" -- specifically, drivers for potential boot devices.  Everything
> else can dynamic-load after boot time.

No.  Just about every block device there is is a POTENTIAL root device.  Boot 
and root devices are seperate things (just as boot and root partitions are 
seperate things.)  Your kernel can decompress from an enternet boot prom if 
you're clever enough about.  You could theoretically have your root device on 
a USB storage device.  Booting from CD-ROM is fairly common, yet not 
something you normally want your installed kernel to have compiled in.

I've even seen kernels that load via tftp, including an initial ram disk, and 
either never have local storage of any kind or use it purely as swap space.  
(Why?  Really really really easy system administration of multiple terminals 
in libraries and kiosks and such.  It breaks, you drop in a new one (don't 
even have to image it).  No local hard drive liminates the #1 cause of system 
failure.  And there's no way an end-user can screw up its configuration in a 
way a reboot won't fix.)

What's interesting is what devices the root partition IS going to live on and 
this has NOTHING to do with the device itself.  It can be any device any 
normal partition lives on.  You can have IDE and SCSI in the same system.  
You can have hard drives, CD-ROM drives, and floppies.  The fact you can boot 
off of an IDE cd-rom doesn't mean you will, or that's how you want to 
configure your kernel.

When manually configuring, you select this.  And if the autoprober isn't 
smart enough to figure out what your root device is, it needs to be fixed.

Rob
