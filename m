Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131927AbQKRXIi>; Sat, 18 Nov 2000 18:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131933AbQKRXI3>; Sat, 18 Nov 2000 18:08:29 -0500
Received: from h-dialin-211.addcom.de ([213.61.83.219]:21253 "EHLO
	server1.localnet") by vger.kernel.org with ESMTP id <S131927AbQKRXIQ> convert rfc822-to-8bit;
	Sat, 18 Nov 2000 18:08:16 -0500
To: linux-kernel@vger.kernel.org
Subject: VIA IDE UDMA Mode x -> CRC-ERRORs (2.4.0-testxx)
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (GTK)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <20001118233837L.rene@jackson>
Date: Sat, 18 Nov 2000 23:38:37 +0100
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have an Asus K7M motherboard with an AMD Irongate and a VIA VT82C686
connected to an IBM-DPTA-372050 and/or IBM-DTLA-307030.

I ever had IDE-DMA problems since I got the board in the beginning of
this year.

Until Kernel 2.4.0-test7 (or test6 or 8?) it was not possible to use a
ATA-66 cable and DMA. I got a never ending list of:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

My hack solution was to use a normal and cheap 40pol cable and was
able to use UDMA Mode 2.

Since test8 (the bigger via change - or so) I get the same CRC-error
with the normal 40pol cable, too. But after a IDE-Bus reset: "ide0:
reset: success" to MDMA Mode 2 I'm able to use the harddisc - a bit
slower. Since then I'm able to use a 80pol cable and get the same
(much lines of error and a reset) result.

I get the same results with a IBM-DPTA-372050 or IBM-DTLA-307030.

With test10 and a 80pol cable I did a bit more testing a few minutes
ago:
When I connect one of the discs to the second ide-channel this second
hd runs fine in DMA Mode 4 without any problem!

When I connect on of the discs as slave to the same channel this
second disc runs fine in UDMA Mode 4 !!?!

I did a short test with test11-pre7 with the same strange results. All
kernels where compiled with gcc-2.95.2 on RockLinux-1.3.9.

The "ATA/IDE/MFM/RLL support", "Include IDE/ATA-2 DISK support" ,
"VIA82CXXX chipset support", "Generic 4 drives/port support" and "Use
PCI DMA by default when available" are compiled into the kernel.

A friend has the same board and kernels and had no problems with DMA
modes. But he has a Seagate or Western disc. IBM only problem?? I
don't have non IBM discs to test here ...

A longer cut from syslog:

<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>VP_IDE: IDE controller on PCI bus 00 dev 21
<4>VP_IDE: chipset revision 6
<4>VP_IDE: not 100% native mode: will probe irqs later
<6>VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:4.1
<4>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
<4>hda: IBM-DTLA-307030, ATA DISK drive
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(66)

Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x53 { DriveReady SeekComplete Index Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:34 jackson kernel: hda: dma_intr: status=0x53 {DriveReady SeekComplete Index Error } 
-- CUT much lines of this style --
Nov 18 22:31:34 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 18 22:31:35 jackson kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 18 22:31:35 jackson kernel: ide0: reset: success 

Any ideas?? Please cc me cause I'm currently not on the list.

k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
