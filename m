Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276990AbRJCVap>; Wed, 3 Oct 2001 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276989AbRJCVag>; Wed, 3 Oct 2001 17:30:36 -0400
Received: from colorfullife.com ([216.156.138.34]:30213 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276990AbRJCVaa>;
	Wed, 3 Oct 2001 17:30:30 -0400
Message-ID: <000b01c14c52$b4de6eb0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Linux Bigot" <linuxopinion@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to get virtual address from dma address
Date: Wed, 3 Oct 2001 23:30:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then why isn't there a call like pci_unmap_single()

<<< linux/include/asm-i386/pci.h:
/* Unmap a single streaming mode DMA translation.  The dma_addr and size
 * must match what was provided for in a previous pci_map_single call.
All
 * other usages are undefined.
 *
 * After this call, reads by the cpu to the buffer are guarenteed to see
 * whatever the device wrote there.
 */
static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t
dma_addr,
                                    size_t size, int direction)
<<<<

Please try to store both the dma address and the virtual address in your
driver and use pci_map_single().
I'm aware of one case where that's not possible: if your hardware builds
a linked list of finished commands, and that list is in DMA addresses,
not virtual addresses.
I think both sym53c8xx and one of the USB controllers (usb-ohci.c?) have
that problem, they use a hash table for the reverse dma address->linear
address mapping.

I hope that answers your question.

--
    Manfred

