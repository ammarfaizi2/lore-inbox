Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263415AbRFRXYr>; Mon, 18 Jun 2001 19:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbRFRXYh>; Mon, 18 Jun 2001 19:24:37 -0400
Received: from firewall.sch.bme.hu ([152.66.215.213]:2432 "EHLO
	singular.sch.bme.hu") by vger.kernel.org with ESMTP
	id <S263415AbRFRXY3>; Mon, 18 Jun 2001 19:24:29 -0400
Date: Tue, 19 Jun 2001 01:26:17 +0200 (CEST)
From: =?ISO-8859-2?Q?Kajt=E1r_Zsolt?= <soci@firewall.sch.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Iptables ipt_unclean bug?
Message-ID: <Pine.LNX.4.21.0106190104020.414-100000@firewall.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

I think it's possible to hang the kernel useing isic 0.05
(www.packetfactory.net/Projects/ISIC/), when there's a unclean match in
iptables rules.

Example:

(somewhere on target:)
iptables -A INPUT -m unclean --match unclean -j DROP

(on local machine:)
# isic -s rand -d target.ip

After <10 seconds the kernel hangs on the target machine, no console
switch/input, no oops/panic, sysrq only prints messages, but only B
works...

This is 100% reproductible on 2.4.5-ac13 and 2.4.5-ac15.

soci@firewall.sch.bme.hu IS NOT A VALID E-MAIL ADDRESS, PLEASE DO NOT
CC! (I read the archives...)

Some info of this machine:

Kernel: 2.4.5 +ac15 +dvorak sysrq +int2.4.31 +badmem2.4.4

Linux version 2.4.5-ac15 (sysadmin@singular.sch.bme.hu) (gcc version 2.95.4 20010604 (Debian prerelease)) #2 Mon Jun 18 21:04:13 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 40960
zone(0): 4096 pages.
zone(1): 36864 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=307 reboot=warm hdb=none idebus=42 badmem=0x04db0bfc,0xffffffff
ide_setup: hdb=none
ide_setup: idebus=42
Initializing CPU#0
Detected 225.002 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 448.92 BogoMIPS
Memory: 159284k/163836k available (769k kernel code, 4168k reserved, 205k data, 72k init, 0k highmem, 4k badram)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080a135 00000000 00000000, vendor = 1
CPU: After vendor init, caps: 0080a135 00000000 00000000 00000004
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix M II 3x Core/Bus Clock stepping 08
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'ESS ES1869 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 105621kB/35207kB, 320 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 42MHz system bus speed for PIO modes
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL CX6.4A, ATA DISK drive
hdc: Seagate Technology 1275MB - ST31276A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=784/255/63, UDMA(33)
hdc: 2502308 sectors (1281 MB), CHS=2482/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p7 p8 p9 > p2 p3 p4
 /dev/ide/host0/bus1/target0/lun0: p1
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 11 for device 00:11.0
PCI: The same IRQ used for device 00:07.2
eth0: KTI ET32P2 found at 0x6800, IRQ 11, xx:xx:xx:xx:xx:xx.
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: ESS ES1869 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, irq 5, dma 1, 3
ESS chip ES1869 detected
sb: 1 Soundblaster PnP card(s) found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 72k freed
Adding Swap: 64252k swap-space (priority -1)
loop: loaded (max 8 devices)
reiserfs: checking transaction log (device 03:06) ...
reiserfs: replayed 5 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:08) ...
reiserfs: replayed 4 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
ip_tables: (c)2000 Netfilter core team
ip_conntrack (1280 buckets, 10240 max)
arping uses obsolete (PF_INET,SOCK_PACKET)

								-soci-

