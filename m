Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271072AbTGPUBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271094AbTGPUBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:01:13 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:13070
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271072AbTGPUAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:00:11 -0400
Date: Wed, 16 Jul 2003 13:15:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030716201512.GA1821@matchmail.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716014650.GB2681@matchmail.com> <20030716023150.GA2302@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20030716023150.GA2302@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2003 at 07:31:50PM -0700, Greg KH wrote:
> On Tue, Jul 15, 2003 at 06:46:50PM -0700, Mike Fedyk wrote:
> > On Tue, Jul 15, 2003 at 06:37:43PM -0700, Greg KH wrote:
> > > On Tue, Jul 15, 2003 at 06:29:48PM -0700, Mike Fedyk wrote:
> > > > Here's a nice oops for you guys.
> > > > 
> > > > Hotplug is the trigger.  I can't reproduce without hotplug.
> > > > 
> > > > hotplug tries to load ohci, ehci, and finally uhci (the correct module), it
> > > > oopses for each driver with hotplug, but if I try without hotplug ('apt-get
> > > > remove hotplug' before rebooting), I can load all three usb drivers with no
> > > > oops.
> > > 
> > > If you just load these drivers by hand, does the oops happen?
> > > 
> > 
> > I didn't look into the hotplug scripts to see which hotplug modules (and
> > they are modules for me) were being loaded and in which order.
> 
> It should just do:
> 	modprobe -q ehci-hcd >/dev/null 2>&1
> 	modprobe -q ohci-hcd >/dev/null 2>&1
> 	modprobe -q uhci-hcd >/dev/null 2>&1
> 		    
> That's what the latest hotplug package has in it.  I don't know what
> Debian has lately...
> 
> > I did load the usb drivers by hand with no oops though.
> 
> That's really strange.
> 
> > > Can you enable debugging in the kobject code, or the driver base code to
> > > try to get some better debug messages of what is going on?
> > > 
> > 
> > Please tell me which file that's in, and what I need to change, or give a
> > patch.
> 
> Here's a patch that I always run with.  It is pretty verbose, but helps
> me out a lot in debugging and development.
> 
> Let us know if it shows anything interesting.
> 
Ok, I only see it when the system is booting, and after looking at the    
hotplug script in init.d there is different behaviour on boot, and on later   
invocations.                               
                               
I'm including dmesg output, and the hotplug script (hotplug has an exit at
the top so I can boot without uninstalling the package).
                               
What else can I do?
			       
Mike			       


















--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hotplug-oops-dmesg-2.6.0-test1-debug1.log"

rmodehelper returned -16
bus ide: add device 0.0
hdc: NEC CD-ROM DRIVE:28D, ATAPI CD/DVD-ROM drive
DEV: registering device: ID = 'ide1', name = IDE Controller
kobject ide1: registering. parent: 0000:00:07.1, set: devices
ide1 at 0x170-0x177,0x376 on irq 15
DEV: registering device: ID = '1.0', name = IDE Drive
kobject 1.0: registering. parent: ide1, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.1/ide1/1.0'
kset_hotplug: /sbin/hotplug ide HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=102
kset_hotplug - call_usermodehelper returned -16
bus ide: add device 1.0
PDC20269: IDE controller at PCI slot 0000:00:0e.0
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 10
    ide2: BM-DMA at 0x1010-0x1017, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1018-0x101f, BIOS settings: hdg:pio, hdh:pio
bus pci: add driver AEC62xx IDE
kobject AEC62xx IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver ALI15x3 IDE
kobject ALI15x3 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver AMD IDE
kobject AMD IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver CMD64x IDE
kobject CMD64x IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver SC1200 IDE
kobject SC1200 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver Cypress IDE
kobject Cypress IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver HPT34x IDE
kobject HPT34x IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver HPT366 IDE
kobject HPT366 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver NS87415IDE
kobject NS87415IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver Opti621 IDE
kobject Opti621 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver Promise Old IDE
kobject Promise Old IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver Promise IDE
kobject Promise IDE: registering. parent: <NULL>, set: drivers
bound device '0000:00:0e.0' to driver 'Promise IDE'
bus pci: add driver PIIX IDE
kobject PIIX IDE: registering. parent: <NULL>, set: drivers
bound device '0000:00:07.1' to driver 'PIIX IDE'
bus pci: add driver RZ1000 IDE
kobject RZ1000 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver Serverworks IDE
kobject Serverworks IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver SiI IDE
kobject SiI IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver SIS IDE
kobject SIS IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver SLC90e66 IDE
kobject SLC90e66 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver TRIFLEX IDE
kobject TRIFLEX IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver TRM290 IDE
kobject TRM290 IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver VIA IDE
kobject VIA IDE: registering. parent: <NULL>, set: drivers
bus pci: add driver PCI IDE
kobject PCI IDE: registering. parent: <NULL>, set: drivers
hda: max request size: 128KiB
hda: host protected area => 1
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(33)
kobject hda: registering. parent: <NULL>, set: block
kset_hotplug
fill_kobj_path: path = '/block/hda'
kset_hotplug: /sbin/hotplug block HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=103
kset_hotplug - call_usermodehelper returned -16
 hda: hda1 hda2
