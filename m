Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266685AbUGLBvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUGLBvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUGLBv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:51:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:16553 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266685AbUGLBvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:51:09 -0400
Date: Mon, 12 Jul 2004 03:49:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roger Luethi <rl@hellgate.ch>
Cc: lkml <linux-kernel@vger.kernel.org>, Donald Becker <becker@scyld.com>
Subject: via-rhine breaks with recent Linus kernels : probe of 0000:00:09.0
 failed with error -5
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've noticed that with recent kernels from Linus' tree the via-rhine
driver that I use for my NIC seems to have broken.

I don't recall any problems with kernels prior to 2.6.7
2.6.7 vanilla - works.
2.6.7-BK20    - breaks
2.6.8-rc1     - breaks
2.6.7-mm1,-mm2,-mm3,-mm6,-mm7 all work
I haven't tested earlier BK snapshots, but I'm willing to do so if wanted.

I get the following from the kernels that break:
Invalid MAC address for card #0
via-rhine: probe of 0000:00:09.0 failed with error -5

After this it's quite impossible for me to use the device of course since
the driver refuses to talk to it.

whereas with the kernels that work I get:
eth0: VIA Rhine II (VT6102) at 0xed800000, 00:50:ba:f2:a3:1d, IRQ 5.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.


Below you can find dmesg output from a boot of 2.6.7-mm7 and 2.6.8-rc1
from the start until the point where the problem manifests itself.
I've also included ver_linux output as well as output from /proc/cpuinfo
and lspci below.

If any additional info is required to find a solution then I'll be happy
to provide it. I'm also willing to try and narrow it down to a specific
2.6.7-BK release if you want me to, but I haven't had time to do that yet
and thought I'd just initially report the info I do have. Also, if you
need me to test any patches, revert changes, whatever, just let me know.
I've not included my .config (I use the same one with all the kernels
btw), but it's available upon request.


Booting a working 2.6.7-mm7 :

Linux version 2.6.7-mm7 (juhl@dragon) (gcc version 3.4.0) #2 Sun Jul 11
17:29:47 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f69e0
ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux267mm7 ro root=801 psmouse.proto=imps
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1400.224 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514500k/524208k available (2666k kernel code, 8960k reserved, 959k
data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 2752.51 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After vendor identify, caps:  0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0801 MHz.
..... host bus clock speed is 266.0628 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:0d.0
spurious 8259A interrupt: IRQ7.
vesafb: framebuffer at 0xf0000000, mapped to 0xe0800000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:b5b0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.1.6a 2004-07-01 Jens Axboe (axboe@suse.de) and
petero2@telia.com
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
PCI: Enabling device 0000:00:09.0 (0094 -> 0097)
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:0d.0
eth0: VIA Rhine II (VT6102) at 0xed800000, 00:50:ba:f2:a3:1d, IRQ 5.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
[remaining output omitted]


Booting a broken 2.6.8-rc1:

Linux version 2.6.8-rc1 (juhl@dragon) (gcc version 3.4.0) #1 Mon Jul 12
01:56:52
 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f69e0
ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Lnx268rc1 ro root=801 psmouse.proto=imps
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1400.224 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514568k/524208k available (2611k kernel code, 8892k reserved, 949k
data,
 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 2752.51 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After vendor identify, caps:  0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.0792 MHz.
..... host bus clock speed is 266.0627 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try
pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:0d.0
spurious 8259A interrupt: IRQ7.
vesafb: framebuffer at 0xf0000000, mapped to 0xe0800000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:b5b0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
PCI: Enabling device 0000:00:09.0 (0094 -> 0097)
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:0d.0
Invalid MAC address for card #0
via-rhine: probe of 0000:00:09.0 failed with error -5
[remaining output omitted]


scripts/ver_linux output :

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.7-mm7 #2 Sun Jul 11 17:29:47 CEST 2004 i686 unknown
unknown GNU/Linux

Gnu C                  3.4.0
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      6.0.0
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ehci_hcd uhci_hcd evdev agpgart


output of  cat /proc/cpuinfo  :

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1400.165
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2752.51


output of  lspci -vvv  :

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f7800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: ee000000-ef5fffff
	Prefetchable memory behind bridge: ef700000-f77fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc. A7M266 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Asustek Computer, Inc. A7M266 Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
	Subsystem: D-Link System Inc DFE-530TX rev B
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at ed800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160N Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at 9800 [disabled] [size=256]
	Region 1: Memory at ed000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs: Unknown device 8067
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 9000 [disabled] [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc. AGP-V8200 DDR
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at ef7f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


--
Jesper Juhl <juhl-lkml@dif.dk>

