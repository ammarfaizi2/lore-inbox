Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTJFEOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 00:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTJFEOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 00:14:53 -0400
Received: from bay1-f158.bay1.hotmail.com ([65.54.245.158]:777 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263973AbTJFEOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 00:14:49 -0400
X-Originating-IP: [65.25.165.241]
X-Originating-Email: [jw2357@hotmail.com]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Reboot during boot with 2.4.20 RedHat Boot Disk
Date: Mon, 06 Oct 2003 04:14:48 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F158kQ6mBySsxV000023c8@hotmail.com>
X-OriginalArrivalTime: 06 Oct 2003 04:14:48.0623 (UTC) FILETIME=[61BC7BF0:01C38BC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to upgrade a RH 7.3 machine to RH 9 and the machine keeps
spontaneously rebooting when I boot from the boot disk.

The machine is an HP Vectra XU, dual Pentium 100, 32MB memory. It has
the beloved CMD640 IDE controller, but the hard drive and CD-ROM are
both SCSI - no IDE devices are installed. The machine has been running
various flavors of RedHat for about 4 years now, is currently running
7.3 and is stable - no overclocking. Just to rule out a recent
hardware failure, I ran Memtest86 overnight - no problems.

When booting from the RH boot disk, I capture the following from the
serial console:

Linux version 2.4.20-8BOOT (bhcompile@porky.devel.redhat.com) (gcc
version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:31:38 EST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee010
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
32MB LOWMEM available.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: initrd=initrd.img BOOT_IMAGE=vmlinuz dd console=ttyS0
Initializing CPU#0
Detected 99.718 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 198.65 BogoMIPS
Memory: 29016k/32768k available (1209k kernel code, 3108k reserved,
350k data, 104k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium 75 - 200 stepping 05
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.00 entry at 0xfdcf0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.09 2003-Jan-22, 0 devices found
EDD information not available.
Starting kswapd
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

At which point the machine reboots. When the machine comes back up,
many of the self tests fail (processor, cache memory, main memory,
floppy and a couple others) and the machine is pretty unhappy.
Resetting the machine or power cycling it fixes that problem.

>From the point where it fails, I have suspected a problem with the IDE
probing, so I tried booting with "mem=24M", "mem=32M", "apm=off",
"nomce" and "noapic" without any luck.

"/sbin/lspci -v" produces the following:

00:00.0 Host bridge: Intel Corp. 82434LX [Mercury/Neptune] (rev 11)
	Flags: bus master, slow devsel, latency 240

00:01.0 VGA compatible unclassified device: S3 Inc. 86c864 [Vision 864
DRAM] vers 0
	Flags: medium devsel
	Memory at a0000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:02.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 04)
	Flags: bus master, medium devsel, latency 248

00:03.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet LANCE] (rev 02)
	Flags: bus master, stepping, medium devsel, latency 0, IRQ 9
	I/O ports at ffe0 [size=32]

00:04.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 02)
	Flags: bus master, stepping, medium devsel, latency 0, IRQ 10
	I/O ports at ff00 [size=128]

00:05.0 IDE interface: CMD Technology Inc PCI0640 (rev 02) (prog-if 0a
[SecP PriP])
	Flags: medium devsel, IRQ 14

00:0e.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
21)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 248, IRQ 10
	I/O ports at fe00 [size=256]
	Memory at fffec000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fd000000 [disabled] [size=256K]

Does anyone have any suggestions to help me?

Thanks,

- John

_________________________________________________________________
Instant message during games with MSN Messenger 6.0. Download it now FREE!  
http://msnmessenger-download.com

