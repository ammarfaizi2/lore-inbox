Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRBLP6d>; Mon, 12 Feb 2001 10:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131284AbRBLP6Y>; Mon, 12 Feb 2001 10:58:24 -0500
Received: from gate.rebel.com ([207.245.35.200]:60867 "HELO gw.rebel.com")
	by vger.kernel.org with SMTP id <S131246AbRBLP6M>;
	Mon, 12 Feb 2001 10:58:12 -0500
Message-ID: <3A8808DE.46C21A48@rebel.com>
Date: Mon, 12 Feb 2001 11:01:35 -0500
From: "Bob james" <bob.james@rebel.com>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No IRQ known for interrupt pin...
Content-Type: multipart/mixed;
 boundary="------------40ADA1BD035278E680C76CFF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------40ADA1BD035278E680C76CFF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I'm having terrible grief trying to get a PCMCIA wireless card going in
a desktop mchine using a card reader.  David Ford suggested that I try
you (see attached e-mail...I came across him while searching the
internet for solutions).  I'm running out of things to try and things to
read.  I'd be grateful if you could point me in the right direction.

Here is the short version:

1. I get messages like "No IRQ known for interrupt pin B of device
01:02:1.  Please try pci=biosirq." coming from yenta_socket.

2. The same card reader hardware works okay in a friend's machine.

3. I've tried 3 different machines (new and old) with the same results.

4. I've tried different PCI slots with the same results.

5. I've built the kernel (2.4.0) with and without kernel PCMCIA support
(as well as all sorts of other combinations of options), with
yenta_socket and with i82365, all with essentially the same results.

6. I've tried specifying "pci=biosirq" in every place I can think
of...as an argument to lilo, in the /etc/sysconfig/pcmcia file, even as
an environment variable...no luck.  Exactly where am I supposed to try
this setting?

7. I'm building kernel 2.4.0, pcmcia-cs 3.1.24 (although it says
3.1.22), modutils 2.4.0.  The processor is a Pentium III.

The rest of this e-mail is the following stuff:
- "lspci -v" output.
- "lsmod" output.
- "dmesg" output.
- pcmcia-cs "dump_pirq" output (and the stderr output).
- pcmcia-cs "test_setup" output.
- "/var/log/messages" file.
- Linux ".config" file.

Thanks very much for your time and effort.

Regards,
Bob James.

----------------------------------------------------------------------------

lspci -v

00:00.0 Host bridge: Intel Corporation 82810 GMCH [Graphics Memory
Controller Hub] (rev 03)
 Subsystem: GVC/BCM Advanced Research: Unknown device 2118
 Flags: bus master, fast devsel, latency 0

00:01.0 VGA compatible controller: Intel Corporation 82810 CGC [Chipset
Graphics Controller] (rev 03) (prog-if 00 [VGA])
 Subsystem: GVC/BCM Advanced Research: Unknown device 2118
 Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
 Memory at e8000000 (32-bit, prefetchable) [disabled] [size=64M]
 Memory at eff80000 (32-bit, non-prefetchable) [disabled] [size=512K]
 Capabilities: [dc] Power Management version 1

00:1e.0 PCI bridge: Intel Corporation 82801AA 82810 PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
 Flags: bus master, fast devsel, latency 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
 I/O behind bridge: 0000b000-0000bfff
 Memory behind bridge: efd00000-efdfffff
 Prefetchable memory behind bridge: e6b00000-e7bfffff

00:1f.0 ISA bridge: Intel Corporation 82801AA 82810 Chipset ISA Bridge
(LPC) (rev 02)
 Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801AA 82810 Chipset IDE (rev
02) (prog-if 80 [Master])
 Subsystem: Intel Corporation: Unknown device 2411
 Flags: bus master, medium devsel, latency 0
 I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA 82810 Chipset USB (rev
02) (prog-if 00 [UHCI])
 Subsystem: Intel Corporation: Unknown device 2412
 Flags: bus master, medium devsel, latency 0, IRQ 10
 I/O ports at d400 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA 82810 Chipset SMBus (rev 02)
 Subsystem: Intel Corporation: Unknown device 2413
 Flags: medium devsel
 I/O ports at 0540 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA 82810
