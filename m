Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWDVTJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDVTJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDVTJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:09:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12471 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750945AbWDVTJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:09:03 -0400
Date: Fri, 21 Apr 2006 23:00:45 -0700
From: Greg KH <greg@kroah.com>
To: Bert Thomas <bert@brothom.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI device driver writing newbie trouble
Message-ID: <20060422060045.GA18067@kroah.com>
References: <4447A2E7.6000407@brothom.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447A2E7.6000407@brothom.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:04:07PM +0100, Bert Thomas wrote:
> Hi All,
> 
> I'm attempting to write a PCI device driver. I've read chapters 2, 9 and 
> 12 of the linux device driver book (3rd ed) and it got me going with the 
> code below. However, I never see the message printed from cif50_probe, 
> so appearantly the kernel doesn't consider my driver the correct driver 
> for the hardware.
> 
> I tried to load the driver with insmod, but I also rebooted the system 
> in the hope that some part of the kernel would find the hardware and try 
> to load my driver. Is that how it is supposed to work? At least my 
> driver is listed in /lib/modules/2.6.15.7/modules.pcimap. Modprobe 
> doesn't find it, I don't know why. The hardware contains a PLX chip. The 
> hardware is found by the kernel, as it correctly shows up in /proc/pci:
> 
>   Bus  1, device  13, function  0:
>     Class 0680: PCI device 10b5:9050 (rev 1).
>       IRQ 5.
>       Non-prefetchable 32 bit memory at 0xd1005000 [0xd100507f].
>       I/O at 0xd100 [0xd17f].
>       Non-prefetchable 32 bit memory at 0xd1000000 [0xd1001fff].
> 
> Also in the corresponding /sys files.
> 
> Does anyone have a suggestion why my probe function is not being called?
> 
> TIA
> Bert
> 
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/pci.h>
> MODULE_LICENSE("Dual BSD/GPL");
> 
> static const struct pci_device_id cif50_ids[] = {
>         {
>         .vendor = 0x10B5,
>         .device = 0x9050,
>         .subvendor = PCI_ANY_ID, //0x10B5,
>         .subdevice = PCI_ANY_ID, //0x1080,
>         .class = PCI_ANY_ID,
>         .class_mask = PCI_ANY_ID
>         },

Try the PCI_DEVICE() macro here instead.

But that should not matter, this should work, I don't know why it
doesn't sorry.

greg k-h
