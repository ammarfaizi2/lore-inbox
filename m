Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTJJWZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbTJJWZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:25:59 -0400
Received: from toulouse-2-a7-62-147-37-2.dial.proxad.net ([62.147.37.2]:16768
	"EHLO albireo.free.fr") by vger.kernel.org with ESMTP
	id S263155AbTJJWZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:25:46 -0400
Message-Id: <200310102226.h9AMPvuF002396@albireo.free.fr>
Date: Sat, 11 Oct 2003 00:25:57 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: 2.6.0-test7: pb with SCSI-device attribution for USB memory stick
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have encountered a strange problem with the SCSI-device attribution 
when using a USB memory stick (KINGMAX, USB 2.0, 256 MB) on a
2.6.0-test7 kernel (previous versions are similar). When I plug in the
stick for the first time it is apparently correctly recognized and 
it can be mounted under the emulated SCSI-device /dev/sda. When the 
stick is plugged out and in again it will be attributed to /dev/sdb and 
the next times it will be /dev/sdc, /dev/sdd, ..., /dev/sdz, /dev/sdaa etc. 
It seems that the memory stick is always properly working, (reading,
writing) but one has to use each time a different SCSI-device for the
mount. This is not very convenient since I have put a line with
/dev/sda in /etc/fstab. 
In a 2.4.22 or 2.4.23.pre5,6,7 kernel this problem does not appear. 
It seems that this is independent of the hardware (I have tested 
with three quite different machines) and of the kernel configuration 
provided that the proper drivers are present (scsi-mod, usb-storage,
usb-core, etc.) either as modules or directly compiled into the kernel.

I have attached below two dmesg-outputs. In the second I have tried to
unload the scsi, usb-modules and somehow this has triggered 
a kernel BUG (at mm/slab.c:1268!). See below at the end for the
detailed BUG-message.

There are also a lot of SCSI-error messages but they appear in general 
to be harmless and they are also present in 2.4.22/23-pre kernels. 

Klaus Frahm.

(Please cc any reply to frahm@irsamc.ups-tlse.fr since I am not on the 
mailing list.)

---------------------------------------------------------
first dmesg output
---------------------------------------------------------
Linux version 2.6.0-test7 (frahm@pttpc1.ups-tlse.fr) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #2 Fri Oct 10 22:55:44 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe2800 (usable)
 BIOS-e820: 000000000ffe2800 - 0000000010000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65506
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61410 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda7
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1795.189 MHz processor.
Console: colour VGA+ 80x25
Memory: 256256k/262024k available (1425k kernel code, 5044k reserved, 651k data, 200k init, 0k highmem)
Calibrating delay loop... 3547.13 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.0
divert: not allocating divert_blk for non-ethernet device lo
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
VFS: Disk quotas dquot_6.5.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:00:1f.5
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
divert: allocating divert_blk for eth0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:02:00.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
hda: IC25N020ATCS04-0, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-C2612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdb: ATAPI 24X DVD-ROM drive, 192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 11, io base 0000bf80
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.0
uhci-hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: irq 11, io base 0000bf20
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
EXT3 FS on hda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdb: DMA disabled
updfstab: numerical sysctl 1 23 is obsolete.
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
hub 1-1:1.0: new USB device on port 1, assigned address 3
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
updfstab: numerical sysctl 1 23 is obsolete.
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: Write Protect is off
sda: Mode Sense: 00 26 00 00
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI error: host 0 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
 sda: sda1 sda2 sda3 sda4
