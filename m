Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCCWHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCCWHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCCWHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:07:48 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:39608
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750810AbWCCWHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:07:47 -0500
Date: Fri, 3 Mar 2006 14:07:41 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060303220741.GA22298@kroah.com>
References: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
> I was wondering what the proper way to assign and setup a single PCI  
> device that comes into existence after the system has booted.  I have  
> an FPGA that we load from user space at which time it shows up on the  
> PCI bus.

Idealy your BIOS would set up this information :)

> It has a single BAR and I need to assign it at a fixed address in PCI  
> MMIO space.
> 
> All of the exported interfaces I see have to do with having the  
> kernel assign the BAR automatically for me.
> 
> the following looks like what I want to do:
> 
> bus = pci_find_bus(0, 3);
> dev = pci_scan_single_device(bus, devfn);
> pci_bus_alloc_resource(...);
> pci_update_resource(dev, dev->resource[0], 0);
> pci_bus_add_devices(bus);
> 
> However, pci_update_resource() is not an exported symbol, so I could  
> replace that code with the need updates to the actual BAR.
> 
> Is this the "right" way to go about this or is there a better  
> mechanism to do this.

Take a look at how the compat pci hotplug driver does this, you probably
just need to do the same as it.

thanks,

greg k-h
