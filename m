Return-Path: <linux-kernel-owner+w=401wt.eu-S1751418AbXAFQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXAFQZv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAFQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:25:51 -0500
Received: from main.gmane.org ([80.91.229.2]:37631 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXAFQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:25:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: JMicron JMB363 SATA hard disk appears twice (sda + hdg)
Date: Sat, 6 Jan 2007 17:25:32 +0100
Message-ID: <31vxryq446ny.b23nrmopmm4.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-54-235.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm using a Debain unstable 2.6.18-3 kernel on an ASRock
motherboard (VIA K8T890 chipset). The motherboard has IDE, SATA
and SATA_II controllers:

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.5 PIC: VIA Technologies, Inc. VT3351 I/O APIC Interrupt Controller
00:00.7 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. [K8T890 North / VT8237 South] PCI Bridge
00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.1 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.2 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.3 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
00:0f.0 IDE interface: VIA Technologies, Inc. VT8237A SATA 2-Port Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev a0)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev a0)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev a0)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev a0)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237A PCI to ISA Bridge
00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
00:13.0 Host bridge: VIA Technologies, Inc. VT8237A Host Bridge
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
02:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 02)
02:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 02)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
06:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)
80:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio Controller (rev 10)

I have a DVD burner attached to the first IDE channel and a hard
disk (THE hard disk) attached to the SATA_II controller.

The BIOS is set to use the SATA controllers in AHCI mode, not IDE.
However, the hard disk appears twice, first as hdg, then as sda.
Passing ide2=noprobe ide3=noprobe as boot parameters to the kernel
doesn't seem to have any effect:

ATA/IDE-relative dmesg without noprobe:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
JMB363: IDE controller at PCI slot 0000:02:00.1
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: ST3320620AS, ATA DISK drive
ide3 at 0xd800-0xd807,0xd482 on irq 74
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl
SATA mode
ata1: SATA max UDMA/133 cmd 0xF8874100 ctl 0x0 bmdma 0x0 irq 122
ata2: SATA max UDMA/133 cmd 0xF8874180 ctl 0x0 bmdma 0x0 irq 122
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth
31/32)
ata2: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 7
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237a (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
ide3: reset: master: error (0xff?); slave: failed
ide3: reset: master: error (0xff?); slave: failed
hda: PHILIPS DVDR1668P1, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ata3: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 106
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 106
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
ata3: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xCC07
ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC807

with ide2=noprobe ide3=noprobe:

Kernel command line: root=/dev/sda2 ro ide2=noprobe ide3=noprobe 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
JMB363: IDE controller at PCI slot 0000:02:00.1
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: ST3320620AS, ATA DISK drive
ide3 at 0xd800-0xd807,0xd482 on irq 66
ACPI: PCI Interrupt 0000:02:00.0[A] -> <6>VP_IDE: IDE controller
at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 7
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237a (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PHILIPS DVDR1668P1, ATAPI CD/DVD-ROM drive
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl
SATA mode
ata1: SATA max UDMA/133 cmd 0xF88D4100 ctl 0x0 bmdma 0x0 irq 122
ata2: SATA max UDMA/133 cmd 0xF88D4180 ctl 0x0 bmdma 0x0 irq 122
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth
31/32)
ata2: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
ata3: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 106
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 106
ide3: reset: master: error (0xff?); slave: failed
ide3: reset: master: error (0xff?); slave: failed
ata3: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xCC07
ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC807
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)

combined_mode=libata libata.atapi_enabled=1 doesn't help either.

As a consequence of this double appearance, I get lots of error
messages concerning hdg: although these may be considered purely
aesthetical, they are rather bothersome and may actually hide some
more relevant bug or performance loss

Any suggestions on what might be wrong and what I could do to work
around this?

(Apart from changing motherboard, that given the USB EHCI problems
I'm having too, might be not too bad an idea.)

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown

