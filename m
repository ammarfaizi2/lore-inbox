Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWH1T5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWH1T5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWH1T5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:57:15 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:16305 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750739AbWH1T5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:57:14 -0400
Date: Mon, 28 Aug 2006 15:57:09 -0400
To: Gustavo Guillermo P?rez <gustavo@compunauta.com>
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
Message-ID: <20060828195709.GL13641@csclub.uwaterloo.ca>
References: <200608271239.32507.gustavo@compunauta.com> <200608271316.22992.gustavo@compunauta.com> <44F1E42B.2010601@garzik.org> <200608271434.35840.gustavo@compunauta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608271434.35840.gustavo@compunauta.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 02:34:35PM -0500, Gustavo Guillermo P?rez wrote:
> forgot to said "off"
> BIOS has Enhaced or Combined mode, but no one of this options helps.
> Disabling SATA, and using a normal ATAPI Hard Drive, let me use DMA for Atapi 
> Devices and works.
> 
> But I see this problem on a newest sony vaio laptop too, having the same 
> chipset, on this one there is no option for sata, cause there is no sata...
> 
> 00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express Memory 
> Controller Hub (rev 04)
> 00:02.0 Display controller: Intel Corporation 82915G/GV/910GL Express Chipset 
> Family Graphics Controller (rev 04)
> 00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> High Definition Audio Controller (rev 04)
> 00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #1 (rev 04)
> 00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #2 (rev 04)
> 00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #3 (rev 04)
> 00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB UHCI #4 (rev 04)
> 00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> USB2 EHCI Controller (rev 04)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4)
> 00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
> Bridge (rev 04)
> 00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
> IDE Controller (rev 04)
> 00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
> Controller (rev 04)
> 01:00.0 Multimedia video controller: Internext Compression Inc iTVC16 
> (CX23416) MPEG-2 Encoder (rev 01)
> 01:01.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 
> AGP 8x] (rev c1)
> 01:02.0 Communication controller: Agere Systems V.92 56K WinModem (rev 03)
> 01:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE 
> (LOM) Ethernet Controller (rev 04)
> 01:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
> (rev 80)
> root@rp-1 /home/gus # hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 16383/255/63, sectors = 156368016, start = 0

Make sure the piix ide drive is loaded BEFORE the ide-generic driver,
otherwise the wrong driver will run the PATA port, and the generic
driver doesn't do DMA.  Your dmesg did not look like it was using the
piix driver for PATA, it looked like ide-generic.  Some initrd systems
seem to load ide-generic for cdrom, if the HD is on sata or scsi, or
something later in the boot process does it.

You should see something like (using piix driver, ata_piix would look
somewhat different I think):

ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide1...

Yours had:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SAMSUNG SP0802N, ATA DISK drive
hdd: TSSTcorpCD/DVDW TS-H552L, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63
hdc: cache flushes supported
 /dev/ide/host1/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 16
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ATA: abnormal status 0x7F on port 0x1F7
ata1: disabling port
scsi0 : ata_piix

That looks like ata_piix couldn't get at the ide port because it was
already taken by the generic driver already.

--
Len Sorensen
