Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbSAGRyS>; Mon, 7 Jan 2002 12:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbSAGRyJ>; Mon, 7 Jan 2002 12:54:09 -0500
Received: from air-1.osdl.org ([65.201.151.5]:28290 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S284220AbSAGRyD>;
	Mon, 7 Jan 2002 12:54:03 -0500
Date: Mon, 7 Jan 2002 09:55:08 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Paul Jakma <paulj@alphyra.ie>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201051659040.15928-100000@dunlop.dub.ie.alphyra.com>
Message-ID: <Pine.LNX.4.33.0201070942310.867-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Paul Jakma wrote:

> On Fri, 4 Jan 2002, Dave Jones wrote:
>
> >  When devicefs is ready (or more to the point, the drivers become
> >  devicefs aware), something to the effect of ls -R /devices
> >  should be possible.
>
> how does devicefs differ from devfs? eg, on some of my systems i mount
> devfs on /devfs and an ls -l of it shows all the devices that
> currently have drivers that registered them.

It's actually driverfs ;). (I know it's confusing, I wanted devfs, but it
was already taken.)

It exports devices based on their locality. On my test box, I have this
output:

sh-2.05# find pci0/ -type d
pci0/
pci0/00:1f.4
pci0/00:1f.3
pci0/00:1f.2
pci0/00:1f.1
pci0/00:1f.0
pci0/00:02.0
pci0/00:00.0

Nodes are added by the bus driver as it enumerates the bus, before
device-specific drivers are loaded.

devfs groups devices based on device class (video, net, disk, etc). Adding
primitive support for this should be pretty easy to driverfs, though there
are many nasty details to work out.

Basically, each device already has a directory. When it registers with its
class subsystem (like networking), the subsystem creates a symlink:

class/net/1 -> pci0/00:02.0

(or something like that). It doesn't seem that there needs to be any
explicit devfs_register() in the driver. I could be wrong, but that's my
initial impression...

	-pat

