Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWCCX1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWCCX1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWCCX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:27:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38558
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932556AbWCCX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:27:41 -0500
Date: Fri, 3 Mar 2006 15:27:39 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060303232739.GA11796@kroah.com>
References: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org> <20060303220741.GA22298@kroah.com> <A9483AAD-670C-4D03-9996-6AE89F6FD4FB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9483AAD-670C-4D03-9996-6AE89F6FD4FB@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 05:13:55PM -0600, Kumar Gala wrote:
> 
> On Mar 3, 2006, at 4:07 PM, Greg KH wrote:
> 
> >On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
> >>I was wondering what the proper way to assign and setup a single PCI
> >>device that comes into existence after the system has booted.  I have
> >>an FPGA that we load from user space at which time it shows up on the
> >>PCI bus.
> >
> >Idealy your BIOS would set up this information :)
> >
> >>It has a single BAR and I need to assign it at a fixed address in PCI
> >>MMIO space.
> >>
> >>All of the exported interfaces I see have to do with having the
> >>kernel assign the BAR automatically for me.
> >>
> >>the following looks like what I want to do:
> >>
> >>bus = pci_find_bus(0, 3);
> >>dev = pci_scan_single_device(bus, devfn);
> >>pci_bus_alloc_resource(...);
> >>pci_update_resource(dev, dev->resource[0], 0);
> >>pci_bus_add_devices(bus);
> >>
> >>However, pci_update_resource() is not an exported symbol, so I could
> >>replace that code with the need updates to the actual BAR.
> >>
> >>Is this the "right" way to go about this or is there a better
> >>mechanism to do this.
> >
> >Take a look at how the compat pci hotplug driver does this, you  
> >probably
> >just need to do the same as it.
> 
> I found cpqhp_configure_device(), but I dont see anything about how  
> to handle assigned a fixed address to the BAR.

I don't know either, try asking on the pci hotplug mailing list and CC:
Scott, the author of that driver for how his devices work around that.

thanks,

greg k-h
