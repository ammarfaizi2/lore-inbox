Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSEOQzy>; Wed, 15 May 2002 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316440AbSEOQzx>; Wed, 15 May 2002 12:55:53 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:5449 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S316430AbSEOQzv>; Wed, 15 May 2002 12:55:51 -0400
Message-ID: <3CE29321.7050605@blue-labs.org>
Date: Wed, 15 May 2002 12:56:01 -0400
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-a3
In-Reply-To: <200205151433.g4FEXko20788@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040506060005010202050004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506060005010202050004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Enabling DMA for IDE broke for my laptop.  If I turn on DMA, my laptop
stalls doing partition checks.  Keyboard is responsive, mouse is fine,
etc, all normal except it looks like the partition check just went to
sleep with the HD LED on.  It's the same place it hangs if I enable the
PIIX tuning however if I enable PIIX tuning, the machine locks up hard
and must be powered off to reboot.

Attached is lspci -vv output.

block: 352 slots per queue, batch=88
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHG2102AT, ATA DISK drive
hdc: MATSHITA CR-175, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 19640880 sectors (10056 MB) w/512KiB Cache, CHS=1222/255/63
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

It will hang before printing "p1"

David

Alan Cox wrote:

 >Linux 2.4.19pre8-ac3
 >o	Kbuild fixes					(Keith Owens)
 >o	Fix eepro100 bug/typo				(Michael Rozhavsky)
 >o	Intel 845G GART support				(Graeme Fisher)
 >o	Fix tasklet disable/kill in pppoatm		(Luca Barbier)
 >o	Add another PCI ident to the acenic driver	(Eric Smith)
 >o	Major IDE updates				(Andre Hedrick)
 >
 >


--------------040506060005010202050004
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at fb000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: fa800000-fa8fffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:03.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Subsystem: NEC Corporation: Unknown device 8039
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Subsystem: NEC Corporation: Unknown device 8039
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: NEC Corporation ES1978 Maestro-2E Audiodrive
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: [virtual] I/O ports at 01f0
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 (rev dc) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage LT Pro AGP-133
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at dc00 [size=256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: National Datacomm Corp: Unknown device a100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 4000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 10400000 [size=256K]



--------------040506060005010202050004--

