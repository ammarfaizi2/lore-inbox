Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWBXBnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWBXBnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBXBnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:43:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:5764 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932363AbWBXBnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:43:39 -0500
Date: Thu, 23 Feb 2006 17:42:51 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: what's a platform device?
Message-ID: <20060224014251.GC25787@kroah.com>
References: <8B3A62DF-6991-4C46-A294-6DF314D24AF4@kernel.crashing.org> <Pine.LNX.4.44.0602231324110.12559-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0602231324110.12559-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 01:30:39PM -0600, Kumar Gala wrote:
> On Thu, 23 Feb 2006, Kumar Gala wrote:
> 
> > >> Yes, the FPGA is a pci device.
> > >>
> > >> Not sure I follow exactly what you mean by the fact that platform
> > >> devices dont know about mmio regions.  They know about struct
> > >> resource and iomem_resource & ioport_resource.
> > >
> > > Yes, as they have no "bus" to attach too.  That's why they are there,
> > > they are for devices with no bus, but are merely "raw" memory mapped
> > > devices.
> > 
> > I'm not sure I follow this. How is PCI different?  How would "kumar"  
> > bus be different?
> > 
> > >> I think I might be missing something fundamental here.  In
> > >> implementing my own bus_type, I'll end up introducing my own struct
> > >> foobar_device which looked pretty much like struct platform_device.
> > >> Then I'll need a set of functions to assign resources, etc.
> > >>
> > >> I got no issue implementing my own bus_type, but I clearly feel like
> > >> I'm missing something here (just not sure what it is :)
> > >
> > > I guess I look at your FPGA as a PCI "bridge" chip, that bridges  
> > > between
> > > the PCI bus, and your "kumar" bus (for lack of a better name).  Your
> > > devices hang off of that bus, which is attached to the FPGA, which is
> > > attached to the pci bridge, and so on.  If you use the platform  
> > > bus, you
> > > break that link.
> > >
> > > Does that make sense?
> > 
> > This makes sense, but you seem to be talking about hierarchy more the  
> > functionality.  I agree in your description of hierarchy.
> > 
> > I was looking at it from a functional point of view, maybe more from  
> > the device view then from the bus.  I need a struct device type that  
> > contains resources, a name, an id.  I'll do matching based on name.   
> >  From a functional point of view platform does all this.
> > 
> > Based on your description would you say that a platform_device's  
> > parent device should always be platform_bus? [I'm getting at the fact  
> > that we allow pdev->dev.parent to be set by the caller of  
> > platform_device_add].
> > 
> > Hmm, as I think about this further, I think that its more coincidence  
> > that the functionality for the "kumar" bus is equivalent to that of  
> > the "platform" bus.
> > 
> 
> What about a new bus_type that uses all the sematics of the platform_bus.  
> Doing someting like the following which would allow the caller to specify 
> their own bus_type.
> 
> I'm just trying to avoid duplicating alot of code that already exists in 
> base/platform.c

I'm ok with this patch, Russell?

thanks,

greg k-h
