Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310577AbSCMNew>; Wed, 13 Mar 2002 08:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310580AbSCMNeo>; Wed, 13 Mar 2002 08:34:44 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:64517 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S310577AbSCMNe0>; Wed, 13 Mar 2002 08:34:26 -0500
Date: Wed, 13 Mar 2002 08:34:22 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: IO-APIC -- lockup on machine if enabled
Message-Id: <20020313083422.3262cb35.fryman@cc.gatech.edu>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

i have a new laptop (Dell Latitude C610) running 2.4.18-rc4.  when i built the
new kernel, i thought i would amuse myself by turning on IO-APIC. the 
configure.help entry claims that even if you don't have an IO-APIC system, the
kernel will still run without problems.

this is definitely _not_ the case on this laptop.  i get a hard lockup, at a
random time after booting this kernel.  it seems very reproducible if i enable
the network interfaces (eg, it happens within moments), but even if i don't
enable them it will still lock up (within a few minutes).

any suggestions?  is configure.help lying to me making this idiot user error?
google searches didn't turn up anything recent about problems here...

regards,

josh fryman

PS>

if it's useful, below are /proc/pci and dmesg after a successful (no IO-APIC)
kernel boot:

/proc/pci:
----------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 8086:3575 (Intel Corp.) (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 8086:3576 (Intel Corp.) (rev 2).
      Master Capable.  Latency=32.  Min Gnt=12.
  Bus  0, device  29, function  0:
    USB Controller: PCI device 8086:2482 (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0xbf80 [0xbf9f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 65).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: PCI device 8086:248c (Intel Corp.) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: PCI device 8086:248a (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0xbfa0 [0xbfaf].
      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. AC'97 Audio Controller (rev 1).
      IRQ 11.
      I/O at 0xd800 [0xd8ff].
      I/O at 0xdc80 [0xdcbf].
  Bus  0, device  31, function  6:
    Modem: PCI device 8086:2486 (Intel Corp.) (rev 1).
      IRQ 11.
      I/O at 0xd400 [0xd4ff].
      I/O at 0xdc00 [0xdc7f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xfcff0000 [0xfcffffff].
  Bus  2, device   0, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 120).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xec80 [0xecff].
      Non-prefetchable 32 bit memory at 0xf8fffc00 [0xf8fffc7f].
  Bus  2, device   1, function  0:
    CardBus bridge: Texas Instruments PCI1420 (rev 0).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf4000fff].
  Bus  2, device   1, function  1:
    CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xf4001000 [0xf4001fff].
  Bus  2, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xf4002000 [0xf4002fff].

dmesg:
------
Linux version 2.4.18 (root@rescuecd) (gcc version 2.95.3 20010315 (release)) #2 Mon Mar 11 13:38:18 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffe2800 (usable)
 BIOS-e820: 000000001ffe2800 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
On node 0 totalpages: 131042
zone(0): 4096 pages.
zone(1): 126946 pages.
zone(2): 0 pages.
Building zonelist for node : 0
Kernel command line: root=/dev/hda12 video=radeon
Initializing CPU#0
Detected 797.354 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1592.52 BogoMIPS
Memory: 513620k/524168k available (1449k kernel code, 10160k reserved, 490k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfbffe, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 02:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 (0x778) [PCSPP]
parport0: irq 7 detected
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
radeonfb: panel ID string: DE 1400X1050            
radeonfb: detected DFP panel size from BIOS: 1400x1050
Console: switching to colour frame buffer device 175x65
radeonfb: ATI Radeon M6 LY  DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
pty: 256 Unix98 ptys configured
Dell laptop SMM driver v1.7 21/11/2001 Massimo Dal Zotto (dz@debian.org)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:03.0
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
ppdev: user-space parallel port driver
block: 992 slots per queue, batch=248
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 02:00.0
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0355e40, I/O limit 4095Mb (mask 0xffffffff)
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1f.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.16
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i830M chipset
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] AGP 0.99 on Unknown @ 0xd0000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
uhci.c: detected 2 ports
usb.c: kmalloc IF dfe0a340, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: bf80
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe0a340
usb.c: call_policy add, num 1 -- no FS yet
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
uhci.c: bf80: suspend_hc
Adding Swap: 1092380k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,12), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:01.0
PCI: Sharing IRQ 11 with 02:01.1
PCI: Found IRQ 11 for device 02:01.1
PCI: Sharing IRQ 11 with 02:01.0
PCI: Found IRQ 11 for device 02:03.0
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 0000, PCI irq11
Socket status: 30000011
