Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRCFTJd>; Tue, 6 Mar 2001 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRCFTJY>; Tue, 6 Mar 2001 14:09:24 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:22595 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129402AbRCFTJH>; Tue, 6 Mar 2001 14:09:07 -0500
From: Konrad Stopsack <konrad@stopsack.de>
Date: Tue, 6 Mar 2001 20:13:40 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Subject: IDE bug in 2.4.2-ac12?
MIME-Version: 1.0
Message-Id: <01030620134000.00343@Stopsack>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello guys,

I hope you've read my posting "DMA problem with ZIP drive and VIA VT82C598MVP 
/ VT82C586B chip" (why does anybody answer?).
I now tried the 2.4.2-ac12 kernel including the latest VIA 82c586b driver 
(version 3.21), but the effects were almost the same:
- just when the kernel tried to access to the hard disk during boot, DMA 
errors were occured
- "hdparm /dev/hda" displayed 9 MB per second (and not 11 MB like without ZIP)
- /proc/ide/via reported 16 MB transfer rate (and not 33MB like without ZIP 
drive)
- Kernel 2.4.2-ac12 reports a "ide-floppy: hdd: I/O error, pc = 5a, key =  5, 
asc = 24, ascq =  0" error, 2.4.2 doesn't

My IDE configuration is:
/dev/hda: Hard disk  => Primary IDE controller
/dev/hdc CD-ROM  => Secondary IDE controller
/dev/hdd: ZIP           => Secondary IDE controller

