Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHHRqT>; Thu, 8 Aug 2002 13:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSHHRqT>; Thu, 8 Aug 2002 13:46:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55560
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317859AbSHHRqI>; Thu, 8 Aug 2002 13:46:08 -0400
Date: Thu, 8 Aug 2002 10:41:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
Subject: Part 2: Re: [PATCH] pdc20265 problem.
In-Reply-To: <170FF7412A6@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208081031140.25573-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two cases one HighPoint the other Promise.
See how they play games with device locations?

[root@autobuild root]# lspci
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:03.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04)
[root@autobuild root]#


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 18
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfeae0000
     (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide0: BM-DMA at 0xdf00-0xdf07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdc:pio, hdd:pio
SvrWks OSB4: IDE controller on PCI bus 00 dev 79
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DPTA-373420, ATA DISK drive
hdc: IBM-DPTA-373420, ATA DISK drive
hde: CW038D ATAPI CD-R/RW, ATAPI CD/DVD-ROM drive
ide0 at 0xdfe0-0xdfe7,0xdfae on irq 31
ide1 at 0xdfa0-0xdfa7,0xdfaa on irq 31
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14


bp6:~ # lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:0f.0 VGA compatible controller: S3 Inc. 86c988 [ViRGE/VX] (rev 02)
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT366: onboard version of chipset, pin1=1 pin2=2
PCI: HPT366: Fixing interrupt 18 pin 2 to ZERO
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xec00-0xec07, BIOS settings: hdc:DMA, hdd:pio
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: device disabled (BIOS)
hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0xd800-0xd807,0xdc02 on irq 18
ide1 at 0xe400-0xe407,0xe802 on irq 18
hda: setmax LBA 18041184, native  18039168
hda: DupliDisk IDE RAID-1 Adapter( 1.19), 8808MB w/371kB Cache, CHS=17896/16/63, UDMA(33)
hdc: QUANTUM FIREBALLP KA13.6, 13217MB w/371kB Cache, CHS=26853/16/63, UDMA(33)


Andre Hedrick
LAD Storage Consulting Group

