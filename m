Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJSPWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTJSPWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:22:12 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:7817 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261592AbTJSPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:21:52 -0400
Date: Sun, 19 Oct 2003 12:07:22 -0400
From: John Chia <orange@geek.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 Migration (CPUfreq, Synaptics, PS/2, undocking, omnibook 6000)
Message-ID: <20031019160722.GA1172@beefchickenpork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: 
Problems undocking in 2.6 kernel; CPUfreq & ps/2 drivers behaving unpleasantly.

Full Description:

I've spent the morning toying with Linux 2.6.0-test8 on my Omnibook 6000.  So
far, the experience has been TERRIFIC.  The great majority of my hardware is
working.  So far, there are three major problems.  I believe I can solve most
of them with some more experimentation, but here they are anyway for it may be
useful at least to gauge how convenient a migration from 2.4.x can be..

My beloved pointing nipple has stopped responding to my incessant fondling.
Instead I have to rub this recessed, flat area below it.  (Unacceptable!  My
beloved plastic girlfriend is wearing out from all the load transferred!!!)
I've found some information in the synaptics driver on a "pass through" which
is apparently what is needed to let me use the nipple, but-- would it be
possible to support this ala 2.4.x's ps2 driver again?  It's convenient...
especially while the synaptics support in XFree86 is not ubiquitous.

My dock refuses to perform an undock.  I have a feeling it has to do with ACPI,
because it is enabled, but doesn't load properly.  This is one of the things I
think I can fix.

The CPUfreq driver (speedstep-smi) seems to not detect my chipset although this old compatability page seems to think omnibook 6000s are supported: 
http://www.poupinou.org/cpufreq/reports.html
See 8.0 for dmesg otuput from this driver.  FWIW, the Windows XP driver
speedstep doesn't work, either.

Sorry for the 20k message,
Please CC on replies,
Thanks, 
John.

Keywords: 2.6 Migration, Omnibook 6000, CPUfreq, Synaptics, PS/2, undocking

[4.0] 
Linux version 2.6.0-test8 (root@marvin) (gcc version 3.3.2 20031005 (Debian prerelease)) #1 Sat Oct 18 22:52:03 EDT 2003

[7.2] 
% cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 310.966
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 851.96

[7.3]
% cat /proc/modules
speedstep_lib 3136 0 - Live 0xcc934000
ide_cd 40900 1 - Live 0xcc99c000
cdrom 35040 1 ide_cd, Live 0xcc992000
orinoco_cs 7880 1 - Live 0xcc8ce000
orinoco 43916 1 orinoco_cs, Live 0xcc986000
hermes 8480 2 orinoco_cs,orinoco, Live 0xcc8d7000
ds 14980 5 orinoco_cs, Live 0xcc89e000
yenta_socket 17184 1 - Live 0xcc8d1000
pcmcia_core 72832 3 orinoco_cs,ds,yenta_socket, Live 0xcc93e000
parport_pc 36188 1 - Live 0xcc91f000
lp 10976 2 - Live 0xcc8a3000
parport 43592 2 parport_pc,lp, Live 0xcc913000
irda 203168 0 - Live 0xcc953000
snd_pcm_oss 53700 1 - Live 0xcc904000
snd_mixer_oss 19264 2 snd_pcm_oss, Live 0xcc8c4000
snd_maestro3 24324 5 - Live 0xcc8bd000
snd_ac97_codec 54852 1 snd_maestro3, Live 0xcc8f5000
snd_pcm 100612 3 snd_pcm_oss,snd_maestro3, Live 0xcc8db000
snd_page_alloc 11812 1 snd_pcm, Live 0xcc87c000
snd_timer 25540 1 snd_pcm, Live 0xcc8a7000
snd 52644 11 snd_pcm_oss,snd_mixer_oss,snd_maestro3,snd_ac97_codec,snd_pcm,snd_timer, Live 0xcc8af000
soundcore 9440 3 snd, Live 0xcc880000
af_packet 21672 4 - Live 0xcc897000
nls_cp437 5568 2 - Live 0xcc850000
vfat 15744 1 - Live 0xcc853000
fat 45824 1 vfat, Live 0xcc88a000
apm 17804 2 - Live 0xcc876000
3c59x 37896 0 - Live 0xcc838000
hid 33152 0 - Live 0xcc843000
usbcore 111612 1 hid, Live 0xcc859000
rtc 12632 0 - Live 0xcc808000
unix 28368 420 - Live 0xcc810000

