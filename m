Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbSJBKJ7>; Wed, 2 Oct 2002 06:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbSJBKJ7>; Wed, 2 Oct 2002 06:09:59 -0400
Received: from slarti.muc.de ([193.149.48.10]:36625 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S263028AbSJBKJ4> convert rfc822-to-8bit;
	Wed, 2 Oct 2002 06:09:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Stephan Maciej <stephan@maciej.muc.de>
To: linux-kernel@vger.kernel.org
Subject: A7V333, 2.4.20-pre8 does not detect on-board Promise PDC20276, 2.4.19 does
Date: Tue, 1 Oct 2002 23:09:56 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210012309.56513.stephan@maciej.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I bought a new ASUS A7V333 board today. Kernel 2.4.20-pre8 does not detect the 
on-board PDC20276 IDE raid controller on the board despite it boots from a 
harddrive connected to this controller. It halts and complains that it can't 
mount the root fs.

2.4.19 works. I have used identical compile settings for both kernels.

Otherwise the board works pretty well, but see below.

lspci says:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:06.0 RAID bus controller: Promise Technology, Inc.: Unknown device 5275 
(rev 01)
00:07.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51)
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
74)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 11)

Device 00:06.0 is the 20276 controller. I have an Athlon XP 2000+ running at 
1.667 GHz and one 512MB PC266 DDR-RAM stick installed. My disk setup:

ide0 (onboard ATA100 -> VIA VT8233)
-> CDR as master: ASUS CD-S520/A

ide1 (onboard ATA100 -> VIA VT8233)
-> CDRW as master: ASUS CRW-4012A

ide2 (onboard PDC20276)
-> HD as master: IBM-DJNA-352030 (20G ATA100 harddisk), my root filesystem 
lies here

ide3 (onboard PDC20276)
-> HD as master: IC35L060AVVA07-0 (60G ATA133 harddisk), data storage disk

LILO can load both kernels from the 20G HD (ide2) without problems. 

Please have a look at the appended 2.4.19 dmesg output, too. There is one 
interesting line in there:

VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using 
pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1

Even when I try using pci=biosirq this line shows up. So what does it mean and 
what can I do against it? :-)

I also do get the "spurious 8259A interrupt: IRQ7." output. I have looked it 
up in the kernel sources and I found some interesting comments there. But 
wait, this line shows up on every VIA based system I have ever had in my 
life:
- Asus P5A (older board for K6 processors)
- my broken A7V133 (VIA KT133)
- my new A7V333 (KT333, you guessed it)
- my Sony laptop (KT133)

How serious is this?

Also note that my KT333 chipset gets detected as KT266 chipset. May this be 
because I have installed PC266 DDR-RAM, not PC333? I get

calibrating APIC timer ...
..... CPU clock speed is 1666.2239 MHz.
..... host bus clock speed is 266.5956 MHz. <---

in my dmesg, which is correct. Does this influence the chipset detection? 
(hehe, I am waiting for someone who responds "yes, it does, it makes it 
faster"... =8-)

Okay, here's my dmesg (well, partially):

PCI: PCI BIOS revision 2.10 entry at 0xf1aa0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/3147] at 00:11.0
PCI: Found IRQ 12 for device 00:09.0
PCI: Sharing IRQ 12 with 00:06.0
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:0d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Via IRQ fixup for 00:09.0, from 255 to 12
PCI: Via IRQ fixup for 00:09.1, from 255 to 11
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20276: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 12 for device 00:06.0
PCI: Sharing IRQ 12 with 00:09.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using 
pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
hda: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
hdc: ASUS CRW-4012A, ATAPI CD/DVD-ROM drive
hde: IBM-DJNA-352030, ATA DISK drive
hdg: IC35L060AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd400-0xd407,0xd002 on irq 12
ide3 at 0xb800-0xb807,0xb402 on irq 12
hde: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63, UDMA(66)
hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
hda: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: [PTBL] [2482/255/63] hde1 hde2 hde3
 hdg: [PTBL] [7476/255/63] hdg1 hdg2

Greetings,

Stephan

-- 
"That's interesting.  Can it be disabled?" -- someone on LKML, after being 
told about the PIV hyperthreading features