Could you please tell me whether it's a bug or a feature?
I'm really waiting for your answer - else I might get crazy with this problem 
:-((

I attached both dmesg and /proc/ide/via, and my old posting. 

cu Konrad


boot messages of 2.4.2-ac12:
Linux version 2.4.2-ac12 (root@Stopsack) (gcc version 2.95.2 19991024 
(release)) #5 Tue Mar 6 17:25:57 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000013f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 81920
zone(0): 4096 pages.
zone(1): 77824 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=ac24 ro root=304 1
Initializing CPU#0
Detected 350.802 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 699.59 BogoMIPS
Memory: 320240k/327680k available (934k kernel code, 7056k reserved, 266k 
data, 176k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 212464kB/81392kB, 640 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91080D5, ATA DISK drive
hdc: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 21095424 sectors (10801 MB) w/512KiB Cache, CHS=1313/255/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
ide-floppy: hdd: I/O error, pc = 5a, key =  5, asc = 24, ascq =  0
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 263M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus cluster size
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
reiserfs: checking transaction log (device 03:04) ...
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
Adding Swap: 104416k swap-space (priority -1)


boot messages of 2.4.2:
Linux version 2.4.2 (root@Stopsack) (gcc version 2.95.2 19991024 (release)) 
#4 Sun Feb 25 11:15:33 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000013f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 81920
zone(0): 4096 pages.
zone(1): 77824 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lx24 ro root=304 1
Initializing CPU#0
Detected 350.802 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 699.59 BogoMIPS
Memory: 320180k/327680k available (927k kernel code, 7112k reserved, 335k 
data, 176k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 212421kB/81349kB, 640 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91080D5, ATA DISK drive
hdc: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 21095424 sectors (10801 MB) w/512KiB Cache, CHS=1313/255/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: 98304kB, 196608 blocks, 512 sector size, , DMA 
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdd: hdd4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 263M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus cluster size
reiserfs: checking transaction log (device 03:04) ...
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
Adding Swap: 104416k swap-space (priority -1)
VFS: Disk change detected on device ide1(22,68)
 hdd: hdd4
VFS: Disk change detected on device ide1(22,68)
 hdd: hdd4


2.4.2-ac12's /proc/ide/via:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.21
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        DMA       DMA      UDMA       DMA
Address Setup:       30ns     120ns      30ns      60ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      90ns
Cycle Time:         120ns     600ns      60ns     180ns
Transfer Rate:   16.5MB/s   3.3MB/s  33.0MB/s  11.0MB/s


2.4.2's /proc/ide/via:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        DMA       DMA      UDMA       DMA
Address Setup:       30ns     120ns      30ns      60ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      90ns
Cycle Time:         120ns     600ns      60ns     180ns
Transfer Rate:   16.5MB/s   3.3MB/s  33.0MB/s  11.0MB/s


My old posting:
> Hello guys (especially Vojtech),
> 
> I've got a strange problem with my ZIP drive. If I connect it as /dev/hdd, 
> I'm not able to use uDMA on my hard disk (/dev/hda) properly anymore. 
> Once the kernel stopped with a "kernel panic" (because an disk I/O error 
> occured and ReiserFS coudn't read a superblock, so Linux wasn't able to > 
mount 
> the root FS). Next time I tried to boot it, lots of DMA errors occured, but 
> the system booted. Unfortunally the disk transfer rate was 9MB/s and not 11 
> anymore...

> Kernel: 2.4.2 (with VIA support enabled, but no "use DMA when available")
> Chip: VT82C598MVP / VT82C586B
> ZIP: Iomega ZIP 100MB drive
> Hard disk: Maxtor 91080D5 (10GB)
> CD-ROM: Asus CD-S400/A (/dev/hdc)

> lspci output:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
>         Flags: bus master, medium devsel, latency 16
>         Memory at e0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 1.0
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] 
> (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         Memory behind bridge: e4000000-e7ffffff
>         Prefetchable memory behind bridge: e8000000-e8ffffff
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
> VP] (rev 47)
>         Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
>         Flags: bus master, stepping, medium devsel, latency 0
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev > 
06) 
> (prog-if 8a [Master SecP PriP])
>        Flags: bus master, medium devsel, latency 32
>        I/O ports at e000 [size=16]
> 
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) 
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 12
>         I/O ports at e400 [size=32]
> 
> 00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
>         Flags: medium devsel
> 
> 00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
>         Subsystem: Ensoniq: Unknown device 1371
>         Flags: bus master, slow devsel, latency 32, IRQ 5
>         I/O ports at e800 [size=64]
>         Capabilities: [dc] Power Management version 1
> 
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 
> 03) (prog-if 00 [VGA])
>         Subsystem: Matrox Graphics, Inc. Millennium G200 SD AGP
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         Memory at e8000000 (32-bit, prefetchable) [size=16M]
>         Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
>         Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [dc] Power Management version 1
>         Capabilities: [f0] AGP version 1.0
> 
> 
> hdparm -i:
> 
> /dev/hda:
> 
>  Model=Maxtor 91080D5, FwRev=GAS54112, SerialNo=A50BDR4C
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=29
>  BuffType=3(DualPortCache), BuffSize=512kB, MaxMultSect=16, MultSect=off
>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=21095424
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
>  UDMA modes: mode0 mode1 mode2 
>  Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 
ATA-4 
> 
> 
> hdparm | grep version: 
> hdparm version: 3.6
> 
> 
> dmesg:
> 
> Linux version 2.4.2 (root@Stopsack) (gcc version 2.95.2 19991024 (release)) 
> #4 Sun Feb 25 11:15:33 CET 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
>  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
>  BIOS-e820: 0000000013f00000 @ 0000000000100000 (usable)
> On node 0 totalpages: 81920
> zone(0): 4096 pages.
> zone(1): 77824 pages.
> zone(2): 0 pages.
> Kernel command line: BOOT_IMAGE=lx24 ro root=304 1
> Initializing CPU#0
> Detected 350.802 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 699.59 BogoMIPS
> Memory: 320180k/327680k available (927k kernel code, 7112k reserved, 335k 
> data, 176k init, 0k highmem)
> Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
> CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
> CPU: Common caps: 008021bf 808029bf 00000000 00000002
> CPU: AMD-K6(tm) 3D processor stepping 0c
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/0586] at 00:07.0
> Activating ISA DMA hang workarounds.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> parport0: PC-style at 0x378 [PCSPP(,...)]
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> lp0: using parport0 (polling).
> block: queued sectors max/low 212421kB/81349kB, 640 slots per queue
> loop: enabling 8 loop devices
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
>     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: Maxtor 91080D5, ATA DISK drive
> hdc: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
> hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 21095424 sectors (10801 MB) w/512KiB Cache, CHS=1313/255/63, UDMA(33)
> hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> hdd: 98304kB, 196608 blocks, 512 sector size, , DMA 
> hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> Partition check:
>  hda: hda1 hda2 hda3 hda4
>  hdd: hdd4
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ > 
SERIAL_PCI 
> enabled
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> PPP generic driver version 2.4.1
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 263M
> agpgart: Detected Via MVP3 chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> fatfs: bogus cluster size
> reiserfs: checking transaction log (device 03:04) ...
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Using tea hash to sort names
> reiserfs: using 3.5.x disk format
> ReiserFS version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 176k freed
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide0: reset: success
> Adding Swap: 104416k swap-space (priority -1)
> VFS: Disk change detected on device ide1(22,68)
>  hdd: hdd4
> VFS: Disk change detected on device ide1(22,68)
>  hdd: hdd4
> 
> 
> /proc/ide/via:
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.20
> South Bridge:                       VIA vt82c586b
> Revision:                           ISA 0x47 IDE 0x6
> BM-DMA base:                        0xe000
> PCI clock:                          33MHz
> Master Read  Cycle IRDY:            1ws
> Master Write Cycle IRDY:            1ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                  no
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   40w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:        DMA       DMA      UDMA       DMA
> Address Setup:       30ns     120ns      30ns      60ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      90ns      90ns
> Data Active:         90ns     330ns      90ns      90ns
> Data Recovery:       30ns     270ns      30ns      90ns
> Cycle Time:         120ns     600ns      60ns     180ns
> Transfer Rate:   16.5MB/s   3.3MB/s  33.0MB/s  11.0MB/s
> 
> 
> 
> my normal /proc/ide/via (without ZIP):
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.20
> South Bridge:                       VIA vt82c586b
> Revision:                           ISA 0x47 IDE 0x6
> BM-DMA base:                        0xe000
> PCI clock:                          33MHz
> Master Read  Cycle IRDY:            1ws
> Master Write Cycle IRDY:            1ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                  no
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   40w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA       DMA      UDMA       DMA
> Address Setup:       30ns     120ns      30ns     120ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns     330ns      90ns     330ns
> Data Recovery:       30ns     270ns      30ns     270ns
> Cycle Time:          60ns     600ns      60ns     600ns
> Transfer Rate:   33.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s
> 
> 
> BIOS' uDMA settings for Primary Master and Slave are "Auto", for Secondary 
> Master and Slave are "Disabled", but Linux detects DMA for all devices (see 
> dmesg).
> 
> What could I do? Try the 2.4.2-ac12 kernel?
> 
> cu Konrad
> 
-- 
Konrad Stopsack - konrad@stopsack.de
