Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKMU0a>; Wed, 13 Nov 2002 15:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSKMU03>; Wed, 13 Nov 2002 15:26:29 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:34575 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S263105AbSKMU02>; Wed, 13 Nov 2002 15:26:28 -0500
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Bjorn Helgaas <bjorn_helgaas@hp.com>, Greg KH <greg@kroah.com>,
       Miles Bader <miles@gnu.org>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface 
In-Reply-To: Message from "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com> 
   of "Wed, 13 Nov 2002 12:23:48 EST." <200211131723.gADHNmp02426@localhost.localdomain> 
References: <200211131723.gADHNmp02426@localhost.localdomain> 
Date: Wed, 13 Nov 2002 13:33:21 -0700
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20021113203321.DCF174829@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.E.J. Bottomley" wrote:
> We should also allow devices to do all the setup through bus generic 
> functions, but leave open the possibility that the driver may (once it knows 
> the bus type) obtain the pci_dev (or whatever) from the struct device if it 
> really, really has to muck with bus specific registers.

For device discovery and initialization, the generic PCI code has to muck
with PCI specific resources (IO Port, MMIO, and IRQ related stuff primarily).

> As far as the SCSI mid layer goes, all we really need from struct device is 
> the dma_mask for setting up the I/O bounce buffers.
> 
> The simplest way to do all of this is probably to add a pointer to the 
> dma_mask in struct device and make it point to the same thing in pci_dev.
> If we find we need more than this per device, it could become a pointer
> to a generic dma information structure later on.

uhmm...If we are going to touch dma_mask in pci_dev, then just move it
to struct device and be done with it. Then fixup pci_set_dma_mask()
to do the right thing.

...
> Since the 53c700 is also used by parisc (including some machines with 
> IOMMUs---which, unfortunately, I don't have access to), it probably makes an 
> ideal conversion test case.

Duck! (that's going to get fixed it seems) ;^)

thanks,
grant
