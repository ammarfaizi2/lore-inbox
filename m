Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275733AbTHOIQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275794AbTHOIQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:16:22 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:52396 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S275733AbTHOIPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:15:41 -0400
Message-ID: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Trying to run 2.6.0-test3
Date: Fri, 15 Aug 2003 17:11:42 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I cannot keep up with the list.  Any advice or questions, personal
mail please.  The following problems still exist in 2.6.0-test3.  The
first one is still a show stopper.

1.  Although both yenta and i82365 are compiled in, my 16-bit NE2000 clone
isn't recognized.  If I boot kernel 2.4.19 I can use the network, if I
boot kernel 2.6.0 I can't find any way to use the network.  Partial output
of various commands and files are shown below.

2.  When I attach a USB hard disk drive, 2.6.0 drivers log the following:
[...] no runnable /etc/hotplug/scsi_device.agent is installed
2.4.19 didn't have this problem.  2.4.19 automatically updated /etc/fstab.

3.  For 2.6.0-test1, a few people kindly explained and provided a patch
to make the keyboard work with a plain text console, to get a pipe symbol
when not running under X.  How come 2.6.0-test3 still doesn't incorporate
that patch?

4.  A hotkey on the keyboard, Fn+F10, is interpreted by the BIOS to do a
suspend-to-RAM.  In an OS without APM support, the BIOS does it directly.
In Windows 98, it does what Microsoft calls Standby but is really suspend-
to-RAM.  In Windows 2000, a vendor-supplied driver makes it do the same.
In Linux 2.4.19, it did what Intel calls Standby, what the apm command
calls "apm -S", which still drains the battery quickly.  I patched 2.4.19
to make it do a suspend-to-RAM, what the apm command calls "apm -s".
But in 2.6.0 the hotkey is ignored.  The kapmd driver recognizes things
like the battery level but never gets notified of standby requests.
(No I didn't configure the kernel to ignore them.)  "apm -s" still works.

5.  Modules seem to work except for module symbols.  This seems to be a
result of compiling the new modules packages manually at a time when I
could not persuade the rpm --rebuild command to target the correct cpu.
Later I persuaded rpm --rebuild to work.  modprobe and lsmod and rmmod
work, only kernel symbols think that modules are disabled.

6.  It is still necessary to omit vga=788 from the kernel command line.
In kernel 2.4.19 this worked fine, but in 2.6.0 it blanks the screen.

7.  The UDF driver makes some very strange observations about a CD drive
and CD media at boot time when no CD device even exists.  I have used a
USB DVD+RW drive under 2.4.19 but have not even tried connecting it under
2.6.0 yet.  (I also have a PCMCIA CD-ROM drive for which 2.6.0 finally
copied necessary code from the external PCMCIA package, but haven't tried
connecting it under 2.6.0 yet.)

8.  As always, the OPL3/SA-whatever chip driver doesn't work.  In some
previous versions I could make it buzz if I tried hard enough, but never
music, and usually only silence.  Now it's silence.  I'd better delete
the driver from my .config in order to hear the PCMCIA driver's tones
in case PCMCIA starts working.


(lspci)

00:0a.0 CardBus bridge: Texas Instruments PCI1250 (rev 02)
        Flags: bus master, medium devsel, latency 168, IRQ 10
        Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00001800-000018ff
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1250 (rev 02)
        Flags: bus master, medium devsel, latency 168, IRQ 10
        Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00001c00-00001cff
        I/O window 1: 00002000-000020ff
        16-bit legacy interface ports at 0001


(cardctl status)

Socket 0:
  5V 16-bit PC Card
  function 0: [ready], [wp]
Socket 1:
  no card


(cardctl ident)

Socket 0:
  no product info available
Socket 1:
  no product info available


(lsmod)
(This is after doing modprobe pcnet_cs manually;
8390 and crc32 were loaded by that, but
videodev, evdev, and ntfs were already
loaded automatically.)

Module                  Size  Used by
pcnet_cs               16644  0
8390                    8960  1 pcnet_cs
crc32                   4224  1 8390
videodev                7936  0
evdev                   8192  0
ntfs                   82708  1


(.config)

CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=y
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
CONFIG_I82365=y
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m


(/var/log/messages)

Aug 14 22:07:55 diamondpana syslogd 1.4.1: restart.
Aug 14 22:07:56 diamondpana /etc/hotplug/usb.rc[472]: FATAL: Module joydev not found.
Aug 14 22:08:00 diamondpana kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 14 22:08:00 diamondpana kernel: Inspecting /boot/System.map-2.6.0-test3
Aug 14 22:08:01 diamondpana kernel: Loaded 26800 symbols from /boot/System.map-2.6.0-test3.
Aug 14 22:08:01 diamondpana kernel: Symbols match kernel version 2.6.0.
Aug 14 22:08:01 diamondpana kernel: No module symbols loaded - kernel modules not enabled.
Aug 14 22:08:04 diamondpana SuSEfirewall2: Firewall rules successfully set in QUICKMODE for device(s) " ppp+"
Aug 14 22:08:06 diamondpana modprobe: FATAL: Module ipv6 not found.
Aug 14 22:08:06 diamondpana sshd[669]: Server listening on 0.0.0.0 port 22.
Aug 14 22:08:17 diamondpana SuSEfirewall2: Firewall rules successfully set in QUICKMODE for device(s) " ppp+"
Aug 14 22:08:19 diamondpana smpppd[835]: smpppd version 0.78 started
Aug 14 22:08:31 diamondpana /usr/sbin/cron[1065]: (CRON) STARTUP (fork ok)
Aug 14 22:08:38 diamondpana modprobe: FATAL: Module sr_mod not found.
Aug 14 22:08:47 diamondpana kernel: Linux video capture interface: v1.00
Aug 14 22:09:07 diamondpana kdm[1154]: pam_unix2: session started for user ndiamond, service xdm
Aug 14 22:10:00 diamondpana /USR/SBIN/CRON[1260]: (root) CMD ( /usr/lib/sa/sa1      )
Aug 14 22:10:52 diamondpana su: (to root) ndiamond on /dev/pts/1
Aug 14 22:10:52 diamondpana su: pam_unix2: session started for user root, service su
Aug 14 22:20:00 diamondpana /USR/SBIN/CRON[1493]: (root) CMD ( /usr/lib/sa/sa1      )
Aug 14 22:21:37 diamondpana kernel: cs: warning: no high memory space available!
Aug 14 22:21:37 diamondpana kernel: cs: unable to map card memory!
Aug 14 22:21:37 diamondpana last message repeated 3 times
Aug 14 22:22:49 diamondpana last message repeated 7 times
Aug 14 22:23:35 diamondpana last message repeated 3 times
Aug 14 22:24:40 diamondpana last message repeated 3 times
Aug 14 22:29:07 diamondpana kernel: cs: unable to map card memory!


(dmesg)

Linux version 2.6.0-test3 (ndiamond@diamondpana) (gcc version 3.2) #1 Thu Aug 14 21:00:20 JST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005ff0000 (usable)
 BIOS-e820: 0000000005ff0000 - 0000000006000000 (ACPI data)
 BIOS-e820: 0000000010000000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
95MB LOWMEM available.
On node 0 totalpages: 24560
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 20464 pages, LIFO batch:4
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: acpi=off apm=on root=/dev/hda8
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 198.983 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 392.19 BogoMIPS
Memory: 92704k/98240k available (2549k kernel code, 5036k reserved, 1130k data, 172k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 008001bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: 008001bf 00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After all inits, caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd74c, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 180 entries (12 bytes)
biovec pool[1]:   4 bvecs: 180 entries (48 bytes)
biovec pool[2]:  16 bvecs: 180 entries (192 bytes)
biovec pool[3]:  64 bvecs:  90 entries (768 bytes)
biovec pool[4]: 128 bvecs:  45 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  22 entries (3072 bytes)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fdf90
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x58ed, dseg 0xf0000
PnPBIOS: 23 nodes reported by PnP BIOS; 23 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:01.0
PCI: IRQ 0 for device 0000:00:01.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:02.0
neofb: mapped io at c6800000
Autodetected internal display
Panel is a 800x600 color TFT display
neofb: mapped framebuffer at c6a01000
neofb v0.4.1: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
fb0: MagicGraph 128XD frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:01.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
hda: TOSHIBA MK4018GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 >
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 0000:00:0a.0
Yenta: CardBus bridge found at 0000:00:0a.0 [0000:0000]
Yenta IRQ list 0ab8, PCI irq10
Socket status: 30000010
PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 0000:00:0a.1
Yenta: CardBus bridge found at 0000:00:0a.1 [0000:0000]
Yenta IRQ list 0ab8, PCI irq10
Socket status: 30000006
Intel PCIC probe: not found.
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Enabling device 0000:00:01.2 (0000 -> 0001)
PCI: IRQ 0 for device 0000:00:01.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 0000:00:01.2
uhci-hcd 0000:00:01.2: UHCI Host Controller
uhci-hcd 0000:00:01.2: irq 10, io base 00001000
uhci-hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch block 256, tag 1413234186 != 256
UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
reiserfs: checking transaction log (hda8) for (hda8)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
Adding 1092380k swap on /dev/hda7.  Priority:42 extents:1
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.1.
Linux video capture interface: v1.00

