Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTC3XsI>; Sun, 30 Mar 2003 18:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTC3XsI>; Sun, 30 Mar 2003 18:48:08 -0500
Received: from gallium.deepthought.org ([64.253.103.121]:60585 "HELO
	gallium.deepthought.org") by vger.kernel.org with SMTP
	id <S261320AbTC3XsG>; Sun, 30 Mar 2003 18:48:06 -0500
Date: Sun, 30 Mar 2003 18:59:18 -0500 (EST)
From: Martin Murray <mmurray@deepthought.org>
To: linux-kernel@vger.kernel.org
Subject: accessing ROM on Rage 128 chips in aty128fb
Message-ID: <Pine.LNX.4.53.0303301846130.24044@gallium.deepthought.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a thinkpad A21p and am trying to use the aty128fb fbcon driver.
With 2.4.20 and 2.5.63, the lcd becomes garbled and erratic upon modprobe
of the module. I am trying to solve this problem.

I believe the aty128fb needs the correct pll values for my LCD which
stored in the Rage 128 ROM, however, the aty128fb does not find the ROM. I
compared the aty128fb initialization sequence to the ati driver from
X4.3.0, and found that the X driver maps the ROM through configuration
space.

I have been trying to implement this in the aty128fb driver, and have the
following questions:

How can I find a linear segment of address space [64k] to map the ROM to?

Why does the linux PCI code not set up a mapping for the ROM
automatically? pci_resource_start(pdev, PCI_ROM_RESOURCE) is 0, where
pdev is the Rage 128 chip.

Do I need to do anything further than write the base to the
PCI_ROM_ADDRESS register in the pci configuration space?
 - I tried this with the value 0xe8000001 without success. The last 1 is
the enable bit.

I noticed the AGP bridge had memory ranges mapped that encompassed those
required by the Rage 128 chip. Do I need to make another entry to properly
map the ROM?

I also noticed that the AGP bridge had mapped 64 megs of memory, and the
Rage 128 chip had also mapped 64 megs of memory, however, the chip has
only 16 megs of ram. There are seperate regions for the memory mapped
register and memory mapped I/O. Can I use the space above 16 megs to map
the ROM?

I inserted this code into aty128_pci_register() and it did not work:

unsigned char *ptr;
pci_write_config_dword(pdev, PCI_ROM_ADDRESS, 0xe8000001);
ptr = ioremap(0xe8000000, 0x10000);

if this were correct, ptr[0] would be 0x55 and ptr[1] would be 0xaa,
however, I read 0xff, 0xff respectively.

Any Suggestions?

Thank you, Martin Murray

Martin Murray, <mmurray@deepthought.org>, :\\//\\//:
- What is Industrial Music? It's the sound of angry
  Belgians having a fight with a washing machine.
Fear: Seeing B8:00:4C:CD:21, and knowing what it means.