kobject hda1: registering. parent: hda, set: <NULL>
kset_hotplug
fill_kobj_path: path = '/block/hda/hda1'
kset_hotplug: /sbin/hotplug block HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=104
kset_hotplug - call_usermodehelper returned -16
kobject hda2: registering. parent: hda, set: <NULL>
kset_hotplug
fill_kobj_path: path = '/block/hda/hda2'
kset_hotplug: /sbin/hotplug block HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=105
kset_hotplug - call_usermodehelper returned -16
kobject queue: registering. parent: hda, set: <NULL>
kobject iosched: registering. parent: queue, set: <NULL>
bus ide: add driver ide-disk
kobject ide-disk: registering. parent: <NULL>, set: drivers
bus pci: add driver aic7xxx
kobject aic7xxx: registering. parent: <NULL>, set: drivers
bus scsi: add driver sd
kobject sd: registering. parent: <NULL>, set: drivers
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   768.000 MB/sec
   8regs_prefetch:   696.000 MB/sec
   32regs    :   520.000 MB/sec
   32regs_prefetch:   484.000 MB/sec
   pII_mmx   :  1108.000 MB/sec
   p5_mmx    :  1148.000 MB/sec
raid5: using function: p5_mmx (1148.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 1.0.6-ioctl (2002-10-15) initialised: dm@uk.sistina.com
NET4: Frame Diverter 0.46
kobject netlink: registering. parent: <NULL>, set: major
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kobject lapic_nmi: registering. parent: <NULL>, set: system
kobject lapic_nmi0: registering. parent: <NULL>, set: lapic_nmi
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
subsystem edd: registering
kobject edd: registering. parent: <NULL>, set: firmware
kobject int13_dev80: registering. parent: <NULL>, set: edd
kobject md0: registering. parent: <NULL>, set: block
kset_hotplug
fill_kobj_path: path = '/block/md0'
kset_hotplug: /sbin/hotplug block HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=106
kset_hotplug - call_usermodehelper returned -16
kobject queue: registering. parent: md0, set: <NULL>
kobject iosched: registering. parent: queue, set: <NULL>
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 364888k swap on /dev/hda2.  Priority:1 extents:1
subsystem usb: registering
kobject usb: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: usb, set: <NULL>
kobject drivers: registering. parent: usb, set: <NULL>
bus type 'usb' registered
device class 'usb_host': registering
subsystem usb_host: registering
kobject usb_host: registering. parent: <NULL>, set: class
kobject usb: registering. parent: <NULL>, set: major
device class 'usb': registering
subsystem usb: registering
kobject usb: registering. parent: <NULL>, set: class
bus usb: add driver usbfs
kobject usbfs: registering. parent: <NULL>, set: drivers
drivers/usb/core/usb.c: registered new driver usbfs
bus usb: add driver hub
kobject hub: registering. parent: <NULL>, set: drivers
drivers/usb/core/usb.c: registered new driver hub
bus usb: add driver usb
kobject usb: registering. parent: <NULL>, set: drivers
bus usb: add driver usbmouse
kobject usbmouse: registering. parent: <NULL>, set: drivers
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
bus pci: add driver uhci-hcd
kobject uhci-hcd: registering. parent: <NULL>, set: drivers
uhci-hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 0000:00:07.2: irq 9, io base 00001020
CLASS: registering class device: ID = 'usb1'
kobject usb1: registering. parent: usb_host, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/usb_host/usb1'
class_hotplug - name = usb1
kset_hotplug: /sbin/hotplug usb_host HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=107
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
DEV: registering device: ID = 'usb1', name = Intel Corp. 82371AB/EB/MB PIIX4  (Linux 2.6.0-tes
kobject usb1: registering. parent: 0000:00:07.2, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1'
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=108
bus usb: add device usb1
bound device 'usb1' to driver 'usb'
DEV: registering device: ID = '1-0:0', name = usb-0000:00:07.2-0 interface 0
kobject 1-0:0: registering. parent: usb1, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-0:0'
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=109
bus usb: add device 1-0:0
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
bound device '1-0:0' to driver 'hub'
bound device '0000:00:07.2' to driver 'uhci-hcd'
bus pci: add driver 3c59x
kobject 3c59x: registering. parent: <NULL>, set: drivers
PCI: Enabling device 0000:00:0d.0 (0114 -> 0117)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
divert: allocating divert_blk for eth0
CLASS: registering class device: ID = 'eth0'
kobject eth0: registering. parent: net, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/net/eth0'
class_hotplug - name = eth0
kset_hotplug: /sbin/hotplug net HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=110
kobject statistics: registering. parent: eth0, set: <NULL>
bound device '0000:00:0d.0' to driver '3c59x'
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
bus pci: add driver eepro100
kobject eepro100: registering. parent: <NULL>, set: drivers
Linux Tulip driver version 1.1.13 (May 11, 2002)
bus pci: add driver tulip
kobject tulip: registering. parent: <NULL>, set: drivers
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
8139too Fast Ethernet driver 0.9.26
bus pci: add driver 8139too
kobject 8139too: registering. parent: <NULL>, set: drivers
hub 1-0:0: new USB device on port 2, assigned address 2
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
bus pci: add driver pcnet32
kobject pcnet32: registering. parent: <NULL>, set: drivers
DEV: registering device: ID = '1-2', name = USB Mouse (Logitech)
kobject 1-2: registering. parent: usb1, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-2'
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=111
bus usb: add device 1-2
bound device '1-2' to driver 'usb'
DEV: registering device: ID = '1-2:0', name = usb-0000:00:07.2-2 interface 0
kobject 1-2:0: registering. parent: 1-2, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:0'
kset_hotplug: /sbin/hotplug usb HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=112
bus usb: add device 1-2:0
subsystem ide-scsi: registering
kobject ide-scsi: registering. parent: <NULL>, set: bus
kobject devices: registering. parent: ide-scsi, set: <NULL>
kobject drivers: registering. parent: ide-scsi, set: <NULL>
bus type 'ide-scsi' registered
DEV: registering device: ID = 'ide-scsi', name = Ide-scsi Parent
kobject ide-scsi: registering. parent: <NULL>, set: devices
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
DEV: registering device: ID = 'host0', name = ide-scsi
kobject host0: registering. parent: ide-scsi, set: devices
CLASS: registering class device: ID = 'host0'
kobject host0: registering. parent: scsi_host, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/scsi_host/host0'
class_hotplug - name = host0
kset_hotplug: /sbin/hotplug scsi_host HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=113
input: Logitech USB Mouse on usb-0000:00:07.2-2
bound device '1-2:0' to driver 'usbmouse'
  Vendor: NEC       Model: CD-ROM DRIVE:28D  Rev: 3.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:0:0', name = SCSI CD-ROM
kobject 0:0:0:0: registering. parent: host0, set: devices
kset_hotplug
fill_kobj_path: path = '/devices/ide-scsi/host0/0:0:0:0'
kset_hotplug: /sbin/hotplug scsi HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=114
bus scsi: add device 0:0:0:0
CLASS: registering class device: ID = '0:0:0:0'
kobject 0:0:0:0: registering. parent: scsi_device, set: class_obj
kset_hotplug
fill_kobj_path: path = '/class/scsi_device/0:0:0:0'
class_hotplug - name = 0:0:0:0
kset_hotplug: /sbin/hotplug scsi_device HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add SEQNUM=115
bus ide: add driver ide-scsi
kobject ide-scsi: registering. parent: <NULL>, set: drivers
bus usb: add driver hiddev
kobject hiddev: registering. parent: <NULL>, set: drivers
drivers/usb/core/usb.c: registered new driver hiddev
bus usb: add driver hid
kobject hid: registering. parent: <NULL>, set: drivers
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 262136k swap on /usr/swap_file.  Priority:2 extents:38
bus pci: add driver ehci_hcd
kobject ehci_hcd: registering. parent: <NULL>, set: drivers
Unable to handle kernel paging request at virtual address d493885c
 printing eip:
c01d3cb7
*pde = 040ce067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01d3cb7>]    Not tainted
EFLAGS: 00010292
EIP is at kobject_add+0xa3/0x124
eax: c03d2980   ebx: d49550c4   ecx: d493885c   edx: d49550dc
esi: c03d2988   edi: c03d2924   ebp: d3ae3f28   esp: d3ae3f1c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 209, threadinfo=d3ae2000 task=d39612e0)
Stack: d49550c4 d49550c4 00000000 d3ae3f40 c01d3d50 d49550c4 d49550c4 d49550c4 
       c03d2920 d3ae3f70 c0238f2e d49550c4 d49550c4 d4953a8a 00000014 c036001c 
       c0341452 d4953a8a d4955080 00000000 d4955120 d3ae3f7c c023931a d49550a8 
