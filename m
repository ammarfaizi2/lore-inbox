Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbSKPP0x>; Sat, 16 Nov 2002 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbSKPP0x>; Sat, 16 Nov 2002 10:26:53 -0500
Received: from host194.steeleye.com ([66.206.164.34]:34066 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267291AbSKPP0w>; Sat, 16 Nov 2002 10:26:52 -0500
Message-Id: <200211161533.gAGFXiF02733@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Arnd Bergmann <ibm.com@arndb.de>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [RFC][PATCH] move dma_mask into struct device 
In-Reply-To: Message from Arnd Bergmann <arndb@de.ibm.com> 
   of "Sat, 16 Nov 2002 18:23:48 +0100." <200211161823.48018.arndb@de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 10:33:44 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arndb@de.ibm.com said:
> That does not sound like the right way to me. If you need to have the
> dma_mask for the Scsi_Host, you should store it in Scsi_Host itself. A
> struct device must never know about obscure architecture specific
> stuff like dma.

The SCSI host itself has no need of a DMA mask.  What we need the mask for is 
to set up the bounce limits for the block queue, we don't actually ever use it 
again.  Unfortunately, dma_mask isn't architecture specific, its a universal 
property of the block queues used to determine when to bounce memory regions.

The dma_mask is a property of the connection of the Scsi_Host to the machine 
bus, not of the Scsi_Host itself, so it does properly belong in the generic 
device which is used to reflect machine bus attachments.

Think of it this way: we have two struct device's per SCSI host: one for the 
actual HBA card or bus attachment, which contains all of the bus specific 
pieces, and one for the host itself reflecting the fact that it is a bridge 
from the machine bus to the scsi bus.

James



