Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQL0JOH>; Wed, 27 Dec 2000 04:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQL0JNr>; Wed, 27 Dec 2000 04:13:47 -0500
Received: from ns1.megapath.net ([216.200.176.4]:15368 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129210AbQL0JNq>;
	Wed, 27 Dec 2000 04:13:46 -0500
Message-ID: <3A49AB66.1000607@megapathdsl.net>
Date: Wed, 27 Dec 2000 00:42:14 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test13pre4-ac2 i686; en-US; m18) Gecko/20001226
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: test13-pre4-ac2 -- The cardbus/pcmcia sockets no longer work with two devices present at boot time.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot with the following inserted:

Socket 0:
   product info: "3Com Corporation", "3CCFE575BT", "LAN Cardbus Card", "001"
   manfid: 0x0101, 0x5157
   function: 6 (network)
Socket 1:
   product info: "PCMCIA  ", "56K V.90 Fax Modem (LK)  ", "FM560LK  "
   manfid: 0x0175, 0x0000
   function: 2 (serial)

both sockets fail to set up properly and work.

Linux PCMCIA Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:04.0 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.0
PCI: Enabling device 00:04.1 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.1
Intel PCIC probe: not found.
Yenta IRQ list 0698, PCI irq11
Socket status: 30000020
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
ACPI: System description tables not found
cs: socket c118b000 timed out during reset.  Try increasing setup_delay.
cs: socket c118b800 timed out during reset.  Try increasing setup_delay.

If I then run "cardctl eject" and then eject and reinsert the two
cards, the cards get set up correctly.

Note that I am not using the PCMCIA drivers.  I am using Yenta
and its native development kernel friends. I am using modutils
2.3.22.

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(AGP disabled) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 64 set
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:02.0 VGA compatible controller: Neomagic Corporation NM2160 
[MagicGraph 128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 16 min, 255 max, 128 set
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

00:04.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 007e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168 set, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at fcc0 [disabled] [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

01:00.0 Ethernet controller: 3Com Corporation 3c575 [Megahertz] 10/100 
LAN CardBus (rev 01)
	Subsystem: 3Com Corporation: Unknown device 5b57
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 10 min, 5 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10400000 [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
