Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTJ0OPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTJ0OPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:15:37 -0500
Received: from vic20.blipp.com ([217.75.101.38]:6125 "EHLO vic20.blipp.com")
	by vger.kernel.org with ESMTP id S262321AbTJ0OPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:15:33 -0500
Date: Mon, 27 Oct 2003 15:15:32 +0100
From: Patrik Wallstrom <pawal@blipp.com>
To: linux-kernel@vger.kernel.org
Subject: SATA and 2.6.0-test9
Message-ID: <20031027141531.GD15558@vic20.blipp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Foodfight Stockholm
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jeff Garzik:
>   o [libata] Merge Serial ATA core, and drivers for
>   o [libata] Integrate Serial ATA driver into kernel tree

I am happy to see these in the kernel now, but I have yet to get them
working on my KT6 Delta KT600 motherboard with the VT8237 SATA
southbridge controller or even the Promise controller.

These are the devices:

  Bus  0, device  13, function  0:
    RAID bus controller: PCI device 105a:3373 (Promise Technology, )
    (rev 2).
      IRQ 19.
      Master Capable.  Latency=96.  Min Gnt=4.Max Lat=18.
      I/O at 0xec00 [0xec3f].
      I/O at 0xe800 [0xe80f].
      I/O at 0xe400 [0xe47f].
      Non-prefetchable 32 bit memory at 0xdffdb000 [0xdffdbfff].
      Non-prefetchable 32 bit memory at 0xdffa0000 [0xdffbffff].

Bus  0, device  15, function  0:
    RAID bus controller: PCI device 1106:3149 (VIA Technologies, In)
    (rev 128).
      IRQ 16.
      Master Capable.  Latency=32.
      I/O at 0xd800 [0xd807].
      I/O at 0xd400 [0xd403].
      I/O at 0xd000 [0xd007].
      I/O at 0xcc00 [0xcc03].
      I/O at 0xc800 [0xc80f].
      I/O at 0xc400 [0xc4ff].


And I am booting the kernel with these parameters to not let the IDE
drivers catch the SATA-drives:
ide2=noprobe ide3=noprobe hde=noprobe hdg=noprobe apm=power-off

I am booting from a working IDE drive, to see if I can get the
SATA-drives working:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DPTA-372050, ATA DISK drive
hdb: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(33)
 hda: hda1 hda2 hda3
hdb: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)


And here is the SATA on the Promise chipset (SATA378 TX2plus):
libata version 0.75 loaded.
sata_via version 0.11
ata1: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
ata2: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
ATA: abnormal status 0x7F on port 0xD807
scsi0 : sata_via
ata1: thread exiting
ATA: abnormal status 0x7F on port 0xD007
ata2: thread exiting
scsi1 : sata_via
(kernel continues)

SATA on the VIA-chipset (VIA Serial ATA RAID):
ata1: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 16
ata2: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 16
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 ATA, max UDMA/133, 156301488 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: ST380013AS        Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST380013AS        Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda:<3>ata1: DMA timeout, stat 0x4
(then hangs the kernel)

What can I do to make either the Promise or the VIA interface work
fine with the SATA disks?

-- 
patrik_wallstrom->foodfight->pawal@blipp.com->+46-733173956
                `-> http://www.gnuheter.com/
