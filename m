Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285276AbRLNAdI>; Thu, 13 Dec 2001 19:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285280AbRLNAc7>; Thu, 13 Dec 2001 19:32:59 -0500
Received: from netswarm.net ([212.55.200.138]:640 "EHLO netswarm.net")
	by vger.kernel.org with ESMTP id <S285276AbRLNAcp>;
	Thu, 13 Dec 2001 19:32:45 -0500
Date: Fri, 14 Dec 2001 01:32:31 +0100
From: Christian Birchinger <joker@netswarm.net>
To: linux-kernel@vger.kernel.org
Subject: ANA-6944A/TX totaly freezes kernel 2.4.16
Message-ID: <20011214013231.A188@netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...
I wanted to use a Adaptec 6944A/TX Quadport Ethernet Card
with a 2.4.16 kernel. (Card contains a tulip chipset)
The whole machine *complettly* freezes when 2 or more interfaces
are configured with ifconfig. When only one port is being
configured it works just fine. Only listing them with
ifconfig -a works and shows eth0-eth3.
It's also possible to ifconfig up and then down various
NICs. Only 2 or more configured in parallel lock the
system.

2.4.16 was tested with and without "Use PCI shared mem 
for NIC registers".
Testes with an older 2.4.5 behave the same as 2.4.16

The same setup with a kernel 2.2.19 works and allows all
4 interfaces being configured.

I tested it on a SNENIC PRO5 (Intel 82439HX Triton II Chipset)
and on a Asus P2B Board to make sure it's not the PC (or BIOS). 
Having it work with 2.2.19 also tells me it's not a HW fault.

An interesting thing is that /proc/pci shows a different and
uniq IRQ for each interface while /proc/interrupts shows
all NICs on the same IRQ (only known on 2.2 since i can't configure
them on 2.4)

If you need additional information please CC: the mail
to joker@netswarm.net because i'm not subscribed to the
ML. I usualy read the stuff later on the archive though.

Here are dmesg /proc/pci and /proc/interrupt datas.
2.2.19 (working) and 2.4.5 (same problem as 2.4.16)

