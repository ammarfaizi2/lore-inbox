Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTFRTgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTFRTgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:36:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:28420 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265264AbTFRTgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:36:49 -0400
Date: Wed, 18 Jun 2003 15:50:46 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030618171527.GA1415@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0306181515520.1231-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, Greg KH wrote:

> Ok, have you _read_ the documentation on the driver model?  In it,
> classes and devices are clearly spelled out as to what the differences
> are, and what shows up where.

Yes, of course I've read it.  It's lacking a number of important details.

For example, nowhere in devices.txt does it say that a device driver
should not create attributes in the struct device's directory since that
directory is owned by the bus driver.  (That's a very easy mistake to
make; at first sight it appears to be the natural way for a driver to
expose details of how it controls a device.)  In fact, nowhere in the
documentation does it say that you shouldn't attach an attribute to an 
object unless you own that object.  Maybe that seems obvious, but when a 
driver is bound to a device can't it be said to "own" that device in some 
sense?

The class.txt document does _not_ explain clearly what the differences
between devices and classes (or more properly, class devices) are.  It
merely says that "A device class describes a type of device..."  It
doesn't say what sorts of devices get to belong to a class; it doesn't
even list the existing classes yet!  (As you are obviously aware.)

Let me ask you this:  Given a device that doesn't fit clearly into any of 
the existing classes, how would you decide whether or not to create a new 
class for it?

> See Pat's linux.conf.au 2003 paper for much more detail.
> 
> And yes, I need to fix up the Documentation/driver_model/class.txt with
> the most recent info...
> 
> In short, devices describe physical things that are present in the
> computer system.  Classes describe a type of device, be it virtual or
> physical.  Almost always, classes refer to something a user uses through
> the /dev filesystem (like mice, tty, block, audio, etc.)

Yes, but _which_ physical things correspond to devices?  And how should 
the parent-child relationships be decided?

Consider a concrete example: a USB host controller.  Let's say that on my
system /sys/devices/pci0/0000:00:07.2 is an OHCI HC.  That particular
object is created by the PCI bus driver, and directly below it is
/sys/devices/pci0/0000:00:07.2/usb1 -- what physical thing does that
correspond to?  Is it the virtual root hub?  It's created by the USB core;
where does the object created by the HC driver belong?

Or have I misunderstood, and was it intended from the start that _all_ the
objects under /sys/devices/ should be created by bus drivers, while _all_
the objects created by device drivers belong somewhere else?  Is that
somewhere else always under /sys/class/ (or /sys/block/)?  And where in
the documentation is this spelled out?

> So no, there is not always a 1:1 mapping from classes to devices, that
> is why the driver model does not enforce such a mapping at all.  You can
> have multiple "struct class_device" structures that point to the same
> "struct device" or no "struct device" at all.
> 
> Hope this helps to clear up the confusion that seems to be happening.

I'm still struggling... :-)

Alan Stern

