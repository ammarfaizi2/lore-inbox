Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285169AbRL0Gyr>; Thu, 27 Dec 2001 01:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286221AbRL0Gyi>; Thu, 27 Dec 2001 01:54:38 -0500
Received: from ns2.q-station.net ([202.66.128.35]:1029 "HELO
	smtp.q-station.net") by vger.kernel.org with SMTP
	id <S285169AbRL0Gy0>; Thu, 27 Dec 2001 01:54:26 -0500
Date: Thu, 27 Dec 2001 14:54:22 +0800 (CST)
From: Leung Yau Wai <chris@gist.q-station.net>
To: linux-kernel@vger.kernel.org
cc: chris@q-station.net
Subject: dd cdrom error
Message-ID: <Pine.LNX.4.10.10112271442090.3984-100000@gist.q-station.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

	I come across a problem which seem exist in kernel 2.4.x but not
in 2.2.x.

	The problem is that, when I try to using dd to create a ISO image
of a cdrom then around dumping the end of the disc it will give out the
following error message:

e.g. dd if=/dev/cdrom of=n.iso

Dec 22 16:53:25 rainbow kernel: hdd: command error: status=0x51 {
DriveReady SeekComplete Error }
Dec 22 16:53:25 rainbow kernel: hdd: command error: error=0x54
Dec 22 16:53:25 rainbow kernel: end_request: I/O error, dev 16:40 (hdd),
sector 1324148
Dec 22 16:56:51 rainbow kernel: hdd: command error: status=0x51 {
DriveReady SeekComplete Error }
Dec 22 16:56:51 rainbow kernel: hdd: command error: error=0x54
Dec 22 16:56:51 rainbow kernel: end_request: I/O error, dev 16:40 (hdd),
sector 1323912
Dec 22 16:56:51 rainbow kernel: hdd: command error: status=0x51 {
DriveReady SeekComplete Error }
Dec 22 16:56:51 rainbow kernel: hdd: command error: error=0x54
Dec 22 16:56:51 rainbow kernel: end_request: I/O error, dev 16:40 (hdd),
sector 1323916


	However, the problem will gone if I trun off the DMA support of my
cdrom under kernel 2.4.x.

e.g. hdparm -d0 /dev/hdd


	Then I recheck everything, keeping the same OS, the same machine
except booting the 2.2.X kernel (with UDMA patch to support my Promise
UDMA 66 controller). Then everything will run fine even turn on the DMA
support of the cdrom.

	Could anyone tell me what happened? Or, anything I missed? or I
should give which information to get some help?


My machine is a
Asus P3BF
with Promise UDMA66 add-on-card

cutting a part of dmesg from booting 2.4.17 hope can help
------------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
PDC20262: IDE controller on PCI bus 00 dev 58
PCI: Found IRQ 5 for device 00:0b.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:DMA
hdd: CD-S500/A, ATAPI CD/DVD-ROM drive
hde: IBM-DPTA-372050, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb002 on irq 5
hde: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, UDMA(66)

---------------------------------------------------------------------

	Thanks your attention


Chris

