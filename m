Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133042AbRDRHGa>; Wed, 18 Apr 2001 03:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133043AbRDRHGV>; Wed, 18 Apr 2001 03:06:21 -0400
Received: from a29d2hel.dial.kolumbus.fi ([212.54.16.29]:3117 "EHLO
	darkmoon.imagesoft") by vger.kernel.org with ESMTP
	id <S133042AbRDRHGC>; Wed, 18 Apr 2001 03:06:02 -0400
Message-ID: <3ADD3CE9.12F309F7@imagesoft.fi>
Date: Wed, 18 Apr 2001 10:06:17 +0300
From: Jussi Laako <jussi.laako@imagesoft.fi>
Organization: Image Soft Oy
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac7: PDC20265 / VIA chipset / aic7xxx deadlock/panic
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get deadlock soon after boot with 2.4.3-ac7 with PDC20265/VIA when booting
_without_ idex=noautotune. System seems to be stable with noautotune
parameter. Motherboard is ASUS A7V133 with Duron/800.

Another problem is aic7xxx driver, the system as Adaptec 2930UC SCSI card
with HP's 24 GB DAT attached to it. If I modprobe aic7xxx the kernel panics.

Here's dmesg:

--- 8< ---

Linux version 2.4.3-ac7 (root@davinci) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #4 Tue Apr 17 15:32:09 EEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fec000 (usable)
 BIOS-e820: 0000000007fec000 - 0000000007fef000 (ACPI data)
 BIOS-e820: 0000000007fef000 - 0000000007fff000 (reserved)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=2104
BOOT_FILE=/boot/vmlinuz ide0=noautotune ide1=noautotune ide2=noautotune
ide3=noautotune panic=60
ide_setup: ide0=noautotune
ide_setup: ide1=noautotune
ide_setup: ide2=noautotune
ide_setup: ide3=noautotune
Initializing CPU#0
Detected 807.207 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1608.90 BogoMIPS
Memory: 126852k/130992k available (901k kernel code, 3748k reserved, 218k
data, 176k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA PCI latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 84248kB/28082kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:DMA, hdh:DMA
hda: SONY CDU4811, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hdf: IBM-DTLA-307030, ATA DISK drive
hdg: IBM-DTLA-307030, ATA DISK drive
hdh: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8800-0x8807,0x8402 on irq 10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdf: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdh: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
Partition check:
 hde: [PTBL] [3737/255/63] hde1 hde2 hde3 hde4
 hdf: unknown partition table
 hdg: unknown partition table
 hdh: unknown partition table
ACPI: APM is already active, exiting
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1219.200 MB/sec
   32regs    :   792.800 MB/sec
   pII_mmx   :  1887.600 MB/sec
   p5_mmx    :  2411.200 MB/sec
raid5: using function: p5_mmx (2411.200 MB/sec)
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding Swap: 265064k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 15:36:50 Apr 17 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
(read) hdf's sb offset: 30018176 [events: 00000009]
(read) hdg's sb offset: 30018176 [events: 00000009]
(read) hdh's sb offset: 30018176 [events: 00000009]
autorun ...
considering hdh ...
  adding hdh ...
  adding hdg ...
  adding hdf ...
created md0
bind<hdf,1>
bind<hdg,2>
bind<hdh,3>
running: <hdh><hdg><hdf>
now!
hdh's event counter: 00000009
hdg's event counter: 00000009
hdf's event counter: 00000009
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid5: device hdh operational as raid disk 2
raid5: device hdg operational as raid disk 1
raid5: device hdf operational as raid disk 0
raid5: allocated 3264kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdf
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdh
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdf
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdh
md: updating md0 RAID superblock on device
hdh [events: 0000000a](write) hdh's sb offset: 30018176
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 30018176 blocks.
hdg [events: 0000000a](write) hdg's sb offset: 30018176
hdf [events: 0000000a](write) hdf's sb offset: 30018176
.
... autorun DONE.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0x9400,  00:01:02:dd:83:52, IRQ 5
  product code 464a rev 00.13 date 10-10-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
eth0: using NWAY device table, not 8
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (interrupt-driven).

--- 8< ---

Here's SCSI log entries:

--- 8< ---

Apr 17 16:09:36 davinci kernel: SCSI subsystem driver Revision: 1.00
Apr 17 16:09:36 davinci kernel: PCI: Found IRQ 15 for device 00:0a.0
Apr 17 16:09:36 davinci kernel: scsi0: brkadrint, PCI Error detected at
seqaddr
= 0x1bd
Apr 17 16:09:36 davinci kernel: scsi0: Dumping Card State in unknown phase,
at SEQADDR 0x1bd
Apr 17 16:09:36 davinci kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Apr 17 16:09:36 davinci kernel:  DFCNTRL = 0x0, DFSTATUS = 0x29
Apr 17 16:09:36 davinci kernel: LASTPHASE = 0xff, SCSISIGI = 0x0, SXFRCTL0 =
0x88
Apr 17 16:09:36 davinci kernel: SSTAT0 = 0x5, SSTAT1 = 0x0
Apr 17 16:09:36 davinci kernel: STACK == 0x0, 0x0, 0x0, 0x0
Apr 17 16:09:36 davinci kernel: SCB count = 4
Apr 17 16:09:36 davinci kernel: Kernel NEXTQSCB = 3
Apr 17 16:09:36 davinci kernel: Card NEXTQSCB = 3
Apr 17 16:09:36 davinci kernel: QINFIFO entries:
Apr 17 16:09:36 davinci kernel: Waiting Queue entries:
Apr 17 16:09:36 davinci kernel: Disconnected Queue entries:
Apr 17 16:09:36 davinci kernel: QOUTFIFO entries:
Apr 17 16:09:36 davinci kernel: Sequencer Free SCB List: 0 1 2
Apr 17 16:09:36 davinci kernel: Pending list:
Apr 17 16:09:36 davinci kernel: Kernel Free SCB list: 2 1 0
Apr 17 16:09:36 davinci kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.1.11
Apr 17 16:09:36 davinci kernel:         <Adaptec 2930CU SCSI adapter>
Apr 17 16:09:36 davinci kernel:         aic7860: Single Channel A, SCSI
Id=7, 3/255 SCBs
Apr 17 16:09:36 davinci kernel:
Apr 17 16:09:57 davinci kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Apr 17 16:09:57 davinci kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Apr 17 16:09:57 davinci kernel: aic7xxx_abort returns 8194
Apr 17 16:10:07 davinci kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Apr 17 16:10:07 davinci kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Apr 17 16:10:07 davinci kernel: aic7xxx_abort returns 8194
Apr 17 16:10:07 davinci kernel: scsi0:0:0:0: Attempting to queue a TARGET
RESET
message
Apr 17 16:10:07 davinci kernel: scsi0:0:0:0: Is not an active device
Apr 17 16:10:07 davinci kernel: aic7xxx_dev_reset returns 8194
Apr 17 16:10:17 davinci kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Apr 17 16:10:17 davinci kernel: Waiting List inconsistency. SCB index ==
255, yet numscbs == 4.scsi0: Dumping Card State while idle, at SEQADDR 0x18
Apr 17 16:10:17 davinci kernel: SCSISEQ = 0x1a, SBLKCTL = 0xc0
Apr 17 16:10:17 davinci kernel:  DFCNTRL = 0x4, DFSTATUS = 0x69
Apr 17 16:10:17 davinci kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x0
Apr 17 16:10:17 davinci kernel: SSTAT0 = 0x10, SSTAT1 = 0x88
Apr 17 16:10:17 davinci kernel: STACK == 0x17, 0x196, 0x0, 0x0
Apr 17 16:10:17 davinci kernel: SCB count = 4
Apr 17 16:10:17 davinci kernel: Kernel NEXTQSCB = 2
Apr 17 16:10:17 davinci kernel: Card NEXTQSCB = 2
Apr 17 16:10:17 davinci kernel: QINFIFO entries:
Apr 17 16:10:17 davinci kernel: Waiting Queue entries: 0:255 1:255 2:255
Apr 17 16:10:17 davinci kernel: Disconnected Queue entries:
Apr 17 16:10:17 davinci kernel: QOUTFIFO entries:
Apr 17 16:10:17 davinci kernel: Sequencer Free SCB List: 1 2
Apr 17 16:10:17 davinci kernel: Pending list:
Apr 17 16:10:17 davinci kernel: Kernel Free SCB list: 3 1 0
Apr 17 16:10:17 davinci kernel: Kernel panic: for safety

--- 8< ---

Best regards,

	- Jussi Laako

-- 
PGP key fingerprint: 3827 6A53 B7F9 180E D971  362B BB53 C8A1 B578 D249
Available at: ldap://certserver.pgp.com
