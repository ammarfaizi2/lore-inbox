Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbREEPU7>; Sat, 5 May 2001 11:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbREEPUt>; Sat, 5 May 2001 11:20:49 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:5358 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132738AbREEPU3>;
	Sat, 5 May 2001 11:20:29 -0400
From: thunder7@xs4all.nl
Date: Sat, 5 May 2001 17:17:52 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4-ac5; hpt370 & new dma setup
Message-ID: <20010505171752.A729@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <E14vo0T-00089Q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14vo0T-00089Q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 04, 2001 at 11:24:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 11:24:58PM +0100, Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 		Intermediate diffs are available from
> 
> 			http://www.bzimage.org
> 
> Please test this code **carefully** if using an HPT366/370 IDE controller as
> there are driver changes there. Otherwise its mostly just catching up with
> the bugfixes.
> 
> 2.4.4-ac5
> o	Fix DMA setup on hpt366/370			(Tim Hockin)

I see definite changes; on heavy disk-access I got the following:

hdg: timeout waiting for dma
ide_dmaproc: chipset supported ide_dma_timeout func only:14
hdg: irq timeout: status = 0x58 { DriveReady SeekComplete DataRequest}

this was repeated several times, and ide3 was being reset, but the
kernel hung anyway after 5 minutes of waiting.

I must have an unlucky set of hardware (via chipset VP6 board, Live!,
ibm drives).

The following output is from 2.4.3-ac12:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 33073H3, ATA DISK drive
hde: IBM-DTLA-307045, ATA DISK drive
hdg: IBM-DJNA-372200, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdc00-0xdc07,0xe002 on irq 10
ide3 at 0xe400-0xe407,0xe802 on irq 10
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(44)
hdg: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=43800/16/63, UDMA(33)
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 > hda4
 hde: [PTBL] [5606/255/63] hde1 hde2 hde3 hde4
 hdg: hdg1 hdg2 hdg3 hdg4

/proc/interrupts:

           CPU0       CPU1       
  0:      31793      13448    IO-APIC-edge  timer
  1:       1974       1033    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  7:          0          0   IO-APIC-level  usb-uhci, usb-uhci
  8:          2          0    IO-APIC-edge  rtc
 10:      12499      12543   IO-APIC-level  ide2, ide3, EMU10K1
 11:        245        239   IO-APIC-level  sym53c8xx, PCnet/PCI II 79C970A
 14:      26781       6762    IO-APIC-edge  ide0
NMI:          0          0 
LOC:      45155      45154 
ERR:          0
MIS:          0

lspci -n:
00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 16)
00:07.3 Class 0c03: 1106:3038 (rev 16)
00:07.4 Class 0680: 1106:3057 (rev 40)
00:0a.0 Class 0100: 1000:0006 (rev 13)
00:0b.0 Class 0200: 1022:2000 (rev 16)
00:0d.0 Class 0401: 1102:0002 (rev 07)
00:0d.1 Class 0980: 1102:7002 (rev 07)
00:0e.0 Class 0180: 1103:0004 (rev 03)
01:00.0 Class 0300: 102b:0525 (rev 03)

lspci -v:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d8ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Flags: medium devsel, IRQ 3
	Capabilities: [68] Power Management version 2

00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c860 (rev 13)
	Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at cc00 [size=256]
	Memory at da001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 16)
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d000 [size=32]
	Memory at da000000 (32-bit, non-prefetchable) [size=32]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs: Unknown device 8061
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at d400 [size=32]
	Capabilities: [dc] Power Management version 1

00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=8]
	Capabilities: [dc] Power Management version 1

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 10
	I/O ports at dc00 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at ec00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
	Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0

Good luck,
Jurriaan
-- 
BOFH excuse #220:

Someone thought The Big Red Button was a light switch.
GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.83 0.36 0.13
