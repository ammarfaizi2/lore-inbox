Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132661AbQLNTF7>; Thu, 14 Dec 2000 14:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132677AbQLNTFt>; Thu, 14 Dec 2000 14:05:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132661AbQLNTFo>; Thu, 14 Dec 2000 14:05:44 -0500
Subject: Re: Physical memory addresses/PCI memory addresses/io_remap
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Thu, 14 Dec 2000 18:37:22 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <FA894952830@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Dec 14, 2000 05:56:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146dFr-00009D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1. Should pci_resource_start be returning the PCI memory space address or
> >    a physical memory space address?
> 
> I believe that pci_resource_start() should return physical address, not
> bus one. It already happens on PReP.

It returns a cookie for use with ioremap. Who says that a given device has
a constant bus or physical mapping that is unique ?

> > 4. What does this mean for ioremap?  (currently, on ARM, ioremap takes
> >    PCI memory space addresses, not a physical memory address, which makes
> >    the physmap MTD driver technically broken).
> 
> And ioremap() should take physical address, returning virtual one.

No. Ioremap takes a cookie and returns a different cookie suitable for using
with readb/writeb/memcpy_fromio and friends.

Eg on Sparc64 its a physical address and readb uses TLB bypass

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
