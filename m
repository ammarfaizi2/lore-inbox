Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTFPXYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTFPXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:24:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24277 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264437AbTFPXYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:24:10 -0400
Date: Mon, 16 Jun 2003 16:36:51 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030616233651.GB27033@kroah.com>
References: <Pine.LNX.4.44.0306161345570.908-100000@cherise> <Pine.LNX.4.44L0.0306161714100.789-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306161714100.789-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 05:29:00PM -0400, Alan Stern wrote:
> On Mon, 16 Jun 2003, Patrick Mochel wrote:
> 
> > > This doesn't provide any really good place to put device attributes that 
> > > are owned by the driver.  They can't go in
> > > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/device/...
> > > because the driver doesn't own the device.  They can't go in
> > > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/driver/...
> > > because they aren't attributes of the _driver_, they're attributes of the 
> > > _device_.  And they certainly aren't class attributes.
> > > 
> > > So where would you put them?  You'd have to create another subdirectory of
> > > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/
> > > owned by the driver.  No really good name for this subdirectory spings 
> > > to mind, and it's still kind of awkward.  But doable.
> > 
> > What is wrong with putting them in 
> > 
> > /sysfs/class/pcmcia_socket/pcmcia_socket0/
> > 
> > ? The driver owns that object. And, if it is device-specific feature, then 
> > it is likely related to what class the device belongs to, and is therefore 
> > relevant for that directory.
> 
> Are you sure?  Suppose a pcmcia disk drive is plugged in to that socket.  
> Why is a disk driver going to name its object "pcmcia_socket0"?  It must
> be the pcmcia socket driver that owns the object, not the disk driver.  So 
> then where does the disk driver put the disk-related attributes?  Don't 
> say in /sys/class/pcmcia_socket/pcmcia_socket0/device/, because the driver 
> doesn't own that object either.

All disk info is in the /sys/block directory, does that work for you?

> Anyway, in my case it's a USB device.  At the moment /sys/class/usb
> doesn't contain anything AFAICT, although no doubt that can be changed.

It will contain things if you have a device that uses the USB major
plugged in.

> Greg, what is the current organization of directories for USB buses and 
> devices?  Would it make sense to let each driver register its devices as
> /sys/class/usb/bus#/dev#/ ?  Would that better be done under /sys/bus/usb 
> ?  Or is something else already there?  Or should the usb-storage driver, 
> for example, create its own class?

I think the scsi core will create you a directory that you can use that
will have the proper lifetime that you are looking for.  If not, I can
look into doing something else for some of the other USB devices that
are not using the USB major.

thanks,

greg k-h
