Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbSKPSFw>; Sat, 16 Nov 2002 13:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267323AbSKPSFw>; Sat, 16 Nov 2002 13:05:52 -0500
Received: from host194.steeleye.com ([66.206.164.34]:4100 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267322AbSKPSFv>; Sat, 16 Nov 2002 13:05:51 -0500
Message-Id: <200211161812.gAGICj604696@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Arnd Bergmann <ibm.com@arndb.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>
Subject: Re: [RFC][PATCH] move dma_mask into struct device 
In-Reply-To: Message from Arnd Bergmann <arndb@de.ibm.com> 
   of "Sat, 16 Nov 2002 20:56:54 +0100." <200211162056.54008.arndb@de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 13:12:44 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arndb@de.ibm.com said:
> You can easily keep out the pci stuff if you do something like this: 

No...look at what you've done.  Now SCSI has to know about every bus type on 
every architecture; that's an extreme layering violation.  architecture/bus 
types are generally only defined for the arch (PCI being the exception), so 
now the additions have to be #ifdef'd just so it will compile..

You've done this because you effectively have to pull a common but differently 
located structure element out of each of these bus specific devices.  That 
implies to me that dma_mask should be in a common structure, which was the 
whole basis for the dmaable_device that I outlined previously.  As I said, the 
only reason I haven't implemented dmaable_device is for expediency.

James


