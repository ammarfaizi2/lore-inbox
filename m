Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUAHUSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUAHUSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:18:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:12685 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266374AbUAHURc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:17:32 -0500
X-Authenticated: #3120621
Subject: Problem - 2.6.0 Kernel and irq 18: nobody cared!
From: Jan-Christian Treusch <jan-christian.treusch@gmx.de>
Reply-To: jan-christian@treusch.de
To: linux-kernel@vger.kernel.org
Cc: acpi-bugzilla@lists.sourceforge.net
Content-Type: text/plain
Organization: 
Message-Id: <1073593046.1255.9.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Jan 2004 21:17:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a ACPI problem wenn I use the new 2.6.0 Kernel (with 2.6.0-rc1/2
same problem)

After the kernel initialize my IDE-ports I get the message: 
irq 18: nobody cared! 
and I get this message repeatedly, so that I can't use my pc anymore.

dmesg:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 18
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
hdb: ST340016A, ATA DISK drive
ide0 at 0xefe0-0xefe7,0xefae on irq 18
hdc: CD-RW CDR-6S52, ATAPI CD/DVD-ROM drive
ide1 at 0xefa0-0xefa7,0xefaa on irq 18
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdb: hdb1 hdb2
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

[.......]

irq 18: nobody cared!
Call Trace:
 [<c010b0bf>] __report_bad_irq+0x2b/0x98
 [<c010b0c7>] __report_bad_irq+0x33/0x98
 [<c010b1a4>] note_interrupt+0x50/0x78
 [<c010b434>] do_IRQ+0xf8/0x180
 [<c0109b3c>] common_interrupt+0x18/0x20
 [<c01141e4>] delay_tsc+0x14/0x20
 [<c01fc5e2>] __delay+0x12/0x18
 [<c01fc677>] __const_udelay+0x2b/0x30
 [<c02e982a>] psmouse_command+0xea/0x18c
 [<c02ea2d8>] ps2pp_cmd+0x6c/0x84
 [<c02ea5c0>] ps2pp_detect_model+0x20c/0x24c
 [<c02ea677>] ps2pp_detect+0x77/0x90
 [<c02e9aef>] psmouse_extensions+0xe7/0x178
 [<c02e9bd9>] psmouse_probe+0x59/0x74
 [<c02e9ec6>] psmouse_connect+0xbe/0x1d8
 [<c02eb9fb>] serio_find_dev+0x2b/0x54
 [<c02ebe07>] __serio_register_port+0x27/0x2c
 [<c02ebdb1>] serio_register_port+0x31/0x4c
 [<c04e8796>] i8042_port_register+0x4a/0x6c
 [<c04e891e>] i8042_init+0xce/0x190
 [<c04d282d>] do_initcalls+0x39/0x90
 [<c04d28a0>] do_basic_setup+0x1c/0x2c
 [<c010510d>] init+0x65/0x168
 [<c01050a8>] init+0x0/0x168
 [<c0107289>] kernel_thread_helper+0x5/0xc

handlers:
[<c0295974>] (ide_intr+0x0/0x1b4)
[<c0295974>] (ide_intr+0x0/0x1b4)
Disabling IRQ #18

[......]

I'm able to boot when I add "noirqdebug" as a kernel parameter but then
ACPI doesn't work (My pc doesn't power down) and sometimes my pc stops
and does for a moment nothing without writing any error messages.

With the 2.4.23 kernel my pc does only boot with "acpi=off". Hyper
Threading doesn't work and therefore I have a bad performance.

Does anyone know what's wrong? Thanks fo help.

Jan-Christian Treusch

Here some useful info's:


My Hardware:

Mainboard is an Asus P4P800 Deluxe (Intel i865PE Chipset)
newest BIOS version
VIA Raid-Controller deaktivated
2 Seagate UMDA5 HDD (Parallel ATA)
Intel P4 2.4 GHz HT


My Software:

Debian Woody  3.0r1
XFree86 4.1.0.1

I compiled the kernel without module support.

cat /proc/version:
Linux version 2.6.0 (root@debian) (gcc version 2.95.4 20011002 (Debian
prerelease)) #3 SMP Sun Jan 4 13:00:38 CET 2004

kernel parameters: noirqdebug


sh /scripts/ver_linux

Linux debian 2.6.0 #3 SMP Sun Jan 4 13:00:38 CET 2004 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11


cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 9
cpu MHz		: 2881.557
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 5685.24

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 9
cpu MHz		: 2881.557
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 5750.7


cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0cf8-0cff : PCI conf1
d800-d8ff : 0000:02:05.0
  d800-d8ff : SysKonnect SK-98xx
dc00-dc7f : 0000:02:03.0
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
eec0-eedf : 0000:00:1d.0
  eec0-eedf : uhci_hcd
ef00-ef1f : 0000:00:1d.1
  ef00-ef1f : uhci_hcd
