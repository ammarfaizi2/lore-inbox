Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSKMUho>; Wed, 13 Nov 2002 15:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSKMUho>; Wed, 13 Nov 2002 15:37:44 -0500
Received: from host194.steeleye.com ([66.206.164.34]:25092 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262662AbSKMUhn>; Wed, 13 Nov 2002 15:37:43 -0500
Message-Id: <200211132044.gADKiHi02548@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Grant Grundler <grundler@dsl2.external.hp.com>
cc: Bjorn Helgaas <bjorn_helgaas@hp.com>, Greg KH <greg@kroah.com>,
       Miles Bader <miles@gnu.org>,
       "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device 
 interface
In-Reply-To: Message from Grant Grundler <grundler@dsl2.external.hp.com> 
   of "Wed, 13 Nov 2002 13:33:21 MST." <20021113203321.DCF174829@dsl2.external.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Nov 2002 15:44:17 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grundler@dsl2.external.hp.com said:
> For device discovery and initialization, the generic PCI code has to
> muck with PCI specific resources (IO Port, MMIO, and IRQ related stuff
> primarily). 

Oh, I agree.  If we conduct a phased approach to this, what happens initially 
is that the pci drivers simply pull pci_dev out of the struct device and use 
it as previously.

However, I think the ultimate destination is to see how much of the bus 
specific stuff we can abstract by throwing an API around it.  I think IRQ, 
port and mmio are feasible.  Specific knowledge of bus posting et al may not 
be.

> uhmm...If we are going to touch dma_mask in pci_dev, then just move it
> to struct device and be done with it. Then fixup pci_set_dma_mask() to
> do the right thing. 

Well...OK.  The advantage of a pointer in struct device is that the code can 
be converted as is, and no-one has to muck with the direct accessors of the 
pci_dev->dma_mask.  However, I'll see how many of them there actually are, its 
probably just the drivers that transfer the information to 
blk_queue_bounce_limit.

> Duck! (that's going to get fixed it seems) ;^) 

I thought the 53c700 was working OK?  Richard Hirst did some extensive testing 
on a parisc with an IO-MMU for me (he caught a lot of early mapping leaks 
which I fixed).

James


