Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSA3BSy>; Tue, 29 Jan 2002 20:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSA3BSp>; Tue, 29 Jan 2002 20:18:45 -0500
Received: from air-1.osdl.org ([65.201.151.5]:5276 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S287840AbSA3BSc>;
	Tue, 29 Jan 2002 20:18:32 -0500
Date: Tue, 29 Jan 2002 17:19:29 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Greg KH <greg@kroah.com>
cc: Dave Jones <davej@suse.de>, <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driverfs support for USB - take 2
In-Reply-To: <20020130010921.GB22131@kroah.com>
Message-ID: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Greg KH wrote:

> On Wed, Jan 30, 2002 at 02:03:12AM +0100, Dave Jones wrote:
> > 
> >  > Yes, I need to have better names for the devices than just "usb_bus",
> >  > any suggestions?  These devices nodes are really the USB root hubs in
> >  > the USB controller, so they could just have the USB number as the name
> >  > like the other USB devices (001), but that's pretty boring :)
> > 
> >  "usb_root0" .. "usb_rootN" ?
> 
> Hm, that's a good idea, it would match the usbfs bus numbers which
> should keep people happy.

Would it be usb_rootN or usb_busN?

> >  btw, a script to marry the busid's from driverfs to lspci/lsusb
> >  output may be useful in the future especially if combined somehow
> >  with tree(1). Could be very handy when it gets time to debug
> >  those "My system won't suspend to disk" "What does /driver look like?"
> >  situations.
> 
> Ah, a lsdrivers program is needed! :)

I started writing an 'lsdev' program a while back. If I ever get some free 
time and feel like playing userspace again, I'll finish it along with a 
couple of other utilities. 

One of the things I fantasized about was making different bus 
'personalities' for it. So, you emulate lspci behavior with the same 
executable. And, extend it to other buses, so you could view all the 
devices of a particular bus type (and only those devices). 

This information will be known by devices as they are registered in the 
tree, and will be easy to export to userspace. So, one could do lspcmcia, 
lssbus, and *drum roll* lsisa. 

Now for the best part: instead of having to do lsdev -t pci etc, I was 
just going to hard link ls{$bus type} to lsdev and make it check what 
argv[0] was to decide how to behave. :) 

People hate that idea, and I admit it's twisted. But, there's something 
kinda cute about it. 

	-pat

