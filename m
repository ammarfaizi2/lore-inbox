Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265734AbSKAUYp>; Fri, 1 Nov 2002 15:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265739AbSKAUYp>; Fri, 1 Nov 2002 15:24:45 -0500
Received: from user141.3eti.com ([65.220.88.141]:6416 "EHLO mail.aeptec.local")
	by vger.kernel.org with ESMTP id <S265734AbSKAUYm>;
	Fri, 1 Nov 2002 15:24:42 -0500
Message-ID: <EF5625F9F795C94BA28B150706A215480DF84D@MAIL>
From: "Donepudi, Suneeta" <sdonepudi@3eti.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Matt D. Robinson'" <yakker@aparity.com>
Subject: RE: Kernel Panic during memcpy_toio to PCI card
Date: Fri, 1 Nov 2002 15:34:45 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt,

Thanks for the response, I am using a 2.4.18 kernel with
a busybox. This is an embedded system with the file system
laid out by an 'initrd.gz'. I am new to Linux. Can LKCD
still be used in our case ?


Suneeta

-----Original Message-----
From: Matt D. Robinson [mailto:yakker@aparity.com]
Sent: Friday, November 01, 2002 3:26 PM
To: Donepudi, Suneeta; Matt D. Robinson
Subject: Re: Kernel Panic during memcpy_toio to PCI card


Hey, Suneeta.  Can you try LKCD and see if you can get
a crash dump with it?  Also, is this 2.4 or 2.5?

--Matt

On Fri, 1 Nov 2002, Donepudi, Suneeta wrote:
|>Hi,
|>
|>I would like help in diagnosing a kernel panic while accessing a PCI
device.
|>
|>Everything runs fine for sometime and in about 1/2 hour I get a Kernel
Panic
|>message saying :
|>
|>"Unable to handle kernel paging request at virtual address 0xc2821000"
|>
|>Analysis with Ksymoops shows that it is happening during a memcpy_toio()
|>with the PCI card. The PCI card uses three Base Address Registers with
|>virtual addresses mapped as follows (after ioremap has been issued):
|>
|>BAR0 = 0xc280f000
|>BAR1 = 0xc2811000
|>BAR2 = 0xc2822000
|>
|>It seems like the kernel panic is complaining about an address which is a
|>combination of BAR1 (lower bytes) and BAR2 (upper bytes). It should really
|>be accessing the BAR1 address at the point the crash occurred.
|>
|>I put the following if-statement just before the memcpy_toio():
|>-----------------------------------------------------------
|>if (((long int)pci_bar1) == 0xc2821000)
|>{
|>	printk (KERN_ERR "Illegal address for BAR1\n");
|>	return -1;
|>}
|>memcpy_toio (pci_bar1, in_ptr, len);
|>------------------------------------------------------------
|>
|>It still caused the crash in the same manner and at the same location.
|>Could someone help me with pointers to where I should start looking ?
|>Disabling interrupts around the memcpy_toio() did not make any
|>difference. Is this a hardware problem with the PCI card ? We are using
|>a Xilinx core with out FPGA build into it.
|>Is there a book I could read to learn more about debugging this in the 
|>Kernel ?
|>
|>Thanks a bunch,
|>Suneeta
