Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267304AbSKPQzH>; Sat, 16 Nov 2002 11:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267295AbSKPQzH>; Sat, 16 Nov 2002 11:55:07 -0500
Received: from host194.steeleye.com ([66.206.164.34]:6931 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267304AbSKPQzF>; Sat, 16 Nov 2002 11:55:05 -0500
Message-Id: <200211161701.gAGH1xF03711@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Arnd Bergmann <ibm.com@arndb.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>
Subject: Re: [RFC][PATCH] move dma_mask into struct device 
In-Reply-To: Message from Arnd Bergmann <arndb@de.ibm.com> 
   of "Sat, 16 Nov 2002 19:26:52 +0100." <200211161926.52092.arndb@de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 12:01:59 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arndb@de.ibm.com said:
> On my s390 system, I can have many thousand devices and none of them
> is doing DMA, so I would indeed call it architecture specific. Note
> that  even in a normal PC system, most devices (e.g. CPUs, input
> devices or the disks attached to the host adapter) don't have any
> concept of DMA. 

DMA itself is pervasive to almost every architecture, that's why we have the 
DMA API.  That some devices don't do DMA, I agree with (the struct scsi_device 
is another example).  However, in order to divorce DMA from the PCI bus, it 
has to be obtainable from the generic device, without requiring knowledge of 
the bus.  In OO terms, it would be in a dmaable_device which inherits from 
device, but for expediency in layering all this into the kernel means I'd have 
to break almost every driver and introduce them to the concept of 
dmaable_device, so it's just easier to expand device by a pointer.

James


