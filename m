Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSC1Rio>; Thu, 28 Mar 2002 12:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313192AbSC1Rie>; Thu, 28 Mar 2002 12:38:34 -0500
Received: from rizzo.jerky.net ([204.57.55.99]:37125 "EHLO rizzo.jerky.net")
	by vger.kernel.org with ESMTP id <S313190AbSC1RiU>;
	Thu, 28 Mar 2002 12:38:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Chris Danielson <tdc@phreaker.net>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx SCSI problem on 2.4.18-SMP
Date: Thu, 28 Mar 2002 18:36:41 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02032818364100.04530@void.pvt.net>
Content-Transfer-Encoding: 7BIT
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please, reply to my mail, i'm not subscribed to lkml)

Hi,
I have a problem to get aic7xxx running on SMP machine. Problem started when 
i upgraded from old RedHat 6.2 (with many modifications) to new MandrakeLinux.
The machine is old (1996) dual PPRO 200MHz, 128M Ram, Adaptec 2940 UltraWide 
SCSI adapter (AIC7880) with 3 drives attached, running MandrakeLinux 8.2.
When probing SCSI, it hangs a while, and then it starts to write those 
well-known messages ad-infinitum (and machine won't boot):
---
scsi0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Command phase, at SEQADDR 0xbf
ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0xa
SCSISEQ = 0x12, SBLKCTL = 0xa
.....
---
These are maybe not accurate, if you need exact ones, i have to rewrite them 
from screen - in this state, they are not written to log :((

It happens ONLY when running SMP kernel - when using UniProcessor one, 
everything works ok. I tested several combinations:

hangs:
SMP kernel 2.4.18 (mandrake), "new" aic7xxx driver rev 6.2.4 as module 
(default install)
SMP kernel 2.4.18 (mandrake), "new" aic7xxx driver rev 6.2.4 compiled-in 
SMP kernel 2.4.18 (mandrake), aic7xxx_old driver rev 5.2.0 as module
SMP kernel 2.4.18 (mandrake), aic7xxx_old driver rev 5.2.0 as compiled-in
SMP kernel 2.4.18 (linus), "new" aic7xxx driver rev 6.2.4 as module
SMP kernel 2.4.18 (linus), "new" aic7xxx driver rev 6.2.4 compiled-in 
SMP kernel 2.4.18 (linus), aic7xxx_old driver rev 5.2.0 as module
SMP kernel 2.4.18 (linus), aic7xxx_old driver rev 5.2.0 as compiled-in

works:
UniProc kernel 2.4.18 (mandrake), "new" aic7xxx driver rev 6.2.4 as module 
(default install)
UniProc kernel 2.4.18 (mandrake), "new" aic7xxx driver rev 6.2.4 compiled-in 
UniProc kernel 2.4.18 (linus), "new" aic7xxx driver rev 6.2.4 as module
(i didn't tested more UP combinations, looks they all would work)

(no HIMEM was used on compiled kernels)

There was some article about combining writes enabled in BIOS on some VIA 
motherboards, so i checked my BIOS and only similiar option i have found was 
"PCI Burst Write Combine". Even when disabled, results are still the same.

Any ideas how to start SMP on this?
Thx Chris


dmesg of 2.4.18-6mdk (UniProcessor):
---
Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version 2.96 
20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f0d10
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux ro root=801 devfs=mount
Initializing CPU#0
Detected 199.794 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.13 BogoMIPS
Memory: 126312k/131072k available (1170k kernel code, 4376k reserved, 332k 
data, 260k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
CPU:             Common caps: 0000fbff 00000000 00000000 00000000
CPU: Intel Pentium Pro stepping 09
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
hda: IC35L120AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Uncompressing...........done.
Freeing initrd memory: 249k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
 
  Vendor: SEAGATE   Model: ST34371W          Rev: 0484
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST34371W          Rev: 0484
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: ST32171W          Rev: 0388
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi0:A:5:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 5, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sda: 8496884 512-byte hdwr sectors (4350 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdb: 8496884 512-byte hdwr sectors (4350 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 < p5 p6 p7 p8 p9 >
(scsi0:A:5): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdc: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target5/lun0: p1
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 260k freed
Real Time Clock Driver v1.10e
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
Adding Swap: 312476k swap-space (priority -1)
---

lspci -v:
---
00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
        Flags: bus master, medium devsel, latency 32
 
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
        Flags: bus master, medium devsel, latency 0
 
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] 
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at f000 [size=16]
 
00:0c.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] 
(prog-if 00 [VGA])
        Flags: medium devsel
        Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0d.0 SCSI storage controller: Adaptec AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at 8000 [disabled] [size=256]
        Memory at e0800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0e.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at 8100 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]
---

