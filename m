Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSA3CR0>; Tue, 29 Jan 2002 21:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSA3CRQ>; Tue, 29 Jan 2002 21:17:16 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:57032 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S288040AbSA3CRF>; Tue, 29 Jan 2002 21:17:05 -0500
Date: Tue, 29 Jan 2002 18:15:13 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@suse.de>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-id: <08cf01c1a933$f45ac460$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  > Yes, I need to have better names for the devices than just "usb_bus",
> > >  > any suggestions?  These devices nodes are really the USB root hubs in
> > >  > the USB controller, so they could just have the USB number as the name
> > >  > like the other USB devices (001), but that's pretty boring :)

Actually one of my criticisms of Greg's patch is that
it hides the actual device tree.   The root hub is easily
distinguishable, it's the topmost one in the tree!  There
should be no need to name it specially.

I'd really rather move away from the model which
exposes a USB bus as a flat non-hierarchical
setup, and move instead to a model reflects the
actual topology of the USB devices and hubs.


> > >  "usb_root0" .. "usb_rootN" ?
> > 
> > Hm, that's a good idea, it would match the usbfs bus numbers which
> > should keep people happy.
> 
> Would it be usb_rootN or usb_busN?

I'd rather see neither, and have the device names reflect
physical topology ... so they could make sense to users.

For example, if you plug a USB device into a particular
USB socket it would have a particular name, and that
name would show up in diagnostics.  So when something
goes flakey about the device, the diagnostic will be able
to completely identify it.  And likewise, when userspace
tools need to do something, they should be able to use
the same pathname each time, unless the devices got
re-cabled ... re-enumerating shouldn't affect those names.

The notion of a "bus number" is bothersome, since it's
a function only of the order of driver initialization, and that
isn't a "stable" way to identify anything.  Re-ordering
driver initialization shouldn't change device name.

- Dave