SCSI error: host 0 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI error: host 0 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
SCSI error: host 0 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
usb 1-1: USB disconnect, address 2
usb 1-1.1: USB disconnect, address 3
hub 1-0:1.0: new USB device on port 1, assigned address 4
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
hub 1-1:1.0: new USB device on port 1, assigned address 5
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 512000 512-byte hdwr sectors (262 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 26 00 00
sdb: cache data unavailable
sdb: assuming drive cache: write through
SCSI error: host 1 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
 sdb: sdb1 sdb2 sdb3 sdb4
SCSI error: host 1 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
updfstab: numerical sysctl 1 23 is obsolete.
usb 1-1: USB disconnect, address 4
usb 1-1.1: USB disconnect, address 5

--------------------------------------------------
second dmesg output (with kernel Bug in the end)
--------------------------------------------------
te hdwr sectors (262 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 26 00 00
sdd: cache data unavailable
sdd: assuming drive cache: write through
SCSI error: host 3 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
 sdd: sdd1 sdd2 sdd3 sdd4
SCSI error: host 3 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
Attached scsi removable disk sdd at scsi3, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 9
updfstab: numerical sysctl 1 23 is obsolete.
usb 1-1: USB disconnect, address 8
usb 1-1.1: USB disconnect, address 9
hub 1-0:1.0: new USB device on port 1, assigned address 10
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
hub 1-1:1.0: new USB device on port 1, assigned address 11
scsi4 : SCSI emulation for USB Mass Storage devices
  Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sde: 512000 512-byte hdwr sectors (262 MB)
sde: Write Protect is off
sde: Mode Sense: 00 26 00 00
sde: cache data unavailable
sde: assuming drive cache: write through
SCSI error: host 4 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
 sde: sde1 sde2 sde3 sde4
SCSI error: host 4 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
Attached scsi removable disk sde at scsi4, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 11
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usb 1-1: USB disconnect, address 10
usb 1-1.1: USB disconnect, address 11
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 11 rqt 128 rq 6 len 18 ret -19
hub 1-0:1.0: new USB device on port 1, assigned address 12
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
hub 1-1:1.0: new USB device on port 1, assigned address 13
scsi5 : SCSI emulation for USB Mass Storage devices
  Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdf: 512000 512-byte hdwr sectors (262 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 26 00 00
sdf: cache data unavailable
sdf: assuming drive cache: write through
SCSI error: host 5 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
 sdf: sdf1 sdf2 sdf3 sdf4
SCSI error: host 5 id 0 lun 0 return code = 8000002
	Sense class 7, sense error 0, extended sense 0
Attached scsi removable disk sdf at scsi5, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 13
updfstab: numerical sysctl 1 23 is obsolete.
usb 1-1: USB disconnect, address 12
usb 1-1.1: USB disconnect, address 13
drivers/usb/core/usb.c: deregistering driver usb-storage
uhci-hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci-hcd 0000:00:1d.0: USB bus 1 deregistered
uhci-hcd 0000:00:1d.2: remove, state 1
usb usb2: USB disconnect, address 1
uhci-hcd 0000:00:1d.2: USB bus 2 deregistered
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
SLAB: cache with size 384 has lost its name
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:00.0
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 11, io base 0000bf80
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.0
uhci-hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: irq 11, io base 0000bf20
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 1 port detected
hub 1-1:1.0: new USB device on port 1, assigned address 3
SCSI subsystem initialized
Initializing USB Mass Storage driver...
kmem_cache_create: duplicate cache scsi_cmd_cache
------------[ cut here ]------------
kernel BUG at mm/slab.c:1268!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0135c4a>]    Tainted: PF 
EFLAGS: 00010202
EIP is at kmem_cache_create+0x3fa/0x470
eax: c0272a80   ebx: cbb4ee18   ecx: c0344fc8   edx: d09a2bc0
esi: d09a2bcf   edi: d09a2bcf   ebp: cbb4ed30   esp: cab37e44
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3014, threadinfo=cab36000 task=cb0bc6a0)
Stack: 00b37e48 cab37e50 c0000000 00000080 00000bc7 cb0bc6a0 ca41ea80 00000000 
       d09aa340 cba7a800 d09aa368 cba7a810 d099b237 d09a2bc0 00000180 00000080 
       00002000 00000000 00000000 000001d0 cba7a800 00000400 d0993dc0 d099c0a5 
Call Trace:
 [<d099b237>] scsi_setup_command_freelist+0x57/0xe0 [scsi_mod]
 [<d099c0a5>] scsi_host_alloc+0x1e5/0x2b0 [scsi_mod]
 [<c0117bd0>] default_wake_function+0x0/0x20
 [<d0990f90>] usb_stor_acquire_resources+0xb0/0xe0 [usb_storage]
 [<d0991222>] storage_probe+0x112/0x190 [usb_storage]
 [<c01746e2>] create_dir+0x62/0x80
 [<d086b06a>] usb_probe_interface+0x4a/0x80 [usbcore]
 [<c01c6b4e>] bus_match+0x2e/0x50
 [<c01c6c30>] driver_attach+0x40/0xa0
 [<c01c6e80>] bus_add_driver+0x60/0x80
 [<d086b181>] usb_register+0x71/0xc0 [usbcore]
 [<d0996015>] usb_stor_init+0x15/0x30 [usb_storage]
 [<c012dc32>] sys_init_module+0xf2/0x1b0
 [<c010a803>] syscall_call+0x7/0xb

Code: 0f 0b f4 04 48 20 27 c0 0f b6 05 01 11 2a c0 8b 0b 88 44 24 
 <6>updfstab: numerical sysctl 1 23 is obsolete.
usb 1-1: USB disconnect, address 2
usb 1-1.1: USB disconnect, address 3



