Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbTDJCTO (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 22:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTDJCTO (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 22:19:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47879
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263710AbTDJCTL (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 22:19:11 -0400
Date: Wed, 9 Apr 2003 19:29:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Dominik Brodowski <linux@brodo.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-ac1 IDE trouble
In-Reply-To: <Pine.LNX.4.51.0304092206070.1250@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.10.10304091927510.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change this to where dma_timer_expiry returns WAIT_CMD;

Let the CPU process the interrupt, and not generate the race!

The simple fix was to remove the execution of the handler and return to
back to the timer waiting.

Cheers,


On Wed, 9 Apr 2003, Maciej Soltysiak wrote:

> > Hi Alan,
> >
> > In recent 2.5. kernels I see a few messages like this during heavy I/O load:
> I have been getting similar too on non -ac kernels.
> 
> Apr  9 18:59:05 pysiak kernel: hdb: dma_timer_expiry: dma status == 0x64
> Apr  9 18:59:05 pysiak kernel: hdb: lost interrupt
> Apr  9 18:59:05 pysiak kernel: hdb: dma_intr: bad DMA status (dma_stat=70)
> Apr  9 18:59:05 pysiak kernel: hdb: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> Some more info:
> 
> Linux version 2.5.67 (root@pysiak) (gcc version 3.2.3 20030331 (Debian prerelease)) #4 Tue Apr 8 14:22:49 CEST 2003
> Linux Plug and Play Support v0.96 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fbc10
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbc40, dseg 0xf0000
> PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
> block request queues:
>  128 requests per read queue
>  128 requests per write queue
>  8 requests per batch
>  enter congestion at 15
>  exit congestion at 17
> PCI: Probing PCI hardware (bus 00)
> Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
> PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH2: IDE controller at PCI slot 00:1f.1
> ICH2: chipset revision 18
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> hda: IC35L020AVER07-0, ATA DISK drive
> hdb: WDC WD200BB-00CLB0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: CD-950E/TKU, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63, UDMA(100)
>  hda: hda1 hda2 hda3
> hdb: host protected area => 1
> hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
>  hdb: hdb1
> hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> 
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 03)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 12)
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12)
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 12)
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)
> 02:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
> 02:03.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
> 
> Regards,
> Maciej
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

