Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267783AbTAMDdR>; Sun, 12 Jan 2003 22:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTAMDdQ>; Sun, 12 Jan 2003 22:33:16 -0500
Received: from services.cam.org ([198.73.180.252]:65245 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267783AbTAMDcw>;
	Sun, 12 Jan 2003 22:32:52 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Greg KH <greg@kroah.com>
Subject: usb mouse and 2.5.56bk
Date: Sun, 12 Jan 2003 22:42:01 -0500
User-Agent: KMail/1.4.3
References: <200212141215.49449.tomlins@cam.org> <200212172243.52786.tomlins@cam.org> <20021218054802.GF28629@kroah.com>
In-Reply-To: <20021218054802.GF28629@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1MVM4X37V9R02I05NYRC"
Message-Id: <200301122242.01033.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1MVM4X37V9R02I05NYRC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Greg,

Something strange with 2.5.56.  My usb mouse is no longer working
after boot.  I can get it to work by repluging it.  Here is my
dmesg ang the init.d/local that should make sure the modules needed=20
are loaded.  Before tring to replug I unloaded and reloaded hid and
psmouse to see if this would fix things (it did not).

I suspect the changeset below:

ChangeSet@1.889.19.1, 2003-01-09 10:29:40-08:00, greg@kroah.com

which got added just before .56 - I have been tracking bk fairly
closely and all was working up to the version of 55bk built at 8am
on the 9th.

Ideas?
Ed Tomlinson


--------------Boundary-00=_1MVM4X37V9R02I05NYRC
Content-Type: application/x-shellscript;
  name="local"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="local"

#! /bin/sh -x

if [ "$1" = "stop" -o "$1" = "restart" ]; then

  sync
  umount /dev/sda
  rmmod usb-storage
  rmmod sd_mod
  rmmod scsi_mod

fi

if [ "$1" = "start" -o "$1" = "restart" ]; then

  echo "8192" > /proc/sys/fs/file-max
  echo "32768" > /proc/sys/fs/inode-max
  echo "80" > /proc/sys/vm/swappiness
 
  #/sbin/insmod ide-tape
  #/sbin/modprobe ide-scsi

  modprobe af_packet
  modprobe ppp_async

  #enable usb mouse
  modprobe psmouse
  modprobe hid   

  rmmod iptable_filter
  rmmod ip_tables
  rmmod -f ip_tables
  modprobe ipchains

  modprobe pppoe

# modprobe mga

# modprobe matroxfb_base

# modprobe pl2303
  modprobe usb-storage

  modprobe cs46xx

  rmmod lp
  modprobe parport_pc
  modprobe lp

  /bin/chmod 1777 /tmp

  #su -c "cd /usr/src/linux-2.4-rmap; bk bkd -d -p3334 -xcd -xpush" - ed &
  /usr/bin/pon dsl-provider
fi
 
 

--------------Boundary-00=_1MVM4X37V9R02I05NYRC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="boot"
Content-Disposition: attachment; filename="boot"
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.56 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prer=
elease)) #33 Sun Jan 12 22:08:49 EST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=3D/dev/hde3 console=3Dtty0 console=3DttyS0,3840=
0 idebus=3D33 hdb=3Dnone hdf=3Dnone hdh=3Dnone vga=3Dask
ide_setup: idebus=3D33
ide_setup: hdb=3Dnone
ide_setup: hdf=3Dnone
ide_setup: hdh=3Dnone
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.811 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 515888k/524224k available (1321k kernel code, 7592k reserved, 776=
k data, 80k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc160
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc188, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
aio_setup: sizeof(struct page) =3D 40
Journalled Block Device driver loaded
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 12
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: host protected area =3D> 1
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=3D26853/16/63, UDMA(=
33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hde: host protected area =3D> 1
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=3D77557/16/63, UDMA=
(100)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: host protected area =3D> 1
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=3D77557/16/63, UDMA=
(100)
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driv=
er v2.0
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 10, io base 0000a400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecate=
d.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,3), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide2(33,3)) for (ide2(33,3))
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
hub 1-1:0: USB hub found
hub 1-1:0: 4 ports detected
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 4
hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 4, assigned address 5
reiserfs: replayed 27 transactions in 2 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 80k freed
Adding 393552k swap on /dev/hda1.  Priority:1 extents:1
Adding 393584k swap on /dev/hde1.  Priority:1 extents:1
Adding 393584k swap on /dev/hdg1.  Priority:1 extents:1
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 9, want irq 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) bloc=
k.
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
Execing /sbin/hotplug
eth0: Digital DS21140 Tulip rev 34 at 0xc000, 00:C0:F0:32:30:70, IRQ 9.
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 9 for device 00:08.0
IRQ routing conflict for 00:08.0, have irq 11, want irq 9
Execing /sbin/hotplug
eth1: VIA VT86C100A Rhine at 0xed120000, 00:80:c8:f9:ee:ba, IRQ 11.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 000=
0.
IPv4 over IPv4 tunneling driver
Execing /sbin/hotplug
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
Execing /sbin/modprobe
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Module parport cannot be unloaded due to unsafe usage in include/linux/mo=
dule.h:424
Module parport_pc cannot be unloaded due to unsafe usage in include/linux=
/module.h:424
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
Execing /sbin/hotplug
Execing /sbin/modprobe
Execing /sbin/modprobe
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,5), size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30
reiserfs: checking transaction log (ide0(3,5)) for (ide0(3,5))
reiserfs: replayed 24 transactions in 2 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,5), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide2(33,5)) for (ide2(33,5))
reiserfs: replayed 5 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide3(34,3), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide3(34,3)) for (ide3(34,3))
reiserfs: replayed 26 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide3(34,5), size 8192, journal first bloc=
k 18, max trans len 1024, max batch 900, max commit age 30, max trans age=
 30
