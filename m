Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266645AbUBQVTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUBQVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:19:53 -0500
Received: from ns2.len.rkcom.net ([80.148.32.9]:43189 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S266645AbUBQVO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:14:59 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 99% System load
Date: Tue, 17 Feb 2004 21:16:07 +0000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200402111423.02217.ma1flfs@bath.ac.uk> <20040211234413.3d90df5d.akpm@osdl.org>
In-Reply-To: <20040211234413.3d90df5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XSoMAzBxEKwtd0F"
Message-Id: <200402172116.18254.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XSoMAzBxEKwtd0F
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 February 2004 07:44, Andrew Morton wrote:
> Florian Schanda <ma1flfs@bath.ac.uk> wrote:
> > Sometimes (not allways, thats the problem, otherwise I could just avoid
> > the offending command) during paralel builds (for instance kde-libs or
> > kde-base) the build just stops, and I get a 99% system load.
> >
> Make sure that you have enabled CONFIG_KALLSYMS, and that
> /proc/sys/kernel/sysrq is set to one.  Then, when it hangs, do
>
> 	echo t > /proc/sysrq-trigger
>
> or type alt-sysrq-t
>
> Then, run
>
> 	dmesg -s 1000000 > /tmp/foo
>
> and make `foo' available.

=46inally it happened again. I attached the output of that dmesg.

> It would help if you could make a note of the PIDs of the hung processes,
> so they can be correlated with the sysrq output.

The PIDs hanging are 3303, 3305, 3306, 3307.

An advance warning: I had the nvidia driver (yes, I know, closed source mak=
es=20
debugging impossible) loaded, and before the trace begins, there are some=20
messages of that module:

1: NVRM: AGPGART: unable to retrieve symbol table
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio=
0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio=
0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
request_module: failed /sbin/modprobe -- block-major-3-0. error =3D 256
3: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock
3: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock
1: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interr=
upt=20
or holding a spinlock

=2D From what I understand is I get some kind of deadlock, right?

Thanks in advance,

	Florian
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAMoSbfCf8muQVS4cRAuvPAJ4upsbqfGCuP6NgrR1wtgH99S8R7ACdG9yh
GHbC6dZIwX65HDp7sFPg3sQ=3D
=3Dsy7G
=2D----END PGP SIGNATURE-----

--Boundary-00=_XSoMAzBxEKwtd0F
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-output"

ive:1)
00:00:1d[B] -> 2-19 -> IRQ 19
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:02[A] -> 2-20 -> IRQ 20
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  0    0    0   0   0    1    1    51
 06 00F 0F  0    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  0    1    0   0   0    1    1    71
 0a 00F 0F  0    0    0   0   0    1    1    79
 0b 00F 0F  0    0    0   0   0    1    1    81
 0c 00F 0F  0    0    0   0   0    1    1    89
 0d 00F 0F  0    0    0   0   0    1    1    91
 0e 00F 0F  0    0    0   0   0    1    1    99
 0f 00F 0F  0    0    0   0   0    1    1    A1
 10 00F 0F  1    1    0   1   0    1    1    B9
 11 00F 0F  1    1    0   1   0    1    1    B1
 12 00F 0F  1    1    0   1   0    1    1    A9
 13 00F 0F  1    1    0   1   0    1    1    C1
 14 00F 0F  1    1    0   1   0    1    1    D1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 00F 0F  1    1    0   1   0    1    1    C9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
Starting balanced_irq
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with no debug enabled
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1480-0x1487, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1488-0x148f, BIOS settings: hdc:DMA, hdd:pio
hdc: PIONEER DVD-RW DVR-105, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
(scsi0:A:2): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
(scsi0:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 16)
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DNES-318350W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:3:0: Tagged Queuing enabled.  Depth 32
  Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target1/lun0: p1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sdc: drive cache: write through
 /dev/scsi/host0/bus0/target2/lun0: p1
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdd: drive cache: write back
 /dev/scsi/host0/bus0/target3/lun0: p1
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
SCSI device sde: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sde: drive cache: write back
 /dev/scsi/host0/bus0/target4/lun0: p1
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg4 at scsi0, channel 0, id 4, lun 0,  type 0
Attached scsi generic sg5 at scsi0, channel 0, id 5, lun 0,  type 5
Attached scsi generic sg6 at scsi0, channel 0, id 6, lun 0,  type 5
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001400
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001420
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001440
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
XFS mounting filesystem sdc1
hub 1-0:1.0: new USB device on port 1, assigned address 2
Ending clean XFS mount for filesystem: sdc1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 356k freed
input: USB HID v1.00 Mouse [USB Mouse] on usb-0000:00:1d.0-1
NET: Registered protocol family 1
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: raid0 personality registered as nr 2
md: bind<sdd1>
md: nonpersistent superblock ...
md: bind<sde1>
md: nonpersistent superblock ...
md0: setting max_sectors to 32, segment boundary to 8191
raid0: looking at sde1
raid0:   comparing sde1(17920464) with sde1(17920464)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdd1
raid0:   comparing sdd1(17920464) with sde1(17920464)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 35840928 blocks.
raid0 : conf->hash_spacing is 35840928 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
Adding 401616k swap on /dev/sda4.  Priority:-1 extents:1
XFS mounting filesystem md0
Ending clean XFS mount for filesystem: md0
XFS mounting filesystem sda3
Starting XFS recovery on filesystem: sda3 (dev: sda3)
Ending XFS recovery on filesystem: sda3 (dev: sda3)
e100: eth0 NIC Link is Up 100 Mbps Full duplex
request_module: failed /sbin/modprobe -- block-major-3-0. error = 256
XFS mounting filesystem sda3
Starting XFS recovery on filesystem: sda3 (dev: sda3)
Ending XFS recovery on filesystem: sda3 (dev: sda3)
nvidia: module license 'NVIDIA' taints kernel.
1: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 14 18:29:26 PST 2004
Linux agpgart interface v0.100 (c) Dave Jones
1: NVRM: AGPGART: unable to retrieve symbol table
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
1: NVRM: AGPGART: unable to retrieve symbol table
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
1: NVRM: AGPGART: unable to retrieve symbol table
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
request_module: failed /sbin/modprobe -- block-major-3-0. error = 256
3: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
3: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
1: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
2: nvidia: trying to map 0xef9f1000 to kernel space, but we're in an interrupt or holding a spinlock
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C14F1FC8  5528     1      0     2               (NOTLB)
f7fa9eb0 00000086 00000000 c14f1fc8 c03b9980 000001d5 f7fa9f40 00000000 
       c013eccf c03b9980 00000000 00000000 ec646e80 d0a9a080 c2431c80 00000e9c 
       bbde137c 00000df6 c247f940 c247fb08 00e5e93e f7fa9ec4 0000000b 0000000b 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0164471>] sys_stat64+0x37/0x39
 [<c0108f45>] sysenter_past_esp+0x52/0x71

migration/0   S 00000001  7888     2      1             3       (L-TLB)
c2473fc4 00000046 c2429c80 00000001 0000000f f7cef310 50b39010 00000000 
       00000000 02542ce4 f7cebf58 c2472000 f7cebf50 00000292 c2429c80 0000074b 
       02543085 00000000 c247e080 c247e248 c242a5b4 c2472000 c2429c80 c2473fec 
Call Trace:
 [<c011e046>] migration_thread+0xc9/0x137
 [<c011df7d>] migration_thread+0x0/0x137
 [<c0106e19>] kernel_thread_helper+0x5/0xb

ksoftirqd/0   S EAC55EC8  7208     3      1             4     2 (L-TLB)
f7f9ffd8 00000046 000dab44 eac55ec8 c242b674 c242b66c f7f9ff94 f7f9ff94 
       c242b67c 00000000 cedd9310 c0465664 c01250af cedd9310 c2429c80 000001ac 
       9e154195 00000dd4 c2471940 c2471b08 00000000 f7f9e000 00000000 00000000 
Call Trace:
 [<c01250af>] tasklet_action+0x65/0xae
 [<c0125351>] ksoftirqd+0xdd/0xec
 [<c0125274>] ksoftirqd+0x0/0xec
 [<c0106e19>] kernel_thread_helper+0x5/0xb

migration/1   S 00000001  7884     4      1             5     3 (L-TLB)
f7f9dfc4 00000046 c2431c80 00000001 00000003 c0464d20 c0129caf c03b897c 
       c03b8978 f7f9c000 c0121fff 00000082 c03b5510 00000008 c2431c80 0000151c 
       001025be 00000000 c2471310 c24714d8 c24325b4 f7f9c000 c2431c80 f7f9dfec 
Call Trace:
 [<c0129caf>] free_uid+0x1f/0x7d
 [<c0121fff>] reparent_to_init+0x104/0x199
 [<c011e046>] migration_thread+0xc9/0x137
 [<c011df7d>] migration_thread+0x0/0x137
 [<c0106e19>] kernel_thread_helper+0x5/0xb

ksoftirqd/1   S C54F2DC8  7784     5      1             6     4 (L-TLB)
f7f9bfd8 00000046 f7f9bf94 c54f2dc8 c2433674 c243366c f7f9bf94 f7f9bf94 
       c243367c 00000000 f7f9a000 c0465664 c01250af e1bcd310 c2431c80 00000117 
       ad6bb34d 00000dd4 c2470ce0 c2470ea8 00000000 f7f9a000 00000000 00000000 
Call Trace:
 [<c01250af>] tasklet_action+0x65/0xae
 [<c0125351>] ksoftirqd+0xdd/0xec
 [<c0125274>] ksoftirqd+0x0/0xec
 [<c0106e19>] kernel_thread_helper+0x5/0xb

migration/2   S 00000001  7884     6      1             7     5 (L-TLB)
f7f99fc4 00000046 c2439c80 00000001 00000007 c0464d20 c0129caf c03b897c 
       c03b8978 f7f98000 c0121fff 00000082 c03b5510 00000008 c2439c80 00002da8 
       001f122c 00000000 c24706b0 c2470878 c243a5b4 f7f98000 c2439c80 f7f99fec 
Call Trace:
 [<c0129caf>] free_uid+0x1f/0x7d
 [<c0121fff>] reparent_to_init+0x104/0x199
 [<c011e046>] migration_thread+0xc9/0x137
 [<c011df7d>] migration_thread+0x0/0x137
 [<c0106e19>] kernel_thread_helper+0x5/0xb

ksoftirqd/2   S 00000001  7764     7      1             8     6 (L-TLB)
f7f97fd8 00000046 c2439c80 00000001 0000000f c243b66c f7f97f94 f7f97f94 
       c243b67c 00000000 f7f96000 c0465664 c01250af d9dd6ce0 c2439c80 00000255 
       d915264a 00000dd2 c2470080 c2470248 00000000 f7f96000 00000000 00000000 
Call Trace:
 [<c01250af>] tasklet_action+0x65/0xae
 [<c0125351>] ksoftirqd+0xdd/0xec
 [<c0125274>] ksoftirqd+0x0/0xec
 [<c0106e19>] kernel_thread_helper+0x5/0xb

migration/3   S 00000001  7884     8      1             9     7 (L-TLB)
f7f93fc4 00000046 c2441c80 00000001 0000000f c0464d20 c0129caf c03b897c 
       c03b8978 f7f92000 c0121fff 00000082 c03b5510 00000008 c2441c80 00001879 
       002e594e 00000000 f7f95940 f7f95b08 c24425b4 f7f92000 c2441c80 f7f93fec 
Call Trace:
 [<c0129caf>] free_uid+0x1f/0x7d
 [<c0121fff>] reparent_to_init+0x104/0x199
 [<c011e046>] migration_thread+0xc9/0x137
 [<c011df7d>] migration_thread+0x0/0x137
 [<c0106e19>] kernel_thread_helper+0x5/0xb

ksoftirqd/3   S C7D389C8  7764     9      1            10     8 (L-TLB)
f7f91fd8 00000046 000da97e c7d389c8 c2443674 c244366c f7f91f94 f7f91f94 
       c244367c 00000000 f7f90000 c0465664 c01250af e1bcd310 c2441c80 00000114 
       adbe22f0 00000dd4 f7f95310 f7f954d8 00000000 f7f90000 00000000 00000000 
Call Trace:
 [<c01250af>] tasklet_action+0x65/0xae
 [<c0125351>] ksoftirqd+0xdd/0xec
 [<c0125274>] ksoftirqd+0x0/0xec
 [<c0106e19>] kernel_thread_helper+0x5/0xb

events/0      R C03C42E4  6904    10      1            11     9 (L-TLB)
f7f81f70 00000046 f7fc6c00 c03c42e4 c04969a0 00000286 00000001 f7f8007b 
       f7fc007b ffffff00 f7fc6c24 f7f80000 f7fc6c20 f28b4080 c2429c80 000001d8 
       feae07ce 00000df6 f7f94ce0 f7f94ea8 f7f80000 f7fc6c0c c03c42e0 00000292 
Call Trace:
 [<c0130f85>] worker_thread+0x270/0x298
 [<c026ac74>] console_callback+0x0/0xbe
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

events/1      S E7AB7720  7384    11      1            12    10 (L-TLB)
c24fff70 00000046 00000000 e7ab7720 00000000 00000000 00000000 f2d46080 
       0000007b 0000007b f2d46080 c2431c80 00005436 e887b310 c2431c80 0000063b 
       327660c7 000005c9 f7f946b0 f7f94878 c24fe000 f7fc6c8c e7ab76e0 00000286 
Call Trace:
 [<c0130f85>] worker_thread+0x270/0x298
 [<c01309d1>] __call_usermodehelper+0x0/0x65
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

events/2      S E8055DE8  7492    12      1            13    11 (L-TLB)
c24fdf70 00000046 00000000 e8055de8 00000000 00000000 00000000 c2680ce0 
       0000007b 0000007b c2680ce0 c2439c80 00001b89 c2681310 c2439c80 00000553 
       81239d37 000005cc f7f94080 f7f94248 c24fc000 f7fc6d0c e8055da8 00000286 
Call Trace:
 [<c0130f85>] worker_thread+0x270/0x298
 [<c01309d1>] __call_usermodehelper+0x0/0x65
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

events/3      S 3CB54AB3  7724    13      1            14    12 (L-TLB)
c24f9f70 00000046 f7f95310 3cb54ab3 000005c8 f7fc6da4 c011c643 e7ab7ea8 
       00000003 00000000 f7fc6da4 3cb54ab3 000005c8 f7f95310 c2441c80 000de095 
       3cb55874 000005c8 c24fb940 c24fbb08 c24f8000 f7fc6d8c c03c42e0 00000292 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c026ac74>] console_callback+0x0/0xbe
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kblockd/0     S 00000001  7116    14      1            15    13 (L-TLB)
f7d9ff70 00000046 c2429c80 00000001 0000000f f7c98000 d46f2200 f7d9e000 
       f7d9e000 f7c9de00 f7dcc024 f7d9e000 f7dcc020 c4c0c6b0 c2429c80 000000e1 
       21e611bb 00000dd2 c24fb310 c24fb4d8 f7d9e000 f7dcc00c f7c8ff1c 00000286 
Call Trace:
 [<c0130f85>] worker_thread+0x270/0x298
 [<c0279bfb>] as_work_handler+0x0/0x81
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kblockd/1     S F7C98000  7412    15      1            16    14 (L-TLB)
f7d9df70 00000046 d3dafe00 f7c98000 c0270dd3 f7c98000 d3dafe00 f7c9de00 
       d3dafe00 f7c9de00 f7dcc0a4 f7d9c000 f7dcc0a0 d0a9b310 c2431c80 000012a2 
       e74b1718 00000d7c c24face0 c24faea8 f7d9c000 f7dcc08c f7c980fc 00000286 
Call Trace:
 [<c0270dd3>] elv_next_request+0xf/0xf1
 [<c0130f85>] worker_thread+0x270/0x298
 [<c027286c>] blk_unplug_work+0x0/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kblockd/2     S F7C8CE00  7412    16      1            17    15 (L-TLB)
f7d9bf70 00000046 f7c9c080 f7c8ce00 c0270dd3 f7c8ce00 f7c9c080 f7c9de00 
       f7c9c080 f7c9de00 f7dcc124 f7d9a000 f7dcc120 f28b4080 c2439c80 00000b29 
       3683b921 00000ddd c24fa6b0 c24fa878 f7d9a000 f7dcc10c f7c8cefc 00000286 
Call Trace:
 [<c0270dd3>] elv_next_request+0xf/0xf1
 [<c0130f85>] worker_thread+0x270/0x298
 [<c027286c>] blk_unplug_work+0x0/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kblockd/3     S F7C8CE00  7424    17      1            18    16 (L-TLB)
f7d99f70 00000046 e38d3200 f7c8ce00 c0270dd3 f7c8ce00 e38d3200 f7c9de00 
       e38d3200 f7c9de00 f7dcc1a4 f7d98000 f7dcc1a0 e1bccce0 c2441c80 00001e65 
       c7cebd0f 00000dd1 c24fa080 c24fa248 f7d98000 f7dcc18c f7c8cefc 00000286 
Call Trace:
 [<c0270dd3>] elv_next_request+0xf/0xf1
 [<c0130f85>] worker_thread+0x270/0x298
 [<c027286c>] blk_unplug_work+0x0/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

khubd         S 00000001  6956    18      1            19    17 (L-TLB)
f7d65fb4 00000046 c2431c80 00000001 0000000f f7c65c80 f7c32880 00000001 
       00000002 00000002 f7c32880 00000202 f7c32880 f7d65fa0 c2431c80 0001e25d 
       d7e8ef00 00000002 f7d67940 f7d67b08 f7d64000 f7d64000 f7d65fc4 00000000 
Call Trace:
 [<c02c9d25>] hub_thread+0x97/0xc3
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c02c9c8e>] hub_thread+0x0/0xc3
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kirqd         S FC2EBCFD  7852    19      1            22    18 (L-TLB)
f7d63fa0 00000046 cefcf310 fc2ebcfd 00000dd5 00000000 c04675a0 00000200 
       00000000 00000000 e887b310 fc2ebcfd 00000dd5 d9dd7940 c2439c80 00000753 
       93885208 00000df6 f7d67310 f7d674d8 00e5e699 f7d63fb4 00000000 00000000 
Call Trace:
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c01171d9>] balanced_irq+0x4b/0x71
 [<c011718e>] balanced_irq+0x0/0x71
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kswapd0       S 00000100  6532    22      1            23    19 (L-TLB)
f7d4df08 00000046 000000d0 00000100 00000100 c03b9f80 00000002 00000000 
       c0146418 00000080 c03b9f80 000000d0 0000007f cefcf310 c2429c80 00008d69 
       77974d39 00000dad f7d66080 f7d66248 f7d4df20 f7d4dfc0 c03ba5d4 c03b9380 
Call Trace:
 [<c0146418>] balance_pgdat+0x19e/0x220
 [<c014657a>] kswapd+0xe0/0x115
 [<c011e87b>] autoremove_wake_function+0x0/0x4f
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011e87b>] autoremove_wake_function+0x0/0x4f
 [<c014649a>] kswapd+0x0/0x115
 [<c0106e19>] kernel_thread_helper+0x5/0xb

aio/0         S F7FA9F68  7804    23      1            24    22 (L-TLB)
f7d09f70 00000046 00000001 f7fa9f68 00000001 f7d09f4c c011c643 c247f940 
       00000003 00000000 f7fa9f68 f7d08000 00010000 c247f940 c2429c80 00000781 
       024f310d 00000000 f7d0b940 f7d0bb08 f7d08000 00000000 f7d09fb4 f7fa9f5c 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

aio/1         S 00000001  7724    24      1            25    23 (L-TLB)
f7d03f70 00000046 c2431c80 00000001 0000000f f7d03f4c c011c643 c247f940 
       00000003 00000000 f7fa9f68 f7d02000 00010000 f7d0b310 c2431c80 00000d26 
       024f71e9 00000000 f7d0b310 f7d0b4d8 f7d02000 00000001 f7d03fb4 f7fa9f5c 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

aio/2         S 00000001  7724    25      1            26    24 (L-TLB)
f7d01f70 00000046 c2439c80 00000001 0000000f f7d01f4c c011c643 c247f940 
       00000003 00000000 f7fa9f68 f7d00000 00010000 f7d0ace0 c2439c80 00000edc 
       024fb64d 00000000 f7d0ace0 f7d0aea8 f7d00000 00000002 f7d01fb4 f7fa9f5c 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

aio/3         S 00000001  7724    26      1            27    25 (L-TLB)
f7cfff70 00000046 c2441c80 00000001 0000000f f7cfff4c c011c643 c247f940 
       00000003 00000000 f7fa9f68 f7cfe000 00010000 f7d0a6b0 c2441c80 00000fdc 
       02500458 00000000 f7d0a6b0 f7d0a878 f7cfe000 00000003 f7cfffb4 f7fa9f5c 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfslogd/0     S C27DFD80  6328    27      1            28    26 (L-TLB)
f7cfdf70 00000046 f7cfc000 c27dfd80 00000000 c01e5b08 c27dfd80 00000000 
       c27d3600 c27ce580 f7d30424 f7cfc000 f7d30420 f28b4080 c2429c80 000000bf 
       2ec4ed7c 00000df6 f7d0a080 f7d0a248 f7cfc000 f7d3040c e8c2cce0 00000282 
Call Trace:
 [<c01e5b08>] xlog_state_done_syncing+0x7a/0xb1
 [<c0130f85>] worker_thread+0x270/0x298
 [<c0203a77>] pagebuf_iodone_work+0x0/0x56
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfslogd/1     S 00000001  7724    28      1            29    27 (L-TLB)
f7cf9f70 00000046 c2431c80 00000001 0000000f f7cf9f4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cf8000 00010000 f7cfb940 c2431c80 00000a7b 
       0252abd9 00000000 f7cfb940 f7cfbb08 f7cf8000 00000001 f7cf9fb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfslogd/2     S 00000001  7724    29      1            30    28 (L-TLB)
f7cf7f70 00000046 c2439c80 00000001 0000000f f7cf7f4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cf6000 00010000 f7cfb310 c2439c80 00000ea9 
       0252f0c5 00000000 f7cfb310 f7cfb4d8 f7cf6000 00000002 f7cf7fb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfslogd/3     S 00000001  7724    30      1            31    29 (L-TLB)
f7cf5f70 00000046 c2441c80 00000001 0000000f f7cf5f4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cf4000 00010000 f7cface0 c2441c80 00000dd1 
       02533551 00000000 f7cface0 f7cfaea8 f7cf4000 00000003 f7cf5fb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfsdatad/0    S F7FA9F08  7804    31      1            32    30 (L-TLB)
f7cf3f70 00000046 00000001 f7fa9f08 00000001 f7cf3f4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cf2000 00010000 c247f940 c2429c80 000005a0 
       02536801 00000000 f7cfa6b0 f7cfa878 f7cf2000 00000000 f7cf3fb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfsdatad/1    S 00000001  7724    32      1            33    31 (L-TLB)
f7cf1f70 00000046 c2431c80 00000001 0000000f f7cf1f4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cf0000 00010000 f7cfa080 c2431c80 00000a50 
       0253a5ba 00000000 f7cfa080 f7cfa248 f7cf0000 00000001 f7cf1fb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfsdatad/2    S 00000001  7724    33      1            34    32 (L-TLB)
f7cedf70 00000046 c2439c80 00000001 0000000f f7cedf4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cec000 00010000 f7cef940 c2439c80 00001011 
       0253f34c 00000000 f7cef940 f7cefb08 f7cec000 00000002 f7cedfb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfsdatad/3    S 00000001  7724    34      1            35    33 (L-TLB)
f7cebf70 00000046 c2441c80 00000001 0000000f f7cebf4c c011c643 c247f940 
       00000003 00000000 f7fa9f08 f7cea000 00010000 f7cef310 c2441c80 00000fd2 
       02544216 00000000 f7cef310 f7cef4d8 f7cea000 00000003 f7cebfb4 f7fa9efc 
Call Trace:
 [<c011c643>] __wake_up_common+0x38/0x57
 [<c0130f85>] worker_thread+0x270/0x298
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108e6e>] ret_from_fork+0x6/0x14
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0130d15>] worker_thread+0x0/0x298
 [<c0106e19>] kernel_thread_helper+0x5/0xb

pagebufd      S 00000000  7276    35      1            36    34 (L-TLB)
f7ce9f88 00000046 f7c68c80 00000000 00000000 f7c8fe80 00000000 f7c90c00 
       f7ce8000 c02790e4 d9dd7940 f7c9c680 f7c98000 d9dd7940 c2439c80 000000fb 
       d0e5e8ce 00000df6 f7ceece0 f7ceeea8 00e5daff f7ce9f9c f7ce8000 f7ce9fd4 
Call Trace:
 [<c02790e4>] as_next_request+0x33/0x3c
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c0204474>] pagebuf_daemon+0x56/0x1da
 [<c020441e>] pagebuf_daemon+0x0/0x1da
 [<c0106e19>] kernel_thread_helper+0x5/0xb

scsi_eh_0     S C011A7A6     4    36      1            37    35 (L-TLB)
f7c93f70 00000046 f7c93f40 c011a7a6 c247f940 26896a00 00000000 00000000 
       0ac9a25a 00000001 c2429c80 f7c93f6c 00000096 c247f940 c2429c80 00001e09 
       0ac9a74c 00000001 f7cee6b0 f7cee878 f7c92000 f7c93fc4 00000286 f7cee6b0 
Call Trace:
 [<c011a7a6>] recalc_task_prio+0x90/0x1aa
 [<c0107d5c>] __down_interruptible+0xac/0x142
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0107e83>] __down_failed_interruptible+0x7/0xc
 [<c0296e19>] .text.lock.scsi_error+0xb9/0xc0
 [<c0296a50>] scsi_error_handler+0x0/0x141
 [<c0106e19>] kernel_thread_helper+0x5/0xb

ahc_dv_0      S 1ED01FB0  7576    37      1            38    36 (L-TLB)
f7c6bf88 00000046 c2470ce0 1ed01fb0 00000002 f7c9e400 f7c6a000 c02790e4 
       f7cc0380 f7c6a000 f7c98e00 1ed01fb0 00000002 c2470ce0 c2431c80 000005b2 
       1ed0369b 00000002 f7cee080 f7cee248 f7c6a000 f7ca50c4 00000286 f7cee080 
Call Trace:
 [<c02790e4>] as_next_request+0x33/0x3c
 [<c0107d5c>] __down_interruptible+0xac/0x142
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0297614>] scsi_run_host_queues+0x36/0x42
 [<c0107e83>] __down_failed_interruptible+0x7/0xc
 [<c02b6639>] .text.lock.aic7xxx_osm+0x71/0x1dc
 [<c02b1d58>] ahc_linux_dv_thread+0x0/0x31b
 [<c0106e19>] kernel_thread_helper+0x5/0xb

kseriod       S 00000001  7864    38      1            39    37 (L-TLB)
c27c3fb4 00000046 c2441c80 00000001 0000000f 00000000 c0129caf c03b897c 
       c03b8978 c27c2000 c0121fff c03b897c c03b5510 00000008 c2441c80 04e7fbb8 
       c239ecf5 00000002 c27c5940 c27c5b08 c27c2000 c27c2000 c27c3fc4 00000000 
Call Trace:
 [<c0129caf>] free_uid+0x1f/0x7d
 [<c0121fff>] reparent_to_init+0x104/0x199
 [<c02e1d3a>] serio_thread+0x11e/0x14a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c02e1c1c>] serio_thread+0x0/0x14a
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfs_syncd     S 00000000  6844    39      1           133    38 (L-TLB)
c2687f9c 00000046 d3643cf0 00000000 c27dfd80 00000002 00000000 c01e3442 
       c27dfd80 00000002 c01d9137 c27c8d90 00000031 f28b4080 c2439c80 000015d5 
       50b59888 00000df4 c27c5310 c27c54d8 00e6224e c2687fb0 00000000 00000000 
Call Trace:
 [<c01e3442>] xfs_log_force+0x5d/0x8a
 [<c01d9137>] xfs_iunlock+0x37/0x71
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c020a433>] syncd+0x46/0x8e
 [<c020a3ed>] syncd+0x0/0x8e
 [<c0106e19>] kernel_thread_helper+0x5/0xb

xfs_syncd     S 00000000    12   133      1           144    39 (L-TLB)
f7767f9c 00000046 c2439c80 00000000 f764c080 00000002 00000000 c01e3442 
       f764c080 00000002 00000000 00000031 00000031 f28b4080 c2439c80 0000022f 
       0b0a2629 00000df3 c27c46b0 c27c4878 00e60cf4 f7767fb0 00000000 00000000 
Call Trace:
 [<c01e3442>] xfs_log_force+0x5d/0x8a
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c020a433>] syncd+0x46/0x8e
 [<c020a3ed>] syncd+0x0/0x8e
 [<c0106e19>] kernel_thread_helper+0x5/0xb

bash          S 00000001  6528   144      1 31785     145   133 (NOTLB)
f74f7f3c 00000086 c2439c80 00000001 0000000f 7abb2065 00000000 f5097800 
       f5097820 c260c340 f7764ce0 c0118e24 f5097800 c260c340 c2439c80 000061e2 
       b70403b4 00000493 f7764ce0 f7764ea8 fffffe00 f74f6000 f7764d88 f7764d88 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cdfd>] sigprocmask+0x64/0xf0
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S 00000001  6132   145      1           146   144 (NOTLB)
f74f5e7c 00000086 c2441c80 00000001 0000000f c026b232 f762b000 00000000 
       f74f5e64 0000000b 0000000b f762b000 c025d69a f762b000 c2441c80 00005d90 
       d2a53020 000002ce f77646b0 f7764878 f762b000 7fffffff f7c49680 f75ac000 
Call Trace:
 [<c026b232>] con_write+0x39/0x47
 [<c025d69a>] opost_block+0x112/0x1da
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c02c5474>] vgacon_cursor+0x100/0x206
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c025f1f3>] write_chan+0x157/0x21a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c012cf88>] sys_rt_sigprocmask+0xff/0x18a
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

agetty        S 00000001  5872   146      1           147   145 (NOTLB)
c262fe7c 00000086 c2441c80 00000001 0000000f c2782ca0 ffffffff f77b4e00 
       00000020 c0495868 c026a7c1 f77b4e00 00000020 00000008 c2441c80 0000a771 
       32faa162 0000000c c27c4ce0 c27c4ea8 f76af000 7fffffff c2604b80 f76ae000 
Call Trace:
 [<c026a7c1>] do_con_write+0x27e/0x731
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c025f1f3>] write_chan+0x157/0x21a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c02323c0>] __copy_to_user_ll+0x68/0x6c
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

agetty        S 00000001  6668   147      1           160   146 (NOTLB)
f74ffe7c 00000082 c2439c80 00000001 0000000f c2782ca0 ffffffff c2621c00 
       00000020 c0495868 c026a7c1 c2621c00 00000020 00000008 c2439c80 0002320f 
       32f9f644 0000000c c2681940 c2681b08 f770a000 7fffffff c2604080 f7709000 
Call Trace:
 [<c026a7c1>] do_con_write+0x27e/0x731
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c025f1f3>] write_chan+0x157/0x21a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c02323c0>] __copy_to_user_ll+0x68/0x6c
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S 00000001    80   160      1 25339    2144   147 (NOTLB)
f771bf3c 00000086 c2429c80 00000001 0000000f 5d4d7065 00000000 f7c50d00 
       f7c50d20 c260ce40 c27c4080 c0118e24 f7c50d00 c260ce40 c2429c80 000039b9 
       f072f2a1 000005c8 c27c4080 c27c4248 fffffe00 f771a000 c27c4128 c27c4128 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cdfd>] sigprocmask+0x64/0xf0
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

pdflush       S 00000001  5444  2144      1          2968   160 (L-TLB)
ed1a9fac 00000046 c2431c80 00000001 0000000f 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 c2431c80 0000079b 
       cad33e32 00000353 f7d666b0 f7d66878 ed1a9fdc ed1a8000 ed1a9fd0 ffffe000 
Call Trace:
 [<c0140603>] __pdflush+0xab/0x20c
 [<c0140764>] pdflush+0x0/0x13
 [<c0140773>] pdflush+0xf/0x13
 [<c0106e14>] kernel_thread_helper+0x0/0xb
 [<c0106e19>] kernel_thread_helper+0x5/0xb

pdflush       S 00000000  5272  2968      1         24952  2144 (L-TLB)
ed309fac 00000046 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 d9dd7940 c2439c80 0000979e 
       24cb0f6d 00000df6 f42e8080 f42e8248 ed309fdc ed308000 ed309fd0 ffffe000 
Call Trace:
 [<c0140603>] __pdflush+0xab/0x20c
 [<c0140764>] pdflush+0x0/0x13
 [<c0140773>] pdflush+0xf/0x13
 [<c0106e14>] kernel_thread_helper+0x0/0xb
 [<c0106e19>] kernel_thread_helper+0x5/0xb

bash          S 00000001  5872 24952      1          2924  2968 (NOTLB)
f74fde7c 00000082 c2431c80 00000001 0000000f c026b232 f2d2d000 00000000 
       f74fde64 00000012 00000012 f2d2d000 c025d69a f2d2d000 c2431c80 0000607d 
       40ac8c4a 0000058f f7765310 f77654d8 f2d2d000 7fffffff e866c280 e9372000 
Call Trace:
 [<c026b232>] con_write+0x39/0x47
 [<c025d69a>] opost_block+0x112/0x1da
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c013a333>] unlock_page+0x15/0x57
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c025f1f3>] write_chan+0x157/0x21a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c012cf88>] sys_rt_sigprocmask+0xff/0x18a
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xfs_syncd     S 00000001     0  2924      1         30337 24952 (L-TLB)
e806ff9c 00000046 c2439c80 00000001 0000000f 28719838 c04675a0 00000200 
       e806ff8c 00000092 f28b4080 4e9e8332 00000b79 f28b4080 c2439c80 000000e9 
       b528a8c7 00000df4 c2680080 c2680248 00e628e4 e806ffb0 00000000 00000000 
Call Trace:
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c020a433>] syncd+0x46/0x8e
 [<c020a3ed>] syncd+0x0/0x8e
 [<c0106e19>] kernel_thread_helper+0x5/0xb

top           S 00000000     0 31785    144                     (NOTLB)
f2675eb0 00000082 c03b9980 00000000 00000000 5b1b2020 00000000 f28b46b0 
       00000010 c03ba580 00000000 000000d0 0000004b d9dd7940 c2439c80 00039b03 
       cab2b561 00000df6 f28b46b0 f28b4878 00e5e266 f2675ec4 00000001 00000001 
Call Trace:
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

startx        S 00000001     0 25339    160 25352               (NOTLB)
f22f1f3c 00000082 c2431c80 00000001 0000000f 3809e067 00000000 e8192080 
       e81920a0 f4a29380 f42e8ce0 c0118e24 e8192080 f4a29380 c2431c80 00013571 
       f3d7927a 000005c8 f42e8ce0 f42e8ea8 fffffe00 f22f0000 f42e8d88 f42e8d88 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xinit         S 00000001    52 25352  25339 25353               (NOTLB)
d175df50 00000082 c2429c80 00000001 0000000f d175df88 d175c000 d175c000 
       d175df68 c011c903 00000000 f2d47940 c011c5f9 00000000 c2429c80 00007885 
       97dd49df 000005c9 f2d47940 f2d47b08 fffffe00 d175c000 f2d479e8 f2d479e8 
Call Trace:
 [<c011c903>] wait_for_completion+0x88/0xea
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0107717>] sys_vfork+0x37/0x3b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

X             S 00000000     0 25353  25352         25358       (NOTLB)
e7ab7eb0 00003086 c03b9980 00000000 00000000 ffffffff 00000000 e887b310 
       00000010 c03ba580 00000000 000000d0 e887b6a0 d9dd7940 c2439c80 00000862 
       01a2d48f 00000df7 e887b310 e887b4d8 00e79f46 e7ab7ec4 00000014 00000014 
Call Trace:
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xterm         S 00000001     0 25358  25352 25359         25353 (NOTLB)
c7c7feb0 00000086 c2431c80 00000001 0000000f c03b9980 00000000 00000000 
       c2431c80 00000000 f2d46080 00000010 c03ba580 00000000 c2431c80 0000506a 
       fbbf743e 00000823 f2d46080 f2d46248 00000000 7fffffff 00000005 00000005 
Call Trace:
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025f3c0>] normal_poll+0x10a/0x150
 [<c025b5a2>] tty_poll+0x65/0x73
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

twm           S 00000000     0 25359  25358         25360       (NOTLB)
ce895eb0 00000086 ce895f40 00000000 c013eccf c03b9980 00000000 00000000 
       00000046 00000000 e887b940 00000010 c03ba580 d0a9a080 c2431c80 000004a3 
       57ba73e0 00000df6 e887b940 e887bb08 00000000 7fffffff 00000004 00000004 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<f88686f3>] unix_poll+0x2b/0x99 [unix]
 [<c02e4ccc>] sock_poll+0x29/0x31
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c02e4af8>] sock_ioctl+0x114/0x2bf
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xclock        S 00000000     0 25360  25358         25361 25359 (NOTLB)
f2e3beb0 00000086 f2e3bf40 00000000 c013eccf c03b9980 00000000 00000000 
       00000000 00000000 d0a9a080 00000282 c03ba580 d0a9a080 c2429c80 00000130 
       fee8bb08 00000def f2d46ce0 f2d46ea8 00e64b16 f2e3bec4 00000004 00000004 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<c0129759>] process_timeout+0x0/0x9
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c02e4af8>] sock_ioctl+0x114/0x2bf
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xterm         S 00000000     0 25361  25358 25364   25362 25360 (NOTLB)
f72fdeb0 00000082 f72fdf40 00000000 c013eccf c03b9980 00000000 00000000 
       00000282 00000000 dd865940 00000010 c03ba580 dd865940 c2441c80 0000017f 
       43b6033f 00000df6 c26806b0 c2680878 00000000 7fffffff 00000005 00000005 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025f3c0>] normal_poll+0x10a/0x150
 [<c025b5a2>] tty_poll+0x65/0x73
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xterm         R 00000000  6668 25362  25358 25363   25365 25361 (NOTLB)
ea5bbeb0 00000082 ea5bbf40 00000000 c013eccf c03b9980 00000000 00000000 
       00000282 00000000 f28b4080 00000010 c03ba580 f28b4080 c2429c80 00000118 
       006a3eef 00000df7 e887a6b0 e887a878 00000000 7fffffff 00000005 00000005 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025f3c0>] normal_poll+0x10a/0x150
 [<c025b5a2>] tty_poll+0x65/0x73
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S 00000001     0 25363  25362 24011               (NOTLB)
e78a3f3c 00000086 c2441c80 00000001 0000000f 7c645065 00000000 cf006800 
       cf006820 f357c480 f7764080 c0118e24 cf006800 f357c480 c2441c80 00004399 
       c6195e5e 00000dc4 f7764080 f7764248 fffffe00 e78a2000 f7764128 f7764128 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cdfd>] sigprocmask+0x64/0xf0
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S 00000001     0 25365  25358               25362 (NOTLB)
cc981e7c 00000082 c2429c80 00000001 0000000f 00000000 00000003 00000008 
       00000008 d0837000 cc981e6c 00000008 c025d69a e1ce0ce0 c2429c80 0000201b 
       f6c9db7d 00000821 f7d66ce0 f7d66ea8 d0837000 7fffffff ea390080 d0675000 
Call Trace:
 [<c025d69a>] opost_block+0x112/0x1da
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c013a333>] unlock_page+0x15/0x57
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c011c285>] schedule+0x36e/0x69f
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c012cf88>] sys_rt_sigprocmask+0xff/0x18a
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S 00000001     0 25364  25361 26236               (NOTLB)
d185ff3c 00000086 c2429c80 00000001 0000000f 7cd15067 00000000 c2793800 
       c2793820 f50cc180 e887a080 c0118e24 c2793800 f50cc180 c2429c80 000036f8 
       ee909e0f 00000bb9 e887a080 e887a248 fffffe00 d185e000 e887a128 e887a128 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cdfd>] sigprocmask+0x64/0xf0
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

xterm         S 00000000     0 30337      1 30338          2924 (NOTLB)
ce931eb0 00000086 ce931f40 00000000 c013eccf c03b9980 00000000 00000000 
       c040ad88 00000000 d9dd66b0 00000010 c03ba580 d9dd7940 c2439c80 00000dc6 
       feaf377c 00000df6 d9dd66b0 d9dd6878 00000000 7fffffff 00000005 00000005 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c025f3c0>] normal_poll+0x10a/0x150
 [<c025b5a2>] tty_poll+0x65/0x73
 [<c016d967>] do_select+0x1a8/0x2fa
 [<c016d619>] __pollwait+0x0/0xc7
 [<c016dda5>] sys_select+0x2c7/0x4e3
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S C03B9F80     0 30338  30337                     (NOTLB)
cbf7fe7c 00000086 c013eccf c03b9f80 00000000 00000000 c03ba000 0000001f 
       0000001f d9239000 cbf7fe83 0000001f c025d69a d9dd7940 c2431c80 00001532 
       c2d7f35b 00000dee c3a0e6b0 c3a0e878 d9239000 7fffffff cd334a80 eabf7000 
Call Trace:
 [<c013eccf>] __alloc_pages+0x9d/0x328
 [<c025d69a>] opost_block+0x112/0x1da
 [<c012981f>] schedule_timeout+0xbd/0xbf
 [<c014f013>] page_remove_rmap+0x19/0x1a9
 [<c013a333>] unlock_page+0x15/0x57
 [<c025eefe>] read_chan+0x734/0x8d2
 [<c025f1f3>] write_chan+0x157/0x21a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c025a049>] tty_write+0x1a2/0x2e5
 [<c025e7ca>] read_chan+0x0/0x8d2
 [<c0259e76>] tty_read+0x14d/0x17e
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c012cf88>] sys_rt_sigprocmask+0xff/0x18a
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

make          S 00000001     0 26236  25364 26238               (NOTLB)
cfcb9f50 00000082 c2431c80 00000001 0000000f cfcb9f88 cfcb8000 cfcb8000 
       cfcb9f68 c011c903 00000000 dde56080 c011c5f9 00000000 c2431c80 00003f1c 
       ef27ee50 00000bb9 dde56080 dde56248 fffffe00 cfcb8000 dde56128 dde56128 
Call Trace:
 [<c011c903>] wait_for_completion+0x88/0xea
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cf43>] sys_rt_sigprocmask+0xba/0x18a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108f45>] sysenter_past_esp+0x52/0x71

make          S 00000001     0 26238  26236 26239               (NOTLB)
ca36ff50 00000082 c2431c80 00000001 0000000f daaf8ce0 c0118e24 da610080 
       c5bac140 400cbd60 00000000 00000000 400cbd60 00000000 c2431c80 00008105 
       ef92f36e 00000bb9 daaf8ce0 daaf8ea8 fffffe00 ca36e000 daaf8d88 daaf8d88 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cf43>] sys_rt_sigprocmask+0xba/0x18a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S 00000001     0 26239  26238  3291               (NOTLB)
c5429f3c 00000086 c2429c80 00000001 0000000f 51cd7067 00000000 cf006d00 
       cf006d20 c5bac580 c3a0f940 c0118e24 cf006d00 c5bac580 c2429c80 00011bc1 
       b5359ea7 00000dd4 c3a0f940 c3a0fb08 fffffe00 c5428000 c3a0f9e8 c3a0f9e8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

bash          S FFFDF3B4     0 24011  25363  3310               (NOTLB)
e3129f3c 00000082 080ed688 fffdf3b4 e6730080 56a73067 00000000 cf006580 
       cf0065a0 d85abec0 e13626b0 c0118e24 cf006580 f2d466b0 c2431c80 00001fb9 
       0c59223a 00000df6 e13626b0 e1362878 fffffe00 e3128000 e1362758 e1362758 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cdfd>] sigprocmask+0x64/0xf0
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S 00000001     0  3291  26239  3292               (NOTLB)
e7e73f3c 00000086 c2441c80 00000001 0000000f 56e54067 00000000 c6045300 
       c6045320 f4a29300 c3a0e080 c0118e24 c6045300 f4a29300 c2441c80 0001acef 
       b536258b 00000dd4 c3a0e080 c3a0e248 fffffe00 e7e72000 c3a0e128 c3a0e128 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

make          S 00000001    16  3292   3291  3293               (NOTLB)
ddbe1f50 00000086 c2429c80 00000001 0000000f f28b4ce0 c0118e24 f7c50800 
       e13619c0 400cbd60 00000000 00000000 400cbd60 00000000 c2429c80 00005d98 
       b5aec1f8 00000dd4 f28b4ce0 f28b4ea8 fffffe00 ddbe0000 f28b4d88 f28b4d88 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c012cf43>] sys_rt_sigprocmask+0xba/0x18a
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S 00000001     0  3293   3292  3297               (NOTLB)
d3df3f3c 00000086 c2441c80 00000001 0000000f 415d2067 00000000 d3de8d00 
       d3de8d20 f48a3b80 e1bcd310 c0118e24 d3de8d00 f48a3b80 c2441c80 0001b2fa 
       b600937f 00000dd4 e1bcd310 e1bcd4d8 fffffe00 d3df2000 e1bcd3b8 e1bcd3b8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S 00000001    16  3297   3293  3298               (NOTLB)
d0d61f3c 00000086 c2431c80 00000001 0000000f 66ffa067 00000000 da610d00 
       da610d20 df58d440 f42e9940 c0118e24 da610d00 df58d440 c2431c80 0001116c 
       b60b08f0 00000dd4 f42e9940 f42e9b08 fffffe00 d0d60000 f42e99e8 f42e99e8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

make          S DF68FE74  4048  3298   3297  3300               (NOTLB)
df68feb4 00000086 cffe7380 df68fe74 00000000 00000000 f7e58a9c bf829f33 
       df68e000 f15a028c 00000001 f1613080 dfa7b000 d0a9a080 c2429c80 0002fe53 
       b73f8284 00000dd4 e1362080 e1362248 cf5659ec cf565980 df68fedc 00000001 
Call Trace:
 [<c0166da4>] pipe_wait+0x7c/0x9c
 [<c011e87b>] autoremove_wake_function+0x0/0x4f
 [<c011e87b>] autoremove_wake_function+0x0/0x4f
 [<c0164425>] cp_new_stat64+0x114/0x129
 [<c0166fa2>] pipe_readv+0x1de/0x2d1
 [<c01670cc>] pipe_read+0x37/0x3b
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S FFFDF384     0  3300   3298  3303    3301       (NOTLB)
dccb1f3c 00000082 080e1384 fffdf384 ca68e080 4d812067 00000000 ef993580 
       ef9935a0 d85abe00 d9dd7310 c0118e24 ef993580 d9dd7940 c2431c80 000192b8 
       b9bd1466 00000dd4 d9dd7310 d9dd74d8 fffffe00 dccb0000 d9dd73b8 d9dd73b8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S FFFC3384   188  3301   3298  3305    3302  3300 (NOTLB)
c5de1f3c 00000082 080e1384 fffc3384 dbd51080 4640b067 00000000 d3de8580 
       d3de85a0 f432d100 dd865310 c0118e24 d3de8580 dd865940 c2441c80 000226f6 
       b6fa3445 00000dd4 dd865310 dd8654d8 fffffe00 c5de0000 dd8653b8 dd8653b8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S FFFD1384     0  3302   3298  3306    3304  3301 (NOTLB)
d9f77f3c 00000086 080e1384 fffd1384 db180080 6b043067 00000000 d3de8800 
       d3de8820 f432d180 d0a9b310 c0118e24 d3de8800 f28b4080 c2439c80 00018c37 
       b788d9a8 00000dd4 d0a9b310 d0a9b4d8 fffffe00 d9f76000 d0a9b3b8 d0a9b3b8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            S FFFED384     0  3304   3298  3307          3302 (NOTLB)
d6115f3c 00000086 080e1384 fffed384 d303e080 38f65067 00000000 c6729800 
       c6729820 d8512e40 f42e9310 c0118e24 c6729800 e1362080 c2429c80 000197cf 
       b73c8431 00000dd4 f42e9310 f42e94d8 fffffe00 d6114000 f42e93b8 f42e93b8 
Call Trace:
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0123cb0>] sys_wait4+0x1ac/0x272
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c011c5f9>] default_wake_function+0x0/0x12
 [<c0123d9d>] sys_waitpid+0x27/0x2b
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            R 0000001B     0  3303   3300                     (NOTLB)
ffffffff c011bf7f c243b674 0000001b d9dd7940 d0ff9d1c d0ff9d1c 00000000 
       00000001 c040ad88 0000000a 00000046 00000046 c040ad88 c0464108 00000002 
       c0464104 d0ff9d6c c0115f1d 00000000 00031324 00000000 f641ee20 00000ff0 
Call Trace:
 [<c011bf7f>] schedule+0x68/0x69f
 [<c0115f1d>] smp_apic_timer_interrupt+0xdd/0x145
 [<c0109986>] apic_timer_interrupt+0x1a/0x20
 [<c013ab45>] do_generic_mapping_read+0x78/0x554
 [<c013b021>] file_read_actor+0x0/0xec
 [<c013b2f9>] __generic_file_aio_read+0x1ec/0x21e
 [<c013b021>] file_read_actor+0x0/0xec
 [<c013eb5c>] buffered_rmqueue+0xed/0x1c3
 [<c0208b06>] xfs_read+0x174/0x2a0
 [<c0204b51>] linvfs_read+0x8d/0x9f
 [<c0159996>] do_sync_read+0x8b/0xb7
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c014cf8f>] do_brk+0x13d/0x21b
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c012cf88>] sys_rt_sigprocmask+0xff/0x18a
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            R current      0  3306   3302                     (NOTLB)
00000000 cd58fee8 f7c22740 04000001 00000000 cd58fee8 c010b16a 00000001 
       c049bda0 cd58fee8 c0403080 cd58e000 00000001 f7c22740 c010b51d 00000001 
       cd58fee8 f7c22740 c0403098 f7c22740 00031324 00000000 f641ee20 cd58ff7c 
Call Trace:
 [<c010b16a>] handle_IRQ_event+0x3a/0x64
 [<c010b51d>] do_IRQ+0xb8/0x192
 [<c0109904>] common_interrupt+0x18/0x20
 [<c0163c62>] generic_fillattr+0x86/0xa6
 [<c020817b>] linvfs_getattr+0x27/0x3f
 [<c0163cbb>] vfs_getattr+0x39/0x9a
 [<c0163e08>] vfs_fstat+0x39/0x50
 [<c01644c7>] sys_fstat64+0x1b/0x39
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            R 0000001B    12  3305   3301                     (NOTLB)
c01294d2 00000000 c2443674 0000001b dd865940 e3f8be98 e3f8be98 00000000 
       00000001 c040ad88 0000000a 00000046 00000046 c040ad88 c0464108 00000003 
       c0464104 e3f8bee8 c0115f1d 00000000 00031324 00000000 f641ee20 e3f8bf7c 
Call Trace:
 [<c01294d2>] run_timer_softirq+0xe5/0x1c2
 [<c0115f1d>] smp_apic_timer_interrupt+0xdd/0x145
 [<c0109986>] apic_timer_interrupt+0x1a/0x20
 [<c0163c62>] generic_fillattr+0x86/0xa6
 [<c020817b>] linvfs_getattr+0x27/0x3f
 [<c0163cbb>] vfs_getattr+0x39/0x9a
 [<c0163e08>] vfs_fstat+0x39/0x50
 [<c01644c7>] sys_fstat64+0x1b/0x39
 [<c0108f45>] sysenter_past_esp+0x52/0x71

sh            R 16D8447A    12  3307   3304                     (NOTLB)
e75ebd64 00000086 c2433674 16d8447a d0a9a080 e75ebd1c e75ebd1c 00000000 
       00000001 c040ad88 0000000a 00000046 00000046 c040ad88 c0464108 00000001 
       c0464104 e75ebd6c c0115f1d 00000000 00031324 00000000 f641ee20 00000000 
Call Trace:
 [<c0115f1d>] smp_apic_timer_interrupt+0xdd/0x145
 [<c0109986>] apic_timer_interrupt+0x1a/0x20
 [<c013ab42>] do_generic_mapping_read+0x75/0x554
 [<c013b021>] file_read_actor+0x0/0xec
 [<c013b2f9>] __generic_file_aio_read+0x1ec/0x21e
 [<c013b021>] file_read_actor+0x0/0xec
 [<c013eb5c>] buffered_rmqueue+0xed/0x1c3
 [<c0208b06>] xfs_read+0x174/0x2a0
 [<c013bb83>] filemap_nopage+0x3c2/0x456
 [<c0204b51>] linvfs_read+0x8d/0x9f
 [<c0159996>] do_sync_read+0x8b/0xb7
 [<c0118e24>] do_page_fault+0x2f5/0x4df
 [<c0205776>] linvfs_ioctl+0x41/0x80
 [<c0159a72>] vfs_read+0xb0/0x119
 [<c0159ced>] sys_read+0x42/0x63
 [<c0108f45>] sysenter_past_esp+0x52/0x71

mplayer       S F8931EAD     0  3310  24011                     (NOTLB)
d3643f50 00200082 085d6cc0 f8931ead f76e2480 d3643f70 d3643f70 00000000 
       00000009 d3642000 d0a9a080 e70b0ca8 e70b0ca4 d0a9a080 c2431c80 00000401 
       179eb5c9 00000df7 f2d466b0 f2d46878 00e5dbc5 d3643f64 0000000c 00000000 
Call Trace:
 [<f8931ead>] snd_pcm_playback_ioctl1+0x5e/0x45d [snd_pcm]
 [<c01297cd>] schedule_timeout+0x6b/0xbf
 [<f89e06e3>] snd_pcm_oss_get_space+0xab/0x160 [snd_pcm_oss]
 [<c0129759>] process_timeout+0x0/0x9
 [<c01299e1>] sys_nanosleep+0x103/0x1a9
 [<c0108f45>] sysenter_past_esp+0x52/0x71


--Boundary-00=_XSoMAzBxEKwtd0F--
