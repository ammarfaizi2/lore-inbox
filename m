Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279638AbRJXWmE>; Wed, 24 Oct 2001 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279635AbRJXWl4>; Wed, 24 Oct 2001 18:41:56 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:35793 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S279630AbRJXWlp>; Wed, 24 Oct 2001 18:41:45 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6A7@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Gert-Jan Rodenburg'" <hertog@home.nl>, linux-kernel@vger.kernel.org
Subject: RE: Issue wit ACPI and Promise?
Date: Wed, 24 Oct 2001 15:42:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IDE controller is on irq 9 and I bet ACPI is, too. I've seen other
reports like this.

Either the ACPI interrupt handler is not sharing properly or the promise
interrupt handler isn't. Given that I can't duplicate it, I'm reduced to
waiting for some kind soul to send a patch.. :-(

-- Andy

> -----Original Message-----
> From: Gert-Jan Rodenburg [mailto:hertog@home.nl]
> Sent: Wednesday, October 24, 2001 3:19 PM
> To: linux-kernel@vger.kernel.org
> Subject: Issue wit ACPI and Promise?
> Importance: High
> 
> 
> Hi,
> 
> Trembling all over, this is my first post on this list.
> Up 'till no I have refrained from posting for I alway thought 
> that any fault 
> was more likely to be originated by errors on my side, then 
> on software 
> written by you guys. Therefore, please be gentle *grin*.
> 
> Now for the problem:
> 
> I have an ASUS a7v-133 mobo and get the following messages 
> when I boot up:
> 
> <--Stuff from DMESG-->
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override 
> with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 21
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override 
> with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> PDC20265: IDE controller on PCI bus 00 dev 88
> PCI: Found IRQ 9 for device 00:11.0
> PDC20265: chipset revision 2
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary 
> PCI Mode.
>     ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:DMA
>     ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:pio, hdh:DMA
> hda: SS07 SAMSUNG DVD-ROM SD-612S, ATAPI CD/DVD-ROM drive
> hdc: MATSHITA CD-R CW-7582, ATAPI CD/DVD-ROM drive
> <-- Machine locks here when using ACPI, often with a "spurious 8259A 
> interrupt: IRQ7." -->
> 
> hde: IBM-DPTA-372050, ATA DISK drive
> hdf: FUJITSU MPC3043AT, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x9400-0x9407,0x9002 on irq 9
> hde: 40088160 sectors (20525 MB) w/1961KiB Cache, 
> CHS=39770/16/63, UDMA(66)
> hdf: 8448300 sectors (4326 MB), CHS=8940/15/63, UDMA(33)
> Partition check:
>  hde: hde1 hde2 hde3
>  hdf: hdf1 hdf2 hdf3
> 
> <--End Stuff from DMESG-->
> 
> This all seems correct to me, everything works too.
> 
> But whenever I enable ACPI in the kernel things stop at the 
> <-- Machine..... 
> line. Nothing else to do but a reset.
> 
> Because it stops right when the things with the drives on the 
> promise-connectors are to happen, I suspect that is the cullprit.
> 
> Any Ideas, or need for a more elaborate description of my 
> system? I gladly 
> will supply them to you all :)
> 
> Oh, also quite important:
> Linux bedroom 2.4.12-ac6 #1 Wed Oct 24 06:45:12 CEST 2001 i686 unknown
> 
> Gr.
> 
> Gert-Jan Rodenburg
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
