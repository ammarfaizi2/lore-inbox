Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136763AbREAXQe>; Tue, 1 May 2001 19:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136764AbREAXQU>; Tue, 1 May 2001 19:16:20 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:63637 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136763AbREAXPM>; Tue, 1 May 2001 19:15:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] pdc20267 and dma timeouts
Date: Tue, 1 May 2001 19:15:04 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050119150400.08153@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running 2.4.4 with the lvm -0.91 beta7 patches applied on a debian
sid base.   When I checked my box this morning the follow greeted me on 
the serial console.  The reiserfs errors are caused by the DMA timeout.
Note this is a ultra100 controller not supporting raid.

hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
is_tree_node: node level 15360 does not match to the expected one 1
vs-5150: search_by_key: invalid format found in block 40470. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data o]vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (112833 113085) not found
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: DMA disabled
ide2: reset: success
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: irq timeout: status=0x50 { DriveReady pmlete }
hde: lost interrupt
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: lost interrupt
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: lost interrupt
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: irq timeout: status=0x50 { DriveReady SeekComplete }
hdg: DMA disabled
ide3: reset: success
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt

with another lost interrupt entry added every couple of seconds.  Looks like
the reset is not working...  Here is a lspci -vv of the device

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at b000 [size=8]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=64]
        Region 5: Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at eb000000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

and proc/ide/pdc20267
                                PDC20267 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 66 External
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 11
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled
66 Clocking     enabled                          enabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               yes
DMA Mode:       UDMA 4           NOTSET          UDMA 4            NOTSET
PIO Mode:       PIO 4            NOTSET           PIO 4            NOTSET

The drives both get about 25-28M/S.

dmesg gives:

Linux version 2.4.4 (ed@oscar) (gcc version 2.95.4 20010319 (Debian prerelease)) #1 Sun Apr 29 22:44:51 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone(1): 77808 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=3a01 console=tty0 console=ttyS0,38400 video=matrox:mem:32 idebus=33 hdb=
none hdf=none hdh=none
ide_setup: idebus=33
ide_setup: hdb=none
ide_setup: hdf=none
ide_setup: hdh=none
Initializing CPU#0
Detected 400.921 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 318996k/327616k available (936k kernel code, 8236k reserved, 316k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE8000000, mapped to 0xd4805000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
block: queued sectors max/low 211618kB/80546kB, 640 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict in pirq table for device 00:0a.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb000-0xb007,0xb402 on irq 9
ide3 at 0xb800-0xb807,0xbc02 on irq 9
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=1684/255/63, UDMA(33)
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hde: hde1
 hdg: hdg1
RAMDISK: Compressed image found at block 0

Ideas?

Ed Tomlinson <tomlins@cam.org>
