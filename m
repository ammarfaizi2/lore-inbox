Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbSJaWJq>; Thu, 31 Oct 2002 17:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJaWJE>; Thu, 31 Oct 2002 17:09:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6419 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265396AbSJaWII>;
	Thu, 31 Oct 2002 17:08:08 -0500
Date: Thu, 31 Oct 2002 14:11:36 -0800
From: Greg KH <greg@kroah.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021031221136.GC10689@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A493@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A493@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:00:27PM -0800, Grover, Andrew wrote:
> > From: Greg KH [mailto:greg@kroah.com] 
> > In 2.5 we now have a 
> > pci_bus_read_*
> > and pci_bus_write_* functions, which the pci hotplug drivers use, as
> > they at least know the bus on which the devices they are 
> > looking for are
> > on.  I also had to convert over some ACPI code that was using the
> > pci_read_config functions to get everything to work properly, but I
> > don't seem to be able to find that code in the latest 2.5 tree, so I
> > guess you don't need to do that anymore?
> 
> It's still there in drivers/acpi/osl.c. We use the pci_root_ops directly,
> instead of bus->ops (which is usually set to pci_root_ops anyways) but I
> just mention this as a sidenote.

Ah, thanks for pointing it out, I try to forget my forays into the ACPI
code :)

But even then, you are building up a few pci structures yourself to talk
to the pci device.  In looking at the few places you call this function,
is there any reason that acpi_ex_pci_config_space_handler() can't just
call pci_bus_* itself, instead of having to go through
acpi_os_read_pci_configuration()?  If so, the one other usage of the
acpi_os_read_pci_configuration() can cause that function to be
simplified a lot.

Anyway, this is a nice diversion from the real problem here, for 2.4,
should I just backport the pci_ops changes which will allow pci
hotplugging to work again on ia64, or do we want to do something else?

thanks,

greg k-h