ef90-ef9f : 0000:00:1f.1
  ef90-ef97 : ide0
  ef98-ef9f : ide1
efa0-efa7 : 0000:00:1f.1
  efa0-efa7 : ide1
efa8-efab : 0000:00:1f.1
  efaa-efaa : ide1
efac-efaf : 0000:00:1f.1
  efae-efae : ide0
efe0-efe7 : 0000:00:1f.1
  efe0-efe7 : ide0



cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-0039d3b2 : Kernel code
  0039d3b3-004cfd7f : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
f3f00000-f7efffff : PCI Bus #01
  f4000000-f5ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fd700000-fe7fffff : PCI Bus #01
  fd800000-fdffffff : 0000:01:00.0
  fe7fc000-fe7fffff : 0000:01:00.0
fe900000-fe9fffff : 0000:02:0b.0
  fe900000-fe902fff : CS46xx_BA1_data0
  fe910000-fe9137ff : CS46xx_BA1_data1
  fe920000-fe926fff : CS46xx_BA1_pmem
  fe930000-fe9300ff : CS46xx_BA1_reg
feaf8000-feafbfff : 0000:02:05.0
  feaf8000-feafbfff : SysKonnect SK-98xx
feafe000-feafefff : 0000:02:0b.0
  feafe000-feafefff : CS46xx_BA0
feaff800-feafffff : 0000:02:03.0
  feaff800-feafffff : ohci1394
febff000-febff0ff : 0000:00:1f.5
febff400-febff5ff : 0000:00:1f.5
febff800-febffbff : 0000:00:1d.7
  febff800-febffbff : ehci_hcd
ffb80000-ffffffff : reserved


##############################################
lspci -vvv
##############################################

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd700000-fe7fffff
	Prefetchable memory behind bridge: f3f00000-f7efffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at eec0 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ef00 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02)
(prog-if 20)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe800000-feafffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
(prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at efe0 [size=8]
	Region 1: I/O ports at efac [size=4]
	Region 2: I/O ports at efa0 [size=8]
	Region 3: I/O ports at efa8 [size=4]
	Region 4: I/O ports at ef90 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24d5
(rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at febff400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fe7fc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at fe7c0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. OHCI Compliant IEEE
1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at dc00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev
12)
	Subsystem: Asustek Computer, Inc.: Unknown device 80eb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at d800 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

02:0b.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 112e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk+ DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


###################################################################
Full dmesg with "noirqdebug":
###################################################################


Linux version 2.6.1-rc2 (root@debian) (gcc version 2.95.4 20011002
(Debian prerelease)) #5 SMP Tue Jan 6 19:34:50 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                    ) @
0x000f9e60
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000320 MSFT 0x00000097) @
0x1ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000320 MSFT 0x00000097) @
0x1ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000320 MSFT 0x00000097) @
0x1ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000320 MSFT 0x00000097) @
0x1ff40040
ACPI: DSDT (v001  P4P81 P4P81086 0x00000086 INTL 0x02002026) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 noirqdebug 1
IRQ lockup detection disabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2881.538 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513128k/523456k available (2669k kernel code, 9532k reserved,
1229k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 5685.24 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1463.12 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5750.78 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (11436.03 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2880.0263 MHz.
..... host bus clock speed is 240.0021 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18 Mode:1
Active:1)
00:00:1f[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1
Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1
Active:1)
00:00:1d[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1
Active:1)
00:00:1d[B] -> 2-19 -> IRQ 19
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1
Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1
Active:1)
00:02:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1
Active:1)
00:02:09[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1
Active:1)
00:02:09[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-22 already programmed
Pin 2-20 already programmed
Pin 2-23 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Machine check exception polling timer started.
Starting balanced_irq
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
sk98lin: Network Device Driver v6.18
(C)Copyright 1999-2003 Marvell(R).
eth%d: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 18
    ide0: BM-DMA at 0xef90-0xef97, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xef98-0xef9f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
hdb: ST340016A, ATA DISK drive
ide0 at 0xefe0-0xefe7,0xefae on irq 18
hdc: CD-RW CDR-6S52, ATAPI CD/DVD-ROM drive
ide1 at 0xefa0-0xefa7,0xefaa on irq 18
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdb: hdb1 hdb2
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20] 
MMIO=[feaff800-feafffff]  Max Packet=[2048]
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem e0828800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000eec0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000ef00
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180000295f82]
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 19
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ dfc04340
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25
19:16:36 2003 UTC).
hub 2-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0
alt 1 proto 2 vid 0x03F0 pid 0x1204
ALSA device list:
  #0: Sound Fusion CS46xx at 0xfeafe000/0xfe900000, irq 23
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
hub 2-0:1.0: new USB device on port 2, assigned address 3
Adding 538136k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
serio: kseriod exiting
exiting...exiting...





