Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbSLDVfN>; Wed, 4 Dec 2002 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSLDVfN>; Wed, 4 Dec 2002 16:35:13 -0500
Received: from host194.steeleye.com ([66.206.164.34]:11784 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267101AbSLDVfL>; Wed, 4 Dec 2002 16:35:11 -0500
Message-Id: <200212042142.gB4LgfI04384@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Miles Bader <miles@gnu.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from Miles Bader <miles@gnu.org> 
   of "05 Dec 2002 06:21:42 +0900." <87smxdiiop.fsf@tc-1-100.kawasaki.gol.ne.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 15:42:41 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miles@gnu.org said:
> Keep in mind that sometimes the actual _implementation_ is also highly
> PCI-specific -- that is, what works for PCI devices may not work for
> other devices and vice-versa.

> So perhaps instead of just replacing `pci_...' with `dma_...', it
> would be better to add new function pointers to `struct bus_type' for
> all this stuff (or something like that). 

Not really, that can all be taken care of in the platform implementation.

The parisc implementation has exactly that problem.  The platform 
implementation uses the generic device platform_data to cache the iommu 
accessor methods (it actually finds the iommu by walking up the device parents 
until it gets to the iommu driver--which means it needs to walk off the PCI 
bus).

In general, the generic device already has enough information that the 
platform implementation can be highly bus specific---and, of course, once you 
know exactly what bus it's on, you can cast it to the bus device if you want.

James


