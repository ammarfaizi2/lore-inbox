Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSA3EKk>; Tue, 29 Jan 2002 23:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288395AbSA3EKa>; Tue, 29 Jan 2002 23:10:30 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:60932 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288374AbSA3EKZ>;
	Tue, 29 Jan 2002 23:10:25 -0500
Date: Tue, 29 Jan 2002 20:09:08 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@suse.de>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020130040908.GA23261@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org> <08cf01c1a933$f45ac460$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08cf01c1a933$f45ac460$6800000a@brownell.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 02 Jan 2002 01:56:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 06:15:13PM -0800, David Brownell wrote:
> > > >  > Yes, I need to have better names for the devices than just "usb_bus",
> > > >  > any suggestions?  These devices nodes are really the USB root hubs in
> > > >  > the USB controller, so they could just have the USB number as the name
> > > >  > like the other USB devices (001), but that's pretty boring :)
> 
> Actually one of my criticisms of Greg's patch is that
> it hides the actual device tree.   The root hub is easily
> distinguishable, it's the topmost one in the tree!  There
> should be no need to name it specially.
> 
> I'd really rather move away from the model which
> exposes a USB bus as a flat non-hierarchical
> setup, and move instead to a model reflects the
> actual topology of the USB devices and hubs.

<good description of what the topology tree should show snipped>

I completly agree.  My main concern with these first patches, was
getting the driverfs - usb subsystem linkage working properly.  I wasn't
trying to work on the names yet (you should have seen some of my testing
patches, the names there were pretty horrible :)

As we wait for the rest of Pat's patches to be merged into the kernel,
we can work on nailing down the proper naming scheme for the USB trees.

However, the root hub name _does_ propose a problem.  I feel we have two
solutions:
	- use the bus number (usb_bus_00x)
	  Pros:
	  	matches the usbfs naming and directory structure
	  Cons:
	  	depends on the initialization order of the busses.

	- use a generic name like I did (usb_bus)
	  Pros:
	  	does not depend on the init order, and relies on the
		location in the entire pci topology tree to show its
		uniqueness.
	  Cons:
	  	boring :)

And also remember, the status file in a device's directory also provides
a _lot_ of information.  We haven't even started to fill up the fields
there...

thanks,

greg k-h
