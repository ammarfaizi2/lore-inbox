Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbUKMKWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUKMKWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 05:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKMKWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 05:22:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24844 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261755AbUKMKWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 05:22:09 -0500
Date: Sat, 13 Nov 2004 10:22:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
Message-ID: <20041113102205.A646@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1100301717571@kroah.com> <11003017181402@kroah.com> <20041113091208.A30939@flint.arm.linux.org.uk> <4195DBE3.9000606@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4195DBE3.9000606@ppp0.net>; from jdittmer@ppp0.net on Sat, Nov 13, 2004 at 11:03:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 11:03:15AM +0100, Jan Dittmer wrote:
> Russell King wrote:
> > Why is this needed?  pci_bus_add_devices() is designed to only add new
> > devices to the device tree - new devices have an empty dev->global_list.
> > 
> > Just calling pci_bus_add_devices() for the parent bus should suffice.
> 
> The device got removed from bus->devices, so I can't call that.

This sounds very wrong.  Why did it get removed from bus->devices ?

If it isn't on bus->devices, how does pci_bus_add_device() help?
Sure you get it onto the global list and into the device tree,
but it won't be attached to the parent bus properly.

I think what you want to be using is:

int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)

to discover the new device, which will do the right thing from the
point of setting stuff up before calling pci_bus_add_device*().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
