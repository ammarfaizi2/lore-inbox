Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXPex>; Fri, 24 Nov 2000 10:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129602AbQKXPen>; Fri, 24 Nov 2000 10:34:43 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:20242 "EHLO
        mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
        id <S129153AbQKXPed>; Fri, 24 Nov 2000 10:34:33 -0500
Date: Fri, 24 Nov 2000 15:59:46 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
Message-ID: <20001124155946.B3760@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A1ACCE0.42B93664@mandrakesoft.com> <Pine.LNX.4.10.10011211723380.4687-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011211723380.4687-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 21, 2000 at 05:26:06PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 05:26:06PM -0800, Linus Torvalds wrote:
> On Tue, 21 Nov 2000, Jeff Garzik wrote:
> > 
> > A caveat to this whole scheme is that usb-uhci -already- calls
> > pci_enable_device before checking dev->irq, and yet cannot get around
> > the "assign IRQ to USB: no" setting in BIOS.  I hope that is an
> > exception rather than the rule.
> 
> Do we have a recent report of this with full PCI debug output? It might
> just be another unlisted intel irq router..

I don't know if this is what you're looking for, but I have indeed
problems getting USB to work on my new notebook. Some info: Asus P8300,
500MHz Celeron, 128MB, Intel 440MX chipset. Here is the output from
"lspci -vvx":


00:00.0 Host bridge: Intel Corporation 82440MX I/O Controller (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
00: 86 80 94 71 06 00 00 22 01 00 00 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97 Audio Controller
	Subsystem: Asustek Computer, Inc.: Unknown device 1063
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at f800 [size=256]
	Region 1: I/O ports at fc00 [size=64]
00: 86 80 95 71 05 00 00 00 00 00 01 04 00 00 00 00
10: 01 f8 00 00 01 fc 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 63 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:02.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev a2) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1332
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: <available only to root>
00: 6f 12 20 07 1f 00 30 02 a2 00 00 03 00 40 00 00
10: 00 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 32 13
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

00:07.0 ISA bridge: Intel Corporation 82440MX PCI to ISA Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 98 71 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82440MX EIDE Controller (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fc90 [size=16]
00: 86 80 99 71 05 00 80 02 00 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 91 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at fca0 [size=32]
00: 86 80 9a 71 01 00 80 02 00 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corporation 82440MX Power Management Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 86 80 9b 71 0b 00 80 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fedffc00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at fc88 [size=8]
	Region 2: I/O ports at f400 [size=256]
	Capabilities: <available only to root>
00: c1 11 48 04 03 00 90 02 01 00 80 07 00 00 00 00
10: 00 fc df fe 89 fc 00 00 01 f4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 68 16 00 24
30: 00 00 00 00 f8 00 00 00 00 00 00 00 0b 01 fc 0e

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
00: 80 11 75 04 07 00 10 02 80 00 07 06 00 a8 02 00
10: 00 00 00 10 dc 00 00 02 00 01 01 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 ff 01 80 05
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


I enabled DEBUG in arch/i386/kernel/pci-i386.h, and got the following
output at boot:


Linux version 2.4.0-test11 (root@arthur) (gcc version 2.95.2 19991024 (release)) #2 Fri Nov 24 10:28:22 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f400 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000c00 @ 000000000009f400 (reserved)
 BIOS-e820: 0000000000017000 @ 00000000000e9000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000007fffc00 (ACPI NVS)
 BIOS-e820: 0000000000017000 @ 00000000fffe9000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f400 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=linux-2.4.0t11 ro root=301
Initializing CPU#0
Detected 501.146 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 127064k/131008k available (923k kernel code, 3556k reserved, 61k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
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
00:0a.0: ignoring bogus IRQ 255
IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 60, mask 0800, excl 0000 -> got IRQ 11
PCI: Found IRQ 11 for device 00:0a.0
PCI: The same IRQ used for device 00:02.0
PCI: Allocating resources
PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0)
PCI: Resource 0000fc00-0000fc3f (f=101, d=0, p=0)
PCI: Resource f8000000-fbffffff (f=200, d=0, p=0)
PCI: Resource 0000fc90-0000fc9f (f=101, d=0, p=0)
PCI: Resource 0000fca0-0000fcbf (f=101, d=0, p=0)
PCI: Resource fedffc00-fedffcff (f=200, d=0, p=0)
PCI: Resource 0000fc88-0000fc8f (f=109, d=0, p=0)
PCI: Resource 0000f400-0000f4ff (f=101, d=0, p=0)
PCI: Sorting device list...
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:DMA, hdb:pio
hda: IBM-DARA-212000, ATA DISK drive
hdb: CD-224E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=1559/240/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 136072k swap-space (priority -1)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x398-0x39f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
irda_init()
irlmp_init()
IrDA: Registered device irda0
irlmp_register_client()
irtty_net_open()
irlap_change_speed(), setting speed to 9600
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Setting latency timer of device 00:00.1 to 64


As a sidenote: I am able to use a 3Com Megahertz 574B when I run
2.4.0-test11, but when I use 2.4.0-test11-ac3, every PCMCIA card I use
is detected as a memory card and fails to initialise.

Let me know if you want more information.


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
