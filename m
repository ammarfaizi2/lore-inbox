Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292306AbSBBPq4>; Sat, 2 Feb 2002 10:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292307AbSBBPqu>; Sat, 2 Feb 2002 10:46:50 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:27592 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S292306AbSBBPqc>;
	Sat, 2 Feb 2002 10:46:32 -0500
Message-ID: <3C5C09D7.1010608@candelatech.com>
Date: Sat, 02 Feb 2002 08:46:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IRQ Routing problems with Sony VAIO FX210
Content-Type: multipart/mixed;
 boundary="------------060000050707070300070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060000050707070300070107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm back to trying to get my laptop working with both it's cardbus
slots again....

I tried the latest 2.4.18-pre7 + mppe(VPN) + Jes Sorenson's
IRQ routing patch for certain VAIOS.  Jes' patch was recently
posted to LKML, but it does not seem to affect my problem...

However, the same problems I was having with the 2.4.6 kernel
a while back are still here.  When I insert an adapter in the
second cardbus slot, the machine hangs (alt-sysrq-p does nothing)

I see this when I remove the NIC, and the machine starts working again.
cs: socket c7f90000 timed out during reset.  Try increasing setup_delay.

I believe the problem lies with this:

Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Assigned IRQ 10 for device 00:0a.1
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:10.0

If I can offer any more debugging information, don't hesitate
to ask!

The full dump of lspci -vv, and dmesg is attached.  dump_pirq.pl
shows this:

[root@lanforge-ice log]# dump_pirq.pl
Interrupt routing table found at address 0xfdf60:
   Version 1.0, size 0x0080
   Interrupt router is device 00:07.0
   PCI exclusive interrupt mask: 0x0000 []
   Compatible router: vendor 0x1106 device 0x0596

Device 00:07.0 (slot 0): ISA bridge
   INTA: link 0x55, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
   INTB: link 0x56, irq mask 0x9eb8 [3,4,5,7,9,10,11,12,15]
   INTC: link 0x56, irq mask 0x9cb8 [3,4,5,7,10,11,12,15]
   INTD: link 0x57, irq mask 0x06a0 [5,7,9,10]

Device 00:00.0 (slot 0): Host bridge
   INTA: link 0x55, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
   INTB: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
   INTC: link 0x56, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
   INTD: link 0x57, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
   INTA: link 0x56, irq mask 0x0020 [5]

Device 00:0a.0 (slot 0): CardBus bridge
   INTA: link 0x55, irq mask 0x0020 [5]
   INTB: link 0x56, irq mask 0x0020 [5]

Device 00:10.0 (slot 0): Ethernet controller
   INTA: link 0x56, irq mask 0x0400 [10]

Device 00:0e.0 (slot 0): FireWire (IEEE 1394)
   INTA: link 0x57, irq mask 0x0200 [9]

Interrupt router at 00:07.0: VIA 82C686 PCI-to-ISA bridge
   PIRQA (link 0x01): irq 9
   PIRQB (link 0x02): irq 10
   PIRQC (link 0x03): irq 5
   PIRQD (link 0x05): irq 9
[root@lanforge-ice log]#

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


--------------060000050707070300070107
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.18-pre7 (greear@lanforge-ice) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #3 Sat Feb 2 07:26:56 MST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: ro root=/dev/hda5
Initializing CPU#0
Detected 800.048 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126348k/131008k available (1275k kernel code, 4272k reserved, 341k data, 256k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 800.0754 MHz.
..... host bus clock speed is 200.0187 MHz.
cpu: 0, clocks: 2000187, slice: 1000093
CPU0<T0:2000176,T1:1000080,D:3,S:1000093,C:2000187>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Trying to stomp on VIA Northbridge bug...
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Cannot allocate resource region 4 of device 00:07.3
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Sony Vaio laptop detected.
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: HITACHI DVD-ROM GD-S200, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63, UDMA(66)
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ide-floppy driver 0.97.sv
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Assigned IRQ 10 for device 00:0a.1
IRQ routing conflict for 00:07.5, have irq 5, want irq 10
IRQ routing conflict for 00:07.6, have irq 5, want irq 10
PCI: Sharing IRQ 10 with 00:10.0
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Yenta IRQ list 0808, PCI irq9
Socket status: 30000020
Yenta IRQ list 0808, PCI irq10
Socket status: 30000006
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5157
PCI: Enabling device 02:00.0 (0000 -> 0003)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 256k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 17:30:35 Feb  1 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0000 -> 0001)
PCI: Assigned IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
PCI: Sharing IRQ 9 with 00:0e.0
usb-uhci.c: USB UHCI at I/O 0xfce0, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 00:07.3 (0000 -> 0001)
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
PCI: Sharing IRQ 9 with 00:0e.0
usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver

--------------060000050707070300070107
Content-Type: text/plain;
 name="lspcivv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspcivv.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Sony Corporation: Unknown device 803d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b115 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Sony Corporation: Unknown device 803d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 1c00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fce0 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 22
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1c20 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1c14 [size=4]
	Region 2: I/O ports at 1c10 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller (rev 20)
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	Secondary status: SERR
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0e.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4004000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at f4004800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: 3Com Corporation 3CCFE575BT Cyclone CardBus (rev 01)
	Subsystem: 3Com Corporation 3C575 Megahertz 10/100 LAN Cardbus PC Card
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 4000 [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 10400000 [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------060000050707070300070107--