[7.4]
% cat /proc/io{ports,mem}
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0b.1
1400-14ff : 0000:00:0d.0
  1400-14ff : Maestro3
1800-187f : 0000:00:0b.0
  1800-187f : 0000:00:0b.0
1880-189f : 0000:00:07.2
18a0-18af : 0000:00:07.1
1c00-1cff : PCI CardBus #02
2000-20ff : PCI CardBus #02
2180-219f : 0000:00:07.3
2400-24ff : PCI CardBus #06
2800-28ff : PCI CardBus #06
8000-803f : 0000:00:07.3
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cd800-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bfeffff : System RAM
  00100000-00281687 : Kernel code
  00281688-0031b8ff : Kernel data
0bff0000-0bfffbff : ACPI Tables
0bfffc00-0bffffff : ACPI Non-volatile Storage
10000000-10000fff : 0000:00:0a.0
  10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:0a.1
  10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
a0000000-a0000fff : card services
f4000000-f4001fff : 0000:00:0d.0
f4002000-f400207f : 0000:00:0b.0
f4002400-f400247f : 0000:00:0b.0
f4002800-f400287f : 0000:00:0b.1
f4002c00-f4002cff : 0000:00:0b.1
f4100000-f5ffffff : PCI Bus #01
  f4100000-f4100fff : 0000:01:00.0
  f5000000-f5ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fff80000-ffffffff : reserved

[7.5]
% sudo lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f5ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 18a0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 1880 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001c00-00001cff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Hewlett-Packard Company: Unknown device 0010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus (rev 10)
	Subsystem: 3Com Corporation: Unknown device 6256
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 1250ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1800 [size=128]
	Region 1: Memory at f4002400 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at f4002000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0b.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 10)
	Subsystem: 3Com Corporation: Unknown device 6158
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at f4002c00 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f4002800 (32-bit, non-prefetchable) [size=128]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0d.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator
	Subsystem: Hewlett-Packard Company: Unknown device 0010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[8.0]
% dmesg
Linux version 2.6.0-test8 (root@marvin) (gcc version 3.3.2 20031005 (Debian prerelease)) #1 Sat Oct 18 22:52:03 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
191MB LOWMEM available.
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 HP-MCD                                    ) @ 0x000f6770
ACPI: RSDT (v001 HP-MCD EA RSDT  0x01820000  LTP 0x00000000) @ 0x0bff59b8
ACPI: FADT (v001 HP-MCD EA FACP  0x01820000 HP   0x01000000) @ 0x0bfffb65
ACPI: BOOT (v001 PTLTD  EABFTBL$ 0x01820000  LTP 0x00000001) @ 0x0bfffbd9
ACPI: DSDT (v001 HP-MCD EA DSDT  0x01820000 MSFT 0x0100000b) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=305
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 310.966 MHz processor.
Console: colour VGA+ 80x25
Memory: 189996k/196544k available (1541k kernel code, 5916k reserved, 616k data, 132k init, 0k highmem)
Calibrating delay loop... 851.96 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 1472k freed
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd980, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.FDS_.FCB1.CSID] (Node cbdccfa0), AE_NOT_EXIST
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.FDS_._REG] (Node cbdcc500), AE_NOT_EXIST
ACPI: Unable to initialize ACPI objects
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:0a.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:0b.1
PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:0a.1
PCI: Sharing IRQ 10 with 0000:01:00.0
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a NS16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 > p3
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
NET: Registered protocol family 1
Adding 249440k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
PCI: Sharing IRQ 10 with 0000:00:0b.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c556 Laptop Tornado at 0x1800. Vers LK1.1.19
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
PCI: Found IRQ 5 for device 0000:00:0d.0
irda_init()
NET: Registered protocol family 23
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 0000:00:0a.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:0b.1
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0010]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0898, PCI irq10
Socket status: 30000010
PCI: Found IRQ 10 for device 0000:00:0a.1
PCI: Sharing IRQ 10 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:0a.1 [103c:0010]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0898, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x398-0x39f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0007:0034
eth1: Looks like a Lucent/Agere firmware version 7.52
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:60:1D:F1:78:A1
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth1: New link status: Connected (0001)
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
cdrom_newpc_intr: 3 residual after xfer
speedstep-smi: signature:0x00008680, command:0x0000e6f5, event:0x00000000, perf_level:0x47534943.

