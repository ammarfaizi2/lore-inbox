Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTFPTWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTFPTWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:22:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:60420 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264188AbTFPTWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:22:16 -0400
Date: Mon, 16 Jun 2003 15:36:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Russell King <rmk@arm.linux.org.uk>
cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030616194446.H13312@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.0306161526050.1350-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Russell King wrote:

> Have you noticed the two symlinks which are created from the class
> device.  For example:
> 
> /sysfs/class/pcmcia_socket/
> |-- pcmcia_socket0
> |   |-- device -> ../../../devices/pci0/0000:00:01.0
> |   |-- driver -> ../../../bus/pci/drivers/yenta_cardbus
> |   `-- status
> `-- pcmcia_socket1
>     |-- device -> ../../../devices/pci0/0000:00:01.1
>     |-- driver -> ../../../bus/pci/drivers/yenta_cardbus
>     `-- status
> 
> This means you can access the physical device attributes using (eg):
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/device/resource
> the driver attributes:
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/driver/...
> and the class attributes:
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/...
> 
> You don't have to try to work out where in /sys/bus and /sys/devices the
> driver and device respectively are - that's already done for you.

This doesn't provide any really good place to put device attributes that 
are owned by the driver.  They can't go in
	/sysfs/class/pcmcia_socket/pcmcia_socket0/device/...
because the driver doesn't own the device.  They can't go in
	/sysfs/class/pcmcia_socket/pcmcia_socket0/driver/...
because they aren't attributes of the _driver_, they're attributes of the 
_device_.  And they certainly aren't class attributes.

So where would you put them?  You'd have to create another subdirectory of
	/sysfs/class/pcmcia_socket/pcmcia_socket0/
owned by the driver.  No really good name for this subdirectory spings 
to mind, and it's still kind of awkward.  But doable.

Alan Stern



