Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263696AbUDUUiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbUDUUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUDUUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:38:16 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:18660 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S263696AbUDUUhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:37:25 -0400
Date: Wed, 21 Apr 2004 16:37:24 -0400
From: rm <async@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: OOPS in input subsystem
Message-ID: <20040421203724.GB16075@tokyo.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi all, 
	email me for any further info, and please CC me.

	thanks, 
	rob

oops, dmesg, ver_linux output follow

[1.] One line summary of the problem:    

Oops occurs under certain conditions when /dev/input/eventX is read.

[2.] Full description of the problem/report:

I can reliably get an oops if i do the following: 
1. plug in a ibm USB numeric keypad
1.  cat /dev/input/event1  (which corresponds to the keypad)
2.  unplug the keypad (leaving the cat in 1 running)
3. run another cat /dev/input/event1

NOTE: the first instance of cat doesn't get any sort of end of file or
	file error (which i believe was the old behaviour ~2.4). 


[3.] Keywords (i.e., modules, networking, kernel):

	input, USB, evdev

[4.] Kernel version (from /proc/version):

Linux version 2.6.5 (here@boo) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-8)) #1 SMP Wed Apr 21 14:45:09 EDT 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

	<see below>

[6.] A small shell script or example program which triggers the
     problem (if possible)

	<as above>
 
[7.] Environment
	redhat FC2 test1 (with a stock kernel from linux.org)

[7.1.] Software (add the output of the ver_linux script here)
	<see below>

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5800
stepping        : 3
cpu MHz         : 799.347
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1490.94


[7.3.] Module information (from /proc/modules):

floppy 62736 0 - Live 0xcf9c2000
snd_pcm_oss 56644 1 - Live 0xcf948000
snd_mixer_oss 20960 1 snd_pcm_oss, Live 0xcf941000
evdev 10560 2 - Live 0xcf917000
snd_es1938 23076 2 - Live 0xcf910000
snd_pcm 107780 3 snd_pcm_oss,snd_es1938, Live 0xcf925000
snd_page_alloc 11876 1 snd_pcm, Live 0xcf90c000
snd_opl3_lib 12256 1 snd_es1938, Live 0xcf908000
snd_timer 30212 2 snd_pcm,snd_opl3_lib, Live 0xcf8ff000
snd_hwdep 10180 1 snd_opl3_lib, Live 0xcf8fb000
gameport 5408 1 snd_es1938, Live 0xcf858000
snd_mpu401_uart 8800 1 snd_es1938, Live 0xcf8f7000
snd_rawmidi 27552 1 snd_mpu401_uart, Live 0xcf8ef000
snd_seq_device 8840 2 snd_opl3_lib,snd_rawmidi, Live 0xcf91c000
snd 56836 11 snd_pcm_oss,snd_mixer_oss,snd_es1938,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xcf8e0000
soundcore 10496 2 snd, Live 0xcf921000
ipv6 274240 10 - Live 0xcf89c000
8139too 27072 0 - Live 0xcf81b000
mii 5568 1 8139too, Live 0xcf818000
hid 47008 0 - Live 0xcf963000
uhci_hcd 37456 0 - Live 0xcf80d000
usbcore 112668 4 hid,uhci_hcd, Live 0xcf837000
ext3 122088 2 - Live 0xcf85b000
jbd 71704 1 ext3, Live 0xcf824000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[here@boo here]$ more /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0effffff : System RAM
  00100000-00302e3f : Kernel code
  00302e40-003b855f : Kernel data
e0000000-e0ffffff : 0000:00:09.0
e2000000-e20fffff : 0000:00:00.0
e2100000-e21000ff : 0000:00:08.0
  e2100000-e21000ff : 8139too
ffff0000-ffffffff : reserved

[here@boo here]$ more /proc/ioports
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
02e8-02ef : serial
02f8-02ff : serial
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-40ff : 0000:00:07.4
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
c000-c00f : 0000:00:07.1
  c000-c007 : ide0
c400-c41f : 0000:00:07.2
  c400-c41f : uhci_hcd
cc00-ccff : 0000:00:08.0
  cc00-ccff : 8139too
d000-d03f : 0000:00:0b.0
  d000-d007 : ESS Solo-1
d400-d40f : 0000:00:0b.0
  d400-d40f : ESS Solo-1 SB
d800-d80f : 0000:00:0b.0
  d800-d80f : ESS Solo-1 VC (DMA)
dc00-dc03 : 0000:00:0b.0
  dc00-dc03 : ESS Solo-1 MIDI
e000-e003 : 0000:00:0b.0
  e000-e003 : ESS Solo-1 GAME

[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e2000000 (32-bit, non-prefetchable)

0000:00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at cc00
	Region 1: Memory at e2100000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 VGA compatible controller: Chips and Technologies F69030 (rev 61) (prog-if 00 [VGA])
	Subsystem: Chips and Technologies F69030
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)

0000:00:0b.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 02)
	Subsystem: ESS Technology: Unknown device 8898
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000
	Region 1: I/O ports at d400 [size=16]
	Region 2: I/O ports at d800 [size=16]
	Region 3: I/O ports at dc00 [size=4]
	Region 4: I/O ports at e000 [size=4]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:




