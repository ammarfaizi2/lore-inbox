Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTFFQzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTFFQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:55:47 -0400
Received: from web11304.mail.yahoo.com ([216.136.131.207]:48909 "HELO
	web11304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262066AbTFFQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:55:05 -0400
Message-ID: <20030606170839.96306.qmail@web11304.mail.yahoo.com>
Date: Fri, 6 Jun 2003 10:08:39 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: PCI bridge or IDE problem: Toshiba docking station
To: linux-kernel@vger.kernel.org
Cc: mike@w3z.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to help Mike sort out his problems with his toshiba
Portege 3480CT laptop and docking station.  The docking station seems
to be a PCI bridge with a toshiba IDE controller and some other stuff
on it.  The redhat 9 installer sees the CDROM on the docking station,
but the actual kernel that gets installed doesn't seem to see it.  I am
wondering if this is a PCI bridging issue or an IDE issue.  Some of the
redhat kernels from redhat 8 worked, othered didn't.  none of the ones
he's tried so far for redhat 9 seem to work.  the relevant dmesg and
lspci are below.  the IDE driver does not seem to see the toshiba
controller on the docking station.

Thanks,

Alex

PS.  please cc us as we're not on the list.

--- Mike Collins <mike@w3z.com> wrote:
> To: linux-on-portege@yahoogroups.com
> From: Mike Collins <mike@w3z.com>
> Date: Fri, 06 Jun 2003 10:03:49 -0400
> Subject: Re: [linux-on-portege] Digest Number 668
> 
> At 06:36 AM 6/6/2003 -0700, you wrote:
> > > Still trying to get cdrom working with Portege 3480CT.
> 
> As a reminder, I installed from the multi media cd/dvd drive, but the
> cd is 
> no longer detected after install.
> 
> 
> My hardware was recognized in rh8 depending on the kernel. Don't
> remember 
> the actual number but the last rh8 kernel before upgrading to rh9
> didn't 
> work. Backing off to the previously installed kernel did detect the
> cd. The 
> initial kernel installed from rh9 does not detect the cd, an upgraded
> 
> kernel installed yesterday (2.4.20-18.9) does not detect the cd.
> 
> >find out what
> >device (/dev/hd?) the cdrom is, see what 'hdparm -i /dev/hd?' (? =
> the
> >device letter)
> 
> cd is not detected. It should be /dev/hdc - I get "No such device"
> 
> 

lspci:

00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
00:00.1 Multimedia audio controller: Intel Corp. 82440MX AC'97 Audio
Controller
00:02.0 Communication controller: Lucent Microelectronics 56k WinModem
(rev 01)
00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev
11)
00:06.0 PCI bridge: Toshiba America Info Systems: Unknown device 061b
(rev 03)
00:07.0 Bridge: Intel Corp. 82440MX ISA Bridge (rev 01)
00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller
00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host
Controller
00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
01:03.0 IDE interface: Toshiba America Info Systems: Unknown device
0105 (rev 01)
01:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
01:05.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 41)


lsmod:

Module                  Size  Used by    Not tainted
sd_mod                 13516   0  (autoclean)
i810_audio             27624   0  (autoclean)
ac97_codec             14600   0  (autoclean) [i810_audio]
soundcore               6404   2  (autoclean) [i810_audio]
binfmt_misc             7432   1
parport_pc             19076   1  (autoclean)
lp                      8996   0  (autoclean)
parport                37056   1  (autoclean) [parport_pc lp]
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              15096   1  [iptable_filter]
orinoco_cs              5556   1
orinoco                39724   0  [orinoco_cs]
autofs                 13268   0  (autoclean) (unused)
hermes                  8068   0  [orinoco_cs orinoco]
ds                      8680   3  [orinoco_cs]
yenta_socket           13632   3
pcmcia_core            57216   0  [orinoco_cs ds yenta_socket]
e100                   54564   0
usb-storage            74496   0
scsi_mod              107544   2  [sd_mod usb-storage]
loop                   12152   0  (autoclean)
lvm-mod                64000   0
keybdev                 2976   0  (unused)
mousedev                5556   1
hid                    22244   0  (unused)
input                   5856   0  [keybdev mousedev hid]
usb-uhci               26412   0  (unused)
usbcore                79040   1  [usb-storage hid usb-uhci]
ext3                   70784   2
jbd                    51924   2  [ext3]

dmesg:

Linux version 2.4.20-18.9 (bhcompile@porky.devel.redhat.com) (gcc 
version 
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu May 29 07:08:16 EDT 2003
<snip>
Kernel command line: ro root=LABEL=/
Initializing CPU#0
Detected 600.029 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1196.03 BogoMIPS
Memory: 188736k/196480k available (1356k kernel code, 5824k reserved, 
1004k 
data, 132k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfed9b, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - PCI device 1179:061b (Toshiba America Info 
Systems)
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xbff0-0xbff7, BIOS settings: hda:DMA, hdb:pio
hda: TOSHIBA MK1214GAP, ATA DISK drive
blk: queue c03cdfe0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 23579136 sectors (12073 MB), CHS=1467/255/63, UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
  hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 07:14:02 May 29 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:02.0
usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
hub.c: new USB device 00:07.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x644/0x0) is not claimed by any active 
driver.
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
LVM version 1.0.5+(22/07/2002) module loaded
loop: loaded (max 8 devices)
Adding Swap: 385552k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
   Vendor: TEAC      Model: FD-05PUB          Rev: 1026
   Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
divert: allocating divert_blk for eth0
e100: eth0: Intel(R) PRO/100 Network Connection
   Hardware receive checksums enabled
   cpu cycle saver enabled

ip_tables: (C) 2000-2002 Netfilter core team
hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
ds: no socket drivers loaded!
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:0b.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 00:0b.0
PCI: Enabling device 00:0b.1 (0000 -> 0002)
PCI: Found IRQ 11 for device 00:0b.1
PCI: Sharing IRQ 11 with 00:00.1
PCI: Enabling device 01:05.0 (0000 -> 0002)
Yenta IRQ list 0000, PCI irq11
Socket status: 30000007
Yenta IRQ list 0000, PCI irq11
Socket status: 30000011
Yenta IRQ list 02b8, PCI irq11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> and 
others)
orinoco_cs.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> and 
others)
divert: allocating divert_blk for eth1
eth1: Station identity 001f:0002:0001:0001
eth1: Looks like a Symbol firmware version [V1.00-03] (parsing to 
10003)
eth1: Ad-hoc demo mode supported
eth1: MAC address 00:50:DA:00:99:0D
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x0147
ip_tables: (C) 2000-2002 Netfilter core team
eth1: New link status: Connected (0001)
ip_tables: (C) 2000-2002 Netfilter core team
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Intel 810 + AC97 Audio, version 0.24, 07:13:38 May 29 2003
PCI: Found IRQ 11 for device 00:00.1
PCI: Sharing IRQ 11 with 00:0b.1
PCI: Setting latency timer of device 00:00.1 to 64
i810: Intel 440MX found at IO 0xfcc0 and 0xfd00, MEM 0x0000 and 0x0000,

IRQ 11
i810_audio: Audio Controller supports 2 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7644 (SigmaTel STAC9744/45)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb-uhci.c: interrupt, status 3, frame# 980
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
  sda: I/O error: dev 08:00, sector 0
  I/O error: dev 08:00, sector 0
  unable to read partition table
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
sda: Write Protect is on
  sda: I/O error: dev 08:00, sector 0
  I/O error: dev 08:00, sector 0
  unable to read partition table

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
