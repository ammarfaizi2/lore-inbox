Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSIJVem>; Tue, 10 Sep 2002 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSIJVem>; Tue, 10 Sep 2002 17:34:42 -0400
Received: from mail.dts.de ([212.62.75.8]:46859 "HELO dtsroot.dts.intra")
	by vger.kernel.org with SMTP id <S318158AbSIJVej>;
	Tue, 10 Sep 2002 17:34:39 -0400
Message-ID: <3D7E6675.5080303@dts.de>
Date: Tue, 10 Sep 2002 23:39:01 +0200
From: Andreas Kerl <andreas.kerl@dts.de>
Reply-To: andreas.kerl@dts.de
Organization: DTS Medien GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
same problem here.
Kernel crashes at boot:

.......
ICH3M: IDE Controller on PCI bus 0 dev f9
PCI: Device 00:1f.1 not available becaus of resource collisions
PCI: Assigned IRQ11 for device 00:1f.1
Unable to handle kernel NULL pointer dereference at virtual address 00000010

printing eip:
c025a902
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010 [<c025a902>] Not tainted
EFLAGS: 00010097
eax: 00000010  ebx: 0000000a  ecx: 00000010  edx: fffffffe
esi: c030cf23  edi: 00000000  ebp: c030d31f  esp: c161bea0
.....


it's a Compaq EVO N800c laptop with 845MP chipset.

with kernel 2.4.20-pre5 it boots but no chipset support(dma).
with kernel 2.4.20-pre1-ac1 no problems:


....
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Assigned IRQ 11 for device 00:1f.1
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25T060ATCS05-0, ATA DISK drive
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/1768KiB Cache, CHS=7752/240/63, 
UDMA(100)
....


#lspci -v
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 04)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, fast devsel, latency 0
	Memory at 60000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [d104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 40300000-403fffff
	Prefetchable memory behind bridge: 48000000-4fffffff

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) 
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 40000000-402fffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 
8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 01f0
	I/O ports at 03f4
	I/O ports at 0170
	I/O ports at 0374
	I/O ports at 4440 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
(rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 4000 [size=256]
	I/O ports at 4400 [size=64]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M7 LW (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 66, IRQ 11
	Memory at 48000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at 40300000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

02:04.0 Communication controller: Lucent Microelectronics LT WinModem 
(rev 02)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0450
	Flags: bus master, medium devsel, latency 66, IRQ 5
	Memory at 40200000 (32-bit, non-prefetchable) [size=256]
	I/O ports at 2440 [size=8]
	I/O ports at 2000 [size=256]
	Capabilities: [f8] Power Management version 2

02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset 
Ethernet Controller (rev 42)
	Subsystem: Compaq Computer Corporation: Unknown device 0093
	Flags: bus master, medium devsel, latency 66, IRQ 10
	Memory at 40080000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 2400 [size=64]
	Capabilities: [dc] Power Management version 2

02:0e.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 40, IRQ 10
	Memory at 40100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

02:0e.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 40, IRQ 10
	Memory at 40180000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at 40280000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2





cu
Andreas

