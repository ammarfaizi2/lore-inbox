Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279061AbRKKQ4U>; Sun, 11 Nov 2001 11:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279233AbRKKQ4K>; Sun, 11 Nov 2001 11:56:10 -0500
Received: from host194.steeleye.com ([216.33.1.194]:6160 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S279061AbRKKQ4B>; Sun, 11 Nov 2001 11:56:01 -0500
Message-Id: <200111111655.fABGtr610172@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how is processor cache coherency maintained for device drivers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Nov 2001 08:55:52 -0800
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to help track down some infrequent and difficult to
> reproduce pci bus parity errors that we're seeing on a cPCI card, and
> one of the things that has been suggested is that it may have
> something to do with DMA coherency between devices and the processor.

> Can someone point me to the proper code/information that deals with
> how the processor knows that the memory corresponding to the ethernet
> device is no longer up-to-date?  Is it somehow marked as
> non-cacheable, or is it snooped, explicitly flushed, or what?

This is extremely architecture specific.  Some, like the x86, have a fully 
coherent architecture, so the caches snoop the bus for invalidations.  Others 
(older parisc) are completely incoherent and won't invalidate the CPU cache 
unless explicitly told to do so.

The code for all this is in:

asm/io.h for the basic dma_cache_* functions

asm/pci.h for the pci bus pci_dma_* functions

See Documentation/DMA-mapping.txt for a partial explanation of the 
implementation.

> The platform in question is a Motorola MCPN765 card, with a PPC7400
> processor, running a modified 2.2.17 kernel. 

I believe (although you should take better advice from the PPC people) that 
the powerpc is completely cache coherent, so any coherency problems you may be 
having would be due to the hardware, not the kernel.

James Bottomley


