Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRGKIs4>; Wed, 11 Jul 2001 04:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbRGKIsh>; Wed, 11 Jul 2001 04:48:37 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:3968 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267237AbRGKIs0>; Wed, 11 Jul 2001 04:48:26 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Cc: saw@saw.sw.com.sg
Subject: 2.4.6: eepro100 does not survive warm boot
Date: Wed, 11 Jul 2001 10:47:35 +0200
Organization: Econos
Message-ID: <gg4oktks8jch0sqsdivo2m5071t2h0q1jp@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


For testing purposes, I am running a stock 2.4.6 kernel on a Sony VAIO
Z600 NE notebook (Sony Z505 JS in the US).

On a cold boot, I get this information in dmesg:

>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
>PCI: Found IRQ 9 for device 00:0b.0
>eth0: OEM i82557/i82558 10/100 Ethernet, 08:00:46:07:49:99, IRQ 9.
>  Receiver lock-up bug exists -- enabling work-around.
>  Board assembly 100001-001, Physical connectors present: RJ45
>  Primary interface chip i82555 PHY #1.
>  General self-test: passed.
>  Serial sub-system self-test: passed.
>  Internal registers self-test: passed.
>  ROM checksum self-test: passed (0x04f4518b).
>  Receiver lock-up workaround activated.


With the exact same kernel, after a warm boot ('reboot'), the picture
changes to


>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
>PCI: Found IRQ 9 for device 00:0b.0
>eth0: Invalid EEPROM checksum 0xff00, check settings before activating this device!
>eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 9.
>  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
>  Primary interface chip unknown-15 PHY #31.
>    Secondary interface chip i82555.
>Self test failed, status ffffffff:
> Failure to initialize the i82557.
> Verify that the card is a bus-master capable slot.


Result: The network essentially is dead; I cannot make HTTP requests to a
server on the LAN, for instance. Shut down the system and go through a
cold boot ('halt -p'), and all is well.

Cold booting into 2.4.6 and then warm booting into a stock 2.2.19 kernel
(on a different partition) shows the same effect on the 2.2.19 side in
dmesg plus a couple of lines

  eepro100: cmd_wait for(0xffffffff) timedout with(0xffffffff)!

The very same hardware configuration works perfectly with the 2.2.19
kernel across warm boots.

Anyone interested in tracking this down? Any information in addition to
the below hardware information I could provide?

TIA,
Stefan

******************************

>00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
>	Subsystem: Sony Corporation: Unknown device 807d
>	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>	Latency: 64
>	Region 0: Memory at 40000000 (32-bit, prefetchable) [size=16M]
>	Capabilities: [a0] AGP version 1.0
>		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
>		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>
>00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
>	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 128
>	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>	Memory behind bridge: fe400000-febfffff
>	Prefetchable memory behind bridge: fc000000-fdffffff
>	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
>
>00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
>	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 0
>
>00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64
>	Region 4: I/O ports at fc90 [size=16]
>
>00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64
>	Interrupt: pin D routed to IRQ 9
>	Region 4: I/O ports at fca0 [size=32]
>
>00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
>	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Interrupt: pin ? routed to IRQ 9
>
>00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02) (prog-if 10 [OHCI])
>	Subsystem: Sony Corporation: Unknown device 8080
>	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at fedf7000 (32-bit, non-prefetchable) [size=2K]
>	Region 1: Memory at fedf7c00 (32-bit, non-prefetchable) [size=512]
>	Expansion ROM at <unassigned> [disabled] [size=64K]
>	Capabilities: [dc] Power Management version 1
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
>	Subsystem: Sony Corporation: Unknown device 8081
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (1250ns min, 6250ns max)
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
>	Region 1: I/O ports at fcc0 [size=64]
>	Region 2: I/O ports at fc8c [size=4]
>	Capabilities: [50] Power Management version 1
>		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D3 PME-Enable- DSel=0 DScale=0 PME-
>
>00:0a.0 Communication controller: CONEXANT SoftK56 Speakerphone Winmodem (rev 01)
>	Subsystem: Sony Corporation: Unknown device 8083
>	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at fede0000 (32-bit, non-prefetchable) [size=64K]
>	Region 1: I/O ports at fc38 [size=8]
>	Capabilities: [40] Power Management version 2
>		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>	Subsystem: Sony Corporation: Unknown device 8084
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 66 (2000ns min, 14000ns max), cache line size 08
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at fedf6000 (32-bit, non-prefetchable) [size=4K]
>	Region 1: I/O ports at fc40 [size=64]
>	Region 2: Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
>	Capabilities: [dc] Power Management version 2
>		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
>00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
>	Subsystem: Sony Corporation: Unknown device 8082
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 168
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
>	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
>	Memory window 0: 10400000-107ff000 (prefetchable)
>	Memory window 1: 10800000-10bff000
>	I/O window 0: 00001400-000014ff
>	I/O window 1: 00001800-000018ff
>	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
>	16-bit legacy interface ports at 0001
>
>00:0d.0 FLASH memory: Sony Corporation Memory Stick Controller (rev 01)
>	Subsystem: Sony Corporation: Unknown device 8085
>	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Interrupt: pin A routed to IRQ 0
>	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=1K]
>	Capabilities: [dc] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>01:00.0 VGA compatible controller: Neomagic Corporation NM2380 [MagicMedia 256XL+] (rev 10) (prog-if 00 [VGA])
>	Subsystem: Sony Corporation: Unknown device 809d
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B+
>	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 128 (4000ns min, 63750ns max)
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
>	Region 1: Memory at fe400000 (32-bit, non-prefetchable) [size=4M]
>	Region 2: Memory at feb00000 (32-bit, non-prefetchable) [size=1M]
>	Capabilities: [d0] AGP version 1.0
>		Status: RQ=7 SBA+ 64bit- FW- Rate=x1
>		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>	Capabilities: [dc] Power Management version 1
>		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>

