Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBNLYm>; Wed, 14 Feb 2001 06:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBNLYb>; Wed, 14 Feb 2001 06:24:31 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:23584 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129054AbRBNLYV>; Wed, 14 Feb 2001 06:24:21 -0500
Date: Wed, 14 Feb 2001 05:24:12 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <20010214111700.X9459@redhat.com>
Message-ID: <Pine.LNX.3.96.1010214051817.12910H-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Tim Waugh wrote:
>  }
>  
> -
> +/**
> + * pci_find_capability - query for devices' capabilities 
> + * @dev: PCI device to query
> + * @cap: capability code
> + *
> + * Tell if a device supports a given PCI capability.
> + * Returns the address of the requested capability structure within the device's PCI 
> + * configuration space or 0 in case the device does not support it.
> + * Possible values for @flags:
> + *
> + *  %PCI_CAP_ID_PM           Power Management 
> + *
> + *  %PCI_CAP_ID_AGP          Accelerated Graphics Port 
> + *
> + *  %PCI_CAP_ID_VPD          Vital Product Data 
> + *
> + *  %PCI_CAP_ID_SLOTID       Slot Identification 
> + *
> + *  %PCI_CAP_ID_MSI          Message Signalled Interrupts
> + *
> + *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
> + */

Looks ok, but I wonder if we should include this list in the docs.
These is stuff defined by the PCI spec, and this list could potentially
get longer...  (opinions either way wanted...)


> +/**
> + * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
> + * @ids: array of PCI device id structures to search in
> + * @dev: the PCI device structure to match against
> + * 
> + * Used by a driver to check whether a PCI device present in the
> + * system is in its list of supported devices.Returns the matching
> + * pci_device_id structure or %NULL if there is no match.
> + */

Maybe note that the return value comes from @ids (in case that isn't
abundantly clear to everybody)?


>  }
>  
> +/**
> + * pci_register_driver - register a new pci driver
> + * @drv: the driver structure to register
> + * 
> + * Adds the driver structure to the list of registered drivers
> + * Returns the number of pci devices which were claimed by the driver
> + * during registration.
> + */

Definitely mention that the driver remains registered even if the return
value is zero.  That trips a lot of people up (as we saw.. :))

> +/**
> + * pci_unregister_driver - unregister a pci driver
> + * @drv: the driver structure to unregister
> + * 
> + * Deletes the driver structure from the list of registered PCI drivers,
> + * gives it a chance to clean up and marks the devices for which it
> + * was responsible as driverless.
> + */

Clarify "chance to clean up" as calls each driver's remove() method...


> +/**
> + * pci_dev_driver - get the pci_driver of a device
> + * @dev: the device to query
> + *
> + * Returns the appropriate pci_driver structure or %NULL if there is no 
> + * registered driver for the device.
> + */

Mention the case where pci_compat_driver is returned...

	Jeff




