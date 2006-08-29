Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWH2BmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWH2BmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWH2BmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:42:23 -0400
Received: from compunauta.com ([69.36.170.169]:40593 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1750924AbWH2BmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:42:22 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
Date: Mon, 28 Aug 2006 20:42:26 -0500
User-Agent: KMail/1.8.2
References: <200608271239.32507.gustavo@compunauta.com> <200608271434.35840.gustavo@compunauta.com> <20060828195709.GL13641@csclub.uwaterloo.ca>
In-Reply-To: <20060828195709.GL13641@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608282042.26594.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Lunes, 28 de Agosto de 2006 14:57, escribió:
> Make sure the piix ide drive is loaded BEFORE the ide-generic driver,
> otherwise the wrong driver will run the PATA port, and the generic
> driver doesn't do DMA.  Your dmesg did not look like it was using the
> piix driver for PATA, it looked like ide-generic.  Some initrd systems
> seem to load ide-generic for cdrom, if the HD is on sata or scsi, or
> something later in the boot process does it.
>
> You should see something like (using piix driver, ata_piix would look
> somewhat different I think):
Builded into kernel we can't specify the load order, then you suggest to made 
an initrd with insmod loading firs scsi subsystem and piix before 
ide-generic... Ok I can do that, but imagine, making a kernel for a 
distribution, ;)

No problem, let me try.

> ICH5: IDE controller at PCI slot 0000:00:1f.1
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> Probing IDE interface ide1...
>
> Yours had:
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Probing IDE interface ide0...
> Probing IDE interface ide1...
> hdc: SAMSUNG SP0802N, ATA DISK drive
> hdd: TSSTcorpCD/DVDW TS-H552L, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: max request size: 512KiB
> hdc: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63
> hdc: cache flushes supported
>  /dev/ide/host1/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
> hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
> Uniform CD-ROM driver Revision: 3.20
> ide-floppy driver 0.99.newide
> libata version 1.20 loaded.
> ata_piix 0000:00:1f.2: version 1.05
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 16
> ata: 0x170 IDE port busy
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> ATA: abnormal status 0x7F on port 0x1F7
> ata1: disabling port
> scsi0 : ata_piix
>
> That looks like ata_piix couldn't get at the ide port because it was
> already taken by the generic driver already.
>
> --
> Len Sorensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
