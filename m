Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbTEWCOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 22:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTEWCOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 22:14:03 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:51986 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S263589AbTEWCOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 22:14:02 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <1053656836.21630.25.camel@iguana.localdomain>
From: Matt_Domsch@Dell.com
To: rusty@rustcorp.com.au
cc: greg@kroah.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Date: Thu, 22 May 2003 21:27:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12D359711616930-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the question is, how do you add PCI IDs to a module which isn't
> loaded?

I think the key is here, in drivers/pci/pci-driver.c:

/**
 * pci_register_driver - register a new pci driver
 * @drv: the driver structure to register
 * 
 * Adds the driver structure to the list of registered drivers
 * Returns the number of pci devices which were claimed by the driver
 * during registration.  The driver remains registered even if the
 * return value is zero.
 */
int
pci_register_driver(struct pci_driver *drv)


So it's perfectly legal to have a driver loaded, for which no device
instances are present.  Then you can add the new ID, and it gets probed
for automatically.  When I was testing this, I had the e100 driver built
in statically, and though it didn't have the ID for my actual device in
the table, it remained available.  When I used the new_id interface to
add the ID, then it probed for devices again, the new ID matched, and it
attached itself to the hardware instance.

Granted, today not all the drivers do this.  But I think it's part of
the grand hotplug scheme to allow them to do so.

This does also mean that a whole pile of drivers, for which hardware may
*never* be present, could be loaded.  My sysfs tree shows drivers for
several PCI devices, which I left as =y in my .config file, which don't
exist in my system.

I'll be out of touch the next few days, but will join back in any
discussion next week.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


