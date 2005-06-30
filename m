Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVF3OWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVF3OWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVF3OWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:22:24 -0400
Received: from [195.22.6.196] ([195.22.6.196]:56004 "HELO evoluta.pt")
	by vger.kernel.org with SMTP id S262983AbVF3OTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:19:37 -0400
Subject: Qlogic ISP1020
From: Rui Barreiros <rbarreiros@evoluta.pt>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 30 Jun 2005 15:19:21 +0100
Message-Id: <1120141161.7136.104.camel@aragorn>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently acquired an alphaserver 1000a 5/400 and after struggling a
bit to get a decent linux distro running i finally made it.

Right now it's using alphacore, with a vanilla kernel (that is,
downloaded yesterday from kernel.org not the stock fedora kernel in
which is based the distro)

[root@gimli ~]# uname -a
Linux gimli 2.6.12.2 #1 Thu Jun 30 10:48:19 WEST 2005 alpha alpha alpha
GNU/Linux

The problem is with the usage of the tape that comes with the system (a
DEC TLZ09 aka Sony SDT-7000), the problem seems not to be the tape, but
qlogicisp scsi driver, whatever i do with the tape, the device get's
offlined and that console hangs here is the messages log (note i can do
a mt status without any problem, all the other commands that imply the
usage of the tape like erase, rewind, retension etc, have the problem)

Jun 30 13:14:36 gimli kernel: scsi(0): Resetting
Cmnd=0xfffffc000d9eacc0, Handle=0x0000000000000202, action=0x2
Jun 30 13:14:36 gimli kernel: scsi(0:0:4:0): Queueing device reset
command.
Jun 30 13:14:36 gimli kernel: scsi(0): Resetting
Cmnd=0xfffffc000d9eacc0, Handle=0x0000000000000202, action=0x3
Jun 30 13:14:36 gimli kernel: qla1280(0:0): Issuing BUS DEVICE RESET
Jun 30 13:14:36 gimli kernel: scsi(0:1): Resetting SCSI BUS
Jun 30 13:14:36 gimli kernel: scsi(0): Resetting
Cmnd=0xfffffc000d9eacc0, Handle=0x0000000000000202, action=0x4
Jun 30 13:14:36 gimli kernel: scsi(0): Issued ADAPTER RESET
Jun 30 13:14:36 gimli kernel: scsi(0): I/O processing will continue
automatically
Jun 30 13:14:36 gimli kernel: scsi(0): dequeuing outstanding commands
Jun 30 13:14:37 gimli kernel: scsi(0:0): Resetting SCSI BUS
Jun 30 13:14:47 gimli kernel: scsi: Device offlined - not ready after
error recovery: host 0 channel 0 id 4 lun 0
Jun 30 13:14:47 gimli kernel: st0: Error 2 (sugg. bt 0x0, driver bt 0x0,
host bt 0x0).
Jun 30 13:14:47 gimli kernel: scsi0 (4:0): rejecting I/O to offline
device

I had a look at the driver source in the kernel and noticed this in
qla1280.c

    Rev  3.25, September 28, 2004, Christoph Hellwig
        - add support for ISP1020/1040
        - don't include "scsi.h" anymore for 2.6.x
    Rev  3.24.4 June 7, 2004 Christoph Hellwig
        - restructure firmware loading, cleanup initialization code
        - prepare support for ISP1020/1040 chips

does this mean it isn't fully supported yet ?

Another thing, i wasn't supposed to send this to this list, but i
couldn't find the correct mantainer of this specific driver, can someone
point him out so that we can further talk into solving this issue.

Best regards,

Here goes complete dmesg:

Linux version 2.6.12.2 (root@gimli) (gcc version 3.4.3 20050221 (Red Hat
3.4.3-20)) #1 Thu Jun 30 10:48:19 WEST 2005
Booting on Noritake using machine vector Noritake-Primo from SRM
Major Options: EV56 LEGACY_START DEBUG_SPINLOCK MAGIC_SYSRQ
Command line:  root=/dev/sdb1
memcluster 0, usage 1, start        0, end      226
memcluster 1, usage 0, start      226, end    32742
memcluster 2, usage 1, start    32742, end    32768
freeing pages 226:384
freeing pages 976:32742
reserving pages 976:977
Initial ramdisk at: 0xfffffc000fea2000 (1215791 bytes)
2048K Bcache detected; load hit latency 38 cycles, load miss latency 172
cycles
pci: cia revision 2
On node 0 totalpages: 32742
  DMA zone: 32742 pages, LIFO batch:15
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line:  root=/dev/sdb1
PID hash table entries: 1024 (order: 10, 32768 bytes)
Using epoch = 2000
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 250880k/261936k available (2941k kernel code, 8560k reserved,
640k data, 208k init)
Calibrating delay loop... 793.68 BogoMIPS (lpj=387072)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
checking if image is initramfs... it is
Freeing initrd memory: 1187k freed
NET: Registered protocol family 16
EISA bus registered
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround
available)
pci: passed pci machine check test
pci: enabling save/restore of SRM state
PCI: Bridge: 0000:00:08.0
  IO window: 9000-9fff
  MEM window: 04000000-057fffff
  PREFETCH window: disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
audit: initializing netlink socket (disabled)
audit(1120133401.805:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at 0000:00:07.0
EISA: Mainboard DEC5000 detected.
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP established hash table entries: 32768 (order: 5, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 1835008 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
Freeing unused kernel memory: 208k freed
SCSI subsystem initialized
qla1280: QLA1040 found on PCI bus 1, dev 0
input: AT Translated Set 2 keyboard on isa0060/serio0
scsi(0:0): Resetting SCSI BUS
scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
       Firmware version:  7.65.00, Driver version 3.25
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
  Vendor: DEC       Model: RZ1BB-BS (C) DEC  Rev: 0818
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi(0:0:0:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth
255
SCSI device sda: 4110480 512-byte hdwr sectors (2105 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 4110480 512-byte hdwr sectors (2105 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: DEC       Model: RZ2CA-KA (C) DEC  Rev: N1H1
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi(0:0:1:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth
255
SCSI device sdb: 8380080 512-byte hdwr sectors (4291 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 8380080 512-byte hdwr sectors (4291 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: DEC       Model: RZ2CA-KA (C) DEC  Rev: N1H1
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi(0:0:2:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth
255
SCSI device sdc: 8380080 512-byte hdwr sectors (4291 MB)
SCSI device sdc: drive cache: write through
SCSI device sdc: 8380080 512-byte hdwr sectors (4291 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
  Vendor: DEC       Model: TLZ09     (C)DEC  Rev: 0173
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi(0:0:4:0): Sync: period 10, offset 12
  Vendor: DEC       Model: RRD46   (C) DEC   Rev: 1337
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi(0:0:5:0): Sync: period 10, offset 12
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
st: Version 20050312, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA
32742
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xa000. Vers LK1.1.19
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on sdb1, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 511984k swap on /dev/sda2.  Priority:-1 extents:1
parport0: PC-style at 0x3bc [PCSPP]
st0: Block limits 1 - 16777215 bytes.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1023 buckets, 8184 max) - 384 bytes per
conntrack
NET: Registered protocol family 17
NET: Registered protocol family 10
Disabled Privacy Extensions on device fffffc0000709850(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present


