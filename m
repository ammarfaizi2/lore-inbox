Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNR2q>; Thu, 14 Dec 2000 12:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLNR2g>; Thu, 14 Dec 2000 12:28:36 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:14086 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129267AbQLNR21>;
	Thu, 14 Dec 2000 12:28:27 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 14 Dec 2000 17:56:54 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Physical memory addresses/PCI memory addresses/io_remap
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <FA894952830@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 00 at 15:16, Russell King wrote:
>   virtual space    - address space that the kernel runs in
>   physical space   - address space that the CPU sits in
>   PCI memory space - memory address space that the PCI peripherals sit in
    == bus address...
> 
> Many, if not all ARM architectures have physical address 0 different from
> PCI memory address 0.
> 
> According to include/linux/fb.h, fb drivers should place a physical address
> into "fix.smem_start" and "fix.mmio_start", which can then be passed to
> io_remap_page_range.
> 
> 1. Should pci_resource_start be returning the PCI memory space address or
>    a physical memory space address?

I believe that pci_resource_start() should return physical address, not
bus one. It already happens on PReP.
 
> 3. Do we need a macro to convert PCI memory space addresses to physical
>    memory space addresses?

No. You need PCI memory space address only for busmastering transfers.
And for PCI DMA there is specialized API... Currently all bus -> physical
mapping should be hidden in platform specific PCI code.
 
> 4. What does this mean for ioremap?  (currently, on ARM, ioremap takes
>    PCI memory space addresses, not a physical memory address, which makes
>    the physmap MTD driver technically broken).

And ioremap() should take physical address, returning virtual one.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
