Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265367AbSKAT5q>; Fri, 1 Nov 2002 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265717AbSKAT5q>; Fri, 1 Nov 2002 14:57:46 -0500
Received: from user141.3eti.com ([65.220.88.141]:25612 "EHLO mail.aeptec.local")
	by vger.kernel.org with ESMTP id <S265367AbSKAT44>;
	Fri, 1 Nov 2002 14:56:56 -0500
Message-ID: <EF5625F9F795C94BA28B150706A215480DF84C@MAIL>
From: "Donepudi, Suneeta" <sdonepudi@3eti.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Donepudi, Suneeta" <sdonepudi@3eti.com>
Subject: Kernel Panic during memcpy_toio to PCI card
Date: Fri, 1 Nov 2002 15:06:59 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like help in diagnosing a kernel panic while accessing a PCI device.

Everything runs fine for sometime and in about 1/2 hour I get a Kernel Panic
message saying :

"Unable to handle kernel paging request at virtual address 0xc2821000"

Analysis with Ksymoops shows that it is happening during a memcpy_toio()
with the PCI card. The PCI card uses three Base Address Registers with
virtual addresses mapped as follows (after ioremap has been issued):

BAR0 = 0xc280f000
BAR1 = 0xc2811000
BAR2 = 0xc2822000

It seems like the kernel panic is complaining about an address which is a
combination of BAR1 (lower bytes) and BAR2 (upper bytes). It should really
be accessing the BAR1 address at the point the crash occurred.

I put the following if-statement just before the memcpy_toio():
-----------------------------------------------------------
if (((long int)pci_bar1) == 0xc2821000)
{
	printk (KERN_ERR "Illegal address for BAR1\n");
	return -1;
}
memcpy_toio (pci_bar1, in_ptr, len);
------------------------------------------------------------

It still caused the crash in the same manner and at the same location.
Could someone help me with pointers to where I should start looking ?
Disabling interrupts around the memcpy_toio() did not make any
difference. Is this a hardware problem with the PCI card ? We are using
a Xilinx core with out FPGA build into it.
Is there a book I could read to learn more about debugging this in the 
Kernel ?

Thanks a bunch,
Suneeta

