Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTELLdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTELLdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:33:04 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:43749 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262101AbTELLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:32:59 -0400
Subject: eth0: vortex_error(), status=0xe081
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Xe7Grlh3wW+LowOYQLh3"
Message-Id: <1052739929.793.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 12 May 2003 13:45:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xe7Grlh3wW+LowOYQLh3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I've been experiencing less-than-optimal throughput when using 2.4 and
2.5 kernels with my 3Com Corporation 3CCFE575CT Cyclone CardBus NIC.
I've been playing with the 3c59x.c driver and have found the following
errors logged on the kernel ring when doing large file transfers, using
either FTP or NFS:

eth0: vortex_error(), status=0xe081

This error is logged multiple times, and I would say it's logged at
constant rate. I think some kind of hardware/software interaction is
causing my outgoing rate to be no more than 4MB/s, while the incoming
rate is nearly perfect at 12MB/s approximately.

This is reproducible with RedHat's Rawhide kernel 2.4.20-1.1988 and the
whole 2.5 series (since 2.5.60, if my memory serves me well), so I would
say this s indeed a 3c59x.c or a hardware problem.

The "0xe081" status means, as per the 3c59x.c sorce code:

"IntLatch", which I assume it means an interrupt happened and the ISR
was invoked, so I think it's normal this flag to be set.

"StatsFull", which I don't what does this mean, but I think it's the
cause of the error. What does this mean?

I've been unable to guess what the other three bits, corresponding to
"0xe000" mean.

This is an extract of the driver debug messages logged while loading the
3c59x.ko module:

PCI: Enabling device 06:00.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
06:00.0: 3Com PCI 3CCFE575CT Tornado CardBus at 0x1400. Vers LK1.1.19
PCI: Setting latency timer of device 06:00.0 to 64
00:04:75:ab:6f:cc, IRQ 5
  product code 534c rev 10.0 date 06-07-02
06:00.0: CardBus functions mapped 11000080->d0880080
  Internal config register is 80600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 7809.
  Enabling bus-master transmits and whole-frame receives.
06:00.0: scatter/gather enabled. h/w checksums enabled
eth0: using default media MII
eth0: Initial media type MII.
eth0: MII #0 status 7809, link partner capability 0000, info1 2010,
setting half-duplex.
eth0: vortex_up() InternalConfig 80600000.
eth0: vortex_up() irq 5 media status 8080.
eth0: Setting full-duplex based on MII #0 link partner capability of
01e1.
Setting duplex in Wn3_MAC_Ctrl
--

I have also attached an "lspci" output from my system.
Comments, ideas and patches will be appreciated :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

--=-Xe7Grlh3wW+LowOYQLh3
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: dc800000-dc8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
	Subsystem: NEC Corporation: Unknown device 80b5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ef00 [size=64]
	Region 2: I/O ports at efe4 [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 000002c0-000002c3
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus Controller
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00001800-000018ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011 (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 80b6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: NEC Corporation: Unknown device 80a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at febfff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at eff0 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: NEC Corporation: Unknown device 80b7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 11000080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10c00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-


--=-Xe7Grlh3wW+LowOYQLh3--

