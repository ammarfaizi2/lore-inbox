Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTLDJTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLDJTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:19:46 -0500
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:42724 "EHLO
	imh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S262794AbTLDJT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:19:29 -0500
Message-ID: <3FCEFC5F.9090205@lorenz.eu.org>
Date: Thu, 04 Dec 2003 10:20:31 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test[9|10] freeze after resume (ACPI)
Content-Type: multipart/mixed;
 boundary="------------090406020305050308050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406020305050308050602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

please CC as i am not subscribed to lkml

I would also like to contribute a solution to the problem, as soon as
someone tells me where i should start searching...
i am a quite experienced programmer, but have not yet looked into
the kernel, so it's a bit like tapping blindfolded in a maze when i
start doing so.

in short: On my SHARP PC-MM10 suspend to disk/ram works nicely until 
back from resume. At that moment it completely freezes.

I already tried several variants of kernel konfiguration, unloaded all
modules, stopped all daemons and switched to single user mode to have
barely more than the kernel, init and a shell running.

when suspending to ram or disk (echo -n [mem|disk] > /sys/power/state or
echo [3|4] > /proc/acpi/sleep) it goes down nicely with only an annoying
backlight on and white screen in mem mode - which i currently ignore 
because the backlight is switched off anyway when closing the lid.

after resume it comes back to the very screen i left off (no matter if X 
or console) but does not react on any key nor mouse action anymore.

here comes the system description:
-------------------------
# cat /proc/version
Linux version 2.6.0-test10 (mlo@mellon) (gcc version 3.3.2 (Debian)) #1 
Tue Nov 25 20:48:42 CET 2003

-----------------------
# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mellon 2.6.0-test10 #1 Tue Nov 25 20:48:42 CET 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.11x
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
jfsutils               1.1.4
xfsprogs               2.6.0
pcmcia-cs              3.2.5
PPP                    2.4.2b3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         ds yenta_socket pcmcia_core evdev orinoco_pci 
orinoco hermes ohci_hcd usbcore 8139too mii crc32 msr cpuid rtc


-------------------------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz         : 993.057
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1949.69

---------------------------
# cat /proc/modules
ds 11492 2 - Live 0xcf8a2000
yenta_socket 16736 0 - Live 0xcf898000
pcmcia_core 59776 2 ds,yenta_socket, Live 0xcf888000
evdev 8320 1 - Live 0xcf8b1000
orinoco_pci 6400 0 - Live 0xcf868000
orinoco 60268 1 orinoco_pci, Live 0xcf86f000
hermes 9120 2 orinoco_pci,orinoco, Live 0xcf864000
ohci_hcd 37472 0 - Live 0xcf857000
usbcore 130074 1 - Loading 0xcfa29000
8139too 28320 0 - Live 0xcf84b000
mii 4224 1 8139too, Live 0xcf848000
crc32 4000 1 8139too, Live 0xcf862000
msr 3104 0 - Live 0xcf86d000
cpuid 2784 0 - Live 0xcf86b000
rtc 20636 0 - Live 0xcf87f000


--------------------------
# cat /proc/iomem
00000000-0009abff : System RAM
0009ac00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ccfff : Extension ROM
000da000-000dafff : 0000:00:0c.0
   000da000-000dafff : ohci_hcd
000db000-000dbfff : 0000:00:0c.1
   000db000-000dbfff : ohci_hcd
000dc000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0e6effff : System RAM
   00100000-003b6ce8 : Kernel code
   003b6ce9-0049853f : Kernel data
0e6f0000-0e6fefff : ACPI Tables
0e6ff000-0e6fffff : ACPI Non-volatile Storage
0e700000-0e7fffff : System RAM
10000000-10000fff : 0000:00:05.0
   10000000-10000fff : yenta_socket
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
f4000000-f40fffff : 0000:00:00.0
f4100000-f4100fff : 0000:00:06.0
f4101000-f41010ff : 0000:00:0a.0
   f4101000-f41010ff : 8139too
f4101400-f41014ff : 0000:00:0c.2
f4104000-f4104fff : 0000:00:0b.0
f8000000-fbffffff : 0000:00:09.0
   f8200000-f89fffff : vesafb
fff80000-ffffffff : reserved