AC'97 Audio (rev 02)
 Subsystem: GVC/BCM Advanced Research: Unknown device 2118
 Flags: bus master, medium devsel, latency 0, IRQ 3
 I/O ports at dc00 [size=256]
 I/O ports at d800 [size=64]

01:00.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
 Subsystem: Action Tec Electronics Inc: Unknown device 0293
 Flags: bus master, medium devsel, latency 168
 Memory at efd00000 (32-bit, non-prefetchable) [size=4K]
 Bus: primary=01, secondary=02, subordinate=02, sec-latency=176
 Memory window 0: e7800000-e7bff000 (prefetchable)
 I/O window 0: 0000b800-0000b8ff
 I/O window 1: 00000000-00000003
 16-bit legacy interface ports at 0001

01:00.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
 Subsystem: Action Tec Electronics Inc: Unknown device 0293
 Flags: bus master, medium devsel, latency 168
 Memory at efd01000 (32-bit, non-prefetchable) [size=4K]
 Bus: primary=01, secondary=06, subordinate=06, sec-latency=176
 Memory window 0: e6c00000-e6fff000 (prefetchable)
 I/O window 0: 0000b000-0000b0ff
 I/O window 1: 0000b400-0000b4ff
 16-bit legacy interface ports at 0001

01:01.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine
10/100] (rev 06)
 Subsystem: D-Link System Inc DFE-530TX
 Flags: bus master, medium devsel, latency 64, IRQ 11
 I/O ports at bc00 [size=128]
 Memory at efdfbf80 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at efdd0000 [disabled] [size=64K]

01:02.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 01) (prog-if 00 [VGA])
 Flags: stepping, medium devsel, IRQ 10
 Memory at efdfc000 (32-bit, non-prefetchable) [size=16K]
 Memory at e7000000 (32-bit, prefetchable) [size=8M]
 Expansion ROM at efde0000 [disabled] [size=64K]

----------------------------------------------------------------------------

lsmod

Module                  Size  Used by
ds                      6800   2
yenta_socket           10224   2
pcmcia_core            40928   0  [ds yenta_socket]

----------------------------------------------------------------------------

dmesg

