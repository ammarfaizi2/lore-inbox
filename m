Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbRGYX3K>; Wed, 25 Jul 2001 19:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbRGYX3B>; Wed, 25 Jul 2001 19:29:01 -0400
Received: from smtp09.phx.gblx.net ([64.211.219.58]:62166 "EHLO
	smtp09.phx.gblx.net") by vger.kernel.org with ESMTP
	id <S267405AbRGYX2x>; Wed, 25 Jul 2001 19:28:53 -0400
Date: Wed, 25 Jul 2001 19:23:42 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: how to tell Linux *not* to share IRQs ?
Message-ID: <20010725192342.A2453@vaxerdec.localdomain>
Mail-Followup-To: Scott McDermott <vaxerdec>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I cannot for the life of me get Linux to use all the available IRQs; it
insists on sharing IRQs even though there are enough available to give
each PCI device a separate one.

I have a system which I'm configuring as a gateway; it has three 3c509B
NICs, an AIC7892 SCSI card and an ATI 128 AGP.  I'm getting interrupts
shared between the SCSI and video card, and two of the NICs are sharing
an interrupt as well (the third takes its own).  There are IRQs
available to give each of these devices a different IRQ, but Linux won't
do it on this hardware it seems.  System is a UP Dell T800r.

I have tried using PnP OS setting in BIOS, non-PnP OS, disabling
parallel and USB, giving all manner of "pci=" kernel parameters, tried
with APIC and without (even though it's UP, it seems to still use it if
enabled), and tried lots of "pirq=" lines (although I gather that's only
relevant with SMP?).  If I move the cards around they change IRQs and
even use different IRQs which are unused with different slot
configuration, but they always share interrupts.

Is there some way to tell Linux "don't even boot if you have to share an
IRQ?"

Here's lspci presently:

   00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
           Flags: bus master, medium devsel, latency 64
           Memory at f4000000 (32-bit, prefetchable) [size=64M]
           Capabilities: [a0] AGP version 1.0

   00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
           Flags: bus master, 66Mhz, medium devsel, latency 128
           Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
           I/O behind bridge: 00009000-00009fff
           Memory behind bridge: f0100000-f01fffff
           Prefetchable memory behind bridge: f8000000-fbffffff

   00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
           Flags: bus master, medium devsel, latency 0

   00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
           Flags: bus master, medium devsel, latency 64
           I/O ports at 1000 [size=16]

   00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
           Flags: bus master, medium devsel, latency 64, IRQ 9
           I/O ports at 1020 [size=32]

   00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
           Flags: medium devsel, IRQ 9

   00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
           Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
           Flags: bus master, medium devsel, latency 80, IRQ 10
           I/O ports at 1080 [size=128]
           Memory at f0000000 (32-bit, non-prefetchable) [size=128]
           Expansion ROM at <unassigned> [disabled] [size=128K]
           Capabilities: [dc] Power Management version 1

   00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
           Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
           Flags: bus master, medium devsel, latency 80, IRQ 7
           I/O ports at 1400 [size=128]
           Memory at f0000400 (32-bit, non-prefetchable) [size=128]
           Expansion ROM at <unassigned> [disabled] [size=128K]
           Capabilities: [dc] Power Management version 1

   00:10.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
           Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
           Flags: bus master, medium devsel, latency 80, IRQ 9
           I/O ports at 1480 [size=128]
           Memory at f0000800 (32-bit, non-prefetchable) [size=128]
           Expansion ROM at <unassigned> [disabled] [size=128K]
           Capabilities: [dc] Power Management version 1

   00:11.0 SCSI storage controller: Adaptec 7892A (rev 02)
           Subsystem: Adaptec: Unknown device e2a0
           Flags: bus master, 66Mhz, medium devsel, latency 72, IRQ 7
           BIST result: 00
           I/O ports at 1800 [disabled] [size=256]
           Memory at f0001000 (64-bit, non-prefetchable) [size=4K]
           Expansion ROM at <unassigned> [disabled] [size=128K]
           Capabilities: [dc] Power Management version 2

   01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
           Subsystem: ATI Technologies Inc: Unknown device 0404
           Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 11
           Memory at f8000000 (32-bit, prefetchable) [size=64M]
           I/O ports at 9000 [size=256]
           Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
           Expansion ROM at <unassigned> [disabled] [size=128K]
           Capabilities: [50] AGP version 2.0
           Capabilities: [5c] Power Management version 2

I've -DDEBUG in pci-i386.h to get some more verbose IRQ config messages:

   Linux version 2.4.7 (root@asmodeus) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #7 Wed Jul 25 12:54:14 EDT 2001
   BIOS-provided physical RAM map:
    BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
    BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
    BIOS-e820: 00000000000e6c00 - 0000000000100000 (reserved)
    BIOS-e820: 0000000000100000 - 00000000040fd800 (usable)
    BIOS-e820: 00000000040fd800 - 00000000040ff800 (ACPI data)
    BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
    BIOS-e820: 00000000040ffc00 - 0000000018000000 (usable)
    BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
   Scan SMP from c0000000 for 1024 bytes.
   Scan SMP from c009fc00 for 1024 bytes.
   Scan SMP from c00f0000 for 65536 bytes.
   Scan SMP from c009f400 for 4096 bytes.
   On node 0 totalpages: 98304
   zone(0): 4096 pages.
   zone(1): 94208 pages.
   zone(2): 0 pages.
   mapped APIC to ffffe000 (01664000)
   Kernel command line: auto BOOT_IMAGE=production ro root=802 BOOT_FILE=/boot/bzImage video=aty128fb:1024x768-16@76
   Initializing CPU#0
   Detected 798.177 MHz processor.
   Console: colour VGA+ 80x25
   Calibrating delay loop... 1592.52 BogoMIPS
   Memory: 384508k/393216k available (956k kernel code, 8308k reserved, 362k data, 204k init, 0k highmem)
   Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
   Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
   Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
   Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
   Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
   CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
   CPU: L1 I cache: 16K, L1 D cache: 16K
   CPU: L2 cache: 256K
   Intel machine check architecture supported.
   Intel machine check reporting enabled on CPU#0.
   CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
   CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
   CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
   CPU: Intel Pentium III (Coppermine) stepping 03
   Enabling fast FPU save and restore... done.
   Enabling unmasked SIMD FPU exception support... done.
   Checking 'hlt' instruction... OK.
   POSIX conformance testing by UNIFIX
   mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
   mtrr: detected mtrr type: Intel
   PCI: BIOS32 Service Directory structure at 0xc00f6be0
   PCI: BIOS32 Service Directory entry at 0xfd790
   PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
   PCI: PCI BIOS revision 2.10 entry at 0xfd993, last bus=1
   PCI: Using configuration type 1
   PCI: Probing PCI hardware
   PCI: IDE base address fixup for 00:07.1
   PCI: Scanning for ghost devices on bus 0
   PCI: Scanning for ghost devices on bus 1
   PCI: IRQ init
   PCI: Interrupt Routing Table found at 0xc00fdf20
   00:0d slot=01 0:60/deb8 1:61/deb8 2:62/deb8 3:63/deb8
   00:0e slot=02 0:61/deb8 1:62/deb8 2:63/deb8 3:60/deb8
   00:0f slot=03 0:62/deb8 1:63/deb8 2:60/deb8 3:61/deb8
   00:10 slot=04 0:63/deb8 1:60/deb8 2:61/deb8 3:62/deb8
   00:11 slot=05 0:62/deb8 1:63/deb8 2:60/deb8 3:61/deb8
   00:0c slot=00 0:63/deb8 1:00/def8 2:00/def8 3:00/def8
   00:00 slot=00 0:60/def8 1:61/def8 2:62/def8 3:63/def8
   00:07 slot=00 0:60/def8 1:61/def8 2:62/def8 3:63/def8
   00:01 slot=00 0:60/def8 1:61/def8 2:62/def8 3:63/def8
   01:00 slot=00 0:60/def8 1:61/def8 2:00/def8 3:00/def8
   PCI: Attempting to find IRQ router for 8086:122e
   PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
   PCI: IRQ fixup
   PCI: Allocating resources
   PCI: Resource f4000000-f7ffffff (f=1208, d=0, p=0)
   PCI: Resource 00001000-0000100f (f=101, d=0, p=0)
   PCI: Resource 00001020-0000103f (f=101, d=0, p=0)
   PCI: Resource 00001800-000018ff (f=101, d=0, p=0)
   PCI: Resource f0001000-f0001fff (f=204, d=0, p=0)
   PCI: Resource f8000000-fbffffff (f=1208, d=0, p=0)
   PCI: Resource 00009000-000090ff (f=101, d=0, p=0)
   PCI: Resource f0100000-f0103fff (f=200, d=0, p=0)
   PCI: Resource 00001080-000010ff (f=101, d=1, p=1)
   PCI: Resource f0000000-f000007f (f=200, d=1, p=1)
   PCI: Resource 00001400-0000147f (f=101, d=1, p=1)
   PCI: Resource f0000400-f000047f (f=200, d=1, p=1)
   PCI: Resource 00001480-000014ff (f=101, d=1, p=1)
   PCI: Resource f0000800-f000087f (f=200, d=1, p=1)
   PCI: Sorting device list...
   Limiting direct PCI/PCI transfers.
   Linux NET4.0 for Linux 2.4
   Based upon Swansea University Computer Society NET3.039
   Initializing RT netlink socket
   Starting kswapd v1.8
   IRQ for 01:00.0:0 -> PIRQ 60, mask def8, excl 0000 -> newirq=11 -> got IRQ 11
   PCI: Found IRQ 11 for device 01:00.0
   aty128fb: Rage128 BIOS located at segment C00C0000
   aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
   Console: switching to colour frame buffer device 128x48
   fb0: ATY Rage128 frame buffer device on PCI
   aty128fb: Rage128 MTRR set to ON
   Detected PS/2 Mouse Port.
   pty: 256 Unix98 ptys configured
   Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
   ttyS00 at 0x03f8 (irq = 4) is a 16550A
   block: queued sectors max/low 255200kB/124128kB, 768 slots per queue
   NET4: Frame Diverter 0.46
   Linux agpgart interface v0.99 (c) Jeff Hartmann
   agpgart: Maximum main memory to use for agp memory: 322M
   agpgart: Detected Intel 440BX chipset
   agpgart: AGP aperture is 64M @ 0xf4000000
   SCSI subsystem driver Revision: 1.00
   IRQ for 00:11.0:0 -> PIRQ 62, mask deb8, excl 0000 -> newirq=7 -> got IRQ 7
   PCI: Found IRQ 7 for device 00:11.0
   PCI: Sharing IRQ 7 with 00:0f.0
   scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
           <Adaptec 29160 Ultra160 SCSI adapter>
           aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs
     Vendor: QUANTUM   Model: ATLAS 10K 18WLS   Rev: UCH0
     Type:   Direct-Access                      ANSI SCSI revision: 03
   (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
   scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
   Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
   SCSI device sda: 35877972 512-byte hdwr sectors (18370 MB)
   Partition check:
    sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
   md: raid1 personality registered
   md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
   md: Autodetecting RAID arrays.
   md: autorun ...
   md: ... autorun DONE.
   NET4: Linux TCP/IP 1.0 for NET4.0
   IP Protocols: ICMP, UDP, TCP, IGMP
   IP: routing cache hash table of 4096 buckets, 32Kbytes
   TCP: Hash tables configured (established 32768 bind 32768)
   Linux IP multicast router 0.06 plus PIM-SM
   NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
   VFS: Mounted root (ext2 filesystem) readonly.
   Freeing unused kernel memory: 204k freed
   Adding Swap: 1574360k swap-space (priority -1)
   PCI: Enabling device 00:0e.0 (0114 -> 0117)
   IRQ for 00:0e.0:0 -> PIRQ 61, mask deb8, excl 0000 -> newirq=10 -> got IRQ 10
   PCI: Found IRQ 10 for device 00:0e.0
   3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
   See Documentation/networking/vortex.txt
   00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080,  00:10:4b:63:97:50, IRQ 10
     product code 4e43 rev 00.0 date 02-21-98
     8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
     MII transceiver found at address 24, status 7809.
     Enabling bus-master transmits and whole-frame receives.
   00:0e.0: scatter/gather enabled. h/w checksums enabled
   divert: allocating divert_blk for eth0
   PCI: Enabling device 00:0f.0 (0114 -> 0117)
   IRQ for 00:0f.0:0 -> PIRQ 62, mask deb8, excl 0000 -> newirq=7 -> got IRQ 7
   PCI: Found IRQ 7 for device 00:0f.0
   PCI: Sharing IRQ 7 with 00:11.0
   00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1400,  00:10:4b:63:97:26, IRQ 7
     product code 4e43 rev 00.0 date 02-21-98
     8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
     MII transceiver found at address 24, status 7809.
     Enabling bus-master transmits and whole-frame receives.
   00:0f.0: scatter/gather enabled. h/w checksums enabled
   divert: allocating divert_blk for eth1
   PCI: Enabling device 00:10.0 (0114 -> 0117)
   IRQ for 00:10.0:0 -> PIRQ 63, mask deb8, excl 0000 -> newirq=9 -> got IRQ 9
   PCI: Found IRQ 9 for device 00:10.0
   PCI: Sharing IRQ 9 with 00:07.2
   00:10.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1480,  00:10:4b:63:95:9f, IRQ 9
     product code 4e43 rev 00.0 date 02-21-98
     8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
     MII transceiver found at address 24, status 7809.
     Enabling bus-master transmits and whole-frame receives.
   00:10.0: scatter/gather enabled. h/w checksums enabled
   divert: allocating divert_blk for eth2
   eth0: using NWAY device table, not 8

The system is intended to be a gateway between three networks and I
expect non-trivial interrupt rates; I really don't want to share IRQs.

Any ideas how I might get these to play nice and actually use the
available IRQs?
