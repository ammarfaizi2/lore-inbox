Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSAGTSJ>; Mon, 7 Jan 2002 14:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285347AbSAGTSA>; Mon, 7 Jan 2002 14:18:00 -0500
Received: from air-1.osdl.org ([65.201.151.5]:57474 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S285327AbSAGTRv>;
	Mon, 7 Jan 2002 14:17:51 -0500
Date: Mon, 7 Jan 2002 11:19:06 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Greg KH <greg@kroah.com>
cc: Dave Jones <davej@suse.de>, Paul Jakma <paulj@alphyra.ie>,
        <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <20020107185001.GK7378@kroah.com>
Message-ID: <Pine.LNX.4.33.0201071109490.28000-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Greg KH wrote:

> On Mon, Jan 07, 2002 at 07:11:03PM +0100, Dave Jones wrote:
> > On Mon, 7 Jan 2002, Patrick Mochel wrote:
> >
> > > One of the ideas that I've kicked around with some people here and the
> > > ACPI guys is the notion of trigger device enumeration from userspace
> > > completely.
> > >
> > > During the initramfs stage, a program (say devmgr) figures out what type
> > > of system you have, where the PCI buses are, etc. It tells the kernel this
> > > information, which then probes for existence, then loads drivers.
> >
> > Sounds remarkably like the work that Greg has been doing with hotplug
> > support.
>
> Yup :)
>
> But I wanted to rely on the existing PCI and USB core code to do the
> probing of the busses and devices, as it knows how to do this the best
> right now.  Whenever it finds a new device it calls out to /sbin/hotplug
> with the device info.  The userspace program at that location then loads
> the proper driver for the device, if it knows about it.  This is the
> same code and process that runs when the kernel is up and running today.
> No code duplication is a good thing :)
>
> And the /sbin/hotplug program knows about _all_ devices that the
> currently compiled kernel can handle due to the MODULE_DEVICE_TABLE tags
> in the drivers.
>
> See the linux-hotplug project's documentation for more info on this:
> 	http://linux-hotplug.sf.net/
> A paper and presentation about the linux-hotplug process:
> 	http://www.kroah.com/linux/
>
> dietHotplug, a _very_ tiny implementation of /sbin/hotplug which is was
> created exactly for the initramfs stage:
> 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.3.tar.gz

It's very closely related; kinda like kissing cousins.

/sbin/hotplug is called from the kernel only, right?

I see no reason to change that at all for notification of devices that are
plugged in/removed by suprise.

I was thinking, though, more along the lines of triggering the probe for
devices that the kernel has a tough time finding on its own. E.g. peer
Host/PCI bridges, batteries, etc.

	-pat

