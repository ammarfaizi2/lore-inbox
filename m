Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTCHUUf>; Sat, 8 Mar 2003 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTCHUUf>; Sat, 8 Mar 2003 15:20:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42766 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262190AbTCHUUe>;
	Sat, 8 Mar 2003 15:20:34 -0500
Date: Sat, 8 Mar 2003 12:21:02 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308202101.GA26831@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com> <20030308200943.F1896@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308200943.F1896@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:09:43PM +0000, Russell King wrote:
> On Sat, Mar 08, 2003 at 11:12:37AM -0800, Greg KH wrote:
> > On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> > > Hi,
> > > 
> > > What prevents the following scenario from happening?  It's purely
> > > theoretical - I haven't seen this occuring.
> > > 
> > > - Load PCI driver.
> > > 
> > > - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> > > 
> > > - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> > >   driver, and calls the PCI drivers probe function.
> > 
> > Ugh, yes you are correct, I can't believe I missed this before.
> > 
> > How does this patch look?
> 
> Hrm, I'm wondering whether this should be part of the device model
> infrastructure.  After all, surely every subsystems device driver
> which could be a module would need this to prevent unload races?

Very good point, I can see myself duplicating this logic for every
subsystem :)

I'll look into moving this into the driver core later today.

thanks,

greg k-h
