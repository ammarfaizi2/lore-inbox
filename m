Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbVGOI65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbVGOI65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVGOI6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:58:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263251AbVGOI6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:58:21 -0400
Date: Fri, 15 Jul 2005 09:58:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH] Add PCI<->PCI bridge driver [4/9]
Message-ID: <20050715095814.F25428@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <abelay@novell.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <1121331319.3398.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1121331319.3398.92.camel@localhost.localdomain>; from abelay@novell.com on Thu, Jul 14, 2005 at 04:55:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:55:19AM -0400, Adam Belay wrote:
> This patch adds a basic PCI<->PCI bridge driver that utilizes the new
> PCI bus class API.

Thanks.  I think this breaks Cardbus.

The whole point of the way PCI is _presently_ organised is that it allows
busses to be configured and setup _before_ the devices are made available
to drivers.  This breaks that completely:

> +/**
> + * ppb_detect_children - detects and registers child devices
> + * @bus: pci bus
> + */
> +static void ppb_detect_children(struct pci_bus *bus)
> +{
> +	unsigned int devfn;
> +
> +	/* Go find them, Rover! */
> +	for (devfn = 0; devfn < 0x100; devfn += 8)
> +		pci_scan_slot(bus, devfn);
> +
> +	pcibios_fixup_bus(bus);
> +	pci_bus_add_devices(bus);
> +}

since we scan the bus, and immediately make all devices available.

This is broken, plain and simple.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
