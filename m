Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbTIBIMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTIBIMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:12:30 -0400
Received: from abort.boom.net ([205.159.115.34]:37853 "EHLO abort.boom.net")
	by vger.kernel.org with ESMTP id S262452AbTIBIMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:12:23 -0400
Date: Tue, 2 Sep 2003 01:12:22 -0700
From: Reza Naima <reza@reza.net>
To: linux-kernel@vger.kernel.org
Subject: gdb-5.3 doesn't work under linux-2.6.0-test4 / ide unhandled interrupts
Message-ID: <20030902081222.GA22989@boom.net>
Reply-To: Reza Naima <reza@reza.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-URL: http://www.reza.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found no mention of this problem while searching the linux-kernel
or the gdb archives...

In trying to debug a userland application (mythfrontend from
mythtv.org) running on linux-2.6.0-test4, I get this as soon as the
application tries to display video:

	Program terminated with signal SIGTRAP, Trace/breakpoint trap.
	The program no longer exists.
	(gdb)

Running in the exact same environment but under linux-2.4.22, gdb works
without fault and no problems occur.  The application also runs without
problem under linux-2.6.0-test4 if gdb is not used.

I'm including my 2.6.0 dmesg output in case it might be useful.   Let me know
if anyone wants additional information.  And again, I hope this is not
off-topic.

Reza

p.s. I've added some code to display the number of unhandled interrupts
to /proc/interrupts, and it seems my ide drive consistantly has a high
percentage of unhandled interrupts -- I'm still investigating it, but
just wanted to know if this was expected behaviour?

[mythtv@pvr mythtv]$ cat /proc/interrupts
           CPU0
  0:    2036694          XT-PIC  timer (         0 unhandled)
  1:        303          XT-PIC  i8042 (         0 unhandled)
  2:          0          XT-PIC  cascade (         0 unhandled)
  4:       2166          XT-PIC  lirc_serial (         0 unhandled)
  5:          0          XT-PIC  ehci_hcd (         0 unhandled)
  8:          1          XT-PIC  rtc (         0 unhandled)
 10:        170          XT-PIC  bttv0 (         0 unhandled)
 12:      32879          XT-PIC  eth0 (         0 unhandled), SiS 7012
 14:      12167          XT-PIC  ide0 (      7673 unhandled)
NMI:          0
LOC:    2036705
ERR:          0


--------------------
------ dmesg -------
--------------------
Linux version 2.6.0-test4 (root@pvr) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #6 Mon Sep 1 18:20:28 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dffc000 (usable)
 BIOS-e820: 000000000dffc000 - 000000000dfff000 (ACPI data)
 BIOS-e820: 000000000dfff000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
223MB LOWMEM available.
On node 0 totalpages: 57340
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53244 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda2 init=/sbin/init  acpi=off 
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2793.721 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5521.40 BogoMIPS
Memory: 223008k/229360k available (2127k kernel code, 5652k reserved, 726k data, 152k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2792.0700 MHz.
..... host bus clock speed is 132.0985 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf1070, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Enabling SiS 96x SMBus.
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:02.5
PM: Adding info for pci:0000:00:02.7
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:03.1
PM: Adding info for pci:0000:00:03.2
PM: Adding info for pci:0000:00:03.3
PM: Adding info for pci:0000:00:0e.0
PM: Adding info for pci:0000:00:0e.1
PM: Adding info for pci:0000:00:0f.0
PM: Adding info for pci:0000:01:00.0
PCI: Using IRQ router default [1039/0962] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
pty: 2048 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Journalled Block Device driver loaded
SGI XFS for Linux with no debug enabled
Initializing Cryptographic API
lirc_dev: IR Remote Control driver registered, at major 61 
Real Time Clock Driver v1.11a
Non-volatile memory driver v1.2
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
hda: IC35L060AVV207-0, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hda: max request size: 1024KiB
hda: 80418240 sectors (41174 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 152k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem ce86a000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
PM: Adding info for usb:1-0:0
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 257032k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU0 no microcode found! (sig=f27, pflags=4)
b44.c:v0.9 (Jul 14, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0c:6e:37:98:8d
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
Module smbfs cannot be unloaded due to unsafe usage in include/linux/module.h:483
Intel 810 + AC97 Audio, version 0.24, 18:08:01 Sep  1 2003
i810: SiS 7012 found at IO 0x9000 and 0x9400, MEM 0x0000 and 0x0000, IRQ 12
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
i810_audio: setting clocking to 48566
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0e.0, irq: 10, latency: 32, mmio: 0xe7000000
bttv0: detected: Leadtek WinFast TV 2000 [card=34], PCI subsystem ID is 107d:6606
bttv0: using: Leadtek WinFast 2000/ WinFast 2000 XP [card=34,autodetected]
PM: Adding info for No Bus:i2c-0
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found @ 0xc2
tuner(bttv): type forced to 2 (Philips NTSC (FI1236,FM1236 and compatibles)) [insmod]
tuner: type already set (2)
registering 0-0061
PM: Adding info for i2c:0-0061
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
lirc_serial: auto-detected active high receiver
lirc_dev: lirc_register_plugin:sample_rate: 0
bttv0: PLL can sleep, using XTAL (28636363).