Linux version 2.4.0 (root@dhcp52.isa.ott.rebel.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #31 Mon Feb 12
08:46:59 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000003de0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 0000000003ee0000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 0000000003ef0000 (ACPI NVS)
 BIOS-e820: 0000000000100000 @ 0000000003f00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 16096
zone(0): 4096 pages.
zone(1): 12000 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux240 ro root=307
Initializing CPU#0
Detected 550.980 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1097.72 BogoMIPS
Memory: 61028k/64384k available (1028k kernel code, 2968k reserved, 407k
data, 184k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387f9ff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [8086/2410] at 00:1f.0
  got res[efd00000:efd00fff] for resource 0 of Texas Instruments PCI1225

  got res[efd01000:efd01fff] for resource 0 of Texas Instruments PCI1225
(#2)
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.3 present.
35 structures occupying 2263 bytes.
DMI table at 0x000E05E0.
BIOS Vendor: American Megatrends Inc.
BIOS Version: DR742E BIOS Ver: 1.00
BIOS Release: 01/12/00
Board Vendor: INTEL                           .
Board Name: WHITNEY                         .
Board Version: 1.0                             .
Asset Tag: 0123ABC                         .
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLlct10 05, ATA DISK drive
hdb: ATAPI 48X CDROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 10002825 sectors (5121 MB) w/418KiB Cache, CHS=622/255/63
hdb: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Coda Kernel/Venus communications, v5.3.9, coda@cs.cmu.edu
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT3043 Rhine at 0xbc00, 00:80:c8:91:5e:62, IRQ 11.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link
0000.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 26M
agpgart: no supported devices found.
[drm:r128_init] *ERROR* Cannot initialize agpgart module.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 128480k swap-space (priority -1)
Adding Swap: 128480k swap-space (priority -2)
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus]
PCI: Enabling device 01:00.1 (0000 -> 0002)
PCI: No IRQ known for interrupt pin B of device 01:00.1. Please try
using pci=biosirq.
PCI: Enabling device 01:00.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try
using pci=biosirq.
Yenta IRQ list 0000, PCI irq0
Socket status: 10000006
Yenta IRQ list 0000, PCI irq0
Socket status: 10000006
cs: IO port probe 0x1000-0x17ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x200-0x207
0x290-0x297 0x330-0x337 0x370-0x37f 0x400-0x4bf 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
VFS: Disk change detected on device fd(2,0)

----------------------------------------------------------------------------

dump_pirq stderr

lspci: -f: Invalid slot number

dump_pirq

Interrupt routing table found at address 0xf69f0:
  Version 1.0, size 0x0080
  Interrupt router is device 00:1f.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x8086 device 0x2410

Device 00:01.0 (slot 0): VGA compatible controller
  INTA: link 0x60, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x61, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:1f.0 (slot 0):
  INTA: link 0xfe, irq mask 0x4000 [14]
  INTB: link 0x61, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x63, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 01:00.0 (slot 1): CardBus bridge
  INTA: link 0x61, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTB: link 0x62, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTC: link 0x63, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTD: link 0x60, irq mask 0xdea0 [5,7,9,10,11,12,14,15]

Device 01:01.0 (slot 2): Ethernet controller
  INTA: link 0x62, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTB: link 0x63, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTC: link 0x60, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTD: link 0x61, irq mask 0xdea0 [5,7,9,10,11,12,14,15]

Device 01:02.0 (slot 3): VGA compatible controller
  INTA: link 0x63, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTB: link 0x60, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTC: link 0x61, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTD: link 0x62, irq mask 0xdea0 [5,7,9,10,11,12,14,15]

Device 01:03.0 (slot 0):
  INTA: link 0x60, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTB: link 0x61, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTC: link 0x62, irq mask 0xdea0 [5,7,9,10,11,12,14,15]
  INTD: link 0x63, irq mask 0xdea0 [5,7,9,10,11,12,14,15]

Interrupt router at 00:1f.0: Intel 82801AA ICH PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 11
  PIRQ2 (link 0x61): irq 3
  PIRQ3 (link 0x62): irq 11
  PIRQ4 (link 0x63): irq 10
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=4]
  Level mask: 0x0c08 [3,10,11]

----------------------------------------------------------------------------

pcmcia test_setup

Current kernel: 2.4.0 #31 Mon Feb 12 08:46:59 EST 2001
Module info from /lib/modules/2.4.0/pcmcia/pcmcia_core.o:
  Linux PCMCIA Card Services 3.1.22
  options: [pci] [cardbus]

Startup options from /etc/sysconfig/pcmcia:
  PCMCIA=yes
  PCIC=yenta_socket
  PCIC_OPTS=
  CORE_OPTS=
  CARDMGR_OPTS="-v -d"

Checking current syslog files in /var/log:
  All PCMCIA messages are in /var/log/messages.

Module status:
  No socket drivers are loaded.

Daemon status:
  cardmgr is running (process 475)

Current socket status from /var/lib/pcmcia/stab:
  Socket 0: empty
  Socket 1: empty

----------------------------------------------------------------------------

/var/log/messages

Feb 12 08:50:21 dhcp52 syslogd 1.3-3: restart.
Feb 12 08:50:21 dhcp52 syslog: syslogd startup succeeded
Feb 12 08:50:21 dhcp52 kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Feb 12 08:50:21 dhcp52 kernel: Inspecting /boot/System.map-2.4.0
Feb 12 08:50:21 dhcp52 syslog: klogd startup succeeded
Feb 12 08:50:21 dhcp52 identd: identd startup succeeded
Feb 12 08:50:21 dhcp52 kernel: Loaded 13880 symbols from
/boot/System.map-2.4.0.
Feb 12 08:50:21 dhcp52 kernel: Symbols match kernel version 2.4.0.
Feb 12 08:50:21 dhcp52 kernel: No module symbols loaded.
Feb 12 08:50:21 dhcp52 kernel: Linux version 2.4.0
(root@dhcp52.isa.ott.rebel.com) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #31 Mon Feb 12 08:46:59 EST 2001
Feb 12 08:50:21 dhcp52 kernel: BIOS-provided physical RAM map:
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 000000000009fc00 @
0000000000000000 (usable)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000000400 @
000000000009fc00 (reserved)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000020000 @
00000000000e0000 (reserved)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000003de0000 @
0000000000100000 (usable)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000010000 @
0000000003ee0000 (ACPI data)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000010000 @
0000000003ef0000 (ACPI NVS)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000100000 @
0000000003f00000 (reserved)
Feb 12 08:50:21 dhcp52 kernel:  BIOS-e820: 0000000000080000 @
00000000fff80000 (reserved)
Feb 12 08:50:21 dhcp52 kernel: On node 0 totalpages: 16096
Feb 12 08:50:21 dhcp52 kernel: zone(0): 4096 pages.
Feb 12 08:50:21 dhcp52 kernel: zone(1): 12000 pages.
Feb 12 08:50:21 dhcp52 kernel: zone(2): 0 pages.
Feb 12 08:50:21 dhcp52 kernel: Kernel command line: BOOT_IMAGE=linux240
ro root=307
Feb 12 08:50:21 dhcp52 kernel: Initializing CPU#0
Feb 12 08:50:21 dhcp52 kernel: Detected 550.980 MHz processor.
Feb 12 08:50:21 dhcp52 kernel: Console: colour VGA+ 80x25
Feb 12 08:50:21 dhcp52 kernel: Calibrating delay loop... 1097.72
BogoMIPS
Feb 12 08:50:21 dhcp52 kernel: Memory: 61028k/64384k available (1028k
kernel code, 2968k reserved, 407k data, 184k init, 0k highmem)
Feb 12 08:50:21 dhcp52 kernel: Dentry-cache hash table entries: 8192
(order: 4, 65536 bytes)
Feb 12 08:50:21 dhcp52 kernel: Buffer-cache hash table entries: 1024
(order: 0, 4096 bytes)
Feb 12 08:50:21 dhcp52 kernel: Page-cache hash table entries: 16384
(order: 4, 65536 bytes)
Feb 12 08:50:21 dhcp52 kernel: Inode-cache hash table entries: 4096
(order: 3, 32768 bytes)
Feb 12 08:50:21 dhcp52 kernel: CPU: Before vendor init, caps: 0387f9ff
00000000 00000000, vendor = 0
Feb 12 08:50:21 dhcp52 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb 12 08:50:21 dhcp52 kernel: CPU: L2 cache: 256K
Feb 12 08:50:21 dhcp52 kernel: Intel machine check architecture
supported.
Feb 12 08:50:21 dhcp52 kernel: Intel machine check reporting enabled on
CPU#0.
Feb 12 08:50:21 dhcp52 kernel: CPU: After vendor init, caps: 0387f9ff
00000000 00000000 00000000
Feb 12 08:50:21 dhcp52 kernel: CPU serial number disabled.
Feb 12 08:50:21 dhcp52 kernel: CPU: After generic, caps: 0383f9ff
00000000 00000000 00000000
Feb 12 08:50:21 dhcp52 kernel: CPU: Common caps: 0383f9ff 00000000
00000000 00000000
Feb 12 08:50:21 dhcp52 kernel: CPU: Intel Pentium III (Coppermine)
stepping 01
Feb 12 08:50:21 dhcp52 kernel: Enabling fast FPU save and restore...
done.
Feb 12 08:50:21 dhcp52 kernel: Enabling unmasked SIMD FPU exception
support... done.
Feb 12 08:50:21 dhcp52 kernel: Checking 'hlt' instruction... OK.
Feb 12 08:50:21 dhcp52 kernel: POSIX conformance testing by UNIFIX
Feb 12 08:50:21 dhcp52 kernel: mtrr: v1.37 (20001109) Richard Gooch
(rgooch@atnf.csiro.au)
Feb 12 08:50:21 dhcp52 kernel: mtrr: detected mtrr type: Intel
Feb 12 08:50:21 dhcp52 kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb91, last bus=1
Feb 12 08:50:21 dhcp52 kernel: PCI: Using configuration type 1
Feb 12 08:50:21 dhcp52 kernel: PCI: Probing PCI hardware
Feb 12 08:50:21 dhcp52 kernel: PCI: Using IRQ router default [8086/2410]
at 00:1f.0
Feb 12 08:50:21 dhcp52 kernel:   got res[efd00000:efd00fff] for resource
0 of Texas Instruments PCI1225
Feb 12 08:50:21 dhcp52 kernel:   got res[efd01000:efd01fff] for resource
0 of Texas Instruments PCI1225 (#2)
Feb 12 08:50:21 dhcp52 kernel: isapnp: Scanning for Pnp cards...
Feb 12 08:50:21 dhcp52 kernel: isapnp: No Plug & Play device found
Feb 12 08:50:21 dhcp52 kernel: Linux NET4.0 for Linux 2.4
Feb 12 08:50:21 dhcp52 kernel: Based upon Swansea University Computer
Society NET3.039
Feb 12 08:50:21 dhcp52 kernel: Initializing RT netlink socket
Feb 12 08:50:21 dhcp52 kernel: DMI 2.3 present.
Feb 12 08:50:21 dhcp52 kernel: 35 structures occupying 2263 bytes.
Feb 12 08:50:21 dhcp52 kernel: DMI table at 0x000E05E0.
Feb 12 08:50:21 dhcp52 kernel: BIOS Vendor: American Megatrends Inc.
Feb 12 08:50:21 dhcp52 kernel: BIOS Version: DR742E BIOS Ver: 1.00
Feb 12 08:50:21 dhcp52 kernel: BIOS Release: 01/12/00
Feb 12 08:50:21 dhcp52 kernel: Board Vendor:
INTEL                           .
Feb 12 08:50:21 dhcp52 kernel: Board Name:
WHITNEY                         .
Feb 12 08:50:21 dhcp52 kernel: Board Version:
1.0                             .
Feb 12 08:50:21 dhcp52 kernel: Asset Tag:
0123ABC                         .
Feb 12 08:50:21 dhcp52 kernel: Starting kswapd v1.8
Feb 12 08:50:21 dhcp52 kernel: pty: 256 Unix98 ptys configured
Feb 12 08:50:21 dhcp52 kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Feb 12 08:50:21 dhcp52 kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Feb 12 08:50:21 dhcp52 kernel: PIIX4: IDE controller on PCI bus 00 dev
f9
Feb 12 08:50:21 dhcp52 kernel: PIIX4: chipset revision 2
Feb 12 08:50:21 dhcp52 kernel: PIIX4: not 100% native mode: will probe
irqs later
Feb 12 08:50:21 dhcp52 kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
settings: hda:DMA, hdb:DMA
Feb 12 08:50:21 dhcp52 kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS
settings: hdc:pio, hdd:pio
Feb 12 08:50:22 dhcp52 atd: atd startup succeeded
Feb 12 08:50:22 dhcp52 kernel: hda: QUANTUM FIREBALLlct10 05, ATA DISK
drive
Feb 12 08:50:22 dhcp52 kernel: hdb: ATAPI 48X CDROM, ATAPI CDROM drive
Feb 12 08:50:22 dhcp52 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 08:50:22 dhcp52 kernel: hda: 10002825 sectors (5121 MB) w/418KiB
Cache, CHS=622/255/63
Feb 12 08:50:22 dhcp52 kernel: hdb: ATAPI 48X CD-ROM drive, 128kB Cache
Feb 12 08:50:22 dhcp52 kernel: Uniform CD-ROM driver Revision: 3.12
Feb 12 08:50:22 dhcp52 kernel: Partition check:
Feb 12 08:50:22 dhcp52 kernel:  hda: hda1 hda2 < hda5 hda6 hda7 >
Feb 12 08:50:22 dhcp52 kernel: Floppy drive(s): fd0 is 1.44M
Feb 12 08:50:22 dhcp52 kernel: FDC 0 is a post-1991 82077
Feb 12 08:50:22 dhcp52 kernel: Coda Kernel/Venus communications, v5.3.9,
coda@cs.cmu.edu
Feb 12 08:50:22 dhcp52 kernel: Serial driver version 5.02 (2000-08-09)
with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Feb 12 08:50:22 dhcp52 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb 12 08:50:22 dhcp52 kernel: via-rhine.c:v1.08b-LK1.1.6  8/9/2000
Written by Donald Becker
Feb 12 08:50:22 dhcp52 kernel:
http://www.scyld.com/network/via-rhine.html
Feb 12 08:50:22 dhcp52 kernel: eth0: VIA VT3043 Rhine at 0xbc00,
00:80:c8:91:5e:62, IRQ 11.
Feb 12 08:50:22 dhcp52 kernel: eth0: MII PHY found at address 8, status
0x782d advertising 05e1 Link 0000.
Feb 12 08:50:22 dhcp52 kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Feb 12 08:50:22 dhcp52 kernel: agpgart: Maximum main memory to use for
agp memory: 26M
Feb 12 08:50:22 dhcp52 kernel: [drm:r128_init] *ERROR* Cannot initialize
agpgart module.
Feb 12 08:50:22 dhcp52 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 12 08:50:22 dhcp52 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb 12 08:50:22 dhcp52 kernel: IP: routing cache hash table of 512
buckets, 4Kbytes
Feb 12 08:50:22 dhcp52 kernel: TCP: Hash tables configured (established
4096 bind 4096)
Feb 12 08:50:22 dhcp52 kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Feb 12 08:50:22 dhcp52 kernel: NET4: Ethernet Bridge 008 for NET4.0
Feb 12 08:50:22 dhcp52 kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Feb 12 08:50:22 dhcp52 kernel: Freeing unused kernel memory: 184k freed
Feb 12 08:50:22 dhcp52 kernel: Adding Swap: 128480k swap-space (priority
-1)
Feb 12 08:50:22 dhcp52 kernel: Adding Swap: 128480k swap-space (priority
-2)
Feb 12 08:50:12 dhcp52 rc.sysinit: Mounting proc filesystem succeeded
Feb 12 08:50:12 dhcp52 sysctl: net.ipv4.ip_forward = 0
Feb 12 08:50:12 dhcp52 sysctl: net.ipv4.conf.all.rp_filter = 1
Feb 12 08:50:12 dhcp52 sysctl: kernel.sysrq = 0
Feb 12 08:50:12 dhcp52 sysctl: error: 'net.ipv4.ip_always_defrag' is an
unknown key
Feb 12 08:50:12 dhcp52 rc.sysinit: Configuring kernel parameters
succeeded
Feb 12 08:50:12 dhcp52 date: Mon Feb 12 08:50:11 EST 2001
Feb 12 08:50:12 dhcp52 rc.sysinit: Setting clock : Mon Feb 12 08:50:11
EST 2001 succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Loading default keymap succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Activating swap partitions succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Setting hostname
localhost.localdomain succeeded
Feb 12 08:50:12 dhcp52 fsck: /dev/hda7: clean, 59741/590816 files,
239519/1180769 blocks
Feb 12 08:50:12 dhcp52 rc.sysinit: Checking root filesystem succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Remounting root filesystem in
read-write mode succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Finding module dependencies succeeded

Feb 12 08:50:12 dhcp52 fsck: /dev/hda1: clean, 28/4016 files, 5231/16033
blocks
Feb 12 08:50:12 dhcp52 rc.sysinit: Checking filesystems succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Mounting local filesystems succeeded
Feb 12 08:50:12 dhcp52 rc.sysinit: Turning on user and group quotas for
local filesystems succeeded
Feb 12 08:50:13 dhcp52 rc.sysinit: Enabling swap space succeeded
Feb 12 08:50:13 dhcp52 init: Entering runlevel: 3
Feb 12 08:50:18 dhcp52 kudzu:  succeeded
Feb 12 08:50:18 dhcp52 sysctl: net.ipv4.ip_forward = 0
Feb 12 08:50:18 dhcp52 sysctl: net.ipv4.conf.all.rp_filter = 1
Feb 12 08:50:18 dhcp52 sysctl: kernel.sysrq = 0
Feb 12 08:50:18 dhcp52 sysctl: error: 'net.ipv4.ip_always_defrag' is an
unknown key
Feb 12 08:50:18 dhcp52 network: Setting network parameters succeeded
Feb 12 08:50:19 dhcp52 network: Bringing up interface lo succeeded
Feb 12 08:50:19 dhcp52 ifup: Determining IP information for eth0...
Feb 12 08:50:19 dhcp52 pumpd[267]: starting at (uptime 0 days, 0:00:16)
Mon Feb 12 08:50:19 2001
Feb 12 08:50:22 dhcp52 crond: crond startup succeeded
Feb 12 08:50:20 dhcp52 ifup:  done.
Feb 12 08:50:20 dhcp52 network: Bringing up interface eth0 succeeded
Feb 12 08:50:20 dhcp52 portmap: portmap startup succeeded
Feb 12 08:50:20 dhcp52 rpc.lockd: lockdsvc: Function not implemented
Feb 12 08:50:20 dhcp52 nfslock: rpc.lockd startup failed
Feb 12 08:50:20 dhcp52 nfslock: rpc.statd startup succeeded
Feb 12 08:50:20 dhcp52 random: Initializing random number generator
succeeded
Feb 12 08:50:21 dhcp52 netfs: Mounting other filesystems succeeded
Feb 12 08:50:22 dhcp52 pcmcia: Starting PCMCIA services:
Feb 12 08:50:23 dhcp52 pcmcia:  modules
Feb 12 08:50:23 dhcp52 kernel: Linux PCMCIA Card Services 3.1.22
Feb 12 08:50:23 dhcp52 kernel:   options:  [pci] [cardbus]
Feb 12 08:50:23 dhcp52 kernel: PCI: Enabling device 01:00.1 (0000 ->
0002)
Feb 12 08:50:23 dhcp52 kernel: PCI: No IRQ known for interrupt pin B of
device 01:00.1. Please try using pci=biosirq.
Feb 12 08:50:23 dhcp52 kernel: PCI: Enabling device 01:00.0 (0000 ->
0002)
Feb 12 08:50:23 dhcp52 kernel: PCI: No IRQ known for interrupt pin A of
device 01:00.0. Please try using pci=biosirq.
Feb 12 08:50:23 dhcp52 kernel: Yenta IRQ list 0000, PCI irq0
Feb 12 08:50:23 dhcp52 kernel: Socket status: 10000006
Feb 12 08:50:23 dhcp52 kernel: Yenta IRQ list 0000, PCI irq0
Feb 12 08:50:23 dhcp52 kernel: Socket status: 10000006
Feb 12 08:50:23 dhcp52 pcmcia:  cardmgr.
Feb 12 08:50:23 dhcp52 cardmgr[475]: starting, version is 3.1.22
Feb 12 08:50:23 dhcp52 rc: Starting pcmcia succeeded
Feb 12 08:50:23 dhcp52 lpd[489]: restarted
Feb 12 08:50:23 dhcp52 lpd: lpd startup succeeded
Feb 12 08:50:23 dhcp52 keytable: Loading keymap:
Feb 12 08:50:23 dhcp52 keytable: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Feb 12 08:50:23 dhcp52 cardmgr[475]: watching 2 sockets
Feb 12 08:50:23 dhcp52 kernel: cs: IO port probe 0x1000-0x17ff: clean.
Feb 12 08:50:23 dhcp52 kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x170-0x177 0x200-0x207 0x290-0x297 0x330-0x337 0x370-0x37f
0x400-0x4bf 0x4d0-0x4d7
Feb 12 08:50:23 dhcp52 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 12 08:50:23 dhcp52 keytable: Loading system font:
Feb 12 08:50:24 dhcp52 rc: Starting keytable succeeded
Feb 12 08:50:24 dhcp52 sendmail: sendmail startup succeeded
Feb 12 08:50:25 dhcp52 gpm: gpm startup succeeded
Feb 12 08:50:25 dhcp52 xfs: xfs startup succeeded
Feb 12 08:50:26 dhcp52 xfs: Warning: The directory
"/usr/share/fonts/default/TrueType" does not exist.
Feb 12 08:50:26 dhcp52 xfs:          Entry deleted from font path.
Feb 12 08:50:26 dhcp52 linuxconf: Linuxconf final setup
Feb 12 08:50:27 dhcp52 rc: Starting linuxconf succeeded
Feb 12 08:50:34 dhcp52 PAM_pwdb[621]: (login) session opened for user
root by LOGIN(uid=0)

----------------------------------------------------------------------------

.config

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_M686FXSR=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_FXSR=y
CONFIG_X86_XMM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y
# CONFIG_TCIC is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=y
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_NETWAVE is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_AIRONET4500_CS is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
CONFIG_PCMCIA_SERIAL=m

#
# PCMCIA character device support
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_PCMCIA_SERIAL_CB is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y


--------------40ADA1BD035278E680C76CFF
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <david@blue-labs.org>
Received: from fiji.isa.ott.rebel.com (fiji [10.1.2.10]) by
          quad.rebel.com. (Netscape Messaging Server 4.15) with ESMTP id
          G8M8ZR00.5HU for <bob.james@rebel.com>; Sun, 11 Feb 2001 18:23:51 -0500 
Received: from gate.rebel.com (gate [10.1.1.2])
	by fiji.isa.ott.rebel.com (8.9.1b+Sun/8.9.1) with SMTP id SAA03417
	for <bob.james@rebel.com>; Sun, 11 Feb 2001 18:23:50 -0500 (EST)
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]) by gate.rebel.com
          via smtpd (for fiji.isa.ott.rebel.com [10.1.2.10]) with SMTP; 11 Feb 2001 23:23:13 UT
