Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbSLEPRC>; Thu, 5 Dec 2002 10:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbSLEPRC>; Thu, 5 Dec 2002 10:17:02 -0500
Received: from host194.steeleye.com ([66.206.164.34]:1040 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267254AbSLEPRC>; Thu, 5 Dec 2002 10:17:02 -0500
Message-Id: <200212051524.gB5FOXD02152@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from Russell King <rmk@arm.linux.org.uk> 
   of "Thu, 05 Dec 2002 11:35:46 GMT." <20021205113546.A22686@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 09:24:33 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk@arm.linux.org.uk said:
> I'd rather keep our existing pci_* API than be forced into this crap
> again. 

Let me just clarify: I'm not planning to revoke the pci_* API, or to deviate 
substantially from it.  I'm not even planning to force any arch's to use it if 
they don't want to.  I'm actually thinking of putting something like this in 
the asm-generic implementations:

dma_*(struct device *dev, ...) {
	BUG_ON(dev->bus != &pci_bus_type)
	pci_*(to_pci_device(dev), ..)
}

The whole point is not to force another massive shift in the way drivers are 
written, but to provide a generic device based API for those who need it.  
There are very few drivers that actually have to allocate fake PCI devices 
today, but this API is aimed squarely at helping them.  Drivers that only ever 
see real PCI devices won't need touching.

James


