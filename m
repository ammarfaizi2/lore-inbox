Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSKMUOe>; Wed, 13 Nov 2002 15:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKMUOe>; Wed, 13 Nov 2002 15:14:34 -0500
Received: from host194.steeleye.com ([66.206.164.34]:34323 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263256AbSKMUOd>; Wed, 13 Nov 2002 15:14:33 -0500
Message-Id: <200211132021.gADKL8r02349@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Grant Grundler <grundler@dsl2.external.hp.com>
cc: Miles Bader <miles@gnu.org>, Greg KH <greg@kroah.com>,
       "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device 
 interface
In-Reply-To: Message from Grant Grundler <grundler@dsl2.external.hp.com> 
   of "Wed, 13 Nov 2002 13:13:57 MST." <20021113201357.5302F4829@dsl2.external.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Nov 2002 15:21:07 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> I can't speak for `real machines,' but on my wierd embedded board,
> pci_alloc_consistent allocates from a special area of memory (not
> located at 0) that is the only shared memory between PCI devices and the
> CPU.  pci_alloc_consistent happens to fit this situation quite well, but
> I don't think a bitmask is enough to express the situation.

grundler@dsl2.external.hp.com said:
> HP PARISC V-Class do that as well. The "consistent" memory lives on
> the PCI Bus Controller - not in host mem. Note that parisc-linux does
> not (yet) support V-class. 

Actually, I think dma_mask and consistent memory are orthogonal problems.  
dma_masks are used by the I/O subsystem to determine whether direct DMA to a 
memory region containing an I/O buffer is possible or whether it has to be 
bounced.  Consistent memory is usually allocated for driver specific 
transfers.  The I/O subsystem doesn't usually require the actual I/O buffers 
to be in consistent memory.

James