Received: from blue-labs.org (david@localhost [127.0.0.1])
	by Huntington-Beach.Blue-Labs.org (8.11.0/8.11.0) with ESMTP id f1BNNa103851
	for <bob.james@rebel.com>; Sun, 11 Feb 2001 15:23:39 -0800
Message-ID: <3A871EF8.40209@blue-labs.org>
Date: Sun, 11 Feb 2001 15:23:36 -0800
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre11 i686; en-US; m18) Gecko/20010208
X-Accept-Language: en
MIME-Version: 1.0
To: Bob james <bob.james@rebel.com>
Subject: Re: PCMCIA IRQ Problem
In-Reply-To: <3A83F088.C4CA6124@rebel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bob james wrote:

> David,
> 
> I am trying to get a PCMCIA wireless card going in a desktop (2.4.0
> kernel) using a card reader.  It works in my buddy's machine but not
> mine.  I get messages like:
> 
> No IRQ known for interrupt pin B of device 01:02.1.  Please try using
> pci=biosirq.
> No IRQ known for interrupt pin A of device 01:02.0.  Please try using
> pci=biosirq.
> 
> I noticed that you were having a similar problem last September.  Did
> you ever get it resolved?  Any suggestions?
> 
> Thanks very much for your time.
> 
> Regards,
> Bob James.


Yes, it was solved.  It was an IRQ routing table problem and Linus 
solved it just before 2.4.0.  I recommend you run an 'lspci -v', run the 
pirqdump tool from pcmcia-cs tools, and enclose a copy of your dmesg. 
Post it to linux-kernel@vger.kernel.org.

have you tried pci=biosirq?

-d


--------------40ADA1BD035278E680C76CFF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
