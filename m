Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbTFSQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTFSQ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:27:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65443 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265040AbTFSQ1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:27:06 -0400
Date: Thu, 19 Jun 2003 09:42:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: Greg KH <greg@kroah.com>, <viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306181515520.1231-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306190932160.955-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ok, have you _read_ the documentation on the driver model?  In it,
> > classes and devices are clearly spelled out as to what the differences
> > are, and what shows up where.
> 
> Yes, of course I've read it.  It's lacking a number of important details.

Hey, we've tried. I realize it's missing details, and though I know it's 
important to keep it updated, many other things take precedence. 

> For example, nowhere in devices.txt does it say that a device driver
> should not create attributes in the struct device's directory since that
> directory is owned by the bus driver.  (That's a very easy mistake to
> make; at first sight it appears to be the natural way for a driver to
> expose details of how it controls a device.)  In fact, nowhere in the
> documentation does it say that you shouldn't attach an attribute to an 
> object unless you own that object.  Maybe that seems obvious, but when a 
> driver is bound to a device can't it be said to "own" that device in some 
> sense?

It's "bound" to the device, but it does not own the object. 

Note that only recently have we realized the full importance of creating 
attributes _only_ for objects that you own. It's exposed bugs recently, 
and hasn't had a chance to make it in to the documentation. 

> Let me ask you this:  Given a device that doesn't fit clearly into any of 
> the existing classes, how would you decide whether or not to create a new 
> class for it?

If it does not fit into the existing classes, then there is probably a new 
class that needs to be created for it. While you're at it, please update 
the documentation and set a good example for the rest of us ;)

> Yes, but _which_ physical things correspond to devices?  And how should 
> the parent-child relationships be decided?
> 
> Consider a concrete example: a USB host controller.  Let's say that on my
> system /sys/devices/pci0/0000:00:07.2 is an OHCI HC.  That particular
> object is created by the PCI bus driver, and directly below it is
> /sys/devices/pci0/0000:00:07.2/usb1 -- what physical thing does that
> correspond to?  Is it the virtual root hub?  It's created by the USB core;
> where does the object created by the HC driver belong?
> 
> Or have I misunderstood, and was it intended from the start that _all_ the
> objects under /sys/devices/ should be created by bus drivers, while _all_
> the objects created by device drivers belong somewhere else?  

Yes.

> Is that
> somewhere else always under /sys/class/ (or /sys/block/)?  

Yes, /sys/class

> And where in
> the documentation is this spelled out?

It should be in the first sections of each driver model paper - The 
hierarchy under /sys/devices/ represents the physical hierarchy of the 
system itself. Each object represented in it is intended to map directly 
to a physical device. Physical devices are discovered and registered by 
bus drivers in the system. 


	-pat

