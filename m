Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275270AbTHASjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275275AbTHASjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:39:35 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:48262 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S275270AbTHAShh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:37:37 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: APM problems with ASUS P4PE?
Date: Fri, 1 Aug 2003 14:48:56 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGKEOECDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

(Please cc me!) I may be experiencing some problems with APM on an ASUS P4PE
(Intel 82845PE MCH and Intel 82801DB ICH4 chipsets).  I am using kernel
2.4.20-8 (Red Hat 9.0).  We were having trouble with our system "hanging"
after running for a while.    By this I mean, that no IRQs are getting
through, but software components are still running.  We have a proprietary
PCI DMA bus master device that works fine in PIII system, but the plans are
to ship our product using this ASUS MoBo.  In the process of trying to debug
this problem, we have updated BIOS, tweaked BIOS parameters, added debug to
the kernel to determine the status of our IRQ, etc.  When I changed the
CONFIG_APM_CPU_IDLE to no, our 3 hour test runs to completion.  Previously
this test would cause the system to hang within minutes.  I have tried
various combinations of APM tweaking with the following results:

   TEST:												RESULTS:
1) Power Management enabled in BIOS								Ran to completion (~ 3hours)
   Kernel configured with CONFIG_APM_CPU_IDLE not set

2) Power Management disabled in BIOS							locked up after a few minutes
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y

3) Power Management disabled in BIOS							Ran to completion
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS not set

4) Power Management disabled in BIOS							Ran to completion
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
   Kernel parameter passed in: amp=off

5) Power Management disabled in BIOS							locked up after a few minutes
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
   Kernel parameter passed in: amp=allow_ints

I suspected that when the linux APM driver makes an idle call to BIOS,
control never returns; therefore, interrupts never get re-enabled and our
system appears to freeze.  However, even though test #5 should have allowed
interrupts to stay on, we still had the described lockup.  The results of
test #2 raises another question:  If the kernel is configured with APM
enabled, but it is disabled in the BIOS, is the O/S able to enable it in the
BIOS anyway?

I noticed that this version of linux does not have this particular ASUS MoBo
in it's APM blacklist.  Has anyone seen similar symptoms with other
motherboards?

I would be happy to provide any additional testing needed to determine if
this is a true APM/motherboard interaction related problem.

Additional system information follows.

Thanks in advance!  Please cc me in your response.

Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com

Results of /var/log/messages:

