Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310383AbSCLDQ0>; Mon, 11 Mar 2002 22:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310376AbSCLDQV>; Mon, 11 Mar 2002 22:16:21 -0500
Received: from jack-ras1-1-cs-19.dial.bright.net ([216.255.23.150]:21003 "HELO
	plymale.homeip.net") by vger.kernel.org with SMTP
	id <S310378AbSCLDP6>; Mon, 11 Mar 2002 22:15:58 -0500
From: "George D. Plymale" <plymale@bright.net>
To: <linux-kernel@vger.kernel.org>
Subject: HPT372 Errors even after ac4 patch
Date: Mon, 11 Mar 2002 22:15:47 -0500
Message-ID: <NDENJLAFJMCNNJDNDEDGAEGCCAAA.plymale@bright.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just spoke with ata in #kernelnewbies several days ago and with the help of
a friend we got a kernel compiled for my box with the Iwill XP333-R in it
(as I don't have a linux dev box at the moment).  I added ata's patch to get
the HPT372 recognized as an HPT370, which seems to have done away with
garbage that was being seen at ide chipset initialization, but I am still
having the identical DMA errors as before without the patch.  The problems
start when I mkswap on the ataraid partition (or any time I ever try to
access my raid array).  The errors can be found at the tail of this dmesg
output (starting with hdg: dma_intr: status=0xff { Busy }):

Linux version 2.4.17-r5 (me@somewhere.home) (gcc version 2.95.3 20010315
(release)) #6 Tue Mar 12 01:51:49 GMT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: devfs=nomount vga=normal load_ramdisk=1
prompt_ramdisk=0 ramdisk_size=22000 initrd=rescue.gz root=/dev/ram0 rw
BOOT_IMAGE=kernel
Initializing CPU#0
Detected 1393.115 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2778.72 BogoMIPS
Memory: 505156k/524224k available (1782k kernel code, 18680k reserved, 1085k
data, 228k init, 0k highmem)
kdb version 2.1 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights
Reserved
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router default [10b9/1647] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Non-volatile memory driver v1.1
block: 976 slots per queue, batch=244
RAMDISK driver initialized: 16 RAM disks of 22000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using
pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
HPT372: IDE controller on PCI bus 00 dev 70
HPT372: chipset revision 5
HPT372: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
hde: WDC WD200BB-53AUA1, ATA DISK drive
hdg: WDC WD200BB-53AUA1, ATA DISK drive
ide2 at 0xd800-0xd807,0xdc02 on irq 15
ide3 at 0xe000-0xe007,0xe402 on irq 15
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [2434/255/63] p1 p2 < >
 /dev/ide/host2/bus1/target0/lun0: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
eth0: ADMtek Comet rev 17 at 0xd400, 00:20:78:03:E9:7F, IRQ 11.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Ali M1647 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
 ataraid/d0: p1 p2 < p5 p6 p7 p8 p9 >
Highpoint HPT370 Softwareraid driver for linux version 0.01
Drive 0 is 19092 Mb
Drive 1 is 19092 Mb
Raid array consists of 2 drives.
cmpci: version $Revision: 5.64 $ time 01:54:15 Mar 12 2002
cmpci: found CM8738 adapter at io 0xec00 irq 10
cmpci: chip version = 055
Creative EMU10K1 PCI Audio Driver, version 0.16, 01:53:56 Mar 12 2002
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 01:54:25 Mar 12 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb-ohci.c: USB OHCI at membase 0xe0818000, IRQ 5
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 7071k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 228k freed
hdg: dma_intr: status=0xff { Busy }
hdg: DMA disabled
ide3: reset timed-out, status=0xff
hdg: status timeout: status=0xff { Busy }
hdg: drive not ready for command
ide3: reset timed-out, status=0xff
end_request: I/O error, dev 22:00 (hdg), sector 25712012
end_request: I/O error, dev 22:00 (hdg), sector 25712014
end_request: I/O error, dev 22:00 (hdg), sector 25712016
end_request: I/O error, dev 22:00 (hdg), sector 25712010
Unable to find swap-space signature
VFS: Disk change detected on device fd(2,0)
VFS: Can't find ext3 filesystem on dev fd(2,0).
VFS: Can't find ext2 filesystem on dev fd(2,0).



