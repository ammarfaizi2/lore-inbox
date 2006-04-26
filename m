Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWDZRWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDZRWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDZRWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:22:34 -0400
Received: from mail.suse.de ([195.135.220.2]:16850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932181AbWDZRWd (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:22:33 -0400
Date: Wed, 26 Apr 2006 10:21:04 -0700
From: Greg KH <greg@kroah.com>
To: biswa.nayak@wipro.com
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: PCI ERROR: Segmentation fault in pci_do_scan_bus
Message-ID: <20060426172104.GA8648@kroah.com>
References: <4F36B0A4CDAD6F46A61B2B32C33DC69C025569E4@BLR-EC-MBX03.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F36B0A4CDAD6F46A61B2B32C33DC69C025569E4@BLR-EC-MBX03.wipro.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 05:05:55PM +0530, biswa.nayak@wipro.com wrote:
> 
> Thanks Greg for your reply. My comments are below.
> 
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg KH
> 
> > >On Tue, Apr 25, 2006 at 05:25:32PM +0530, biswa.nayak@wipro.com
> wrote:
> > > Hi
> > >
> > > I am getting segmentation fault, consistently on call to
> > > 'pci_do_scan_bus'. This is a small test code ( attached with this
> > > mail) to test the APIs exposed by the PCI subsystem.
> 
> > The module code you attached isn't exactly "small" :)
> > What chunk of code is causing the problem?
> > Why are you scanning the PCI bus from a module?
> 
> Sorry for attaching the whole module.
> Initially I thought of sending only the part which is causing the
> problem, but
> later thought of sending full module which is compiling and working for
> better understanding.
> 
> In my code inside 'test_scan_bus' I am calling 'pci_do_scan_bus' in that
> case I am getting the segmentation fault.
> 
> I am developing a test suite which will validate all the BSPs.

What is a "BSP"?

> That's the reason I am calling this exported APIs from the subsystem to
> verify that things are working fine.

Working fine for what?

> > > I just checked where it
> > >  faults and found out that inside 'sysfs_create_bin_file' it is not
> > > able  to find the kobject out of the dev pointer passed to it. Now
> > > extracting  of the dev object out of the bus pointer is done by 
> > > 'list_for_each_entry(dev, &bus->devices, bus_list)' in 
> > > 'pci_bus_add_devices'. Now I am not able to understand why the
> kobject 
> > > is missing. Is it something that I am missing or is it a kernel
> defect?
> > > Any help in this will be really appreciated. The bug message is
> pasted 
> > > below.
> 
> > I'm confused as to why you are trying to set up the pci bus for a pci
> bus that is already set up.
> > That's why the function is dying...
> 
> I am not trying to set up the already set up bus ( or is it what I am
> doing by making a call to this function?).

Do you understand what this function does?

> My intention is to call all the APIs provided by all the subsystem of
> the system, like PCI, USB, UART, FS etc...

But you need to call them in ways that make sense, right? :)

> I am doing something seriously wrong over here?

I think you need to understand what the functions that you are calling
really do before calling them.  And understand what you are trying to
achive.

thanks,

greg k-h
