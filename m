Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRAGMUz>; Sun, 7 Jan 2001 07:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRAGMUu>; Sun, 7 Jan 2001 07:20:50 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:15264 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S131079AbRAGMUc>; Sun, 7 Jan 2001 07:20:32 -0500
Date: Sun, 7 Jan 2001 12:28:00 +0000
From: Philip Armstrong <phil@kantaka.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Related VIA PCI crazyness?
Message-ID: <20010107122800.A636@kantaka.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In supplement to Evan Thompson's emails with the subject "Additional
info. for PCI VIA IDE crazyness. Please read." I've noticed the
following message with recent 2.4.0 test + release kernels:

IRQ routing conflict in pirq table! Try 'pci=autoirq'

Booting with pci=autoirq results in an error message. Has this option
been removed at some point?

Setting DEBUG in arch/i386/kernel/pci-i386.h results in the following
extra messages in the boot log (+ a few context lines):

PCI: BIOS32 Service Directory structure at 0xc00fb0a0
PCI: BIOS32 Service Directory entry at 0xfb520
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb550, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf00
00:08 slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:09 slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
00:0a slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:0b slot=04 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:0c slot=05 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:07 slot=00 0:00/deb8 1:00/deb8 2:00/deb8 3:00/deb8
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource e0000000-e7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000e000-0000e00f (f=101, d=0, p=0)
PCI: Resource 0000e400-0000e41f (f=101, d=0, p=0)
PCI: Resource 0000e800-0000e8ff (f=101, d=0, p=0)
PCI: Resource ef100000-ef1000ff (f=200, d=0, p=0)
PCI: Resource 0000ec00-0000ecff (f=101, d=0, p=0)
PCI: Resource ef101000-ef1010ff (f=200, d=0, p=0)
PCI: Resource ef000000-ef0fffff (f=200, d=0, p=0)
PCI: Resource ee000000-eeffffff (f=1208, d=0, p=0)
PCI: Resource ec000000-ecffffff (f=1208, d=0, p=0)
PCI: Resource e8000000-e8003fff (f=200, d=0, p=0)
PCI: Resource e9000000-e97fffff (f=200, d=0, p=0)
PCI: Sorting device list...
...
Starting kswapd v1.8
IRQ for 01:00.0:0 -> not found in routing table
matroxfb: Matrox Millennium II (AGP) detected
...
SCSI subsystem driver Revision: 1.00
IRQ for 00:08.0:0 -> PIRQ 01, mask deb8, excl 0e00 -> newirq=11 -> got IRQ 9
IRQ routing conflict in pirq table! Try 'pci=autoirq'
scsi0 : AdvanSys SCSI 3.2M: PCI Ultra 240 CDB: IO E800/F, IRQ 11
...
8139too Fast Ethernet driver 0.9.13 loaded
IRQ for 00:0a.0:0 -> PIRQ 03, mask deb8, excl 0e00 -> newirq=9 -> got IRQ 11
IRQ routing conflict in pirq table! Try 'pci=autoirq'
eth0: RealTek RTL8139 Fast Ethernet at 0xc8c39000, 00:40:95:33:7a:51, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139B'
...

The IDE controller part of the boot log says:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: FUJITSU M1638TAU, ATA DISK drive
hdb: LS-120 COSM 05 UHD Floppy, ATAPI FLOPPY drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hdc: ST310212A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

So this may or may not be related to Evan's PCI IDE driver issues.

The bios is 

BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 06/19/98

and the output of lspci is:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:08.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0b.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 01)
00:0c.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] AGP

HTH someone.

cheers,

Phil Armstrong

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
