Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277013AbRJCWot>; Wed, 3 Oct 2001 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277016AbRJCWoj>; Wed, 3 Oct 2001 18:44:39 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:33873
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277013AbRJCWo2>; Wed, 3 Oct 2001 18:44:28 -0400
Message-Id: <200110032244.f93MiI103485@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jes Sorensen <jes@sunsite.dk>
cc: Linux Bigot <linuxopinion@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 17:44:18 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux> All programmers I am relatively new to linux kernel. Please
> Linux> advise what is the safe way to get the original virtaul address
> Linux> from dma address e.g.,

> You have to store the address you pass to pci_map_single() somewhere
> in your data structures together with the dma address.

Yes, but speaking as someone who had to use a large hammer to convert his 
driver from bus_to_virt et al.,  it does seem rather hard not to have the 
equivalent for the new pci_dma paradigm.  It does present an obstacle 
persuading people to convert drivers, particularly if the hardware is going to 
present a linked list of addresses (as SCSI hardware often does).

After all, whatever device maps between the io bus and the memory bus, it must 
always map a given dma_addr_t to a known physical address.  It can't be that 
hard to provide an an API in the kernel which can compute this relationship 
(although I can see it may be expensive to walk iommu page tables).  I'm only 
really asking for a dma_addr_t to virtual address by the way.  I see that 
mapping the other way would be problematic.

James Bottomley


