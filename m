Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbQLISs4>; Sat, 9 Dec 2000 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbQLISsg>; Sat, 9 Dec 2000 13:48:36 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:21451 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S130592AbQLISsE>; Sat, 9 Dec 2000 13:48:04 -0500
Date: Sat, 9 Dec 2000 18:11:08 +0000 (GMT)
From: davej@suse.de
To: Martin Mares <mj@suse.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001209160403.A28562@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0012091803270.571-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Martin Mares wrote:

> > Questions:
> > 1. Is there reason for the drivers to be setting this themselves
> >    to hardcoded values ?
> 
> Definitely not unless the devices are buggy and need a work-around.

Maybe that's the case. The culprits are mostly IDE interfaces. Andre ?

drivers/ide/cmd64x.c:   (void) pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x10);
drivers/ide/cs5530.c:   pci_write_config_byte(cs5530_0,PCI_CACHE_LINE_SIZE, 0x04);
drivers/ide/hpt366.c:   pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x08);
drivers/ide/ns87415.c:  (void) pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x10);

drivers/atm/eni.c:      pci_write_config_byte(eni_dev->pci_dev,PCI_CACHE_LINE_SIZE, 0x10);
drivers/media/video/planb.c:    pci_write_config_byte (pdev,PCI_CACHE_LINE_SIZE, 0x8);

> For PC's, we've until now relied on the BIOS setting up cache line
> sizes correctly. Are the "8"'s you've spotted due to drivers messing
> with the cache line register or do they come from the BIOS?

>From the BIOS. They are the USB controllers, I couldn't see any writes
to the PCI_CACHE_LINE_SIZE in the drivers.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
