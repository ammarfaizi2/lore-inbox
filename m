Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUJZRmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUJZRmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUJZRmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:42:55 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:25515 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S261356AbUJZRmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:42:42 -0400
From: "Lincoln D. Durey" <durey@EmperorLinux.com>
Organization: EmperorLinux
To: LKML <linux-kernel@vger.kernel.org>
Subject: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
Date: Tue, 26 Oct 2004 13:42:33 -0400
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>, David Hinds <dhinds@sonic.net>,
       Emperor Research <research@EmperorLinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261342.33924.durey@EmperorLinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of you will recall the woefull tale of the IBM T40 with 2GB RAM, and a 
not happy pcmcia_cs.  http://lkml.org/lkml/2003/8/14/89
This was resolved with a new BIOS from IBM.

However, along the way Linus replied with: http://lkml.org/lkml/2003/8/14/94
and then David Hinds said this:

> I'd bet that your BIOS is mis-configuring the CardBus bridge because
> it can't handle >1GB of RAM.  Check 'lspci -v' and see what memory
> addresses the CardBus bridges are using.  I bet they are < 0x80000000.

> In theory the kernel could recognize this situation and remap PCI
> devices to sane addresses.  That's a problem with the PCI subsystem
> and you'd need to raise that on the linux-kernel mailing list.

So, now we have a new Sony S170 (spiffy ultra-portable laptop) with a 
failure to recognize cards when it has 1GB ram installed.  And I'm 
wondering if anyone wants to tackle having the kernel PCI system remap this 
pcmcia socket's memory so it can see cards ?

        booting with 1GB ram:

kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus] [pm]
kernel: Yenta IRQ list 0000, PCI irq9
kernel: Socket status: 00000000

        revert to 512MB or 768MB ram, and you get a happy PCMCIA slot:

kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus] [pm]
kernel: Yenta IRQ list 0cf8, PCI irq9
kernel: Socket status: 30000410

The is completely independent of the kernel (2.4.24 and 2.6.8 have the same 
problem (as its really a BIOS problem I think.)  Cardbus and PCMCIA cards 
are affected equally.

lspci: Sony S170
02:04.0 CardBus bridge: Texas Instruments: Unknown device ac8e

        Full logs are available: (dmesg, lspci -xxx, iomem, ioports) 
http://www.emperorlinux.com/research/lkml/S170-1GB-pcmcia

 -- Lincoln @ EmperorLinux     http://www.EmperorLinux.com