---------------------
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0398-0399 : pnp 00:02
03c0-03df : vesafb
03f6-03f6 : ide0
040b-040b : pnp 00:02
04d0-04d1 : pnp 00:0a
0cf8-0cff : PCI conf1
1000-100f : 0000:00:10.0
   1000-1007 : ide0
   1008-100f : ide1
1400-14ff : 0000:00:06.0
1800-18ff : 0000:00:0a.0
   1800-18ff : 8139too
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : 0000:00:11.0
   8000-803f : pnp 00:0a
8040-805f : 0000:00:11.0
   8040-804f : pnp 00:0a


-----------------------
# cat /proc/interrupts
            CPU0
   0:    2092157          XT-PIC  timer
   1:       5602          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   3:       1134          XT-PIC  eth0
   4:          0          XT-PIC  eth1
   5:          0          XT-PIC  ohci_hcd, ohci_hcd
   8:          4          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:          0          XT-PIC  yenta
  12:     178420          XT-PIC  i8042
  14:       5086          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
--------------------
# cat /proc/acpi/sleep
S0 S3 S4 S5

--------------090406020305050308050602
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev c1) (prog-if 00 [VGA])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=1 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=<none>
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at f4101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0200
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at f4104000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 000da000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at 000db000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 132 (4000ns min, 8500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at f4101400 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if ea)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-


--------------090406020305050308050602
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.6.0-test10 (mlo@mellon) (gcc version 3.3.2 (Debian)) #1 Tue Nov 25 20:48:42 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
 BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000e6f0000 (usable)
 BIOS-e820: 000000000e6f0000 - 000000000e6ff000 (ACPI data)
 BIOS-e820: 000000000e6ff000 - 000000000e700000 (ACPI NVS)
 BIOS-e820: 000000000e700000 - 000000000e800000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
232MB LOWMEM available.
On node 0 totalpages: 59392
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 55296 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7420
ACPI: RSDT (v001 PTLTD  RSDT     0x06040005  LTP 0x00000000) @ 0x0e6fbdfb
ACPI: FADT (v001 TMETA  RSDT     0x06040005 PTL  0x000f4240) @ 0x0e6fef8c
ACPI: DSDT (v001 PTLTD  DSDT     0x06040005 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=test10nr ro root=303 noresume
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 993.057 MHz processor.
Console: colour dummy device 80x25
Memory: 230088k/237568k available (2779k kernel code, 6704k reserved, 902k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1949.69 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0080893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0080893f 0081813f 000000ce 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.5.0.2, 1000 MHz
CPU: Code Morphing Software revision 4.3.4-9-540
CPU: 20021104 07:53 official release 4.3.4#1
CPU:     After all inits, caps: 00808937 0081813f 000000ce 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8ae, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................
Table [DSDT](id F004) - 397 Objects with 40 Devices 108 Methods 17 Regions
ACPI Namespace successfully loaded at root c04e61fc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs at 0000000000008018 on int 9
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 17/17 Regions 0/0 Fields 12/12 Buffers 26/26 Packages (405 nodes)
Executing all Device _STA and_INI methods:.........................................
41 Devices found containing: 41 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *7)
ACPI: PCI Interrupt Link [LNK2] (IRQs 10)
ACPI: PCI Interrupt Link [LNK3] (IRQs *5)
ACPI: PCI Interrupt Link [LNK4] (IRQs *11)
ACPI: PCI Interrupt Link [LNK5] (IRQs *3)
ACPI: PCI Interrupt Link [LNK6] (IRQs *4)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7 9 10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f74a0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x8a77, dseg 0x400
pnp: 00:02: ioport range 0x398-0x399 has been reserved
pnp: 00:02: ioport range 0x40b-0x40b has been reserved
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x8040-0x804f has been reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 7
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 3
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
 pci_irq-0302 [33] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vesafb: framebuffer at 0xf8200000, mapped to 0xcf009000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at ca87:0002
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (41 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
 pci_irq-0302 [32] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ 255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device: DMA forced
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:DMA
hda: TOSHIBA MK1503GAL, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 29297520 sectors (15000 MB), CHS=29065/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 34
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
NET: Registered protocol family 1
NET: Registered protocol family 17
cpufreq: No CPUs supporting ACPI performance management found.
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 497972k swap on /dev/hda8.  Priority:-1 extents:1
Real Time Clock Driver v1.12
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xcf855000, 08:00:1f:b1:7c:5e, IRQ 3
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c01d0227
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d0227>]    Not tainted
EFLAGS: 00010282
EIP is at create_dir+0x17/0xc0
eax: 00000077   ebx: cfa47bc8   ecx: 00000000   edx: cfa47bcc
esi: cfa47bc8   edi: 00000000   ebp: cd8a7f0c   esp: cd8a7ef4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 57, threadinfo=cd8a6000 task=cd8cd960)
Stack: cfa47b14 cfa47b14 00000246 cfa47bc8 cfa47bc8 cfa47bc8 cd8a7f2c c01d033f 
       cfa47bc8 00000000 cfa47bcc cd8a7f24 00000000 00000000 cd8a7f40 c024642f 
       cfa47bc8 cfa47b00 cfa47b04 cd8a7f64 c0246a11 cfa47bc8 cfa47bc8 cfa47bb8 
