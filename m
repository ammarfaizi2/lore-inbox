Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVBYXoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVBYXoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVBYXoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:44:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:24451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262110AbVBYXnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:43:37 -0500
Date: Fri, 25 Feb 2005 15:38:23 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI bridge driver rewrite
Message-ID: <20050225233823.GC29496@kroah.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109226122.28403.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:22:01AM -0500, Adam Belay wrote:
> Hi all,
> 
> For the past couple weeks I have been reorganizing the PCI subsystem to
> better utilize the driver model.  Specifically, the bus detection code
> is now using a standard PCI driver.  It turns out to be a major
> undertaking, as the PCI probing code is closely tied into a lot of other
> PCI components, and is spread throughout various architecture specific
> areas.  I'm hoping that these changes will allow for a much cleaner and
> more functional PCI implementation.
> 
> The basic flow of the new code is as follows:
> 1.) A standard "driver core" driver binds to a bridge device.
> 2.) When "*probe" is called it sets up the hardware and allocates a
> "struct pci_bus".
> 3.) The "struct pci_bus" is filled with information about the detected
> bridge.
> 4.) The driver then registers the "struct pci_bus" with the PCI Bus
> Class.
> 5.) The PCI Bus Class makes the bridge available to sysfs.
> 6.) It then detects hardware attached to the bridge.
> 7.) Each new PCI bridge device is registered with the driver model.
> 8.) All remaining PCI devices are registered with the driver model.
> 
> Steps 7 and 8 allow for better resource management.
> 
> 
> I've attached an early version of my code.  It has most of the new PCI
> bus class registration code in place, and an early implementation of the
> PCI-to-PCI bridge driver.  The following remains to be done:
> 
> 1.) refine and cleanup the new PCI Bus API
> 2.) export the new API in "linux/pci.h", and cleanup any users of the
> old code.
> 3.) fix every PCI hotplug driver.
> 4.) write a bridge driver for the PCI root bridge
> 5.) write a bridge driver for Cardbus hardware
> 6.) refine device registration order
> 7.) redesign PCI bus number assignment and support bus renumbering
> 8.) redesign PCI resource management to be compatible with the new code
> 9.) testing on various architectures
> 10.) Write "*suspend" and "*resume" routines for PCI bridges.  Any ideas
> on what needs to be done?
> 11.) fix "PCI_LEGACY" (I may have broke it, but it should be trivial)
> 
> I look forward to any comments or suggestions.

I like it all :)

If you want to submit patches now that rearrange the code to make it
easier for you to modify in the future to achieve the above goals, feel
free, I'll gladly take them.

thanks,

greg k-h
