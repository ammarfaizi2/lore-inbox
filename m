Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTFPVQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFPVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:15:21 -0400
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264289AbTFPVPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:15:09 -0400
Date: Mon, 16 Jun 2003 17:29:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@osdl.org>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44.0306161345570.908-100000@cherise>
Message-ID: <Pine.LNX.4.44L0.0306161714100.789-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Patrick Mochel wrote:

> > This doesn't provide any really good place to put device attributes that 
> > are owned by the driver.  They can't go in
> > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/device/...
> > because the driver doesn't own the device.  They can't go in
> > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/driver/...
> > because they aren't attributes of the _driver_, they're attributes of the 
> > _device_.  And they certainly aren't class attributes.
> > 
> > So where would you put them?  You'd have to create another subdirectory of
> > 	/sysfs/class/pcmcia_socket/pcmcia_socket0/
> > owned by the driver.  No really good name for this subdirectory spings 
> > to mind, and it's still kind of awkward.  But doable.
> 
> What is wrong with putting them in 
> 
> /sysfs/class/pcmcia_socket/pcmcia_socket0/
> 
> ? The driver owns that object. And, if it is device-specific feature, then 
> it is likely related to what class the device belongs to, and is therefore 
> relevant for that directory.

Are you sure?  Suppose a pcmcia disk drive is plugged in to that socket.  
Why is a disk driver going to name its object "pcmcia_socket0"?  It must
be the pcmcia socket driver that owns the object, not the disk driver.  So 
then where does the disk driver put the disk-related attributes?  Don't 
say in /sys/class/pcmcia_socket/pcmcia_socket0/device/, because the driver 
doesn't own that object either.

Anyway, in my case it's a USB device.  At the moment /sys/class/usb
doesn't contain anything AFAICT, although no doubt that can be changed.

Greg, what is the current organization of directories for USB buses and 
devices?  Would it make sense to let each driver register its devices as
/sys/class/usb/bus#/dev#/ ?  Would that better be done under /sys/bus/usb 
?  Or is something else already there?  Or should the usb-storage driver, 
for example, create its own class?

Alan Stern

