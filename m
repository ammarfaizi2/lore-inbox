Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJMMlI>; Sun, 13 Oct 2002 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJMMlI>; Sun, 13 Oct 2002 08:41:08 -0400
Received: from [212.104.37.2] ([212.104.37.2]:49421 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261511AbSJMMlE>; Sun, 13 Oct 2002 08:41:04 -0400
Date: Sun, 13 Oct 2002 14:42:14 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: andrew.grover@intel.com
Subject: [2.5.42][ACPI] Acpi and IDE strangeness
Message-ID: <20021013124214.GA1031@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I get the following message at boot:

Linux version 2.5.42 (root@dreamland) (gcc version 3.2) #2 Sat Oct 12 21:39:57 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages
  Normal zone: 61424 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7550
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: Vendor "VIA694" System "AWRDACPI" Revision 0x0 has a known ACPI BIOS problem.
ACPI: Reason: Bogus table. This is a non-recoverable error

Then, at IDE init:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA

Rebooting using pci=biosirq as requested:

Linux version 2.5.42 (root@dreamland) (gcc version 3.2) #2 Sat Oct 12 21:39:57 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages
  Normal zone: 61424 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 VIA694                     ) @ 0x000f7550
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: Vendor "VIA694" System "AWRDACPI" Revision 0x0 has a known ACPI BIOS problem.
ACPI: Reason: Bogus table. This is a non-recoverable error
[cut]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA

lspci -vvv shows this:

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at e000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

"pin A routed to IRQ 0" seems a bit strange... but everything is
working. Btw, I've been running 2.4.41 with ACPI and it's rock solid.
This is the log:

ACPI: RSDP (v000 VIA694                     ) @ 0x000f7550
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
[cut]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA

lspci -vvv:
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Another strangeness:  when I reboot the  machine (shutdown -r) my  HD is
powered off: I can hear it spinning  down when the screen goes blank and
spinning up when BIOS probes IDE channels.

kronos:/usr/src/linux-2.5$ grep ACPI .config | grep -v \#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

# CONFIG_SMP is not set
CONFIG_PREEMPT=y

The motherboard is an Epox8K3A (via kt333) with the latest bios.

HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
This message will self distruct in 5 seconds.
