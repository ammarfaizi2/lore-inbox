Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSLaRPH>; Tue, 31 Dec 2002 12:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSLaRPH>; Tue, 31 Dec 2002 12:15:07 -0500
Received: from host194.steeleye.com ([66.206.164.34]:11792 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264625AbSLaRPG>; Tue, 31 Dec 2002 12:15:06 -0500
Message-Id: <200212311723.gBVHNS502319@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Tue, 31 Dec 2002 09:04:44 PST." <3E11CE2C.3000308@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Dec 2002 11:23:28 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> The same is true of the slab code, which is a better allocator.  Why
> should kernels require an extra allocator, when pci_pool can safely be
> eliminated on quite a few systems? 

I agree in principle.  But the way to get this to work is to allow the slab 
allocater to specify its getpages and freepages in the same way as ctor and 
dtor, so it can be fed by dma_alloc_coherent.  Then you can wrapper the slab 
allocator to be used across all platforms (rather than only those which are 
coherent and have no IOMMU).

The benefit mempool has over slab is its guaranteed minimum pool size and 
hence guaranteed non-failing allocations as long as you manage pool resizing 
correctly.  I suppose this is primarily useful for storage devices, which 
sometimes need memory that cannot be obtained from doing I/O.

However, you can base mempool off slab modified to use dma_alloc_coherent() 
and get the benefits of everything.

James