oops:
------------------------------------------------------------------------
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
SMP 
CPU:    0
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010202   (2.6.5) 
EIP is at 0x6b6b6b6b
eax: cb174084   ebx: 00000001   ecx: 6b6b6b6b   edx: c12b685c
esi: cb174084   edi: cc150b88   ebp: cb174084   esp: ceb95ec8
ds: 007b   es: 007b   ss: 0068
Process more (pid: 1383, threadinfo=ceb94000 task=cc1ba140)
Stack: c0277d81 c12b685c cb174084 cf91736f ccee1734 cb174084 c01d166e c0385800 
       cb174084 cc150b88 cc150b88 c02789ee cc150b88 cb174084 ceb94000 cefe5f88 
       00000000 c0173a67 cc150b88 cb174084 00000020 cb174084 00008000 ffffffe9 
Call Trace:
 [<c0277d81>] input_accept_process+0x31/0x40
 [<cf91736f>] evdev_open+0x5f/0x100 [evdev]
 [<c01d166e>] file_alloc_security+0x3e/0xb0
 [<c02789ee>] input_open_file+0x7e/0x170
 [<c0173a67>] chrdev_open+0x117/0x300
 [<c01691b9>] get_empty_filp+0x79/0x120
 [<c0167170>] dentry_open+0x130/0x1e0
 [<c0167038>] filp_open+0x68/0x70
 [<c01675ab>] sys_open+0x5b/0x90
 [<c010975d>] sysenter_past_esp+0x52/0x71

Code:  Bad EIP value.


dmesg:
----------------------------------------------------------------
Linux version 2.6.5 (here@boo) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-8)) #1 SMP Wed Apr 21 14:45:09 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57344 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: Unable to locate RSDP
Built 1 zonelists
Kernel command line: ro root=LABEL=/ 
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 799.347 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 238868k/245760k available (2059k kernel code, 6156k reserved, 725k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1490.94 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 200k freed
CPU:     After generic identify, caps: 0084893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 800 MHz
CPU: Code Morphing Software revision 4.2.6-8-168
CPU: 20010703 00:29 official release 4.2.6#2
CPU serial number disabled.
CPU:     After all inits, caps: 0080893f 0081813f 0000000e 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
per-CPU timeslice cutoff: 1462.34 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb210, last bus=0
PCI: Using configuration type 1
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB), CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 192k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 9 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:07.2: irq 9, io base 0000c400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.3: new low speed USB device using address 3
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Keyboard [Chicony USB Mobile Numeric Keypad] on usb-0000:00:07.2-1.3
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda8, internal journal
Adding 265064k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 12 for device 0000:00:08.0
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xcf856000, 00:e0:4c:39:00:e4, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c037fdc0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
PCI: Found IRQ 5 for device 0000:00:0b.0
eth0: no IPv6 routers present
ip_tables: (C) 2000-2002 Netfilter core team
usb 1-1.3: USB disconnect, address 3
inserting floppy driver for 2.6.5
FDC 0 is a post-1991 82077
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
SMP 
CPU:    0
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010202   (2.6.5) 
EIP is at 0x6b6b6b6b
eax: cb174084   ebx: 00000001   ecx: 6b6b6b6b   edx: c12b685c
esi: cb174084   edi: cc150b88   ebp: cb174084   esp: ceb95ec8
ds: 007b   es: 007b   ss: 0068
Process more (pid: 1383, threadinfo=ceb94000 task=cc1ba140)
Stack: c0277d81 c12b685c cb174084 cf91736f ccee1734 cb174084 c01d166e c0385800 
       cb174084 cc150b88 cc150b88 c02789ee cc150b88 cb174084 ceb94000 cefe5f88 
       00000000 c0173a67 cc150b88 cb174084 00000020 cb174084 00008000 ffffffe9 
Call Trace:
 [<c0277d81>] input_accept_process+0x31/0x40
 [<cf91736f>] evdev_open+0x5f/0x100 [evdev]
 [<c01d166e>] file_alloc_security+0x3e/0xb0
 [<c02789ee>] input_open_file+0x7e/0x170
 [<c0173a67>] chrdev_open+0x117/0x300
 [<c01691b9>] get_empty_filp+0x79/0x120
 [<c0167170>] dentry_open+0x130/0x1e0
 [<c0167038>] filp_open+0x68/0x70
 [<c01675ab>] sys_open+0x5b/0x90
 [<c010975d>] sysenter_past_esp+0x52/0x71

Code:  Bad EIP value.
 
ver_linux:
---------------------------------------------------

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux boo 2.6.5 #1 SMP Wed Apr 21 14:45:09 EDT 2004 i686 i686 i386 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12pre
mount                  2.12pre
module-init-tools      2.4.26
e2fsprogs              1.35-WIP
jfsutils               1.1.3
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         floppy snd_pcm_oss snd_mixer_oss evdev snd_es1938 snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipv6 8139too mii hid uhci_hcd usbcore ext3 jbd
---------------------------------------------------

----
Robert Melby
Georgia Institute of Technology, Atlanta Georgia, 30332
uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
Internet: async@cc.gatech.edu
