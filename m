Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135565AbRARQCx>; Thu, 18 Jan 2001 11:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135592AbRARQCn>; Thu, 18 Jan 2001 11:02:43 -0500
Received: from cic.teleco.ulpgc.es ([193.145.140.2]:44429 "EHLO
	cic.teleco.ulpgc.es") by vger.kernel.org with ESMTP
	id <S135565AbRARQC3>; Thu, 18 Jan 2001 11:02:29 -0500
Date: Thu, 18 Jan 2001 16:00:26 +0000 (WET)
From: Eugenio Jimenez <eugenio@masdache.teleco.ulpgc.es>
To: linux-kernel@vger.kernel.org
Subject: ACPI slows down the system (2.4.0)
Message-ID: <Pine.LNX.4.21.0101181557140.759-100000@gic12.gic.ulpgc.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Testing a 2.4 kernel I have found something I think it's rather strange
Running a 2.4.0 kernel with APM enabled (not ACPI), it takes about ten minutes
to compile a kernel (Pentium III Coppermine 450 Mhz 128 MB)
[eugenio@gic12 linux]$ time make dep clean bzImage modules >& /dev/null
real    9m45.098s
user    8m1.410s
sys     0m28.800s

Compiling the same kernel with the same options but with ACPI enabled (not
APM) and after failing in the initialization of the ACPI subsystem (see the
ouput of dmseg in this kernel), it takes more than an hour to compile the
kernel. No swap, no stange messages, just sloooooww
[eugenio@gic12 linux]$ time make dep clean bzImage modules >& /dev/null
real    78m58.129s
user    72m56.610s
sys     4m22.810s

Can a wrongly initializated ACPI subsystem slow down the clock or something
so ? How can I measure the speed ?

PS: It doesn't matter if you compile the Kernel or Ptolemy or XFree86, you
just need something hard to do for your box :-)

PS2: dmesg output of the ACPI kernel

Linux version 2.4.0 (root@gic12) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #9 Thu Jan 18 11:23:43 WET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000008000 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000008000 @ 0000000007ff8000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=test ro root=302
Initializing CPU#0
Detected 449.079 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 126668k/131008k available (988k kernel code, 3952k reserved, 344k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
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
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
  got res[10000000:10000fff] for resource 0 of O2 Micro, Inc. 6832
  got res[10001000:10001fff] for resource 0 of O2 Micro, Inc. 6832 (#2)
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
25 structures occupying 960 bytes.
DMI table at 0x000F8380.
BIOS Vendor: ACER
BIOS Version: V3.3 R01-A4g-EN                         
BIOS Release: 02/10/2000
System Vendor: Acer            .
Product Name: TravelMate 730 Series.
Version -1.
Serial Number 9149C0110S005002D5M             .
Board Vendor: Acer            .
Board Name: Intel 440BX and PX4M.
Board Version: -1.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
[snipped ide info]
Real Time Clock Driver v1.10d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe0000000
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
----------------------------------ACPI messages-------------
ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enable failed
------------------------------------------------------------
VFS: Mounted root (ext2 filesystem) readonly.

Thanks in advance

-----------------------------------------------------------------------
 Eugenio Jimenez Yguacel             eugenio@masdache.teleco.ulpgc.es
 E.T.S.I. Telecomunicacion           Tfno: (+34)-28-458079
 Campus de Tafira S/N                Fax:  (+34)-28-451243
 35017 Las Palmas, Spain             Beer, breakfast for champions!
-----------------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
