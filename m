Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130232AbQLFT4U>; Wed, 6 Dec 2000 14:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbQLFT4L>; Wed, 6 Dec 2000 14:56:11 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:3850
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130232AbQLFTz6>; Wed, 6 Dec 2000 14:55:58 -0500
Date: Wed, 6 Dec 2000 11:25:18 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Lamanna <jlamanna@its.caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PDC202xx driver
In-Reply-To: <3A2E3837.6B01FF9E@its.caltech.edu>
Message-ID: <Pine.LNX.4.10.10012061124400.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



<4>ide: Assuming 33MHz system bus speed for PIO modes
<4>AMD7409: IDE controller on PCI bus 00 dev 39
<4>AMD7409: chipset revision 7
<4>AMD7409: not 100% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
<4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
<4>PDC20267: IDE controller on PCI bus 00 dev 48
<4>PDC20267: chipset revision 2
<4>PDC20267: not 100% native mode: will probe irqs later
<4>PDC20267: ROM enabled at 0xe8000000
<4>PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
<4>    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
<4>    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:DMA, hdh:pio
<4>hda: QUANTUM FIREBALL CX13.0A, ATA DISK drive
<4>hdb: QUANTUM FIREBALL CR4.3A, ATA DISK drive
<4>hdc: ATAPI CD ROM DRIVE 50X MAX, ATAPI CDROM drive
<4>hde: Maxtor 91536H2, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0xc400-0xc407,0xc802 on irq 11

Nope you have a chipset that is designed wrong.

On Wed, 6 Dec 2000, James Lamanna wrote:

> Whenever I tried using the PDC202xx driver in 
> 2.4-test11 I kept receiving the line in dmsg:
> PDC20267: neither IDE port enabled (BIOS)
> 
> I traced this to ide-pci.c, line 606:
> if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) 
> 	|| (tmp & e->mask) != e->val))
>     continue;       /* port not enabled */
> 
> This if was returning true, and skipping the rest of the loop
> (which sets up the ioports...)
> So it looks like to me that it's not enabling the IOPorts
> for this chipset. This seems like a really bad thing, considering
> that I can gain no access to the drives currently using this driver.
> Any suggestions?
> 
> Thanks,
> --James Lamanna
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
