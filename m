Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSJLR77>; Sat, 12 Oct 2002 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSJLR77>; Sat, 12 Oct 2002 13:59:59 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:42251 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S261316AbSJLR7s> convert rfc822-to-8bit;
	Sat, 12 Oct 2002 13:59:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Thomas Molina <tmolina@cox.net>
Subject: Re: How does ide-scsi get loaded?
Date: Sat, 12 Oct 2002 19:06:00 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210121122220.4532-100000@dad.molina>
In-Reply-To: <Pine.LNX.4.44.0210121122220.4532-100000@dad.molina>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121906.05675.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 October 2002 5:24 pm, Thomas Molina wrote:
> On Sat, 12 Oct 2002, Alan Chandler wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Saturday 12 October 2002 3:39 pm, Michael Abshoff wrote:
> > > Alan Chandler wrote:
> > > >No - its not in there - as I said grep -r of /etc did not show
> > > > anything
> > >
> > >If you are using lilo to boot look for a block like the following:
> >  > image = /boot/vmlinuz
> >  > label = linux
> >  > root = /dev/hda7
> >  >
> >   >append = "enableapic hdd=ide-scsi"
> >
> > so isn't /etc/lilo.conf in /etc.
> >
> > I keep saying - the string ide-scsi is not used anywhere in /etc
>
> Can you send your .config file for the kernel you are running, the dmesg
> output at boot, and your bootloader configuration file (either
> /etc/lilo.conf, or /boot/grub/grub.conf, commonly) for examination?  Maybe
> something will become apparent when the output is examined.

[See below, but it looks to me as though debian is running /sbin/discover at 
about the point in boot sequence where the module gets loaded (this is also 
confirmed by the log I created by wrapping modprobe with a shell script to 
write its parameters out :-.
...
modprobe called: aic7xxx
modprobe called: -l -t boot
modprobe called: -s -k -- vfat
modprobe called: -s -k -- nls_cp437
modprobe called: -s -k -- char-major-6
modprobe called: -l 3c59x.o
modprobe called: 3c59x
modprobe called: -l aic7xxx.o
modprobe called: aic7xxx
modprobe called: -l emu10k1.o
modprobe called: emu10k1
modprobe called: -l ide-scsi.o
modprobe called: ide-scsi
modprobe called: -l parport_pc.o
....)

This being the case, I will take the whole query back to the debian-user list 
as its a bit off topic for here.]


Due to a disaster on a debian kernel update - I am temporarily back to the 
2.4.18-K7 kernel - (the "old" configuration in lilo.conf) but its still the 
same problem .  I am including what is asked for.


================================== .config
Due to size and the fact that it is the STANDARD DEBIAN CONFIG - I have only 
posted a small amount - but enough to see that its mainly modules and 
CONFIG_BLK_DEV_IDESCSI=m is there

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m

=======================================/etc/lilo.conf
# /etc/lilo.conf - See: `lilo(8)' and `lilo.conf(5)',
# ---------------       `install-mbr(8)', `/usr/share/doc/lilo/',
#                       and `/usr/share/doc/mbr/'.

# +---------------------------------------------------------------+
# |                        !! Reminder !!                         |
# |                                                               |
# | Don't forget to run `lilo' after you make changes to this     |
# | conffile, `/boot/bootmess.txt', or install a new kernel.  The |
# | computer will most likely fail to boot if a kernel-image      |
# | post-install script or you don't remember to run `lilo'.      |
# |                                                               |
# +---------------------------------------------------------------+

# Support LBA for large hard disks.
#
lba32

# Overrides the default mapping between harddisk names and the BIOS'
# harddisk order. Use with caution.
#disk=/dev/hde
#    bios=0x81

#disk=/dev/sda
#    bios=0x80

# Specifies the boot device.  This is where Lilo installs its boot
# block.  It can be either a partition, or the raw device, in which
# case it installs in the MBR, and will overwrite the current MBR.
#
boot=/dev/hda

# Specifies the device that should be mounted as root. (`/')
#
root=/dev/hda3

# Enable map compaction:
# Tries to merge read requests for adjacent sectors into a single
# read request. This drastically reduces load time and keeps the
# map smaller.  Using `compact' is especially recommended when
# booting from a floppy disk.  It is disabled here by default
# because it doesn't always work.
#
# compact

# Installs the specified file as the new boot sector
# You have the choice between: bmp, compat, menu and text
# Look in /boot/ and in lilo.conf(5) manpage for details
#
install=/boot/boot-menu.b

# Specifies the location of the map file
#
map=/boot/map

# You can set a password here, and uncomment the `restricted' lines
# in the image definitions below to make it so that a password must
# be typed to boot anything but a default configuration.  If a
# command line is given, other than one specified by an `append'
# statement in `lilo.conf', the password will be required, but a
# standard default boot will not require one.
#
# This will, for instance, prevent anyone with access to the
# console from booting with something like `Linux init=/bin/sh',
# and thus becoming `root' without proper authorization.
#
# Note that if you really need this type of security, you will
# likely also want to use `install-mbr' to reconfigure the MBR
# program, as well as set up your BIOS to disallow booting from
# removable disk or CD-ROM, then put a password on getting into the
# BIOS configuration as well.  Please RTFM `install-mbr(8)'.
#
# password=tatercounter2000

