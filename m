Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUBVRoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUBVRoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:44:18 -0500
Received: from mxsf29.cluster1.charter.net ([209.225.28.229]:3336 "EHLO
	mxsf29.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261714AbUBVRlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:41:52 -0500
Subject: 2.6.3 kernel, USB and suspend/resume
From: Bill Peck <bill@pecknet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077471586.8116.53.camel@bilbo.home.pecknet.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 22 Feb 2004 12:39:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I am trying to get a suspend/resume to work on a Via C3 (Epia M10000). 
The system suspends and comes back up after resuming.. But USB is not
too happy.  I'm seeing the "Unlink after no-IRQ?" error in
/var/log/messages after resuming.  I had been removing the uhci-hcd, and
ehci-hcd modules before suspend and loading them after resume.  

I guess I'm looking for any suggestions on different ideas to try..  or
someone to say "Forget it for now.. its broken".  I've been trying
2.6.3, 2.6.3-bk[34], 2.6.3-mm[12] wouldn't compile for me.  

as an aside note the via-rhine ethernet driver doesn't come back after
resume either.  and it shares an irq with the USB system.  I tried
disabling the ethernet to see if that would make the USB system work..
but alas, no luck.  I have also been having trouble seeing my usb audio
device when the system first boots up with the 2.6.3-bk3 series..  I
have to unplug and replug the device in for it to see it.  I didn't have
to do this with 2.6.2 or 2.6.3.

Here is /var/log/messages
Feb 22 10:36:16 minibox syslog: syslogd startup succeeded
Feb 22 10:36:16 minibox syslog: klogd startup succeeded
Feb 22 10:36:16 minibox kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Feb 22 10:36:16 minibox kernel: Linux version 2.6.3-bk3
(root@minibox.home.pecknet.com) (gcc version 3.3.3 20040216 (Red Hat
Linux 3.3.3-2)) #4 Sun Feb 22 00:48:27 EST 2004
Feb 22 10:36:16 minibox kernel: BIOS-provided physical RAM map:
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 0000000000100000 -
000000000dff0000 (usable)
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 000000000dff0000 -
000000000dff3000 (ACPI NVS)
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 000000000dff3000 -
000000000e000000 (ACPI data)
Feb 22 10:36:16 minibox kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Feb 22 10:36:16 minibox kernel: 0MB HIGHMEM available.
Feb 22 10:36:16 minibox kernel: 223MB LOWMEM available.
Feb 22 10:36:16 minibox kernel: On node 0 totalpages: 57328
Feb 22 10:36:16 minibox kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 22 10:36:16 minibox kernel:   Normal zone: 53232 pages, LIFO
batch:12
Feb 22 10:36:16 minibox kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 22 10:36:16 minibox kernel: DMI 2.2 present.
Feb 22 10:36:16 minibox kernel: ACPI: RSDP (v000
VT9174                                    ) @ 0x000f6560
Feb 22 10:36:16 minibox kernel: ACPI: RSDT (v001 VT9174 AWRDACPI
0x42302e31 AWRD 0x00000000) @ 0x0dff3000
Feb 22 10:36:16 minibox irqbalance: irqbalance startup succeeded
Feb 22 10:36:16 minibox kernel: ACPI: FADT (v001 VT9174 AWRDACPI
0x42302e31 AWRD 0x00000000) @ 0x0dff3040
Feb 22 10:36:16 minibox kernel: ACPI: DSDT (v001 VT9174 AWRDACPI
0x00001000 MSFT 0x0100000c) @ 0x00000000
Feb 22 10:36:16 minibox kernel: ACPI: PM-Timer IO Port: 0x408
Feb 22 10:36:16 minibox kernel: Built 1 zonelists
Feb 22 10:36:16 minibox kernel: Kernel command line: ro root=LABEL=/
rhgb quiet 3
Feb 22 10:36:16 minibox kernel: No local APIC present or hardware
disabled
Feb 22 10:36:16 minibox kernel: Initializing CPU#0
Feb 22 10:36:16 minibox kernel: PID hash table entries: 1024 (order 10:
8192 bytes)
Feb 22 10:36:16 minibox kernel: Detected 999.807 MHz processor.
Feb 22 10:36:16 minibox kernel: Using pmtmr for high-res timesource
Feb 22 10:36:16 minibox kernel: Console: colour VGA+ 80x25
Feb 22 10:36:16 minibox kernel: Memory: 222516k/229312k available (2150k
kernel code, 6116k reserved, 757k data, 264k init, 0k highmem)
Feb 22 10:36:16 minibox kernel: Checking if this processor honours the
WP bit even in supervisor mode... Ok.
Feb 22 10:36:16 minibox kernel: Calibrating delay loop... 1982.46
BogoMIPS
Feb 22 10:36:16 minibox kernel: Security Scaffold v1.0.0 initialized
Feb 22 10:36:16 minibox kernel: Capability LSM initialized
Feb 22 10:36:16 minibox kernel: Dentry cache hash table entries: 32768
(order: 5, 131072 bytes)
Feb 22 10:36:16 minibox kernel: Inode-cache hash table entries: 16384
(order: 4, 65536 bytes)
Feb 22 10:36:16 minibox kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Feb 22 10:36:16 minibox kernel: checking if image is initramfs...it
isn't (no cpio magic); looks like an initrd
Feb 22 10:36:16 minibox kernel: Freeing initrd memory: 206k freed
Feb 22 10:36:16 minibox kernel: CPU: L1 I Cache: 64K (32 bytes/line), D
cache 64K (32 bytes/line)
Feb 22 10:36:16 minibox kernel: CPU: L2 Cache: 64K (32 bytes/line)
Feb 22 10:36:16 minibox kernel: CPU: Centaur VIA C3 Ezra stepping 09
Feb 22 10:36:16 minibox portmap: portmap startup succeeded
Feb 22 10:36:16 minibox kernel: Checking 'hlt' instruction... OK.
Feb 22 10:36:16 minibox kernel: POSIX conformance testing by UNIFIX
Feb 22 10:36:16 minibox kernel: NET: Registered protocol family 16
Feb 22 10:36:17 minibox kernel: EISA bus registered
Feb 22 10:36:17 minibox kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb260, last bus=1
Feb 22 10:36:17 minibox kernel: PCI: Using configuration type 1
Feb 22 10:36:17 minibox kernel: mtrr: v2.0 (20020519)
Feb 22 10:36:17 minibox kernel: ACPI: Subsystem revision 20040116
Feb 22 10:36:17 minibox kernel: ACPI: IRQ9 SCI: Level Trigger.
Feb 22 10:36:17 minibox kernel: ACPI: Interpreter enabled
Feb 22 10:36:17 minibox kernel: ACPI: Using PIC for interrupt routing
Feb 22 10:36:17 minibox kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 22 10:36:17 minibox kernel: PCI: Probing PCI hardware (bus 00)
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1
3 4 5 6 7 10 *11 12 14 15)
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1
3 4 5 6 7 *10 11 12 14 15)
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1
3 4 *5 6 7 10 11 12 14 15)
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1
3 4 5 6 7 10 11 *12 14 15)
Feb 22 10:36:17 minibox kernel: Linux Plug and Play Support v0.97 (c)
Adam Belay
Feb 22 10:36:17 minibox rpc.statd[1108]: Version 1.0.6 Starting
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKB] enabled
at IRQ 10
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKA] enabled
at IRQ 11
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKC] enabled
at IRQ 5
Feb 22 10:36:17 minibox kernel: ACPI: PCI Interrupt Link [LNKD] enabled
at IRQ 12
Feb 22 10:36:17 minibox kernel: PCI: Using ACPI for IRQ routing
Feb 22 10:36:17 minibox nfslock: rpc.statd startup succeeded
Feb 22 10:36:17 minibox kernel: PCI: if you experience problems, try
using option 'pci=noacpi' or even 'acpi=off'
Feb 22 10:36:17 minibox kernel: apm: BIOS version 1.2 Flags 0x07 (Driver
version 1.16ac)
Feb 22 10:36:17 minibox kernel: apm: overridden by ACPI.
Feb 22 10:36:17 minibox kernel: VFS: Disk quotas dquot_6.5.1
Feb 22 10:36:17 minibox kernel: Initializing Cryptographic API
Feb 22 10:36:17 minibox kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Feb 22 10:36:17 minibox kernel: isapnp: Scanning for PnP cards...
Feb 22 10:36:17 minibox kernel: isapnp: No Plug & Play device found
Feb 22 10:36:17 minibox kernel: pty: 256 Unix98 ptys configured
Feb 22 10:36:17 minibox random: Initializing random number generator: 
succeeded
Feb 22 10:36:17 minibox kernel: Real Time Clock Driver v1.12
Feb 22 10:36:17 minibox kernel: Linux agpgart interface v0.100 (c) Dave
Jones
Feb 22 10:36:17 minibox kernel: agpgart: Detected VIA CLE266 chipset
Feb 22 10:36:17 minibox kernel: agpgart: Maximum main memory to use for
agp memory: 176M
Feb 22 10:36:17 minibox kernel: agpgart: AGP aperture is 128M @
0xd0000000
Feb 22 10:36:17 minibox kernel: Serial: 8250/16550 driver $Revision:
1.90 $ 8 ports, IRQ sharing enabled
Feb 22 10:36:17 minibox kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 22 10:36:17 minibox kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 22 10:36:17 minibox kernel: RAMDISK driver initialized: 16 RAM disks
of 8192K size 1024 blocksize
Feb 22 10:36:17 minibox kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Feb 22 10:36:17 minibox kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Feb 22 10:36:17 minibox kernel: VP_IDE: IDE controller at PCI slot
0000:00:11.1
Feb 22 10:36:17 minibox kernel: VP_IDE: chipset revision 6
Feb 22 10:36:17 minibox kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Feb 22 10:36:17 minibox kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Feb 22 10:36:17 minibox kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
controller on pci0000:00:11.1
Feb 22 10:36:17 minibox rc: Starting pcmcia:  succeeded
Feb 22 10:36:17 minibox kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS
settings: hda:DMA, hdb:pio
Feb 22 10:36:17 minibox kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS
settings: hdc:pio, hdd:pio
Feb 22 10:36:17 minibox kernel: hda: FUJITSU MHT2060AT, ATA DISK drive
Feb 22 10:36:17 minibox kernel: Using anticipatory io scheduler
Feb 22 10:36:17 minibox kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 22 10:36:17 minibox kernel: hda: max request size: 128KiB
Feb 22 10:36:17 minibox kernel: hda: 117210240 sectors (60011 MB)
w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
Feb 22 10:36:17 minibox kernel:  hda: hda1 hda2 hda3
Feb 22 10:36:17 minibox kernel: ide-floppy driver 0.99.newide
Feb 22 10:36:17 minibox kernel: mice: PS/2 mouse device common for all
mice
Feb 22 10:36:17 minibox kernel: serio: i8042 AUX port at 0x60,0x64 irq
12
Feb 22 10:36:17 minibox kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 22 10:36:17 minibox kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
Feb 22 10:36:17 minibox kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Feb 22 10:36:17 minibox kernel: NET: Registered protocol family 2
Feb 22 10:36:17 minibox kernel: IP: routing cache hash table of 512
buckets, 16Kbytes
Feb 22 10:36:17 minibox kernel: TCP: Hash tables configured (established
8192 bind 2340)
Feb 22 10:36:17 minibox kernel: Initializing IPsec netlink socket
Feb 22 10:36:17 minibox kernel: NET: Registered protocol family 1
Feb 22 10:36:17 minibox kernel: NET: Registered protocol family 17
Feb 22 10:36:17 minibox kernel: ACPI: (supports S0 S1 S3 S4 S5)
Feb 22 10:36:17 minibox kernel: md: Autodetecting RAID arrays.
Feb 22 10:36:17 minibox kernel: md: autorun ...
Feb 22 10:36:17 minibox kernel: md: ... autorun DONE.
Feb 22 10:36:17 minibox kernel: RAMDISK: Compressed image found at block
0
Feb 22 10:36:17 minibox kernel: VFS: Mounted root (ext2 filesystem).
Feb 22 10:36:17 minibox kernel: EXT3-fs: INFO: recovery required on
readonly filesystem.
Feb 22 10:36:17 minibox kernel: EXT3-fs: write access will be enabled
during recovery.
Feb 22 10:36:17 minibox kernel: kjournald starting.  Commit interval 5
seconds
Feb 22 10:36:17 minibox netfs: Mounting other filesystems:  succeeded
Feb 22 10:36:17 minibox kernel: EXT3-fs: recovery complete.
Feb 22 10:36:17 minibox kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Feb 22 10:36:17 minibox kernel: Freeing unused kernel memory: 264k freed
Feb 22 10:36:17 minibox kernel: ACPI: Power Button (FF) [PWRF]
Feb 22 10:36:18 minibox kernel: ACPI: Processor [CPU0] (supports C1 C2,
2 throttling states)
Feb 22 10:36:18 minibox kernel: drivers/usb/core/usb.c: registered new
driver usbfs
Feb 22 10:36:18 minibox kernel: drivers/usb/core/usb.c: registered new
driver hub
Feb 22 10:36:18 minibox kernel: ehci_hcd 0000:00:10.3: EHCI Host
Controller
Feb 22 10:36:18 minibox kernel: ehci_hcd 0000:00:10.3: irq 12, pci mem
ce88c000
Feb 22 10:36:18 minibox kernel: ehci_hcd 0000:00:10.3: new USB bus
registered, assigned bus number 1
Feb 22 10:36:18 minibox kernel: ehci_hcd 0000:00:10.3: USB 2.0 enabled,
EHCI 1.00, driver 2003-Dec-29
Feb 22 10:36:18 minibox kernel: hub 1-0:1.0: USB hub found
Feb 22 10:36:18 minibox kernel: hub 1-0:1.0: 6 ports detected
Feb 22 10:36:18 minibox kernel: USB Universal Host Controller Interface
driver v2.2
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.0: UHCI Host
Controller
Feb 22 10:36:18 minibox kernel: hub 1-0:1.0: over-current change on port
5
Feb 22 10:36:18 minibox kernel: hub 1-0:1.0: over-current change on port
6
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.0: irq 11, io base
0000d400
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.0: new USB bus
registered, assigned bus number 2
Feb 22 10:36:18 minibox kernel: hub 2-0:1.0: USB hub found
Feb 22 10:36:18 minibox kernel: hub 2-0:1.0: 2 ports detected
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.1: UHCI Host
Controller
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.1: irq 10, io base
0000d800
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.1: new USB bus
registered, assigned bus number 3
Feb 22 10:36:18 minibox kernel: hub 3-0:1.0: USB hub found
Feb 22 10:36:18 minibox kernel: hub 3-0:1.0: 2 ports detected
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.2: UHCI Host
Controller
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.2: irq 5, io base
0000dc00
Feb 22 10:36:18 minibox kernel: uhci_hcd 0000:00:10.2: new USB bus
registered, assigned bus number 4
Feb 22 10:36:18 minibox kernel: hub 4-0:1.0: USB hub found
Feb 22 10:36:18 minibox kernel: hub 4-0:1.0: 2 ports detected
Feb 22 10:36:18 minibox kernel: EXT3 FS on hda2, internal journal
Feb 22 10:36:18 minibox kernel: Adding 457844k swap on /dev/hda3. 
Priority:-1 extents:1
Feb 22 10:36:18 minibox kernel: kjournald starting.  Commit interval 5
seconds
Feb 22 10:36:18 minibox kernel: EXT3 FS on hda1, internal journal
Feb 22 10:36:18 minibox kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Feb 22 10:36:18 minibox kernel: quotaon: numerical sysctl 5 16 8 is
obsolete.
Feb 22 10:36:18 minibox kernel: kudzu: numerical sysctl 1 23 is
obsolete.
Feb 22 10:36:18 minibox kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE,EPP]
Feb 22 10:36:18 minibox kernel: SCSI subsystem initialized
Feb 22 10:36:18 minibox kernel: inserting floppy driver for 2.6.3-bk3
Feb 22 10:36:18 minibox kernel: floppy0: no floppy controllers found
Feb 22 10:36:18 minibox autofs: automount startup succeeded
Feb 22 10:36:18 minibox kernel: inserting floppy driver for 2.6.3-bk3
Feb 22 10:36:18 minibox kernel: floppy0: no floppy controllers found
Feb 22 10:36:18 minibox kernel: kudzu: numerical sysctl 1 49 is
obsolete.
Feb 22 10:36:18 minibox kernel: kudzu: numerical sysctl 1 49 is
obsolete.
Feb 22 10:36:18 minibox smartd[1192]: smartd version 5.21 Copyright (C)
2002-3 Bruce Allen 
Feb 22 10:36:18 minibox kernel: ip_tables: (C) 2000-2002 Netfilter core
team
Feb 22 10:36:18 minibox smartd[1192]: Home page is
http://smartmontools.sourceforge.net/  
Feb 22 10:36:18 minibox kernel: via-rhine.c:v1.10-LK1.1.19-2.5 
July-12-2003  Written by Donald Becker
Feb 22 10:36:18 minibox smartd[1192]: Opened configuration file
/etc/smartd.conf 
Feb 22 10:36:18 minibox kernel:  
http://www.scyld.com/network/via-rhine.html
Feb 22 10:36:18 minibox smartd[1192]: Configuration file
/etc/smartd.conf parsed. 
Feb 22 10:36:18 minibox smartd[1192]: Device: /dev/hda, opened 
Feb 22 10:36:18 minibox smartd[1192]: Device: /dev/hda, not found in
smartd database. 
Feb 22 10:36:19 minibox smartd[1192]: Device: /dev/hda, is SMART
capable. Adding to "monitor" list. 
Feb 22 10:36:19 minibox smartd[1192]: Monitoring 1 ATA and 0 SCSI
devices 
Feb 22 10:36:19 minibox smartd[1194]: smartd has fork()ed into
background mode. New PID=1194. 
Feb 22 10:36:19 minibox smartd: smartd startup succeeded
Feb 22 10:36:19 minibox acpid: acpid startup succeeded
Feb 22 10:36:22 minibox kernel: lp0: using parport0 (polling).
Feb 22 10:36:22 minibox kernel: lp0: console ready
Feb 22 10:36:28 minibox cups: cupsd startup succeeded
Feb 22 10:36:29 minibox kernel: NET: Registered protocol family 10
Feb 22 10:36:29 minibox kernel: Disabled Privacy Extensions on device
c0399860(lo)
Feb 22 10:36:29 minibox kernel: IPv6 over IPv4 tunneling driver
Feb 22 10:36:29 minibox sshd:  succeeded
Feb 22 10:36:30 minibox xinetd: xinetd startup succeeded
Feb 22 10:36:31 minibox sendmail: sendmail startup succeeded
Feb 22 10:36:31 minibox xinetd[1442]: xinetd Version 2.3.13 started with
libwrap loadavg options compiled in.
Feb 22 10:36:31 minibox xinetd[1442]: Started working: 1 available
service
Feb 22 10:36:31 minibox sendmail: sm-client startup succeeded
Feb 22 10:36:32 minibox gpm: gpm startup succeeded
Feb 22 10:36:32 minibox crond: crond startup succeeded
Feb 22 10:36:33 minibox xfs: xfs startup succeeded
Feb 22 10:36:33 minibox anacron: anacron startup succeeded
Feb 22 10:36:33 minibox atd: atd startup succeeded
Feb 22 10:36:33 minibox xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Feb 22 10:36:34 minibox messagebus: messagebus startup succeeded
Feb 22 10:51:43 minibox login(pam_unix)[1556]: authentication failure;
logname=LOGIN uid=0 euid=0 tty=tty1 ruser= rhost=  user=root
Feb 22 10:51:45 minibox login[1556]: FAILED LOGIN 1 FROM (null) FOR
root, Authentication failure
Feb 22 10:51:49 minibox login(pam_unix)[1556]: session opened for user
root by LOGIN(uid=0)
Feb 22 10:51:49 minibox  -- root[1556]: ROOT LOGIN ON tty1
Feb 22 10:53:24 minibox kernel: usb 2-1: new full speed USB device using
address 2
Feb 22 10:53:28 minibox usb.agent[1636]: ... no modules for USB product
9ef/101/100
Feb 22 10:53:28 minibox kernel: drivers/usb/core/usb.c: registered new
driver snd-usb-audio
Feb 22 10:53:28 minibox kernel: drivers/usb/core/usb.c: registered new
driver hiddev
Feb 22 10:53:28 minibox modprobe: FATAL: Module keybdev not found. 
Feb 22 10:53:28 minibox modprobe: FATAL: Module mousedev not found. 
Feb 22 10:53:29 minibox kernel: input: USB HID v1.00 Device [XITEL
HiFi-Link] on usb-0000:00:10.0-1
Feb 22 10:53:29 minibox kernel: drivers/usb/core/usb.c: registered new
driver hid
Feb 22 10:53:29 minibox kernel: drivers/usb/input/hid-core.c: v2.0:USB
HID core driver
Feb 22 10:53:29 minibox kernel: drivers/usb/core/usb.c: registered new
driver audio
Feb 22 10:53:29 minibox kernel: drivers/usb/class/audio.c: v1.0.0:USB
Audio Class driver
Feb 22 10:53:29 minibox input.agent[1721]: ... no modules for INPUT
product 3/9ef/101/100
Feb 22 10:54:10 minibox kernel: uhci_hcd 0000:00:10.0: remove, state 1
Feb 22 10:54:10 minibox kernel: usb usb2: USB disconnect, address 1
Feb 22 10:54:10 minibox kernel: usb 2-1: USB disconnect, address 2
Feb 22 10:54:10 minibox kernel: updfstab: numerical sysctl 1 23 is
obsolete.
Feb 22 10:54:11 minibox last message repeated 3 times
Feb 22 10:54:12 minibox kernel: uhci_hcd 0000:00:10.0: USB bus 2
deregistered
Feb 22 10:54:12 minibox kernel: uhci_hcd 0000:00:10.1: remove, state 1
Feb 22 10:54:12 minibox kernel: usb usb3: USB disconnect, address 1
Feb 22 10:54:12 minibox kernel: updfstab: numerical sysctl 1 23 is
obsolete.
Feb 22 10:54:12 minibox kernel: uhci_hcd 0000:00:10.1: USB bus 3
deregistered
Feb 22 10:54:12 minibox kernel: uhci_hcd 0000:00:10.2: remove, state 1
Feb 22 10:54:12 minibox kernel: usb usb4: USB disconnect, address 1
Feb 22 10:54:12 minibox kernel: updfstab: numerical sysctl 1 23 is
obsolete.
Feb 22 10:54:12 minibox kernel: uhci_hcd 0000:00:10.2: USB bus 4
deregistered
Feb 22 10:54:13 minibox kernel: inserting floppy driver for 2.6.3-bk3
Feb 22 10:54:13 minibox kernel: ehci_hcd 0000:00:10.3: remove, state 1
Feb 22 10:54:13 minibox kernel: usb usb1: USB disconnect, address 1
Feb 22 10:54:13 minibox kernel: ehci_hcd 0000:00:10.3: USB bus 1
deregistered
Feb 22 10:54:13 minibox kernel: updfstab: numerical sysctl 1 23 is
obsolete.
Feb 22 10:54:16 minibox kernel: floppy0: no floppy controllers found
Feb 22 10:54:16 minibox kernel: inserting floppy driver for 2.6.3-bk3
Feb 22 10:54:19 minibox kernel: floppy0: no floppy controllers found
Feb 22 10:54:42 minibox kernel: Stopping tasks:
==============================|
Feb 22 10:54:42 minibox kernel: hda: start_power_step(step: 0)
Feb 22 10:54:42 minibox kernel: hda: start_power_step(step: 1)
Feb 22 10:54:42 minibox kernel: hda: complete_power_step(step: 1, stat:
50, err: 0)
Feb 22 10:54:42 minibox kernel: hda: completing PM request, suspend
Feb 22 10:54:42 minibox kernel: hda: Wakeup request inited, waiting for
!BSY...
Feb 22 10:54:42 minibox kernel: hda: start_power_step(step: 1000)
Feb 22 10:54:42 minibox kernel: blk: queue c1375540, I/O limit 4095Mb
(mask 0xffffffff)
Feb 22 10:54:42 minibox kernel: hda: completing PM request, resume
Feb 22 10:54:42 minibox kernel: Restarting tasks... done
Feb 22 10:55:11 minibox kernel: ehci_hcd 0000:00:10.3: EHCI Host
Controller
Feb 22 10:55:11 minibox kernel: ehci_hcd 0000:00:10.3: irq 12, pci mem
ce88c000
Feb 22 10:55:11 minibox kernel: ehci_hcd 0000:00:10.3: new USB bus
registered, assigned bus number 1
Feb 22 10:55:11 minibox kernel: ehci_hcd 0000:00:10.3: USB 2.0 enabled,
EHCI 1.00, driver 2003-Dec-29
Feb 22 10:55:11 minibox kernel: hub 1-0:1.0: USB hub found
Feb 22 10:55:11 minibox kernel: hub 1-0:1.0: 6 ports detected
Feb 22 10:55:13 minibox kernel: hub 1-0:1.0: over-current change on port
5
Feb 22 10:55:13 minibox kernel: hub 1-0:1.0: over-current change on port
6
Feb 22 10:55:51 minibox kernel: USB Universal Host Controller Interface
driver v2.2
Feb 22 10:55:51 minibox kernel: uhci_hcd 0000:00:10.0: UHCI Host
Controller
Feb 22 10:55:51 minibox kernel: uhci_hcd 0000:00:10.0: irq 11, io base
0000d400
Feb 22 10:55:51 minibox kernel: uhci_hcd 0000:00:10.0: new USB bus
registered, assigned bus number 2
Feb 22 10:55:51 minibox kernel: hub 2-0:1.0: USB hub found
Feb 22 10:55:51 minibox kernel: hub 2-0:1.0: 2 ports detected
Feb 22 10:55:52 minibox kernel: uhci_hcd 0000:00:10.1: UHCI Host
Controller
Feb 22 10:55:52 minibox kernel: uhci_hcd 0000:00:10.1: irq 10, io base
0000d800
Feb 22 10:55:52 minibox kernel: uhci_hcd 0000:00:10.1: new USB bus
registered, assigned bus number 3
Feb 22 10:55:52 minibox kernel: hub 3-0:1.0: USB hub found
Feb 22 10:55:52 minibox kernel: hub 3-0:1.0: 2 ports detected
Feb 22 10:55:53 minibox kernel: uhci_hcd 0000:00:10.2: UHCI Host
Controller
Feb 22 10:55:54 minibox kernel: usb 2-1: new full speed USB device using
address 2
Feb 22 10:55:54 minibox kernel: uhci_hcd 0000:00:10.2: irq 5, io base
0000dc00
Feb 22 10:55:54 minibox kernel: uhci_hcd 0000:00:10.2: new USB bus
registered, assigned bus number 4
Feb 22 10:55:54 minibox kernel: hub 4-0:1.0: USB hub found
Feb 22 10:55:54 minibox kernel: hub 4-0:1.0: 2 ports detected
Feb 22 10:55:59 minibox kernel: usb 2-1: control timeout on ep0out
Feb 22 10:55:59 minibox kernel: uhci_hcd 0000:00:10.0: Unlink after
no-IRQ?  Different ACPI or APIC settings may help.
Feb 22 10:58:20 minibox kernel: drivers/usb/core/usb.c: deregistering
driver snd-usb-audio
Feb 22 10:58:28 minibox shutdown: shutting down for system reboot
Feb 22 10:58:28 minibox init: Switching to runlevel: 6
Feb 22 10:58:28 minibox login(pam_unix)[1556]: session closed for user
root
Feb 22 10:58:30 minibox messagebus: messagebus -TERM succeeded
Feb 22 10:58:30 minibox atd: atd shutdown succeeded
Feb 22 10:58:30 minibox cups: cupsd shutdown succeeded
Feb 22 10:58:30 minibox xfs[1515]: terminating 
Feb 22 10:58:30 minibox xfs: xfs shutdown succeeded
Feb 22 10:58:30 minibox gpm: gpm shutdown succeeded
Feb 22 10:58:31 minibox sshd: sshd -TERM succeeded
Feb 22 10:58:31 minibox sendmail: sendmail shutdown succeeded
Feb 22 10:58:31 minibox sendmail: sm-client shutdown succeeded
Feb 22 10:58:31 minibox smartd[1194]: smartd received signal 15:
Terminated 
Feb 22 10:58:31 minibox smartd[1194]: smartd is exiting (exit status 0) 
Feb 22 10:58:31 minibox smartd: smartd shutdown succeeded
Feb 22 10:58:31 minibox xinetd[1442]: Exiting...
Feb 22 10:58:31 minibox xinetd: xinetd shutdown succeeded
Feb 22 10:58:32 minibox acpid: acpid shutdown succeeded
Feb 22 10:58:32 minibox crond: crond shutdown succeeded
Feb 22 10:58:32 minibox dd: 1+0 records in
Feb 22 10:58:32 minibox dd: 1+0 records out
Feb 22 10:58:32 minibox random: Saving random seed:  succeeded
Feb 22 10:58:32 minibox rpc.statd[1108]: Caught signal 15,
un-registering and exiting.
Feb 22 10:58:32 minibox nfslock: rpc.statd shutdown succeeded
Feb 22 10:58:32 minibox portmap: portmap shutdown succeeded
Feb 22 10:58:33 minibox kernel: Kernel logging (proc) stopped.
Feb 22 10:58:33 minibox kernel: Kernel log daemon terminating.
Feb 22 10:58:34 minibox exiting on signal 15

           CPU0
  0:    6197932          XT-PIC  timer
  1:       1673          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  uhci_hcd
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          0          XT-PIC  uhci_hcd
 11:       3915          XT-PIC  uhci_hcd, eth0
 12:          0          XT-PIC  ehci_hcd
 14:      56434          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

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
02f8-02ff : serial
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d000-d07f : 0000:00:0d.0
d400-d41f : 0000:00:10.0
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.1
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.2
  dc00-dc1f : uhci_hcd
e000-e00f : 0000:00:11.1
  e000-e007 : ide0
  e008-e00f : ide1
e400-e4ff : 0000:00:12.0
  e400-e4ff : via-rhine

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266
AGP]
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623
[Apollo CLE266] integrated CastleRock graphics (rev 03)


-- 
Bill Peck <bill@pecknet.com>

