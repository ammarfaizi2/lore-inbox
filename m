Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268356AbSIRUyK>; Wed, 18 Sep 2002 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbSIRUyK>; Wed, 18 Sep 2002 16:54:10 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:8343 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S268356AbSIRUyJ>; Wed, 18 Sep 2002 16:54:09 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A68@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux hot swap support
Date: Wed, 18 Sep 2002 16:59:08 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, my driver is for a specific cPCI biard which we have developed here. I
want the Linux Kernel to tell me when this board is inserted and/or removed.
I am running on a 700Mhz PIII with a 2.4.18-3 Kernel (Red Hat 7.3) My driver
is written with a call to pci_module_init in the init routine wherein I
specify a probe and remove routine. According to Linux Device Drivers 2nd
edition (pages 489 - 493), As long as the HW supports hot swap, I should get
called automatically whenevr one of the devices (vendor ID device ID) which
I specified in my table gets inserted or ejected. Am I totaly wrong about
this? I am not trying to write a driver for a hotplug controller but for a
device.

Thanks in advance.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, September 18, 2002 4:38 PM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support


Cced back to lkml as I hate taking things off-line unless it's
necessary, archives are your friend.

On Wed, Sep 18, 2002 at 07:50:49AM -0400, Bloch, Jack wrote:
> Thanks for the response. In my driver init routine, I use the
> pci_module_init( ) to register my driver with the PCI subsystem. Is this
> enough?

No, that's enough to register your driver as a PCI driver.  I'm guessing
your pci hotplug controller looks like a PCI device?

> What exactly is the hotplug_core and or pcihpfs?

See drivers/hotplug/pci_hotplug.h for the interface that a pci hotplug
controller driver needs to interface with (specifcly the
pci_hp_register() and pci_hp_unregister() functions are what you need).

> Do I have to implement the pci_insert_device/pci_remove_device methods
> or does the kernel simply call the probe_one/remove_one which I
> specify during my initialization. 

I'm confused, are you talking about a normal PCI card driver, or a PCI
Hotplug controller driver?  What exactly does your driver do?  Does it
talk to a specific PCI card, or does it control power to PCI slots?

thanks,

greg k-h