Call Trace:
 [<c01d3d50>] kobject_register+0x18/0x48
 [<c0238f2e>] bus_add_driver+0x52/0xa0
 [<c023931a>] driver_register+0x36/0x3c
 [<c01d9cc0>] pci_register_driver+0x74/0x9c
 [<d48e401e>] init+0x1e/0x4c [ehci_hcd]
 [<c01381c8>] sys_init_module+0x118/0x240
 [<c0109af7>] syscall_call+0x7/0xb

Code: 89 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 
 <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
bus pci: add driver ohci-hcd
kobject ohci-hcd: registering. parent: <NULL>, set: drivers
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : SAK
SAK: killed process 13 (init): p->session==tty->session
SAK: killed process 14 (rcS): p->session==tty->session
SAK: killed process 205 (S36hotplug): p->session==tty->session
SAK: killed process 207 (usb.rc): p->session==tty->session
SAK: killed process 210 (modprobe): p->session==tty->session
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hotplug

#!/bin/sh

exit
#
# chkconfig:	2345 01 99
# description:	Starts and stops each hotpluggable subsystem.
#		On startup, may simulate hotplug events for devices
#		that were present at boot time, before filesystems
#		used by /sbin/hotplug became available.
#
# $Id: hotplug.init,v 1.3 2002/01/17 12:39:01 ukai Exp $
#
PATH=/sbin:/bin:/usr/sbin:/usr/bin
test -x /sbin/hotplug || exit 0

