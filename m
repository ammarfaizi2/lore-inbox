Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUEAFT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUEAFT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUEAFT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:19:26 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15547 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261989AbUEAFTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:19:24 -0400
Date: Fri, 30 Apr 2004 23:19:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI DMA Address
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <005701c42f3b$e1ab6aa0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <a826e204.0404282237.6a6b28b0@posting.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think ioremap is what you want here. ioremap is used to map a PCI
memory region on the card itself. To allocate a DMA region within system
memory to transfer to, you want something like pci_alloc_consistent (but
128MB seems a rather large amount to use for that function, given that it
allocates with GFP_ATOMIC..)


----- Original Message ----- 
From: "ina" <celina.miranda@eazix.com>
Newsgroups: fa.linux.kernel
Sent: Thursday, April 29, 2004 12:37 AM
Subject: PCI DMA Address


> Hi,
>
> I need to create a driver for a PCI camera device that uses DMA to
> transfer the captured images. The system that i use is an x86 board
> that has 128M of RAM, I reserved the top of the physical RAM during
> bootup by passing "mem=100".
>
> In my driver i claimed the reserved memory by using ioremap call:
> void* pAdd = ioremap(0x6400000,(1280x1024))
>
> This is the memory where the PCI device should DMA the captured data.
> My question is how do I tell the PCI device the DMA address? I know
> that inorder for the PCI device to access the DMA address correctly, i
> have to convert the return value of ioremap into a bus address. How do
> i do this? I already used:
> virt_to_phys(pAdd)
> but this doesn't seem to work.
>
> I read somewhere that the output of ioremap cannot be directly used
> for virt_to_phys function call, but I'm not really sure...
>
> Thanks,
> Ina