Call Trace:
 [<c01d033f>] sysfs_create_dir+0x3f/0x80
 [<c024642f>] create_dir+0x1f/0x50
 [<c0246a11>] kobject_add+0x51/0x150
 [<c02b99ed>] bus_register+0x5d/0xa0
 [<cf85303c>] usb_init+0x3c/0x60 [usbcore]
 [<c014d914>] sys_init_module+0x1f4/0x3d0
 [<c010b1cb>] syscall_call+0x7/0xb

Code: 8b 77 20 89 44 24 04 c7 04 24 0c e9 3c c0 8d 9e 80 00 00 00 
 <7>ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0c.0: OHCI Host Controller
ohci_hcd 0000:00:0c.0: reset, control = 0xc3
ohci_hcd 0000:00:0c.0: irq 5, pci mem c00da000
ohci_hcd 0000:00:0c.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0c.0: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test10 ohci_hcd
usb usb1: SerialNumber: 0000:00:0c.0
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd 0000:00:0c.0: created debug files
ohci_hcd 0000:00:0c.0: OHCI controller state
ohci_hcd 0000:00:0c.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0c.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:0c.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0c.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:0c.0: intrenable 0x80000012 MIE UE WDH
ohci_hcd 0000:00:0c.0: hcca frame #0575
ohci_hcd 0000:00:0c.0: roothub.a 01000201 POTPGT=1 NPS NDP=1
ohci_hcd 0000:00:0c.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0c.0: roothub.status 00000000
ohci_hcd 0000:00:0c.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0c.1: OHCI Host Controller
ohci_hcd 0000:00:0c.1: reset, control = 0xc3
ohci_hcd 0000:00:0c.1: irq 5, pci mem c00db000
ohci_hcd 0000:00:0c.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0c.1: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test10 ohci_hcd
usb usb2: SerialNumber: 0000:00:0c.1
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ohci_hcd 0000:00:0c.1: created debug files
ohci_hcd 0000:00:0c.1: OHCI controller state
ohci_hcd 0000:00:0c.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0c.1: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:0c.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0c.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:0c.1: intrenable 0x80000012 MIE UE WDH
ohci_hcd 0000:00:0c.1: hcca frame #04f0
ohci_hcd 0000:00:0c.1: roothub.a 01000201 POTPGT=1 NPS NDP=1
ohci_hcd 0000:00:0c.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0c.1: roothub.status 00000000
ohci_hcd 0000:00:0c.1: roothub.portstatus [0] 0x00000100 PPS
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
PCI: Enabling device 0000:00:0b.0 (0010 -> 0012)
Detected Orinoco/Prism2 PCI device at 0000:00:0b.0, mem:0xF4104000 to 0xF4104FFF -> 0xcf886000, irq:4
Reset done................................................................................................................................................................................................................................;
Clear Reset.........................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFBCFD1 - FFFBCDDD
eth1: Station identity 001f:0003:0001:0004
eth1: Looks like an Intersil firmware version 1.4.3
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:8A:79:F1:14
eth1: Station name "Prism  I"
eth1: ready
kjournald starting.  Commit interval 30 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:05.0 [13bd:102b]
Yenta: ISA IRQ list 0888, PCI irq10
Socket status: 30000006
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--------------090406020305050308050602--

