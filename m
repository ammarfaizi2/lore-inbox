Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268566AbTCCRPS>; Mon, 3 Mar 2003 12:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268575AbTCCRPS>; Mon, 3 Mar 2003 12:15:18 -0500
Received: from bunker.worldbank.ro ([141.85.31.233]:59140 "HELO
	bunker.worldbank.ro") by vger.kernel.org with SMTP
	id <S268566AbTCCRPI>; Mon, 3 Mar 2003 12:15:08 -0500
Date: Mon, 3 Mar 2003 19:29:48 +0200
From: Stefan Laudat <stefan@worldbank.ro>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.5 XFS over software linear RAID problem
Message-ID: <20030303172948.GA6101@worldbank.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux bunker 2.4.21-pre4-ac1
X-CuriousGuys-Message: If you can read this then you have to be really bored
User-Agent: Mutt/1.5.1-current-20020808i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
First of all - please reply to my personal address, I'm not subscribed to LKML. :(
I have a custom-made system, AMD duron/900Mhz, on a MSI VIA KT133A motherboard,
and  I am performing software linear RAID on 8 IDE disks, 4 of them connected on the
motherboard IDE ports and the rest to an Adaptec 1200A raid controller (basically
a renamed and unmotivated more expensive Highpoint 370 RAID controller).
I am NOT using the RAID facility of the PCI controller (as it sucks big time), it is
used just as a trivial IDE controller.
I have chosen XFS as the filesystem, and it seems to work just fine with 2.4.20+XFS patches.
I'd like to switch to 2.5 kernel but I get a nasty oops when I'm trying to mount the partition.
I got the same problem when trying to do it over two U160 SCSI disks mounted in an
Adaptec 7892P SCSI controller in an IBM x330 series server. Any idea would be highly appreciated.
Thank you.

output of ver_linux: 
Linux piratu 2.5.63 #3 Thu Feb 27 18:54:14 EET 2003 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      implemented
e2fsprogs              1.27
xfsprogs               2.0.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Kbd                    command
Sh-utils               2.0

lspci :

[root@piratu scripts]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
        Subsystem: Triones Technologies, Inc. HPT370 UDMA100
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at dc00 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at d5201000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e000 [size=64]
        Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d5200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e400 [size=64]
        Region 2: Memory at d5100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[root@piratu scripts]# cat /proc/mdstat 
Personalities : [linear] 
md0 : active linear hda3[7] hdh[6] hdg[5] hdf[4] hde[3] hdd[2] hdc[1] hdb[0]
      743166144 blocks 64k rounding


[root@piratu scripts]# cat /etc/raidtab 
raiddev                 /dev/md0
raid-level              linear
persistent-superblock   1
chunk-size              64
nr-raid-disks           8
nr-spare-disks          0
device                  /dev/hdb
raid-disk               0
device                  /dev/hdc
raid-disk               1
device                  /dev/hdd
raid-disk               2
device                  /dev/hde
raid-disk               3
device                  /dev/hdf
raid-disk               4
device                  /dev/hdg
raid-disk               5
device                  /dev/hdh
raid-disk               6
device                  /dev/hda3
raid-disk               7

[root@piratu scripts]# raidstart --version
raidstart v0.3d compiled for md raidtools-0.90


now for the crash :

[root@piratu scripts]# cat /etc/fstab 
/dev/hda1       swap        swap        defaults   0   0
/dev/hda2       /        ext3        defaults   1   1
/dev/md0         /home/ftp/.disk        xfs     noatime,noexec,nosuid,nodev,async       1       1
none             /dev/pts  devpts     gid=5,mode=620  0   0
none             /proc    proc        defaults   0   0

[root@piratu scripts]# fdisk -l /dev/md0
Segmentation fault

then dmesg output is :

linear_make_request: Block 8 out of bounds on dev ide1(22,64) size 58633280 offset 175854016
Buffer I/O error on device md(9,0), logical block 2
linear_make_request: Block 12 out of bounds on dev ide2(33,0) size 120627264 offset 234487296
Buffer I/O error on device md(9,0), logical block 3
linear_make_request: Block 16 out of bounds on dev ide2(33,64) size 120627264 offset 355114560
Buffer I/O error on device md(9,0), logical block 4
linear_make_request: Block 20 out of bounds on dev ide3(34,0) size 120627264 offset 475741824
Buffer I/O error on device md(9,0), logical block 5
linear_make_request: Block 24 out of bounds on dev ide3(34,64) size 120627264 offset 596369088
Buffer I/O error on device md(9,0), logical block 6
linear_make_request: Block 28 out of bounds on dev ide0(3,3) size 26169792 offset 716996352
Buffer I/O error on device md(9,0), logical block 7
Unable to handle kernel paging request at virtual address 170fc2ad
 printing eip:
c0249bdd
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0249bdd>]    Not tainted
EFLAGS: 00010212
EIP is at linear_make_request+0x3d/0xf0
eax: 170fc2a5   ebx: c131eeec   ecx: 170fc2a5   edx: 00000020
esi: 00000020   edi: c13164e4   ebp: ce36fcb0   esp: ce36fca0
ds: 007b   es: 007b   ss: 0068
Process fdisk (pid: 272, threadinfo=ce36e000 task=ce87db00)
Stack: c1344284 00000008 c13164e4 00000040 ce36fccc c0226f59 c13164e4 cffd4c04 
       00000000 00000000 00000008 ce36fcdc c0226fc6 cffd4c04 ce72a79c ce36fcfc 
       c0156902 00000000 cffd4c04 00000010 00000001 00000000 ce72a79c ce36fd58 