-- /proc/pci from kernel 2.2.16 ------------------------------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82439HX Triton II (rev 3).
      Medium devsel.  Master Capable.  Latency=16.  
  Bus  0, device   3, function  0:
    Hot Swap Controller: Unknown vendor Unknown device (rev 1).
      Vendor id=110a. Device id=5.
      Medium devsel.  Fast back-to-back capable.  
  Bus  0, device   3, function  1:
    Hot Swap Controller: Unknown vendor Unknown device (rev 1).
      Vendor id=110a. Device id=5.
      Medium devsel.  Fast back-to-back capable.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371SB PIIX3 ISA (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.  
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371SB PIIX3 IDE (rev 0).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
      I/O at 0xfcb0 [0xfcb1].
  Bus  0, device   8, function  0:
    VGA compatible controller: Cirrus Logic GD 5446 (rev 0).
      Medium devsel.  
      Prefetchable 32 bit memory at 0xfd000000 [0xfd000008].
  Bus  0, device  19, function  0:
    PCI bridge: DEC DC21152 (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=64.  Min Gnt=4.
  Bus  1, device   4, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xec80 [0xec81].
      Non-prefetchable 32 bit memory at 0xfedffc00 [0xfedffc00].
  Bus  1, device   5, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xec00 [0xec01].
      Non-prefetchable 32 bit memory at 0xfedff800 [0xfedff800].
  Bus  1, device   6, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xe880 [0xe881].
      Non-prefetchable 32 bit memory at 0xfedff400 [0xfedff400].
  Bus  1, device   7, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 5.  Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xe800 [0xe801].
      Non-prefetchable 32 bit memory at 0xfedff000 [0xfedff000].
---------------------------------------------------------------

-- /proc/interrupts from kernel 2.2.19 ------------------------
           CPU0       
  0:     206281          XT-PIC  timer
  1:       2727          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:        857          XT-PIC  eth1, eth0, eth2, eth3
 13:          1          XT-PIC  fpu
 14:          9          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
----------------------------------------------------------------

-- dmesg from kernel 2.2.19 ------------------------------------
Linux version 2.2.19 (root@bigkitty) (gcc version 2.95.3 20010315 (release)) #22 Wed Jun 20 18:12:16 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 03f00000 @ 00100000 (usable)
Detected 132955 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 265.42 BogoMIPS
Memory: 62760k/65536k available (1348k kernel code, 416k reserved, 944k data, 68k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf6d34
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 512 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 49152K size
loop: registered device at major 7
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcb0-0xfcb7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcb8-0xfcbf, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC22100H, ATA DISK drive
hdc: NEC CD-ROM DRIVE:284, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Disabling (U)DMA for WDC AC22100H
hda: DMA disabled
hda: WDC AC22100H, 2014MB w/128kB Cache, CHS=1023/64/63
hdc: ATAPI 8X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
linear personality registered
raid0 personality registered
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2
VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER
VFS: Disk change detected on device fd(2,28)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (minix filesystem).
Freeing unused kernel memory: 68k freed
VFS: Disk change detected on device fd(2,0)
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21140 Tulip rev 34 at 0xec80, 00:00:D1:1A:87:41, IRQ 9.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #1 config 3100 status 7849 advertising 0101.
eth0:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth0:  Advertising 01e1 (to advertise is 01e1).
eth1: Digital DS21140 Tulip rev 34 at 0xec00, EEPROM not present, 00:00:D1:1A:87:42, IRQ 9.
eth1:  Controller 1 of multiport board.
eth1:  EEPROM default media type Autosense.
eth1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth1:  MII transceiver #1 config 3100 status 7849 advertising 0101.
eth1:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth1:  Advertising 01e1 (to advertise is 01e1).
eth2: Digital DS21140 Tulip rev 34 at 0xe880, EEPROM not present, 00:00:D1:1A:87:43, IRQ 9.
eth2:  Controller 2 of multiport board.
eth2:  EEPROM default media type Autosense.
eth2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth2:  MII transceiver #1 config 3100 status 7849 advertising 0101.
eth2:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth2:  Advertising 01e1 (to advertise is 01e1).
eth3: Digital DS21140 Tulip rev 34 at 0xe800, EEPROM not present, 00:00:D1:1A:87:44, IRQ 9.
eth3:  Controller 3 of multiport board.
eth3:  EEPROM default media type Autosense.
eth3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth3:  MII transceiver #1 config 3100 status 7849 advertising 0101.
eth3:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth3:  Advertising 01e1 (to advertise is 01e1).
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth2: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth3: Setting full-duplex based on MII#1 link partner capability of 45e1.
--------------------------------------------------------------

-- /proc/pci from kernel 2.4.5 -------------------------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 3).
      Master Capable.  Latency=16.  
  Bus  0, device   3, function  0:
    Class ff00: Siemens Nixdorf AG Tulip controller, power management, switch extender (rev 1).
  Bus  0, device   3, function  1:
    Class ff00: Siemens Nixdorf AG Tulip controller, power management, switch extender (#2) (rev 1).
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (rev 0).
      Master Capable.  Latency=32.  
      I/O at 0xfcb0 [0xfcbf].
  Bus  0, device   8, function  0:
    VGA compatible controller: Cirrus Logic GD 5446 (rev 0).
      Prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
  Bus  0, device  19, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 3).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  1, device   4, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 34).
      IRQ 9.
      Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xec80 [0xecff].
      Non-prefetchable 32 bit memory at 0xfedffc00 [0xfedffc7f].
  Bus  1, device   5, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (#2) (rev 34).
      IRQ 11.
      Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xec00 [0xec7f].
      Non-prefetchable 32 bit memory at 0xfedff800 [0xfedff87f].
  Bus  1, device   6, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (#3) (rev 34).
      IRQ 10.
      Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xe880 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xfedff400 [0xfedff47f].
  Bus  1, device   7, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (#4) (rev 34).
      IRQ 5.
      Master Capable.  Latency=165.  Min Gnt=20.Max Lat=40.
      I/O at 0xe800 [0xe87f].
      Non-prefetchable 32 bit memory at 0xfedff000 [0xfedff07f].
--------------------------------------------------------------------------------

-- /proc/interrupts from kernel 2.4.5 ------------------------------------------
           CPU0       
  0:      36239          XT-PIC  timer
  1:        664          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:         48          XT-PIC  eth0
 14:          7          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0 
ERR:          0
---------------------------------------------------------------------------------

-- dmesg from kernel 2.4.5 ------------------------------------------------------
Linux version 2.4.5 (root@bigkitty) (gcc version 2.95.3 20010315 (release)) #6 Fri Jun 22 01:38:20 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f219e - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff219e - 0000000100000000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=ramdisk root=21c ramdisk=49152
Initializing CPU#0
Detected 132.955 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 265.42 BogoMIPS
Memory: 61528k/65536k available (1491k kernel code, 3620k reserved, 509k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xf6d34, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 512 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 40770kB/13590kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 49152K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcb0-0xfcb7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcb8-0xfcbf, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC22100H, ATA DISK drive
hdc: NEC CD-ROM DRIVE:284, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Disabling (U)DMA for WDC AC22100H
hda: 4124736 sectors (2112 MB) w/128KiB Cache, CHS=1023/64/63
hdc: ATAPI 8X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER
VFS: Disk change detected on device fd(2,28)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (minix filesystem).
Freeing unused kernel memory: 228k freed
VFS: Disk change detected on device fd(2,0)
Linux Tulip driver version 0.9.15-pre2 (May 16, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth0: Digital DS21140 Tulip rev 34 at 0xec80, 00:00:D1:1A:87:41, IRQ 9.
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip1:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth1: Digital DS21140 Tulip rev 34 at 0xec00, EEPROM not present, 00:00:D1:1A:87:42, IRQ 9.
tulip2:  Controller 2 of multiport board.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip2:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth2: Digital DS21140 Tulip rev 34 at 0xe880, EEPROM not present, 00:00:D1:1A:87:43, IRQ 9.
tulip3:  Controller 3 of multiport board.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 0101.
tulip3:  Advertising 01e1 on PHY 1, previously advertising 0101.
eth3: Digital DS21140 Tulip rev 34 at 0xe800, EEPROM not present, 00:00:D1:1A:87:44, IRQ 9.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
----------------------------------------------------------