case "$1" in
start)
    echo -n "Starting hotplug subsystem:"
    if [ "$runlevel" = "S" ]; then
	touch /etc/nohotplug
    elif grep -q "^/sbin/hotplug$" /proc/sys/kernel/hotplug; then
	# but, pending hotplug action will be executed
	rm -f /etc/nohotplug
	echo ".... already started. process pending events."
	exit 0
    fi
    echo /sbin/hotplug > /proc/sys/kernel/hotplug
    if [ "$runlevel" != "S" ]; then
	rm -f /etc/nohotplug
	# XXX: need wait?
    fi
    for RC in /etc/hotplug/*.rc
    do
        basename=${RC#/etc/hotplug/}
        name=${basename%.rc}
	echo -n " $name"
	$RC $1
    done
    echo "."
    # touch /var/lock/subsys/hotplug
    ;;
stop)
    echo -n "Stopping hotplug subsystem:"
    for RC in /etc/hotplug/*.rc
    do
        basename=${RC#/etc/hotplug/}
        name=${basename%.rc}
	echo -n " $name"
       $RC stop
    done
    echo /bin/true > /proc/sys/kernel/hotplug
    echo "."
    # rm -f /var/lock/subsys/hotplug
    ;;
restart)
    echo -n "Restarting hotplug subsystem:"
    for RC in /etc/hotplug/*.rc
    do
        basename=${RC#/etc/hotplug/}
        name=${basename%.rc}
	echo -n " $name"
	$RC restart
    done
    echo "."
    ;;
force-reload)
    $0 stop && $0 start
    ;;
status)
    for RC in /etc/hotplug/*.rc
    do
	$RC $1
    done
    ;;
help|*)
    echo "Usage: $0 [help|start|stop|restart|status|force-reload]"
    exit 1
    ;;
esac
exit 0

--G4iJoqBmSsgzjUCe--