# Specifies the number of deciseconds (0.1 seconds) LILO should
# wait before booting the first image.
#
delay=20

# You can put a customized boot message up if you like.  If you use
# `prompt', and this computer may need to reboot unattended, you
# must specify a `timeout', or it will sit there forever waiting
# for a keypress.  `single-key' goes with the `alias' lines in the
# `image' configurations below.  eg: You can press `1' to boot
# `Linux', `2' to boot `LinuxOLD', if you uncomment the `alias'.
#
# message=/boot/bootmess.txt
prompt
timeout=50
#	prompt
#	single-key
#	delay=100
#	timeout=100

# Specifies the VGA text mode at boot time. (normal, extended, ask, <mode>)
#
# vga=ask
# vga=9
#
vga=normal

# Kernel command line options that apply to all installed images go
# here.  See: The `boot-prompt-HOWO' and `kernel-parameters.txt' in
# the Linux kernel `Documentation' directory.
#
# append=""

# Boot up Linux by default.
#
default=Linux

image=/vmlinuz
	label=Linux
	initrd=/initrd.img
	read-only
#	restricted
#	alias=1
image=/vmlinuz
	label=single
	initrd=/initrd.img
	read-only
	append=single
#	restricted
#	alias=1


image=/vmlinuz.old
	initrd=/initrd.img.old
	label=old
	read-only
	optional
#	restricted
#	alias=2

# If you have another OS on this machine to boot, you can uncomment the
# following lines, changing the device name on the `other' line to
# where your other OS' partition is.
#
# other=/dev/hda4
#	label=HURD
#	restricted
#	alias=3
other=/dev/hda1
  label="Windows"
===================================== dmesg
The crux lines seem to be (there is no reference to ide-scsi in the log per 
seem, but this is my IDE device).  Judging by its position in the log it 
could well be /sbin/discover being used to load the module.

scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-104   Rev: 2.02
  Type:   CD-ROM                             ANSI SCSI revision: 02





Linux version 2.4.18-k7 (herbert@gondolin) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 Sun Apr 14 13:19:11 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=old ro root=303
Initializing CPU#0
Detected 900.068 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 124416k/131008k available (847k kernel code, 6204k reserved, 236k 
data, 212k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 900.0485 MHz.
..... host bus clock speed is 200.0107 MHz.
cpu: 0, clocks: 2000107, slice: 1000053
CPU0<T0:2000096,T1:1000032,D:11,S:1000053,C:2000107>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2584 blocks [1 disk] into ram disk... 
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
Freeing initrd memory: 2584k freed
VFS: Mounted root (cramfs filesystem).
Journalled Block Device driver loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-305020, ATA DISK drive
hdc: IBM-DTTA-351680, ATA DISK drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40188960 sectors (20577 MB) w/380KiB Cache, CHS=39870/16/63
hdc: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=32760/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [2501/255/63] p1 p2 p3
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [2055/255/63] p1 p2
cramfs: wrong magic
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
change_root: old root has d_count=2
Freeing unused kernel memory: 212k freed
spurious 8259A interrupt: IRQ7.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1951856k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
Real Time Clock Driver v1.10e
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:07.3
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3cSOHO100-TX Hurricane at 0xdc00. Vers LK1.1.16
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
plip: parport0 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x378, not using IRQ.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP BSD Compression module registered
PPP Deflate Compression module registered
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Creative EMU10K1 PCI Audio Driver, version 0.18, 13:41:40 Apr 14 2002
PCI: Found IRQ 11 for device 00:0f.0
PCI: Sharing IRQ 11 with 00:0d.0
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xe400-0xe41f, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
PCI: Sharing IRQ 11 with 00:0f.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: TEAC      Model: CD-R55S           Rev: 1.0J
  Type:   CD-ROM                             ANSI SCSI revision: 02
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lp0: using parport0 (polling).
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-104   Rev: 2.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 13:42:01 Apr 14 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 10 for device 00:07.2
PCI: Sharing IRQ 10 with 00:07.3
PCI: Sharing IRQ 10 with 00:0b.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:07.3
PCI: Sharing IRQ 10 with 00:07.2
PCI: Sharing IRQ 10 with 00:0b.0
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: USB hub found
hub.c: 4 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
hub.c: USB new device connect on bus1/2/3, assigned device number 3
usb_control/bulk_msg: timeout
input0: USB HID v1.00 Joystick [Logitech Inc. Logitech Inc.] on usb1:3.0
hub.c: USB new device connect on bus1/2/4, assigned device number 4
usb.c: USB device 4 (vend/prod 0x4e6/0x313) is not claimed by any active 
driver.



- -- 
Alan Chandler
alan@chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qGSNuFHxcV2FFoIRArTaAJ9Mdu/bgbjLhT0DITLQPNGWAPkT2QCeKBLj
WY9G1Oziew73/IH0+w+T0VQ=
=5k5N
-----END PGP SIGNATURE-----

