Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSAGTEt>; Mon, 7 Jan 2002 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbSAGTEk>; Mon, 7 Jan 2002 14:04:40 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51621 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285216AbSAGTEY>; Mon, 7 Jan 2002 14:04:24 -0500
Date: Mon, 7 Jan 2002 12:04:32 -0700
Message-Id: <200201071904.g07J4Wf02751@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Patrick Mochel <mochel@osdl.org>
Cc: Paul Jakma <paulj@alphyra.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201070942310.867-100000@segfault.osdlab.org>
In-Reply-To: <Pine.LNX.4.33.0201051659040.15928-100000@dunlop.dub.ie.alphyra.com>
	<Pine.LNX.4.33.0201070942310.867-100000@segfault.osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
> 
> On Sat, 5 Jan 2002, Paul Jakma wrote:
> 
> > On Fri, 4 Jan 2002, Dave Jones wrote:
> >
> > >  When devicefs is ready (or more to the point, the drivers become
> > >  devicefs aware), something to the effect of ls -R /devices
> > >  should be possible.
> >
> > how does devicefs differ from devfs? eg, on some of my systems i mount
> > devfs on /devfs and an ls -l of it shows all the devices that
> > currently have drivers that registered them.
> 
> It's actually driverfs ;). (I know it's confusing, I wanted devfs, but it
> was already taken.)
> 
> It exports devices based on their locality. On my test box, I have this
> output:
> 
> sh-2.05# find pci0/ -type d
> pci0/
> pci0/00:1f.4
> pci0/00:1f.3
> pci0/00:1f.2
> pci0/00:1f.1
> pci0/00:1f.0
> pci0/00:02.0
> pci0/00:00.0
> 
> Nodes are added by the bus driver as it enumerates the bus, before
> device-specific drivers are loaded.

This is in fact something that I've had planned for devfs as well: a
/dev/bus hierarchy.

> devfs groups devices based on device class (video, net, disk,
> etc). Adding primitive support for this should be pretty easy to
> driverfs, though there are many nasty details to work out.

Well, devfs itself doesn't lay things out, it's the drivers that do
this. My plan is to have /dev/scsi/host# become a symlink to something
like /dev/bus/pci0/slot1/function1 (a directory).

It still eludes me why a new device FS was developed when devfs
already has the mechanisms that are needed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