Jul 22 04:11:45 rti10 syslogd 1.4.1: restart.
Jul 22 03:02:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:04:25 rti10 kernel: hda: dma_intr: status=0x50 { DriveReady
SeekComplete }
Jul 22 03:16:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:16:25 rti10 kernel:
Jul 22 03:21:05 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:23:05 rti10 kernel: hdc: lost interrupt
Jul 22 03:27:45 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 03:29:45 rti10 kernel: hdc: lost interrupt
Jul 22 03:34:25 rti10 cups: cupsd startup succeeded
Jul 22 08:22:27 rti10 syslogd 1.4.1: restart.
Jul 22 08:22:27 rti10 syslog: syslogd startup succeeded
Jul 22 08:22:27 rti10 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 22 08:22:27 rti10 kernel: Linux version 2.4.20-8
(bhcompile@porky.devel.redhat.com) (gcc version 3.2.2 20030222 (Red Hat
Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
Jul 22 08:22:27 rti10 kernel: BIOS-provided physical RAM map:
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 0000000000100000 -
000000001ffec000 (usable)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffec000 -
000000001ffef000 (ACPI data)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffef000 -
000000001ffff000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 000000001ffff000 -
0000000020000000 (ACPI NVS)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jul 22 08:22:27 rti10 kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
Jul 22 08:22:27 rti10 kernel: 0MB HIGHMEM available.
Jul 22 08:22:27 rti10 kernel: 511MB LOWMEM available.
Jul 22 08:22:27 rti10 kernel: On node 0 totalpages: 131052
Jul 22 08:22:27 rti10 kernel: zone(0): 4096 pages.
Jul 22 08:22:27 rti10 kernel: zone(1): 126956 pages.
Jul 22 08:22:27 rti10 kernel: zone(2): 0 pages.
Jul 22 08:22:27 rti10 kernel: Kernel command line: ro root=LABEL=/
Jul 22 08:22:27 rti10 kernel: Initializing CPU#0
Jul 22 08:22:27 rti10 kernel: Detected 2405.482 MHz processor.
Jul 22 08:22:27 rti10 kernel: Console: colour VGA+ 80x25
Jul 22 08:22:27 rti10 kernel: Calibrating delay loop... 4797.23 BogoMIPS
Jul 22 08:22:27 rti10 kernel: Memory: 511336k/524208k available (1347k
kernel code, 10308k reserved, 999k data, 132k init, 0k highmem)
Jul 22 08:22:27 rti10 kernel: Dentry cache hash table entries: 65536 (order:
7, 524288 bytes)
Jul 22 08:22:27 rti10 kernel: Inode cache hash table entries: 32768 (order:
6, 262144 bytes)
Jul 22 08:22:27 rti10 kernel: Mount cache hash table entries: 512 (order: 0,
4096 bytes)
Jul 22 08:22:27 rti10 kernel: Buffer-cache hash table entries: 32768 (order:
5, 131072 bytes)
Jul 22 08:22:27 rti10 kernel: Page-cache hash table entries: 131072 (order:
7, 524288 bytes)
Jul 22 08:22:27 rti10 syslog: klogd startup succeeded
Jul 22 08:22:27 rti10 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul 22 08:22:27 rti10 kernel: CPU: L2 cache: 512K
Jul 22 08:22:27 rti10 kernel: Intel machine check architecture supported.
Jul 22 08:22:27 rti10 kernel: Intel machine check reporting enabled on
CPU#0.
Jul 22 08:22:27 rti10 portmap: portmap startup succeeded
Jul 22 08:22:27 rti10 kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping 07
Jul 22 08:22:28 rti10 kernel: Enabling fast FPU save and restore... done.
Jul 22 08:22:28 rti10 nfslock: rpc.statd startup succeeded
Jul 22 08:22:28 rti10 kernel: Enabling unmasked SIMD FPU exception
support... done.
Jul 22 08:22:28 rti10 rpc.statd[3174]: Version 1.0.1 Starting
Jul 22 08:22:28 rti10 kernel: Checking 'hlt' instruction... OK.
Jul 22 08:22:28 rti10 keytable:
Jul 22 08:22:28 rti10 kernel: POSIX conformance testing by UNIFIX
Jul 22 08:22:28 rti10 keytable: Loading system font:
Jul 22 08:22:28 rti10 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Jul 22 08:22:28 rti10 kernel: mtrr: detected mtrr type: Intel
Jul 22 08:22:28 rti10 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1e50,
last bus=2
Jul 22 08:22:28 rti10 kernel: PCI: Using configuration type 1
Jul 22 08:22:28 rti10 kernel: PCI: Probing PCI hardware
Jul 22 08:22:28 rti10 kernel: PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Jul 22 08:22:28 rti10 kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB
PCI Bridge
Jul 22 08:22:28 rti10 kernel: PCI: Using IRQ router PIIX [8086/24c0] at
00:1f.0
Jul 22 08:22:28 rti10 kernel: isapnp: Scanning for PnP cards...
Jul 22 08:22:28 rti10 kernel: isapnp: No Plug & Play device found
Jul 22 08:22:28 rti10 kernel: Linux NET4.0 for Linux 2.4
Jul 22 08:22:28 rti10 kernel: Based upon Swansea University Computer Society
NET3.039
Jul 22 08:22:28 rti10 kernel: Initializing RT netlink socket
Jul 22 08:22:28 rti10 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16)
Jul 22 08:22:28 rti10 kernel: Starting kswapd
Jul 22 08:22:28 rti10 kernel: VFS: Disk quotas vdquot_6.5.1
Jul 22 08:22:28 rti10 kernel: pty: 2048 Unix98 ptys configured
Jul 22 08:22:28 rti10 kernel: Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 22 08:22:28 rti10 kernel: ttyS0 at 0x03f8 (irq = 4) is a 16550A
Jul 22 08:22:28 rti10 kernel: ttyS1 at 0x02f8 (irq = 3) is a 16550A
Jul 22 08:22:28 rti10 keytable:
Jul 22 08:22:28 rti10 kernel: Real Time Clock Driver v1.10e
Jul 22 08:22:28 rti10 rc: Starting keytable:  succeeded
Jul 22 08:22:28 rti10 kernel: Floppy drive(s): fd0 is 1.44M
Jul 22 08:22:28 rti10 kernel: FDC 0 is a post-1991 82077
Jul 22 08:22:28 rti10 kernel: NET4: Frame Diverter 0.46
Jul 22 08:22:28 rti10 kernel: RAMDISK driver initialized: 16 RAM disks of
4096K size 1024 blocksize
Jul 22 08:22:28 rti10 kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00beta-2.4
Jul 22 08:22:28 rti10 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jul 22 08:22:28 rti10 kernel: ICH4: IDE controller at PCI slot 00:1f.1
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 11 for device 00:1f.1
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 11 with 00:1d.2
Jul 22 08:22:28 rti10 kernel: ICH4: chipset revision 2
Jul 22 08:22:28 rti10 kernel: ICH4: not 100%% native mode: will probe irqs
later
Jul 22 08:22:28 rti10 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Jul 22 08:22:28 rti10 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Jul 22 08:22:28 rti10 kernel: hda: ST340016A, ATA DISK drive
Jul 22 08:22:28 rti10 kernel: blk: queue c03c9f40, I/O limit 4095Mb (mask
0xffffffff)
Jul 22 08:22:28 rti10 kernel: hdc: FX54++W, ATAPI CD/DVD-ROM drive
Jul 22 08:22:28 rti10 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 22 08:22:28 rti10 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 22 08:22:28 rti10 kernel: hda: host protected area => 1
Jul 22 08:22:28 rti10 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB
Cache, CHS=4865/255/63, UDMA(100)
Jul 22 08:22:28 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:28 rti10 kernel: Partition check:
Jul 22 08:22:28 rti10 kernel:  hda: hda1 hda2 hda3
Jul 22 08:22:28 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:28 rti10 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Jul 22 08:22:28 rti10 kernel: md: Autodetecting RAID arrays.
Jul 22 08:22:28 rti10 random: Initializing random number generator:
succeeded
Jul 22 08:22:28 rti10 kernel: md: autorun ...
Jul 22 08:22:28 rti10 kernel: md: ... autorun DONE.
Jul 22 08:22:28 rti10 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 22 08:22:28 rti10 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jul 22 08:22:28 rti10 kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Jul 22 08:22:28 rti10 kernel: TCP: Hash tables configured (established 32768
bind 65536)
Jul 22 08:22:28 rti10 kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 22 08:22:28 rti10 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jul 22 08:22:28 rti10 kernel: RAMDISK: Compressed image found at block 0
Jul 22 08:22:28 rti10 kernel: Freeing initrd memory: 146k freed
Jul 22 08:22:28 rti10 kernel: VFS: Mounted root (ext2 filesystem).
Jul 22 08:22:28 rti10 kernel: Journalled Block Device driver loaded
Jul 22 08:22:28 rti10 kernel: EXT3-fs: INFO: recovery required on readonly
filesystem.
Jul 22 08:22:28 rti10 kernel: EXT3-fs: write access will be enabled during
recovery.
Jul 22 08:22:28 rti10 kernel: kjournald starting.  Commit interval 5 seconds
Jul 22 08:22:28 rti10 kernel: EXT3-fs: ide0(3,2): orphan cleanup on readonly
fs
Jul 22 08:22:28 rti10 rc: Starting pcmcia:  succeeded
Jul 22 08:22:28 rti10 netfs: Mounting other filesystems:  succeeded
Jul 22 08:22:28 rti10 kernel: EXT3-fs: ide0(3,2): 4 orphan inodes deleted
Jul 22 08:22:28 rti10 aksparlnx: Loading Aladdin HASP/Hardlock driver:
Jul 22 08:22:28 rti10 kernel: EXT3-fs: recovery complete.
Jul 22 08:22:28 rti10 kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jul 22 08:22:28 rti10 kernel: Freeing unused kernel memory: 132k freed
Jul 22 08:22:28 rti10 kernel: usb.c: registered new driver usbdevfs
Jul 22 08:22:28 rti10 kernel: usb.c: registered new driver hub
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: $Revision: 1.275 $ time 17:59:01
Mar 13 2003
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: High bandwidth mode enabled
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 5 for device 00:1d.0
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 5 with 01:00.0
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 5
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 1
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 5 for device 00:1d.1
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 5
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 2
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 11 for device 00:1d.2
Jul 22 08:22:28 rti10 kernel: PCI: Sharing IRQ 11 with 00:1f.1
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 11
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: Detected 2 ports
Jul 22 08:22:28 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 3
Jul 22 08:22:28 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:28 rti10 kernel: hub.c: 2 ports detected
Jul 22 08:22:28 rti10 kernel: usb-uhci.c: v1.275:USB Universal Host
Controller Interface driver
Jul 22 08:22:28 rti10 kernel: PCI: Found IRQ 9 for device 00:1d.7
Jul 22 08:22:28 rti10 kernel: ehci-hcd 00:1d.7: Intel Corp. 82801DB USB EHCI
Controller
Jul 22 08:22:28 rti10 kernel: ehci-hcd 00:1d.7: irq 9, pci mem e0851000
Jul 22 08:22:29 rti10 kernel: usb.c: new USB bus registered, assigned bus
number 4
Jul 22 08:22:29 rti10 kernel: ehci-hcd 00:1d.7: enabled 64bit PCI DMA
Jul 22 08:22:29 rti10 kernel: PCI: 00:1d.7 PCI cache line size set
incorrectly (0 bytes) by BIOS/FW.
Jul 22 08:22:29 rti10 kernel: PCI: 00:1d.7 PCI cache line size corrected to
128.
Jul 22 08:22:29 rti10 kernel: ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00,
driver 2003-Jan-22
Jul 22 08:22:29 rti10 kernel: hub.c: USB hub found
Jul 22 08:22:29 rti10 kernel: hub.c: 6 ports detected
Jul 22 08:22:29 rti10 kernel: usb.c: registered new driver hiddev
Jul 22 08:22:29 rti10 kernel: usb.c: registered new driver hid
Jul 22 08:22:29 rti10 kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik
<vojtech@suse.cz>
Jul 22 08:22:29 rti10 kernel: hid-core.c: USB HID support drivers
Jul 22 08:22:29 rti10 kernel: mice: PS/2 mouse device common for all mice
Jul 22 08:22:29 rti10 kernel: hub.c: connect-debounce failed, port 2
disabled
Jul 22 08:22:29 rti10 kernel: hub.c: new USB device 00:1d.2-2, assigned
address 2
Jul 22 08:22:29 rti10 kernel: usb.c: USB device 2 (vend/prod 0x529/0x1) is
not claimed by any active driver.
Jul 22 08:22:29 rti10 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,2), internal journal
Jul 22 08:22:29 rti10 kernel: Adding Swap: 1044216k swap-space (priority -1)
Jul 22 08:22:29 rti10 aksparlnx: Warning: kernel-module version mismatch
Jul 22 08:22:29 rti10 kernel: kjournald starting.  Commit interval 5 seconds
Jul 22 08:22:29 rti10 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
ide0(3,1), internal journal
Jul 22 08:22:29 rti10 aksparlnx: ^I/opt/aksparlnx/drv/2.4.19/aksparlnx.o was
compiled for kernel version 2.4.19
Jul 22 08:22:29 rti10 kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jul 22 08:22:29 rti10 aksparlnx: ^Iwhile this kernel is version 2.4.20-8
Jul 22 08:22:29 rti10 kernel: ohci1394: $Rev: 693 $ Ben Collins
<bcollins@debian.org>
Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: non-GPL
license - Copyright 1999-2002 Aladdin Knowledge Systems.
Jul 22 08:22:29 rti10 kernel: PCI: Found IRQ 11 for device 02:03.0
Jul 22 08:22:29 rti10 aksparlnx:   See
http://www.tux.org/lkml/#export-tainted for information about tainted
modules
Jul 22 08:22:29 rti10 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]
MMIO=[f2000000-f20007ff]  Max Packet=[2048]
Jul 22 08:22:29 rti10 aksparlnx: Warning: loading
/opt/aksparlnx/drv/2.4.19/aksparlnx.o will taint the kernel: forced load
Jul 22 08:22:29 rti10 kernel: ieee1394: SelfID completion called outside of
bus reset!
Jul 22 08:22:29 rti10 aksparlnx: Module aksparlnx loaded, with warnings
Jul 22 08:22:29 rti10 kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE,EPP]
Jul 22 08:22:29 rti10 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 22 08:22:29 rti10 kernel: Broadcom 4401 Ethernet Driver bcm4400 ver.
1.0.1 (08/26/02)
Jul 22 08:22:29 rti10 kernel: PCI: Found IRQ 11 for device 02:05.0
Jul 22 08:22:29 rti10 aksparlnx:
Jul 22 08:22:29 rti10 kernel: eth0: Broadcom BCM4401 100Base-T found at mem
f1800000, IRQ 11, node addr 00e018ff35ec
Jul 22 08:22:29 rti10 rc: Starting aksparlnx:  succeeded
Jul 22 08:22:29 rti10 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 22 08:22:29 rti10 kernel: parport0: PC-style at 0x378
[PCSPP,TRISTATE,EPP]
Jul 22 08:22:29 rti10 kernel: aksparlnx: EYE/HASP driver v1.05/API
v3.81/major 60 loaded (ppi)
Jul 22 08:22:29 rti10 apmd[3251]: Version 3.0.2 (APM BIOS 1.2, Linux driver
1.16)
Jul 22 08:22:29 rti10 apmd: apmd startup succeeded
Jul 22 08:22:29 rti10 aksusbd[3263]: loaded, daemon version: 1.5, key API
(USB) version: 3.81, key API (parallel) version: 3.81
Jul 22 08:22:29 rti10 aksusbd: aksusbd startup succeeded
Jul 22 08:22:29 rti10 automount[3315]: starting automounter version 3.1.7,
path = /home, maptype = file, mapname = /etc/auto.home
Jul 22 08:22:29 rti10 autofs: automount startup succeeded
Jul 22 08:22:29 rti10 kernel: bcm4400: eth0 NIC Link is Up, 100 Mbps full
duplex
Jul 22 08:22:29 rti10 automount[3315]: using kernel protocol version 3
Jul 22 08:22:25 rti10 network: Setting network parameters:  succeeded
Jul 22 08:22:25 rti10 network: Bringing up loopback interface:  succeeded
Jul 22 08:22:29 rti10 sshd:  succeeded
Jul 22 08:22:30 rti10 apmd[3251]: Charge: * * * (-1% unknown)
Jul 22 08:22:31 rti10 xinetd[3343]: xinetd Version 2.3.10 started with
libwrap options compiled in.
Jul 22 08:22:31 rti10 xinetd[3343]: Started working: 2 available services
Jul 22 08:22:31 rti10 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jul 22 08:22:33 rti10 xinetd: xinetd startup succeeded
Jul 22 08:22:33 rti10 exportfs[3352]: No 'sync' or 'async' option specified
for export "*:/export/home".   Assuming default behaviour ('sync').   NOTE:
this default has changed from previous versions
Jul 22 08:22:33 rti10 exportfs: exportfs: No 'sync' or 'async' option
specified for export "*:/export/home".
Jul 22 08:22:33 rti10 exportfs:   Assuming default behaviour ('sync').
Jul 22 08:22:33 rti10 exportfs:   NOTE: this default has changed from
previous versions
Jul 22 08:22:33 rti10 kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Jul 22 08:22:33 rti10 nfs: Starting NFS services:  succeeded
Jul 22 08:22:33 rti10 nfs: rpc.rquotad startup succeeded
Jul 22 08:22:33 rti10 nfs: rpc.nfsd startup succeeded
Jul 22 08:22:33 rti10 nfs: rpc.mountd startup succeeded
Jul 22 08:22:33 rti10 vsftpd: true startup succeeded
Jul 22 08:22:33 rti10 amd[3396]: switched to logfile "syslog"
Jul 22 08:22:33 rti10 amd[3396]: AM-UTILS VERSION INFORMATION:
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1997-2003 Erez Zadok
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 Jan-Simon Pendry
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 Imperial College of
Science, Technology & Medicine
Jul 22 08:22:33 rti10 amd[3396]: Copyright (c) 1990 The Regents of the
University of California.
Jul 22 08:22:33 rti10 amd[3396]: am-utils version 6.0.9 (build 1).
Jul 22 08:22:33 rti10 amd[3396]: Built by root@sylvester.devel.redhat.com on
date Tue Feb  4 05:46:40 EST 2003.
Jul 22 08:22:33 rti10 amd[3396]: cpu=i386 (little-endian), arch=i386,
karch=i686.
Jul 22 08:22:33 rti10 amd[3396]: full_os=linux, os=linux,
osver=2.4.20-2.25smp, vendor=redhat.
Jul 22 08:22:33 rti10 amd[3396]: Map support for: root, passwd, hesiod,
ldap, union, nisplus, nis, ndbm, file, error.
Jul 22 08:22:33 rti10 amd[3396]: AMFS: nfs, link, nfsx, nfsl, host, linkx,
program, union, inherit, ufs,
Jul 22 08:22:33 rti10 amd[3396]:       lofs, cdfs, auto, direct, toplvl,
error.
Jul 22 08:22:33 rti10 amd: Jul 22 08:22:33 rti10 amd[3396]/info:  using
configuration file /etc/amd.conf
Jul 22 08:22:33 rti10 amd[3396]: FS: iso9660, lofs, nfs, nfs3, tmpfs, ext2.
Jul 22 08:22:33 rti10 amd[3396]: Network: wire="192.9.200.0"
(netnumber=192.9.200).
Jul 22 08:22:33 rti10 amd[3396]: My ip addr is 192.9.200.239
Jul 22 08:22:33 rti10 amd[3397]: released controlling tty using setsid()
Jul 22 08:22:33 rti10 amd[3397]: file server localhost, type local, state
starts up
Jul 22 08:22:33 rti10 amd[3397]: /dev/hda2 restarted fstype link on /
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /proc
Jul 22 08:22:33 rti10 amd[3397]: usbdevfs restarted fstype link on
/proc/bus/usb
Jul 22 08:22:33 rti10 amd[3397]: /dev/hda1 restarted fstype link on /boot
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /dev/pts
Jul 22 08:22:33 rti10 amd[3397]: none restarted fstype link on /dev/shm
Jul 22 08:22:33 rti10 amd[3397]: automount(pid3315) restarted fstype link on
/home
Jul 22 08:22:33 rti10 amd: amd startup succeeded
Jul 22 08:22:33 rti10 amd[3397]: initializing amd.conf map /etc/amd.net of
type file
Jul 22 08:22:33 rti10 oeeclslinuxrti: Starting Linux Collage RTI drivers:
Jul 22 08:22:33 rti10 amd[3397]: first time load of map /etc/amd.net
succeeded
Jul 22 08:22:33 rti10 amd[3397]: /etc/amd.net mounted fstype toplvl on /net
Jul 22 08:22:33 rti10 oeeclslinuxrti: Installing Parallel Port Driver
Jul 22 08:22:33 rti10 oeeclslinuxrti: insmod: pp: no module by that name
found
Jul 22 08:22:34 rti10 oeeclslinuxrti: Using
/lib/modules/2.4.20-8/kernel/drivers/ieee1394/ieee1394.o
Jul 22 08:22:34 rti10 oeeclslinuxrti: insmod: a module named ieee1394
already exists
Jul 22 08:22:34 rti10 kernel: raw1394: /dev/raw1394 device initialized
Jul 22 08:22:34 rti10 oeeclslinuxrti: Using
/lib/modules/2.4.20-8/kernel/drivers/ieee1394/raw1394.o
Jul 22 08:22:34 rti10 oeeclslinuxrti: mknod: `/dev/pp0': File exists
Jul 22 08:22:34 rti10 rc: Starting oeeclslinuxrti:  succeeded
Jul 22 08:22:34 rti10 sendmail: sendmail startup succeeded
Jul 22 08:22:34 rti10 sendmail: sm-client startup succeeded
Jul 22 08:22:35 rti10 gpm: gpm startup succeeded
Jul 22 08:22:37 rti10 httpd: httpd startup succeeded
Jul 22 08:22:38 rti10 canna:  succeeded
Jul 22 08:22:38 rti10 crond: crond startup succeeded
Jul 22 08:22:40 rti10 kernel: lp0: using parport0 (polling).
Jul 22 08:22:40 rti10 kernel: lp0: console ready
Jul 22 08:22:40 rti10 modprobe: modprobe: Can't locate module char-major-188
Jul 22 08:22:40 rti10 last message repeated 15 times
Jul 22 08:22:40 rti10 cups: cupsd startup succeeded
Jul 22 08:22:41 rti10 xfs: xfs startup succeeded
Jul 22 08:22:41 rti10 anacron: anacron startup succeeded
Jul 22 08:22:41 rti10 atd: atd startup succeeded
Jul 22 08:22:42 rti10 xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jul 22 08:22:42 rti10 rc: Starting firstboot:  succeeded
Jul 22 08:22:42 rti10 automount[3315]: attempting to mount entry /home/cls
Jul 22 08:22:42 rti10 rc: Starting mdc_misc:  succeeded
Jul 22 08:22:42 rti10 login(pam_unix)[3649]: session opened for user cls by
LOGIN(uid=0)
Jul 22 08:22:42 rti10 automount[3315]: attempting to mount entry
/home/clshome
Jul 22 08:22:42 rti10  -- cls[3649]: LOGIN ON tty1 BY cls
Jul 22 08:22:49 rti10 gconfd (cls-3723): starting (version 2.2.0), pid 3723
user 'cls'
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source
at position 0
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readwrite:/home/clshome/.gconf" to a writable config source at position
1
Jul 22 08:22:49 rti10 gconfd (cls-3723): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at
position 2
Jul 22 08:22:55 rti10 kernel: ide-floppy driver 0.99.newide
Jul 22 08:22:55 rti10 kernel: hdc: ATAPI 54X CD-ROM drive, 128kB Cache,
UDMA(33)
Jul 22 08:22:55 rti10 kernel: Uniform CD-ROM driver Revision: 3.12
Jul 22 08:22:57 rti10 kernel: cdrom: This disc doesn't have any tracks I
recognize!
Jul 22 08:23:59 rti10 automount[3816]: expired /home/cls
Jul 22 08:24:01 rti10 su(pam_unix)[3815]: session opened for user root by
cls(uid=301)

Results of lpci -vv

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
(rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f3000000-f3dfffff
	Prefetchable memory behind bridge: f3f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at b400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
(prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at f2800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f1000000-f27fffff
	Prefetchable memory behind bridge: f3e00000-f3efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a
[Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra
TF (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7106
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at f3fe0000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at a800 [size=128]
	Capabilities: <available only to root>

02:09.0 Communication controller: Altera Corporation PCI Fiber Optic Engrave
Interface (rev 02)
	Subsystem: Max Daetwyler Corp PCI Fiber Optic Engrave Interface
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f1800000 (32-bit, non-prefetchable) [size=4K]

02:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at f1000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

my .config file:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
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
CONFIG_LOLAT=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_X86_POWERNOW_K6=m
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_SPEEDSTEP=m
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_E820_PROC is not set
CONFIG_EDD=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_TCIC=y
CONFIG_I82092=y
CONFIG_I82365=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_H2999 is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

#
# Cryptography support (CryptoAPI)
#
CONFIG_CRYPTO=m
CONFIG_CIPHERS=m

#
# 128 bit blocksize
#
CONFIG_CIPHER_AES=m
CONFIG_CIPHER_IDENTITY=m
CONFIG_CRYPTODEV=m
CONFIG_CRYPTOLOOP=m

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_TUX=m
CONFIG_TUX_EXTCGI=y
# CONFIG_TUX_EXTENDED_LOG is not set
# CONFIG_TUX_DEBUG is not set
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_VLAN_8021Q=m

#
#
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m

#
# Appletalk devices
#
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_PHONE_IXJ_PCMCIA=m

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_NFORCE=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_BLK_DEV_ATARAID_SII=m

#
# SCSI support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=253
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_OLD_PROC_STATS=y
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
# CONFIG_SCSI_NCR53C7xx_sync is not set
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=40
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_NEWISP=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_SCSI_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Fusion MPT device support
#
CONFIG_FUSION=m
# CONFIG_FUSION_BOOT is not set
CONFIG_FUSION_MAX_SGE=40
# CONFIG_FUSION_ISENSE is not set
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_NET_FC=y

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_LP486E=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_LNE390=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_NE3210=m
CONFIG_ES3210=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
CONFIG_TLAN=m
CONFIG_TC35815=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_WINBOND_840=m
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_MYRI_SBUS is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_NETCONSOLE=m
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCI_HERMES=m

#
# Wireless Pcmcia cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y

#
# Wireless Pcmcia cards support
#
CONFIG_PCMCIA_HERMES_OLD=m

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_TMSISA=m
CONFIG_ABYSS=m
# CONFIG_MADGEMC is not set
CONFIG_SMCTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
# CONFIG_COMX is not set
# CONFIG_DSCC4 is not set
# CONFIG_LANMEDIA is not set
CONFIG_ATI_XX20=m
CONFIG_SEALEVEL_4021=m
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_HDLC is not set
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CHDLC=y
CONFIG_WANPIPE_FR=y
CONFIG_WANPIPE_X25=y
CONFIG_WANPIPE_PPP=y
CONFIG_WANPIPE_MULTPPP=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_AXNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_ARCNET_COM20020_CS is not set
CONFIG_PCMCIA_IBMTR=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_NETWAVE=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_WVLAN=m
CONFIG_AIRONET4500_CS=m

#
# ATM drivers
#
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_ZATM_EXACT_TS=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
# CONFIG_DMASCC is not set
# CONFIG_SCC is not set
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
# CONFIG_BAYCOM_PAR is not set
# CONFIG_BAYCOM_EPP is not set
CONFIG_SOUNDMODEM=m
CONFIG_SOUNDMODEM_SBC=y
CONFIG_SOUNDMODEM_WSS=y
CONFIG_SOUNDMODEM_AFSK1200=y
CONFIG_SOUNDMODEM_AFSK2400_7=y
CONFIG_SOUNDMODEM_AFSK2400_8=y
CONFIG_SOUNDMODEM_AFSK2666=y
CONFIG_SOUNDMODEM_HAPN4800=y
CONFIG_SOUNDMODEM_PSK4800=y
CONFIG_SOUNDMODEM_FSK9600=y
# CONFIG_YAM is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m
CONFIG_MA600_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_OLD=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

#
# ISDN subsystem
#
CONFIG_ISDN=m
CONFIG_ISDN_BOOL=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
# CONFIG_ISDN_DIVERSION is not set

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=m
CONFIG_ISDN_HISAX=y

#
#   D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
#   HiSax supported cards
#
CONFIG_HISAX_16_0=y
CONFIG_HISAX_16_3=y
CONFIG_HISAX_AVM_A1=y
CONFIG_HISAX_IX1MICROR2=y
CONFIG_HISAX_ASUSCOM=y
CONFIG_HISAX_TELEINT=y
CONFIG_HISAX_HFCS=y
CONFIG_HISAX_SPORTSTER=y
CONFIG_HISAX_MIC=y
CONFIG_HISAX_ISURF=y
CONFIG_HISAX_HSTSAPHIR=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
CONFIG_HISAX_DEBUG=y
CONFIG_HISAX_SEDLBAUER_CS=m
CONFIG_HISAX_ELSA_CS=m
CONFIG_HISAX_AVM_A1_CS=m
CONFIG_HISAX_ST5481=m
CONFIG_HISAX_FRITZ_PCIPNP=m

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=m
CONFIG_ISDN_DRV_PCBIT=m
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
CONFIG_ISDN_DRV_EICON=y
CONFIG_ISDN_DRV_EICON_DIVAS=m
# CONFIG_ISDN_DRV_EICON_OLD is not set
CONFIG_ISDN_DRV_TPAM=m
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m
CONFIG_ISDN_DRV_AVMB1_B1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1ISA=m
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_KALLSYMS=y

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_ECC=m
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_MAINBOARD=y
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_HYDRA=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_TSUNAMI is not set
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_ISA=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Hardware sensors support
#
CONFIG_SENSORS=y
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1024=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_FSCSCY=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_MAXILIFE=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_MTP008=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_OTHER=y
CONFIG_SENSORS_BT869=m
CONFIG_SENSORS_DDCMON=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_MATORB=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_MK712_MOUSE=m

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m

#
# Joysticks
#
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m
CONFIG_INPUT_IFORCE_USB=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_STINGER=m
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
# CONFIG_QIC02_TAPE is not set
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_PCWATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_WAFER_WDT=m
CONFIG_I810_TCO=m
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_W83877F_WDT=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
# CONFIG_WDT_501 is not set
CONFIG_MACHZ_WDT=m
CONFIG_AMD7XX_TCO=m
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
CONFIG_AMD_PM768=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
#   The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_8151=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
# CONFIG_DRM_I810_XFREE_41 is not set
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_SYNCLINK_CS=m
CONFIG_MWAVE=m
CONFIG_BATTERY_GERICOM=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZR36120=m
CONFIG_VIDEO_MEYE=m

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_MIROPCM20_RDS=m
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_SF16FMR2=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m

#
# Crypto Hardware support
#
CONFIG_CRYPTO=m
CONFIG_CRYPTO_BROADCOM=m

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
# CONFIG_QIFACE_COMPAT is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
CONFIG_AFS_FS=m
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=m
CONFIG_VXFS_FS=m
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
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_VIDEO_IGNORE_BAD_MODE is not set
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_PM2_PCI=y
CONFIG_FB_PM3=m
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
# CONFIG_FB_MATROX_PROC is not set
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_CT_VAIO_LCD=y
CONFIG_FB_RADEON=m
CONFIG_FB_ATY128=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FBCON_HGA=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=330
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_SPEAKERS=2
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
CONFIG_SOUND_AUDIGY=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
CONFIG_MIDI_VIA82CXXX=y
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0
CONFIG_AEDSP16_SBPRO=y
CONFIG_AEDSP16_MPU401=y
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set

#
#   USB Bluetooth can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_POWERMATE=m

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m

#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_RIO500=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_TIGL=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m

#
# Additional device driver support
#
CONFIG_NET_BROADCOM=m
CONFIG_CIPE=m
CONFIG_CRYPTO_AEP=m
CONFIG_MEGARAC=m
CONFIG_FC_QLA2200=m
CONFIG_FC_QLA2300=m
CONFIG_SCSI_ISCSI=m

#
# Bluetooth support
#
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_USB_ZERO_PACKET=y
CONFIG_BLUEZ_HCIUART=m
CONFIG_BLUEZ_HCIUART_H4=y
CONFIG_BLUEZ_HCIUART_BCSP=y
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=y
CONFIG_BLUEZ_HCIDTL1=m
CONFIG_BLUEZ_HCIBT3C=m
CONFIG_BLUEZ_HCIBLUECARD=m
CONFIG_BLUEZ_HCIBTUART=m
CONFIG_BLUEZ_HCIVHCI=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m


