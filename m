Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbTCHT7K>; Sat, 8 Mar 2003 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbTCHT7K>; Sat, 8 Mar 2003 14:59:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22020 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262184AbTCHT7I>; Sat, 8 Mar 2003 14:59:08 -0500
Date: Sat, 8 Mar 2003 20:09:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308200943.F1896@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jeff Garzik <jgarzik@pobox.com>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308191237.GA26374@kroah.com>; from greg@kroah.com on Sat, Mar 08, 2003 at 11:12:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:12:37AM -0800, Greg KH wrote:
> On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> > Hi,
> > 
> > What prevents the following scenario from happening?  It's purely
> > theoretical - I haven't seen this occuring.
> > 
> > - Load PCI driver.
> > 
> > - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> > 
> > - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> >   driver, and calls the PCI drivers probe function.
> 
> Ugh, yes you are correct, I can't believe I missed this before.
> 
> How does this patch look?

Hrm, I'm wondering whether this should be part of the device model
infrastructure.  After all, surely every subsystems device driver
which could be a module would need this to prevent unload races?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