reiserfs: checking transaction log (ide3(34,5)) for (ide3(34,5))
reiserfs: replayed 1 transactions in 0 seconds
Using r5 hash to sort names
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Execing /sbin/modprobe
Execing /sbin/modprobe
ip_tables: (C) 2000-2002 Netfilter core team
Execing /sbin/modprobe
Module ip_tables cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Module tulip cannot be unloaded due to unsafe usage in include/linux/modu=
le.h:424
Execing /sbin/modprobe
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntr=
ack
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
PCI: Found IRQ 9 for device 00:0b.0
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 20:59:51 Jan 12 2003
cs46xx: Card found at 0xed121000 and 0xed000000, IRQ 9
cs46xx: Card without SSID set (0000:0000) at 0xed121000/0xed000000, IRQ 9
ac97_codec: AC97 Audio codec, id: CRY3 (Cirrus Logic CS4297)
lp0: using parport0 (polling).
Execing /sbin/modprobe
Module ppp_async cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Execing /sbin/hotplug
Module af_packet cannot be unloaded due to unsafe usage in include/linux/=
module.h:424
Execing /sbin/modprobe
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Module bsd_comp cannot be unloaded due to unsafe usage in include/linux/m=
odule.h:424
Execing /sbin/modprobe
PPP Deflate Compression module registered
Module ppp_deflate cannot be unloaded due to unsafe usage in include/linu=
x/module.h:424
Module ipchains cannot be unloaded due to unsafe usage in include/linux/m=
odule.h:424
Execing /sbin/modprobe
drivers/usb/core/usb.c: deregistering driver hid
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-2: USB disconnect, address 3
Execing /sbin/hotplug
Execing /sbin/hotplug
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 6
Execing /sbin/hotplug
Execing /sbin/hotplug
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Optical] =
on usb-00:07.2-2
Execing /sbin/hotplug
Execing /sbin/modprobe
Module cs46xx cannot be unloaded due to unsafe usage in include/linux/mod=
ule.h:424
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe
Execing /sbin/modprobe

--------------Boundary-00=_1MVM4X37V9R02I05NYRC--

