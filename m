Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTKHQv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTKHQv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 11:51:56 -0500
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:11025 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261817AbTKHQvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 11:51:46 -0500
Message-ID: <3FAD1F1C.2030405@dgreaves.com>
Date: Sat, 08 Nov 2003 16:51:40 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Promise Ultra100TX2 PDC20286 broken in 2.6.0-test9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: The Promise Ultra100TX2 doesn't work for me in 2.6.0-test9 - 
but it is fine with 2.4.18xfs

(First posting to lkml - hopefully got enough info and this will be 
helpful - let me know if you need more.)
I've been googling, recompiling and trying for 12 hours now so I've seen 
a lot of stuff about the promise drivers :)

My basic system is RedHat 7.3 with XFS. The kernel is non std (has XFS + 
misc ACL patch) 2.4.18

I am using the 80pin cable supplied with the Promise.
I've tried the 'noapic' option (and config'ed without any power 
management) as Alan Cox suggested

Below is trimmed dmesg from 2.4.18 and complete dmesg from 2.6.0-test9

Please cc lkml at dgreaves.com in replies.

grub for 2.4.18: kernel /vmlinuz-2.4.18-4SGI_XFS_1.1customIDE ro 
root=/dev/hdc3 ide2=ata66 ide2=autotune
(Relevant bit from 2.4.18 dmesg:
#########################
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20268: IDE controller on PCI bus 00 dev 48
PCI: Found IRQ 10 for device 00:09.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xe8000000
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hda: ST320420A, ATA DISK drive
hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
hdc: IBM-DTLA-305040, ATA DISK drive
hdd: IC35L060AVVA07-0, ATA DISK drive
hde: WDC WD800JB-00ETA0, ATA DISK drive
hdf: WDC WD800JB-00ETA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xdc02 on irq 10
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=2480/255/63, UDMA(33)
hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=79780/16/63, UDMA(33)
hdd: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(33)
blk: queue c02ebdec, I/O limit 4095Mb (mask 0xffffffff)
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/255/63, 
UDMA(100)
blk: queue c02ebf38, I/O limit 4095Mb (mask 0xffffffff)
hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/255/63, 
UDMA(100)
Partition check:
 hda: hda1 hda2
 hdc: hdc1 hdc2 hdc3
 hdd: hdd1
 hde: hde1
 hdf: hdf1
                             [snip]
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
XFS mounting filesystem ide0(3,1)
XFS mounting filesystem ide1(22,65)
XFS mounting filesystem ide1(22,1)
XFS mounting filesystem ide0(3,2)
XFS mounting filesystem ide2(33,1)
XFS mounting filesystem ide2(33,65)
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdb: packet command error: error=0x00
hdb: DMA disabled
ide0: Speed warnings UDMA 3/4/5 is not functional.
ide1: Speed warnings UDMA 3/4/5 is not functional.
ide1: Speed warnings UDMA 3/4/5 is not functional.
blk: queue c02ebdec, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02ebf38, I/O limit 4095Mb (mask 0xffffffff)
#########################

and from 2.6.0-test9
#########################
Linux version 2.6.0-test9 (root@willow) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-110)) #2 Sat Nov 8 15:56:56 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010ff0000 (usable)
 BIOS-e820: 0000000010ff0000 - 0000000010ff3000 (ACPI NVS)
 BIOS-e820: 0000000010ff3000 - 0000000011000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
271MB LOWMEM available.
On node 0 totalpages: 69616
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 65520 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hdc3 noapic single
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 451.117 MHz processor.
Console: colour VGA+ 80x25
Memory: 271812k/278464k available (2117k kernel code, 5936k reserved, 
753k data, 120k init, 0k highmem)
Calibrating delay loop... 888.83 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc0c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc0e8, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 0000:00:07.0
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with no debug enabled
Activating ISA DMA hang workarounds.
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdb: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-305040, ATA DISK drive
hdd: IC35L060AVVA07-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 0000:00:09.0
PCI: Found IRQ 10 for device 0000:00:09.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0xe8000000
PDC20268: 100% native mode on irq 10
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800JB-00ETA0, ATA DISK drive
hdf: WDC WD800JB-00ETA0, ATA DISK drive
hdf: set_drive_speed_status: status=0xff { Busy }
ide2 at 0xd800-0xd807,0xdc02 on irq 10
hda: max request size: 128KiB
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=39535/16/63
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=65535/16/63
 hdc: hdc1 hdc2 hdc3
hdd: max request size: 128KiB
hdd: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
 hdd: hdd1
hde: max request size: 1024KiB
hde: status timeout: status=0xff { Busy }

hde: drive not ready for command
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63
hde: status timeout: status=0xff { Busy }

hde: drive not ready for command
 hde:hde: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 0
Buffer I/O error on device hde, logical block 0
end_request: I/O error, dev hde, sector 0
Buffer I/O error on device hde, logical block 0
 unable to read partition table
hdf: max request size: 1024KiB
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
hdf: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63
hdf: status timeout: status=0xff { Busy }

hdf: drive not ready for command
 hdf:hdf: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
hdf: status timeout: status=0xff { Busy }

PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
end_request: I/O error, dev hdf, sector 0
Buffer I/O error on device hdf, logical block 0
 unable to read partition table
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 24X CD-ROM CD-R/RW drive, 4096kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:531:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hdc3
Ending clean XFS mount for filesystem: hdc3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 120k freed
Adding 512056k swap on /dev/hdc2.  Priority:-1 extents:1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hdd1
Ending clean XFS mount for filesystem: hdd1
XFS mounting filesystem hdc1
Ending clean XFS mount for filesystem: hdc1
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
hdb: DMA disabled
hda: Speed warnings UDMA 3/4/5 is not functional.
ide1: Speed warnings UDMA 3/4/5 is not functional.
ide1: Speed warnings UDMA 3/4/5 is not functional.
end_request: I/O error, dev hde, sector 0
hde: set_drive_speed_status: status=0xff { Busy }
end_request: I/O error, dev hde, sector 0
hde: set_drive_speed_status: status=0xff { Busy }
end_request: I/O error, dev hde, sector 0
end_request: I/O error, dev hdf, sector 0
hdf: set_drive_speed_status: status=0xff { Busy }
end_request: I/O error, dev hdf, sector 0
hdf: set_drive_speed_status: status=0xff { Busy }
end_request: I/O error, dev hdf, sector 0


