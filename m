Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292364AbSBBT3n>; Sat, 2 Feb 2002 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292366AbSBBT3e>; Sat, 2 Feb 2002 14:29:34 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:52900 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S292364AbSBBT3U>; Sat, 2 Feb 2002 14:29:20 -0500
Date: Sat, 02 Feb 2002 11:27:44 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-id: <0e9f01c1ac1f$b0d99e20$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0201301018580.800-100000@segfault.osdlab.org>
 <0a1e01c1a9cc$15e164c0$6800000a@brownell.org>
 <20020202002309.GD10313@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You have a PCI device that is the USB controller. You create a child of 
> > > that represents the USB bus. Then, devices are added as children of that.
> > > 
> > > Logically, couldn't you skip that extra layer of indirection and make USB 
> > > devices children of the USB controller? Or, do you see benefit in the 
> > > explicit distinction?
> > 
> > Since I don't see a benefit from that extra indirection, I was going to ask
> > almost that same question ... :)
> 
> But that device _is_ a USB device, it's a root hub.  It has bandwidth
> allocation, strings, a configuration, and other stuff.  It operates a
> bit differently from other hubs, but it's pretty close to the real
> thing.

Sure it's a hub (with the firmware provided by Linux :) but it's also a
PCI device.  The extra indirection is the one which makes the root
hub be a different device than the PCI device.  It'll have some
attributes that relate to its PCI device role, others that relate to
the more specialized "USB root hub" role.


> > But it's broader than that:  Why shouldn't that apply to _every_ kind
> > of bridge, not just USB controllers ("PCI-to-USB bridges")?
> > 
> > For example, with PCI why should there ever be "pci0" directories,
> > with children "00:??.?" and "pci1"?
> 
> It's information that is useful to the user.

Not useful to this user ... and I'm unclear why it'd be useful to
any others.  Initialization order can change, and embedding
it in device naming is basically just trouble.


>      If presented with a tree
> that doesn't have the pci? and usb directories, it just looks like a
> random tree of different numbers.

Just like most directories.  That's why I commented that it might
be desirable to have any typing information just show up as one
of the directory attributes.

- Dave


