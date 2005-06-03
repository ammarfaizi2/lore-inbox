Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVFCUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVFCUGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFCUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 16:06:07 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:36227
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S261414AbVFCUFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 16:05:38 -0400
Message-ID: <20050603200532.20970.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Greg KH <greg@kroah.com>
cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: OHCI driver have problems with USB 2.0 memory devices 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Fri, 03 Jun 2005 11:14:54 PDT." <20050603181454.GA5722@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Jun 2005 23:05:32 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 03, 2005 at 08:27:01PM +0300, Dag Nygren wrote:
> > 
> > Hi,
> > 
> > just installed 2.6.11.11 on a single board computer using
> > a SGS Thomson integrated USB controller and found that
> > inserting a USB 2.0 stick generated a "IRQ INTR_SF lossage"
> > message and further lockup of the driver. Ie. a cat of 
> > /proc/bus/usb/devices will freeze the cat process.
> 
> Does 2.6.12-rc5 have this same problem?

OK,

tested now.
And sadly 2.6.12-rc5 does have the same problem. Still generates
a "IRQ INTR_SF lossage". I managed to capture a log of what is
going on this time:

Linux version 2.6.12-rc5 (root@dag) (gcc version 3.4.3) #1 Fri Jun 3 22:48:31 
EEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000001c00000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
28MB LOWMEM available.
On node 0 totalpages: 7168
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 3072 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Allocating PCI resources starting at 01c00000 (gap: 01c00000:fe3f0000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux root=100 psmouse.proto=imps 
splash=silent
Initializing CPU#0
PID hash table entries: 128 (order: 7, 2048 bytes)
Using pit for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 21296k/28672k available (1601k kernel code, 6940k reserved, 706k data, 
124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 49.40 BogoMIPS (lpj=24704)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After all inits, caps: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: 486
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like 
an initrd
Freeing initrd memory: 4096k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1b0, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0d.0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe000, 00:05:8a:00:f7:e7, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
hdd: Hitachi XX.V.3.4.0.0, CFA DISK drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide1 at 0x170-0x177,0x376 on irq 15
hdd: max request size: 128KiB
hdd: 250368 sectors (128 MB) w/1KiB Cache, CHS=978/8/32
hdd: cache flushes not supported
 hdd: hdd1
usbmon: debugs is not available
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0e.0: PCI device 104a:0230 (STMicroelectronics)
ohci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0e.0: irq 10, io mem 0xe0000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096KiB [1 disk] into ram disk... 
|/-\|/-\|/-\|/-\|/-\|<6>usb 1-2: new full speed USB 
device using ohci_hcd and address 2
/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|
/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done
.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k freed
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
 hdd: hdd1
  Vendor: Generic   Model: USB Flash Disk    Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
sda: Unit Not Ready, sense:
: Current: sense key=0x6
    ASC=0x28 ASCQ=0x0
usb 1-2: USB disconnect, address 2
ohci_hcd 0000:00:0e.0: IRQ INTR_SF lossage
sda : READ CAPACITY failed.
sda : status=0, message=00, host=1, driver=00 
sda : sense not available. 
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=1, driver=00 
sda : sense not available. 
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=1, driver=00 
sda : sense not available. 
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sda, logical block 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb-storage: device scan complete
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended


After this /dev/sda is not recognized any more. Didn't try the "cat 
/proc/bus/usb/devices"
though.

Thanks for the  advice so far.

Dag