Call Trace:
 [<c0226f59>] generic_make_request+0x159/0x170
 [<c0226fc6>] submit_bio+0x56/0x70
 [<c0156902>] submit_bh+0x102/0x110
 [<c0155a7e>] block_read_full_page+0x23e/0x260
 [<c01343f1>] add_to_page_cache+0x31/0xb0
 [<c015a081>] blkdev_readpage+0x11/0x20
 [<c0159f40>] blkdev_get_block+0x0/0x50
 [<c0139ccd>] read_pages+0x8d/0x100
 [<c0139e33>] do_page_cache_readahead+0xf3/0x130
 [<c0139f42>] page_cache_readahead+0xd2/0x130
 [<c0134a38>] do_generic_mapping_read+0x68/0x340
 [<c0134f90>] __generic_file_aio_read+0x180/0x1a0
 [<c0134d10>] file_read_actor+0x0/0x100
 [<c013507f>] generic_file_read+0x7f/0xa0
 [<c015b3d1>] do_open+0x1f1/0x2b0
 [<c015b533>] blkdev_open+0x23/0x30
 [<c0150c66>] dentry_open+0xa6/0x150
 [<c013bd08>] kmem_cache_free+0x188/0x1e0
 [<c01515f0>] vfs_read+0xc0/0x120
 [<c015184a>] sys_read+0x2a/0x40
 [<c01097e3>] syscall_call+0x7/0xb

Code: 8b 50 08 03 50 04 39 d6 72 03 8b 4b 04 89 f3 85 c9 75 20 89 


restarted the system, trying to mount the partition, got segfault. dmesg output follows:
blk: queue c03c81bc, I/O limit 4095Mb (mask 0xffffffff)
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c0249970
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0249970>]    Not tainted
EFLAGS: 00010212
EIP is at linear_mergeable_bvec+0x40/0x70
eax: 00000000   ebx: 5897a178   ecx: 2c4bd0bc   edx: 009edfbc
esi: c628ebcc   edi: c1315458   ebp: ce7f1c68   esp: ce7f1c54
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 193, threadinfo=ce7f0000 task=ce87c100)
Stack: cffd2ee0 cffd47c4 c13164e4 00000000 00000000 ce7f1c8c c01574f5 c13164e4 
       cffd47c4 cffd2ee0 00001000 cffd47c4 00002205 00000000 ce7f1cf8 c01f45ac 
       cffd47c4 c1242598 00001000 00000000 00000010 00000001 00002205 ce755d04 
Call Trace:
 [<c01574f5>] bio_add_page+0xd5/0x120
 [<c01f45ac>] pagebuf_iorequest+0xdc/0x310
 [<c01f435a>] pagebuf_iostart+0x7a/0xa0
 [<c01f3a93>] pagebuf_get+0xd3/0x110
 [<c01f2962>] xfs_read_buf+0x32/0x100
 [<c01e4036>] xfs_mountfs+0x676/0xde0
 [<c01fceae>] xfs_setsize_buftarg+0x2e/0x50
 [<c01ec216>] xfs_mount+0x216/0x280
 [<c01fd184>] linvfs_fill_super+0x144/0x2b0
 [<c020cfe6>] vsprintf+0x16/0x20
 [<c020d004>] sprintf+0x14/0x20
 [<c0159eb8>] sb_set_blocksize+0x18/0x50
 [<c01599d4>] get_sb_bdev+0xe4/0x130
 [<c01fd73e>] linvfs_get_sb+0x1e/0x30
 [<c01fd040>] linvfs_fill_super+0x0/0x2b0
 [<c0159bb8>] do_kern_mount+0x48/0xb0
 [<c017182a>] do_add_mount+0x5a/0x150
 [<c0171b5d>] do_mount+0x15d/0x180
 [<c017235c>] sys_mount+0x7c/0xc0
 [<c01097e3>] syscall_call+0x7/0xb

