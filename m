Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265302AbSJaVUW>; Thu, 31 Oct 2002 16:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265303AbSJaVUW>; Thu, 31 Oct 2002 16:20:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:275 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265302AbSJaVUV>;
	Thu, 31 Oct 2002 16:20:21 -0500
Date: Thu, 31 Oct 2002 13:23:49 -0800
From: Greg KH <greg@kroah.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021031212349.GA10689@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A492@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A492@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:07:08PM -0800, Grover, Andrew wrote:
> > From: Lee, Jung-Ik [mailto:jung-ik.lee@intel.com] 
> > 	Some kernel drivers/components such as hotplug 
> > pci/io-node drivers,
> > ACPI driver, some console drivers, etc **need bare pci 
> > configuration space
> > access** before either pci driver is initialized or struct pci_dev is
> > constructed.
> > 
> > ACPI needs this for ACPI/PCI population, hotplug pci driver 
> > for populating
> > hot-added pci hierarchy. As more drivers are cross ported 
> > over to wider
> > architectures, this would become wider need. Help me if 
> > others need this
> > too.
> 
> When the PCI Config stuff got revamped a few months ago, Greg KH, myself,
> and some other people discussed this, and the conclusion seemed to be that
> it was less ugly to make the code that needs bare PCI config access use fake
> structs, than to have the bare functions exposed. Greg, am I remembering
> correctly?

No.  Well, I don't think so anyway.  In 2.5 we now have a pci_bus_read_*
and pci_bus_write_* functions, which the pci hotplug drivers use, as
they at least know the bus on which the devices they are looking for are
on.  I also had to convert over some ACPI code that was using the
pci_read_config functions to get everything to work properly, but I
don't seem to be able to find that code in the latest 2.5 tree, so I
guess you don't need to do that anymore?

(For the LKML readers, this is a spill-over from the pci hotplug and
ia64 mailing lists, where on 2.4 we now have a problem with pci hotplug
drivers as ia64 uses a pci "segment" and the existing pci_*_nodev
functions in the pci hotplug core don't properly set up this field.  See
the archives for either of those lists for more info.)

thanks,

greg k-h
