Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUH3HBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUH3HBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUH3HBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:01:15 -0400
Received: from main.gmane.org ([80.91.224.249]:8341 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266703AbUH3G7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:59:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
 IDE bus)
Date: Mon, 30 Aug 2004 09:01:41 +0200
Message-ID: <cguj7n$gur$1@sea.gmane.org>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com> <20040830010712.GC12313@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070408000903090607040203"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508ea078.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
In-Reply-To: <20040830010712.GC12313@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070408000903090607040203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> Indeed this is a typo but has been fixed on 2.4.26:
> 
>         if (drive->removable && id != NULL) {
It never gets past this check because drive->removable is not set!

>                 if (id->config == 0x848a) return 1;     /* CompactFlash */
>                 if (!strncmp(id->model, "KODAK ATA_FLASH", 15)  /* Kodak */
>                  || !strncmp(id->model, "Hitachi CV", 10)       /* Hitachi */
>                  || !strncmp(id->model, "SunDisk SDCFB", 13)    /* old SanDisk */
>                  || !strncmp(id->model, "SanDisk SDCFB", 13)    /* SanDisk */
>                  || !strncmp(id->model, "HAGIWARA HPC", 12)     /* Hagiwara */
>                  || !strncmp(id->model, "LEXAR ATA_FLASH", 15)  /* Lexar */
>                  || !strncmp(id->model, "ATA_FLASH", 9))        /* Simple Tech */
>                 {
> 
> I haven't got much of a clue about IDE, but I can see the newer card supports
> DMA, and the older doesnt, but you are probably not using DMA on that? whats
> the output of "hdparm /dev/hda".
Ive attached the hdparm output, which is exactly the same for both cards.

> 
> Also can you show us dmesg from both old and new cards.
> 
I've noticed another interesting thing, when doing the same stuff which 
bails out on the new card (reading or writing larger amounts of data), 
sometimes with the old card a kernel message "VFS: Disk change detected 
on device 03:00" appears in the logfiles, which doesnt appear with the 
new card.

Also attached are the both dmesg outputs from booting up and the 
occurence of the error, respectively the disk change event. This logs 
are from an Adeos/Rtai patched kernel, but the exact same problem 
appears when booting with a stock 2.4.27 kernel to.


--------------070408000903090607040203
Content-Type: text/plain;
 name="hdparm_output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm_output"


/dev/ide/host0/bus0/target1/lun0/disc:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 980/8/32, sectors = 250880, start = 0

--------------070408000903090607040203
Content-Type: text/plain;
 name="dmesg_functioning"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_functioning"

d upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=0x378
vesafb: framebuffer at 0xe5000000, mapped to 0xc8806000, size 1875k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:9570
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10f
Non-volatile memory driver v1.2
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xc89dc000, 00:60:e0:03:2b:3f, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth1: RealTek RTL8139 at 0xc89de000, 00:60:e0:03:2b:3e, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: SanDisk SDCFB-128, CFA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus0/target0/lun0: p1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
hub.c: new USB device 00:07.2-2, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
Adeos: Domain RTAI registered.
RTAI 3.0r4 mounted over Adeos 2.4r14/x86.
hub.c: new USB device 00:07.2-2.4, assigned address 3


==== RT memory manager v1.3 Loaded. ====


***** STARTING THE UP REAL TIME SCHEDULER WITH LINUX *****
***** FP SUPPORT AND READY FOR A PERIODIC TIMER *****
***<> LINUX TICK AT 100 (HZ) <>***
***<> CALIBRATED CPU FREQUENCY 800034000 (HZ) <>***
***<> CALIBRATED TIMER-INTERRUPT-TO-SCHEDULER LATENCY 2689 (ns) <>***
***<> CALIBRATED ONE SHOT SETUP TIME 2009 (ns) <>***
***<> COMPILER: gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)***

RTAI libm init
Io Memory at 0xc7d10020Found CIF50
Dualport length=8192 
Setting CIF IRQ State
Devflags 0x20 Hostflags 0xe0
reseting CIF50
Devflags 0xa0 Hostflags 0xe0
reset command accepted
Initialising Controller
Size of a progstep is 56
Size of visu_dpram is 2145
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
: USB HID v1.10 Device [American Power Conversion Back-UPS RS 500 FW:30.j4.I USB FW:j4] on usb1:3.0
Cif50 Reseted
Hilscher Firmware Name:CANopen CIF50CAN
Hilscher Firmware Version:V01.072 22.01.04
Downloading Bus parameters
Start Sequence acced error=0
Amount data transferred in msg 42 of 42 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 150 of 150 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 67 of 67 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 76 of 76 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 83 of 83 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 94 of 94 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
Start Sequence acced error=0
Amount data transferred in msg 42 of 42 
message receiver 16	 sender 3 	nr 25 	command 0 	error 0 answer 68
Download command acced error=0
message receiver 16	 sender 3 	nr 26 	command 0 	error 0 answer 69
End download sequence acced error=0
writing master conf with ln=45
network started
message receiver 16	 sender 3 	nr 23 	command 0 	error 0 answer 68
Download command acced error=0
writing master conf with ln=11
network started
message receiver 16	 sender 3 	nr 23 	command 0 	error 0 answer 68
Download command acced error=0
Inputs at 0xc7d10020 ouputs at 0xc7d10e20
**************
EL/Plasma Control Version 0.0.1 started
**************
Reset Elplasma
Command received id=10
Using new parameters  Oeffnungstemp is 280  kp_druck is 39/1000
Command received id=7
Command received id=9
Set cooling option to 0
VFS: Disk change detected on device 03:00
 /dev/ide/host0/bus0/target0/lun0: p1
VFS: Disk change detected on device 03:00
 /dev/ide/host0/bus0/target0/lun0: p1

--------------070408000903090607040203
Content-Type: text/plain;
 name="dmesg_non_functioning"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_non_functioning"

Linux version 2.4.27-adeos (root@EltroLinux35) (gcc-Version 3.3.4 (Debian 1:3.3.4-6sarge1)) #32 Mo Aug 30 08:58:44 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
ACPI: Unable to locate RSDP
Kernel command line: vga=0x314 root=/dev/nfs rw nfsroot=1.1.1.35:/nfs_root/ver1 ip=dhcp devfs=nomount BOOT_IMAGE=vmlinuz auto
No local APIC present or hardware disabled
Initializing CPU#0
Adeos 2.4r14/x86: Root domain Linux registered.
Detected 800.031 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1599.07 BogoMIPS
Memory: 126408k/131072k available (1673k kernel code, 4280k reserved, 607k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU:     After generic, caps: 00803135 80803035 00000000 00000000
CPU:             Common caps: 00803135 80803035 00000000 00000000
CPU: Centaur VIA Samuel 2 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Adeos: Pipelining started.
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfb510, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport_pc: Via 686A parallel port disabled in BIOS
vesafb: framebuffer at 0xe4000000, mapped to 0xc8800000, size 1875k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:9570
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
kmod: failed to exec /sbin/modprobe -s -k parport_lowlevel, errno = 2
lp: driver loaded but no devices found
Real Time Clock Driver v1.10f
Non-volatile memory driver v1.2
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 00:0b.0
eth0: RealTek RTL8139 at 0xc89d6000, 00:60:e0:81:5b:14, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Found IRQ 11 for device 00:0c.0
eth1: RealTek RTL8139 at 0xc89d8000, 00:60:e0:81:5b:13, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hdb: C/H/S=0/0/0 from BIOS ignored
hdb: SanDisk SDCFB-128, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: attached ide-disk driver.
hdb: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32
Partition check:
 /dev/ide/host0/bus0/target1/lun0: p1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 12 for device 00:07.2
host/uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: link down
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 1.1.1.25, my address is 1.1.1.179
IP-Config: Complete:
      device=eth0, addr=1.1.1.179, mask=255.255.255.0, gw=255.255.255.255,
     host=1.1.1.179, domain=eltropuls, nis-domain=(none),
     bootserver=1.1.1.25, rootserver=1.1.1.35, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 1.1.1.35
Looking up port of RPC 100005/1 on 1.1.1.35
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 132k freed
Adeos: Domain RTAI registered.
RTAI 3.0r4 mounted over Adeos 2.4r14/x86.


==== RT memory manager v1.3 Loaded. ====


***** STARTING THE UP REAL TIME SCHEDULER WITH LINUX *****
***** FP SUPPORT AND READY FOR A PERIODIC TIMER *****
***<> LINUX TICK AT 100 (HZ) <>***
***<> CALIBRATED CPU FREQUENCY 800031000 (HZ) <>***
***<> CALIBRATED TIMER-INTERRUPT-TO-SCHEDULER LATENCY 2689 (ns) <>***
***<> CALIBRATED ONE SHOT SETUP TIME 2009 (ns) <>***
***<> COMPILER: gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)***

RTAI libm init
eth1: link down
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: drive not ready for command
hdb: irq timeout: status=0xd0 { Busy }

ide0: reset: master: error (0x0a?)

--------------070408000903090607040203--

