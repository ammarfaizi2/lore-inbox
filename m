Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbULDQol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbULDQol (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbULDQol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 11:44:41 -0500
Received: from aiolos.otenet.gr ([195.170.0.23]:31430 "EHLO aiolos.otenet.gr")
	by vger.kernel.org with ESMTP id S262557AbULDQn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 11:43:28 -0500
Message-Id: <200412041642.iB4Ggxio006440@aiolos.otenet.gr>
From: "Nicholas Papadakos" <panic@quake.gr>
To: "'Francois Romieu'" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: realtek r8169 + kernel 2.4.24 (openmosix)
Date: Sat, 4 Dec 2004 16:35:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTZmHJaxsI7Lwh9QVyKvYmLVxjY1wAc63KQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20041204002657.GA26399@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thank you for your time

I copied the latest r8169.c file from kernel 2.4.28 but it didn't compile at
all giving an error message:

r8169.c: In function `rtl8169_init_board':
r8169.c:683: warning: implicit declaration of function `SET_NETDEV_DEV'
r8169.c:683: error: structure has no member named `dev'
r8169.c: In function `rtl8169_make_unusable_by_asic':
r8169.c:1164: warning: integer constant is too large for "long" type
make[2]: *** [r8169.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.24-openmosix-r4/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.24-openmosix-r4/drivers'
make: *** [_mod_drivers] Error 2

when trying to compile the modules.
Same with 2.4.27


The patch I previously applied was a patch made by you in personal and it
was posted in this mailing list.
The patch name was : r8169-debug.patch and it contained the following.

--- r8169.c-realtek	2004-01-17 14:14:50.000000000 +0100
+++ r8169.c-debug	2004-01-17 14:17:25.000000000 +0100
@@ -1290,6 +1290,11 @@ static void rtl8169_tx_interrupt (struct
 	dirty_tx = priv->dirty_tx;
 	tx_left = priv->cur_tx - dirty_tx;
 
+	if (entry + tx_left > NUM_TX_DESC) {
+		printk(KERN_ERR, "r8169 bug. Please mail
netdev@oss.sgi.com\n");
+		return;
+	}
+
 	while (tx_left > 0) {
 		if( (priv->TxDescArray[entry].status & OWNbit) == 0 ){
 			dev_kfree_skb_irq( priv->Tx_skbuff[dirty_tx %
NUM_TX_DESC] );




The following info is for the normal kernel 2.4.24 r8169.c file without the
patch applied as I reverted to it since neither the 2.4.28 or the patched
one didn't work.


My dmesg :

romulan linux # dmesg            
Linux version 2.4.24-openmosix-r4 (root@romulan) (gcc version 3.3.4 20040623
(Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #12 SMP Sat Dec 4 01:41:46
EET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5770
ACPI: RSDT (v001 ASUS   P4S8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Kernel command line: root=/dev/hda3
Found and enabled local APIC!
Initializing CPU#0
Detected 2000.207 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 513576k/524272k available (2302k kernel code, 10308k reserved, 636k
data, 144k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
per-CPU timeslice cutoff: 1462.76 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.1831 MHz.
..... host bus clock speed is 100.0089 MHz.
cpu: 0, clocks: 1000089, slice: 500044
CPU0<T0:1000080,T1:500032,D:4,S:500044,C:1000089>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1039/0963] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
bonding.c:v2.4.1 (September 15, 2003)
bonding_init(): either miimon or arp_interval and arp_ip_target module
parameters must be specified, otherwise bonding will not detect link
failures! see bonding.txt for details.
bond0 registered without MII link monitoring, in load balancing
(round-robin) mode.
bond0 registered without ARP monitoring
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 5, 00:0c:6e:99:04:fa.
r8169 Gigabit Ethernet driver 1.2 loaded
r8169: PCI device 00:0a.0: unknown chip version, assuming RTL-8169
r8169: PCI device 00:0a.0: TxConfig = 0x4000000
eth1: Identified chip type is 'RTL-8169'.
eth1: RealTek RTL8169 Gigabit Ethernet at 0xe0800000, 00:11:6b:30:14:7b, IRQ
3
eth1: Auto-negotiation Enabled.
eth1: 1000Mbps Full-duplex operation.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected SiS 648 chipset
agpgart: AGP aperture is 64M @ 0xf4000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 2B020H1, ATA DISK drive
hdb: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63
hdb: attached ide-cdrom driver.
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
es1371: version v0.32 time 04:26:05 Nov 29 2004
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
ehci_hcd 00:03.2: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 00:03.2: irq 9, pci mem e081c000
usb.c: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 00:03.2
ehci_hcd 00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
host/usb-uhci.c: $Revision: 1.7 $ time 01:42:00 Dec  4 2004
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,3)) ...
for (ide0(3,3))
ide0(3,3):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Adding Swap: 1004052k swap-space (priority -1)
eth0: Media Link On 100mbps full-duplex


lspci -vx gives me the following :



0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev
03)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8086
        Flags: bus master, medium devsel, latency 32
        Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 3.0
00: 39 10 48 06 07 00 10 22 03 00 00 06 00 20 80 00
10: 00 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 86 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI
bridge (AGP) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: f3000000-f3ffffff
        Prefetchable memory behind bridge: fbf00000-febfffff
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 20
20: 00 f3 f0 f3 f0 fb b0 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL
Media IO] (rev 25)
        Flags: bus master, medium devsel, latency 0
00: 39 10 63 09 0f 00 00 02 25 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8087
        Flags: bus master, medium devsel, latency 128, IRQ 11
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at b400 [size=16]
00: 39 10 13 55 05 00 00 02 00 8a 01 01 00 80 00 00
10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 01 b8 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 43 10 87 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
Sound Controller (rev a0)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80b0
        Flags: bus master, medium devsel, latency 32, IRQ 3
        I/O ports at a400 [size=256]
        I/O ports at a000 [size=128]
        Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 20 00 00
10: 01 a4 00 00 01 a0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 b0 80
30: 00 00 00 00 48 00 00 00 00 00 00 00 03 03 34 0b

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8087
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at f2800000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 00 80 02 0f 10 03 0c 08 20 80 00
10: 00 00 80 f2 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 87 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 50

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8087
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 00 80 02 0f 10 03 0c 08 20 00 00
10: 00 00 00 f2 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 87 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 50

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 2.0
Controller (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8087
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at f1800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 20 00 00
10: 00 00 80 f1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 87 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 04 00 50

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
PCI Fast Ethernet (rev 91)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a7
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9800 [size=256]
        Memory at f1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fbee0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
00: 39 10 00 09 07 00 90 02 91 00 00 02 00 20 00 00
10: 01 98 00 00 00 00 00 f1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a7 80
30: 00 00 ee fb 40 00 00 00 00 00 00 00 05 01 34 0b

0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 04)
        Subsystem: Creative Labs CT4850 SBLive! Value
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9400 [size=32]
        Capabilities: [dc] Power Management version 1
00: 02 11 02 00 05 00 90 02 04 00 01 04 00 20 80 00
10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 02 14

0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at 9000 [size=8]
        Capabilities: [dc] Power Management version 1
00: 02 11 02 70 05 00 90 02 01 00 80 09 00 20 80 00
10: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 3
        I/O ports at 8800 [size=256]
        Memory at f0800000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 02 10 00 00 02 08 20 00 00
10: 01 88 00 00 00 00 80 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 20 40

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8129
(rev 10)
        Subsystem: Coreco Inc: Unknown device 8129
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 8400 [size=256]
        Memory at f0000000 (32-bit, non-prefetchable) [size=256]
00: ec 10 29 81 07 00 00 02 10 00 00 02 00 20 00 00
10: 01 84 00 00 00 00 00 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 11 29 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 20 20

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head LE
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Memory at f3800000 (32-bit, non-prefetchable) [size=16K]
        Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at fbfe0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0
00: 2b 10 25 05 07 00 90 02 82 00 00 03 08 40 00 00
10: 08 00 00 fc 00 00 80 f3 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 c0 07
30: 00 00 fe fb dc 00 00 00 00 00 00 00 0b 01 10 20

Last but not least:


romulan root # lsmod
Module                  Size  Used by    Not tainted
r8169                   6636   1


Thank you in advance,

Nicholas Papadakos


-----Original Message-----
From: Francois Romieu [mailto:romieu@fr.zoreil.com] 
Sent: Saturday, December 04, 2004 2:27 AM
To: Nicholas Papadakos
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtek r8169 + kernel 2.4.24 (openmosix)

Nicholas Papadakos <panic@quake.gr> :
[...]
> I am trying to use a realtek r8169 gigabit Ethernet levelone card as a
link
> between two machines that are cluster using openmosix, However whenever I
> try to transfer large amounts of data after 5 secs the connections
freezes.
> I found a similar older post with an attacked patch to try, I tried it but
> the problem remained. Any help ?
> I don't want to upgrade kernel to something else as I need openmosix to
keep
> running.

I know it's fri^Wsatursday but it does not help if you do not specify which
patch you applied.

At a minimum, you want to upgrade the sources of the r8169 driver up to a
more recent 2.4.x: simply drop a drivers/net/r8169.c from the latest 2.4.x
into your 2.4.24 tree, rebuild and report the result (+ complete dmesg +
lspci -vx + lsmod for my collection please).

Cc: netdev@oss.sgi.com is welcome.

--
Ueimor