Code: 8b 50 08 03 50 04 39 d1 72 03 8b 46 04 8b 50 04 8b 40 08 01 



For any purpose, dmesg output after clean reboot is:

Linux version 2.5.63 (root@piratu) (gcc version 2.95.3 20010315 (release)) #3 Thu Feb 27 18:54:14 EET 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
On node 0 totalpages: 65536
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=l ro root=302 ide0=autotune ide1=autotune ide2=autotune ide3=autotune console=ttyS0
ide_setup: ide0=autotune
ide_setup: ide1=autotune
ide_setup: ide2=autotune
ide_setup: ide3=autotune
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 899.423 MHz processor.
Calibrating delay loop... 1765.37 BogoMIPS
Memory: 255816k/262144k available (1829k kernel code, 5576k reserved, 632k data, 272k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 899.0409 MHz.
..... host bus clock speed is 199.0868 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb180, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
spurious 8259A interrupt: IRQ7.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
SGI XFS for Linux 2.5.63 with no debug enabled
pagebuf cache hash table entries: 1 (order: 0, 4096 bytes)
Capability LSM initialized
Initializing Cryptographic API
Applying VIA southbridge workaround.
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.11
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 1
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

PCI: Found IRQ 12 for device 00:09.0
e100: selftest OK.
Freeing alive device cfe08000, eth%d
e100: eth0: Intel(R) PRO/100+ Management Adapter
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 10 for device 00:0a.0
e100: selftest OK.
e100: eth1: Intel(R) PRO/100+ Management Adapter
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST328040A, ATA DISK drive
hdb: WDC WD1200BB-00CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QUANTUM FIREBALLP AS60.0, ATA DISK drive
hdd: QUANTUM FIREBALLP AS60.0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370: IDE controller at PCI slot 00:08.0
PCI: Found IRQ 11 for device 00:08.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: IC35L120AVVA07-0, ATA DISK drive
hdf: IC35L120AVVA07-0, ATA DISK drive
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
hdg: IC35L120AVVA07-0, ATA DISK drive
hdh: IC35L120AVVA07-0, ATA DISK drive
ide3 at 0xd400-0xd407,0xd802 on irq 11
hda: 55704097 sectors (28520 MB) w/512KiB Cache, CHS=55262/16/63, UDMA(66)
 hda: hda1 hda2 hda3
hdb: host protected area => 1
hdb: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
 hdb: unknown partition table
hdc: host protected area => 1
hdc: 117266688 sectors (60041 MB) w/1902KiB Cache, CHS=116336/16/63, UDMA(100)
 hdc: unknown partition table
hdd: host protected area => 1
hdd: 117266688 sectors (60041 MB) w/1902KiB Cache, CHS=116336/16/63, UDMA(100)
 hdd: unknown partition table
hde: host protected area => 1
hde: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 hde: unknown partition table
hdf: host protected area => 1
hdf: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 hdf: unknown partition table
hdg: host protected area => 1
hdg: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 hdg: unknown partition table
hdh: host protected area => 1
hdh: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 hdh: unknown partition table
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 324 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
Warning: unable to open an initial console.
md: autorun ...
md: considering hda3 ...
md:  adding hda3 ...
md:  adding hdh ...
md:  adding hdg ...
md:  adding hdf ...
md:  adding hde ...
md:  adding hdd ...
md:  adding hdc ...
md:  adding hdb ...
md: created md0
md: bind<hdb>
md: bind<hdc>
md: bind<hdd>
md: bind<hde>
md: bind<hdf>
md: bind<hdg>
md: bind<hdh>
md: bind<hda3>
md: running: <hda3><hdh><hdg><hdf><hde><hdd><hdc><hdb>
md0: max total readahead window set to 128k
md0: 1 data-disks, max readahead per data-disk: 128k
md0: setting max_sectors to 128, segment boundary to 32767
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: marking sb clean...
md: updating md0 RAID superblock on device (in sync 1)
md: hda3 <6>(write) hda3's sb offset: 26169792
md: hdh <6>(write) hdh's sb offset: 120627264
md: hdg <6>(write) hdg's sb offset: 120627264
md: hdf <6>(write) hdf's sb offset: 120627264
md: hde <6>(write) hde's sb offset: 120627264
md: hdd <6>(write) hdd's sb offset: 58633280
md: hdc <6>(write) hdc's sb offset: 58633280
md: hdb <6>(write) hdb's sb offset: 117220736
md: ... autorun DONE.
Adding 136512k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
e100: eth1 NIC Link is Up 100 Mbps Full duplex
e100: eth0 NIC Link is Up 100 Mbps Full duplex

(end of report)

-- 
Stefan Laudat
CCNA & CCAI
-------------
Do not read this signature under penalty of law.
Violators will be prosecuted.
(Penal Code sec. 2.3.2 (II.a.))
