Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKUIKY>; Tue, 21 Nov 2000 03:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbQKUIKP>; Tue, 21 Nov 2000 03:10:15 -0500
Received: from tuttifrutti.cdt.luth.se ([130.240.52.34]:9220 "HELO
	tuttifrutti.cdt.luth.se") by vger.kernel.org with SMTP
	id <S129259AbQKUIJ6> convert rfc822-to-8bit; Tue, 21 Nov 2000 03:09:58 -0500
X-Mailer: exmh version 2.2 10/15/1999 with nmh-1.0.4
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0, test10, test11: HPT366 problem
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 21 Nov 2000 08:39:49 +0100
Message-Id: <20001121073955.16B948960@tuttifrutti.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

I'm having problems when booting 2.4.0 test10 and test11 kernels
(perhaps some earlier kernels too).
Approximately nine out of ten times the kernel hangs when
trying to detect partitions on the first HPT366 disk.

It looks something like this:

  Nov 21 08:08:40 t kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
  Nov 21 08:08:40 t kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  Nov 21 08:08:40 t kernel: PIIX4: IDE controller on PCI bus 00 dev 39
  Nov 21 08:08:40 t kernel: PIIX4: chipset revision 1
  Nov 21 08:08:40 t kernel: PIIX4: not 100%% native mode: will probe irqs later
  Nov 21 08:08:40 t kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
  Nov 21 08:08:40 t kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
  Nov 21 08:08:40 t kernel: HPT366: IDE controller on PCI bus 00 dev 48
  Nov 21 08:08:40 t kernel: HPT366: chipset revision 1
  Nov 21 08:08:40 t kernel: HPT366: not 100%% native mode: will probe irqs later
  Nov 21 08:08:40 t kernel:     ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:DMA, hdf:pio
  Nov 21 08:08:40 t kernel: HPT366: IDE controller on PCI bus 00 dev 49
  Nov 21 08:08:40 t kernel: HPT366: chipset revision 1
  Nov 21 08:08:40 t kernel: HPT366: not 100%% native mode: will probe irqs later
  Nov 21 08:08:40 t kernel:     ide3: BM-DMA at 0xb800-0xb807, BIOS settings: hdg:DMA, hdh:pio
  Nov 21 08:08:40 t kernel: hda: FUJITSU MPD3064AT, ATA DISK drive
  Nov 21 08:08:40 t kernel: hdc: Hewlett-Packard CD-Writer Plus 8200, ATAPI CDROM drive
  Nov 21 08:08:40 t kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
  Nov 21 08:08:40 t kernel: hde: IBM-DTLA-307030, ATA DISK drive
  Nov 21 08:08:40 t kernel: hdg: QUANTUM Bigfoot TX12.0AT, ATA DISK drive
  Nov 21 08:08:40 t kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  Nov 21 08:08:40 t kernel: ide1 at 0x170-0x177,0x376 on irq 15
  Nov 21 08:08:40 t kernel: ide2 at 0xa400-0xa407,0xa802 on irq 9
  Nov 21 08:08:40 t kernel: ide3 at 0xb000-0xb007,0xb402 on irq 9
  Nov 21 08:08:40 t kernel: hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=788/255/63, UDMA(33)
  Nov 21 08:08:40 t kernel: hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(66)
  Nov 21 08:08:40 t kernel: hdg: 23547888 sectors (12057 MB) w/69KiB Cache, CHS=23361/16/63, UDMA(33)
  Nov 21 08:08:40 t kernel: Partition check:
  Nov 21 08:08:40 t kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
  Nov 21 08:08:40 t kernel:  hde: hde1 hde2 < hde5

And then after a while it gets a DMA timeout and hangs hard.

The hang can occur anywhere during the partition detection and it can for 
instance also fail at once and look like:

  hde:

or fail even after the last partiton:

  hde: hde1 hde2 < hde5 hde6 hde7 hde8

Approximately one out of ten reboots the detection succedes and I'm able
to boot up the kernel and then everything works smoothly.

There are no problems when booting 2.2.*-kernels with the HPT366-patch.

Regards.

/Håkan


---------------------------------------
e-mail: Hakan.Lennestal@lu.erisoft.se |
     or Hakan.Lennestal@cdt.luth.se   |
---------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
