Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLaTmd>; Tue, 31 Dec 2002 14:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSLaTmc>; Tue, 31 Dec 2002 14:42:32 -0500
Received: from host194.steeleye.com ([66.206.164.34]:27409 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264715AbSLaTmc>; Tue, 31 Dec 2002 14:42:32 -0500
Message-Id: <200212311950.gBVJos202971@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Tue, 31 Dec 2002 11:29:35 PST." <3E11F01F.7040205@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Dec 2002 13:50:54 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> You didn't make anything store or return the dma_addr_t ... that was
> the issue I was referring to, it's got to be either (a) passed up from
> the very lowest level, like the pci_*() calls assume, or else (b)
> cheaply derived from the virtual address.  My patch added slab support
> in common cases where (b) applies. 

That's fairly simply done as part of the wrappers: The allocator stores the 
vaddr, paddr and size in a hash table.  Thus, the paddr can be deduced when 
kmem_cache_alloc is called by the allocation wrapper using the linearity 
property.

I've got to say though that the most sensible course of action is still to 
generalise pci_pool, which can be done easily and safely.  I think replacing 
it with a slab based scheme is probably a 2.7 thing.

James




