Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290752AbSAYRr6>; Fri, 25 Jan 2002 12:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSAYRrt>; Fri, 25 Jan 2002 12:47:49 -0500
Received: from air-1.osdl.org ([65.201.151.5]:20881 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290752AbSAYRrg>;
	Fri, 25 Jan 2002 12:47:36 -0500
Date: Fri, 25 Jan 2002 09:48:50 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Greg KH <greg@kroah.com>
cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driverfs support for USB
In-Reply-To: <20020125021435.GA22080@kroah.com>
Message-ID: <Pine.LNX.4.33.0201250939070.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there. 

On Thu, 24 Jan 2002, Greg KH wrote:

> Hi,
> 
> Here's a first cut at adding driverfs support to the USB core code.
> This patch is against 2.5.3-pre5.  I've tested this out with the
> ehci-hcd and uhci drivers, and everything seems to work ok (it doesn't
> oops for me anymore :)
> 
> Right now all devices show up under the pci usb controller directory,
> just like usbfs works.  I'll be changing things so that hubs are iobus
> structures too, which should allow us to show the topology of the trees
> correctly (unless Pat changes all devices to be iobusses too :)

This looks good; thanks. A couple of things:

- For the record, in order to register a device in the device tree, it 
must know it's parent and have a unique, non-NULL ->bus_id. (Unique only 
for the on which it resides).

For an iobus to be registered, it must have a unique, non-NULL bus_id. If 
possible, it should know its parent and self. If an iobus is an orphan, it 
gets adopted by the system root. If it doesn't know it's self, well it has 
identity problems, but nothing fatal. :)

- You're naming every usb iobus 'usb'. Is it possible for there to be more 
than one usb controller on the same bus? 

> Pat,
> You need to export the put_device and put_iobus functions.  The end of
> this patch has that fix.  Also, put_iobus doesn't seem to remove the
> directory that iobus_register created (but a later call to
> iobus_register() seems to place everything in the same place again.)  Is
> this the correct thing that should be happening?

Thanks for catching that. It's fixed in my tree. I have a couple of other 
changes pending with Linus, so I'm waiting for him to release -pre6 to 
sync before I send him anything else :)

	-pat

