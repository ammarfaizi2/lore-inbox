Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290235AbSAOSiS>; Tue, 15 Jan 2002 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290241AbSAOSiI>; Tue, 15 Jan 2002 13:38:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:14863 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290235AbSAOSh7>;
	Tue, 15 Jan 2002 13:37:59 -0500
Date: Tue, 15 Jan 2002 10:34:32 -0800
From: Greg KH <greg@kroah.com>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115183432.GC27059@kroah.com>
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C442395.8010500@debian.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 14:45:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 01:41:57PM +0100, Giacomo Catenazzi wrote:
> 
> Russell King wrote:
> 
> 
> >I really don't see why hisax couldn't say "oh, you have an ISDN card with
> >IDs xxxx:xxxx, that's hisax type nn" and be done with it, rather than
> >needing to be told "pci id xxxx:xxxx type nn".  Have a look at
> >drivers/isdn/hisax/config.c and wonder how the hell you take some random
> >vendors PCI ISDN card and work out how to drive it under Linux.
> >
> >(For the record, the card was:
> >   1397:2bd0       - Cologne Chip Designs GmbH - HFC-PCI 2BD0 ISDN
> > and the driver requirements were:  hisax type 35 proto 2)
> >
> >Realistically, I don't think any autoconfigurator will solve such cases
> >until these areas can be fixed up reasonably.
> 
> 
> Autoconfigure cannnot solve this.
> The card is not in my database.
> To help user, you should tell the driver maintainer to add our card
> in the know pci devices. In this manner autoconfigure, hotplug and
> modutils can take easy use your card.

The hisax driver already has a MODULE_DEVICE_TABLE entry for it's pci
devices, and this data shows up in the modules.pcimap table in the
modules directory.

Russell, when /sbin/hotplug is part of the initramfs in 2.5, the driver
will automatically be loaded for your new card, IF you have all the
different modules already built.  You will not need autoconfigure, just
a good vendor kernel :)

Giacomo, please, please, please, just use the info in the
MODULE_DEVICE_TABLE entries for your autoconfigure program.  Don't try
to keep all of this data up to date by hand, just use the info that is
already in the kernel.  It is a battle you will always loose.  Automate
this process (David Brownell has made a proposal that will work for
you), and you will never have to generate those PCI and USB tables by
hand again.

One other autoconfigure problem that I don't think anyone has mentioned,
USB devices that only show up when they want to transfer data to/from
the host.  Like all of the Palm based devices.  They don't stay
connected long enough for a "probe all the busses" tool like
you are currently developing to detect.

thanks,

greg k-h
