Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFSkP>; Wed, 6 Dec 2000 13:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQLFSkF>; Wed, 6 Dec 2000 13:40:05 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:17678 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129231AbQLFSjz>; Wed, 6 Dec 2000 13:39:55 -0500
Date: Wed, 6 Dec 2000 19:08:50 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
Message-ID: <20001206190850.A847@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 05, 2000 at 11:25:55PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 11:25:55PM -0800, Linus Torvalds wrote:
> Concering the PCI irq routing fixes in particular, I'd ask people with
> laptops to start testing their kernels with PnP OS set to "yes" in the
> BIOS setup. We shoul dbe at a stage where it should basically work all the
> time, and it would be interesting to hear about cases that we don't handle
> right.

I noticed that in recent Phoenix BIOSes (06/21/00), this option has a
slightly name:

  OS:       [Win95/98/2000] [Other]

Choosing "OS = WinXX " doesn't assign PCI resources, so it is indeed
the same as "PnP OS = yes".

> (Anybody who has had problems with USB interrupts seemingly not being
> delivered and similar is also encouraged to test this new kernel).

Sorry, it still doesn't work on my Asus P8300 (440MX chipset), though
the PCI resources are allocated differently from test12-pre3. Here is
the boot output (with DEBUG enabled in the PCI stuff):


PCI: BIOS32 Service Directory structure at 0xc00f6bf0
PCI: BIOS32 Service Directory entry at 0xfd762
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf50
00:07 slot=00 0:00/def8 1:00/def8 2:00/def8 3:63/0800
00:09 slot=00 0:62/0800 1:00/def8 2:00/def8 3:00/def8
01:04 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
01:08 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:0a slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:02 slot=00 0:60/0800 1:00/def8 2:00/def8 3:00/def8
00:00 slot=00 0:00/def8 1:61/08e0 2:00/def8 3:00/def8
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
PCI: IRQ fixup
00:00.1: ignoring bogus IRQ 255
00:07.2: ignoring bogus IRQ 255
00:09.0: ignoring bogus IRQ 255
00:0a.0: ignoring bogus IRQ 255
IRQ for 00:00.1(1) via 00:00.1 -> PIRQ 61, mask 08e0, excl 0000 -> newirq=0 ... failed
IRQ for 00:07.2(3) via 00:07.2 -> PIRQ 63, mask 0800, excl 0000 -> newirq=0 ... failed
IRQ for 00:09.0(0) via 00:09.0 -> PIRQ 62, mask 0800, excl 0000 -> newirq=0 ... failed
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 60, mask 0800, excl 0000 -> newirq=0 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0a.0
PCI: The same IRQ used for device 00:02.0
PCI: Allocating resources
PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
PCI: Resource 0000fcf0-0000fcff (f=101, d=0, p=0)
PCI: Resource 0000f800-0000f8ff (f=101, d=1, p=1)
PCI: Resource 0000fc00-0000fc3f (f=101, d=1, p=1)
PCI: Resource 0000fcc0-0000fcdf (f=101, d=1, p=1)
PCI: Resource fedffc00-fedffcff (f=200, d=1, p=1)
PCI: Resource 0000fce8-0000fcef (f=109, d=1, p=1)
PCI: Resource 0000f400-0000f4ff (f=101, d=1, p=1)
  got res[10000000:10000fff] for resource 0 of Ricoh Co Ltd RL5c475
PCI: Sorting device list...
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found

[...]

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 60, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0a.0
PCI: The same IRQ used for device 00:02.0
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000416

[...]

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 10:08:49 Dec  6 2000
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0000 -> 0001)
IRQ for 00:07.2(3) via 00:07.2 -> PIRQ 63, mask 0800, excl 0000 -> newirq=11 -> assigning IRQ 11 ... OK
PCI: Assigned IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0xfcc0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c24c6900, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: fcc0

[...]

PCI: Enabling device 00:00.1 (0000 -> 0001)
IRQ for 00:00.1(1) via 00:00.1 -> PIRQ 61, mask 08e0, excl 0000 -> newirq=5 -> assigning IRQ 5 -> edge ... OK
PCI: Assigned IRQ 5 for device 00:00.1
PCI: Setting latency timer of device 00:00.1 to 64


So at first the PCI code can't allocate an IRQ for devices 00:00.1
(audio), 00:07.2 (USB), and 00:09.0 (winmodem), but after the audio and
USB modules get inserted, IRQ 5 and 11 get allocated.

Here is the output from "lscpi -vv" for this configuration:


00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: Asustek Computer, Inc.: Unknown device 1063
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at f800 [size=256]
	Region 1: I/O ports at fc00 [size=64]

00:02.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev a2) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1332
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at fcc0 [size=32]

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at fedffc00 (32-bit, non-prefetchable) [disabled] [size=256]
	Region 1: I/O ports at fce8 [disabled] [size=8]
	Region 2: I/O ports at f400 [disabled] [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


Let me know if you need more information.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
