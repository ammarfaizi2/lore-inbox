Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSLON05>; Sun, 15 Dec 2002 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSLON05>; Sun, 15 Dec 2002 08:26:57 -0500
Received: from oe36.law11.hotmail.com ([64.4.16.93]:61200 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261302AbSLON0x>;
	Sun, 15 Dec 2002 08:26:53 -0500
X-Originating-IP: [66.108.18.44]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <3DFC50E9.656B96D0@cinet.co.jp> <3DFC7C17.906E3211@cinet.co.jp>
Subject: Problems with OnStream USB30 Tape drive on the USB ports on a FIC VA-503+ - VIA MVP3 Chipset
Date: Sun, 15 Dec 2002 08:32:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE36ErsoLZdagtbggcc0000e004@hotmail.com>
X-OriginalArrivalTime: 15 Dec 2002 13:34:42.0535 (UTC) FILETIME=[B9686770:01C2A43E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I am trying to use an On-Stream USB30 Tape drive on a Linux system which
I have running on a FIC VA-503+ motherboard that uses the VIA MVP3 chipset.
I am using the standard Linux kernel 2.4.20.  And loaded the drivers
usb-uhci, usb-storage, and osst to access the tape drive.  The tape drive
has its latest firmware version.  Please not that I also tried the alternate
USB driver uhci, which dies even quicker, consistently.  The problem is that
a very short while after I start a backup to the tape (variable length of
time) the backup procedure crashes.  The following error message appears to
be called every time the procedure crashes.

"
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 10
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 10
"

    The entire dmesg has been pasted below, each of the resets appears to
cause the tape drive to be lost and then reinstalled causing a write error
to the process writing to the tape.  The problem seams like it might also be
time dependant.  Before the last tries I made today I was following the
README.osst which strongly suggested using 23k blocks when writing to the
tape so all my tar commands had the -b64 option.  Mysteriously I tried tar
without the -b64 option and the backup proceeded for a significantly longer
amount of time before succumbing to the problem.  I noticed a similar
pattern of behavior in the use of dd commands (dd bs=a_block_size
if=really_big_file of=/dev/osst0).  Smaller block sizes seam to keep the
tape drive working for a longer period of time before dying.  I also tried
telling tar to compress data before writing to the tape with the -z option
which also caused the tape drive to last longer.

    Note: Tape drive seamed to work on another system where I tried it on
with a later VIA chipset, the SMP VIA P3 chipset.  I did a huge backup which
did also die, though at this time I'm not sure if its the same problem.  The
dmesg error messages where different and I may have backed up more data that
the space available on the tape.  The tape drive did last a really long time
though.

    I am willing to help debug the problem.  Can anyone help me?  Thank you.

-------------------------------------------------------------------


Linux version 2.4.20 (root@Miyu) (gcc version 2.95.3 20010315 (release)) #4
Wed Dec 11 17:29:58 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff0800 (ACPI NVS)
 BIOS-e820: 0000000007ff0800 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 451.034 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 127612k/131008k available (934k kernel code, 3008k reserved, 379k
data, 64k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 512 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD102BA, ATA DISK drive
hdc: CREATIVEDVD8400E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0283aa4, I/O limit 4095Mb (mask 0xffffffff)
hda: 20028960 sectors (10255 MB) w/1961KiB Cache, CHS=1246/255/63, UDMA(33)
Partition check:
 hda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not
a dynamic disk.
 hda1 hda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 530104k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Real Time Clock Driver v1.10e
PCI: Assigned IRQ 5 for device 00:08.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:08.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb800. Vers LK1.1.16
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:41:15 Dec 11 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Assigned IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:07.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x7ab/0xfc01) is not claimed by any active
driver.
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: OnStream  Model: USB30             Rev: 1.09
  Type:   Sequential-Access                  ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
osst :I: Tape driver with OnStream support version 0.9.10
osst :I: $Id: osst.c,v 1.65 2001/11/11 20:38:56 riede Exp $
osst :I: Attached OnStream USB30 tape at scsi0, channel 0, id 0, lun 0 as
osst0
usb-uhci.c: interrupt, status 30, frame# 1939
usb-uhci.c: Host controller halted, trying to restart.
usb-uhci.c: interrupt, status 2, frame# 1927
freecom reset called
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 2
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
osst0:I: This warning may be caused by your scsi controller,
osst0:I: it has been reported with some Buslogic cards.
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
usb-uhci.c: interrupt, status 2, frame# 1403
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
freecom reset called
freecom reset called
freecom reset called
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 3
freecom reset called
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 4
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
usb-uhci.c: interrupt, status 2, frame# 508
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 4
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 5
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
usb-uhci.c: interrupt, status 2, frame# 945
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
freecom reset called
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 5
freecom reset called
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 6
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 6
usb-uhci.c: interrupt, status 2, frame# 146
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 6
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 7
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 7
usb-uhci.c: interrupt, status 2, frame# 520
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
freecom reset called
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 7
freecom reset called
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 8
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 8
usb-uhci.c: interrupt, status 2, frame# 1808
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 8
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 9
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 9
usb-uhci.c: interrupt, status 2, frame# 1821
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 00:07.2-2 address 9
freecom reset called
osst0:W: Warning 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
osst0:W: Command with sense data: Info fld=0xa00 (nonstd), Current
osst:ce:00: sns = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x0a 0x00 0x00
hub.c: new USB device 00:07.2-2, assigned address 10
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 10
