Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316479AbSEUBOp>; Mon, 20 May 2002 21:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316480AbSEUBOo>; Mon, 20 May 2002 21:14:44 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:17802 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S316479AbSEUBOm>;
	Mon, 20 May 2002 21:14:42 -0400
Message-ID: <3CE99F6B.5050100@bcgreen.com>
Date: Mon, 20 May 2002 18:14:19 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020427
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: gdth driver oops on shutdown
In-Reply-To: <Pine.LNX.4.44.0204260146220.16148-100000@skynet>
Content-Type: multipart/mixed;
 boundary="------------000507040007030406040300"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000507040007030406040300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

we have a new Intel-hardware box that is having problems with the
gdth driver (or so it seems).   This is a machine that has 6gb of ram
(breaking the 4GB boundary MAY have something to do with it..) and an
srcu-31 hardware raid controller  (2x2 mirror) Things work fine except for
two things:
  Modprobe fails when loading the system (boot extract below),
and the system has an OOPS when shutting down the filesystems.

1) when booting, I see the message:
May 20 18:54:05 virtual kernel: Linux IP multicast router 0.06 plus PIM-SM
May 20 18:54:05 virtual kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 20 18:54:05 virtual kernel: RAMDISK: Compressed image found at block 0
May 20 18:54:05 virtual kernel: Freeing initrd memory: 216k freed
May 20 18:54:05 virtual kernel: VFS: Mounted root (ext2 filesystem).
May 20 18:54:05 virtual kernel: SCSI subsystem driver Revision: 1.00
May 20 18:54:05 virtual kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
************
May 20 18:54:05 virtual kernel: Configuring GDT-PCI HA at 1/8 IRQ 31
May 20 18:54:05 virtual kernel: scsi0 : SRCU31
May 20 18:54:05 virtual kernel:   Vendor: Intel     Model: Host Drive  #00   Rev:
May 20 18:54:05 virtual kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May 20 18:54:05 virtual kernel:   Vendor: ESG-SHV   Model: SCA HSBP M16      Rev: 0.04
May 20 18:54:05 virtual kernel:   Type:   Processor                          ANSI SCSI revision: 02


When shutting down the system... The last thing we see is an oops
(when shutting down)

images of the  OOPS screens are at:

  http://www.bcgreen.com/kernel/screen_01.jpg
and http://www.bcgreen.com/kernel/screen_02.jpg

the boot messages from /var/adm/messages is attached (oops)

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

--------------000507040007030406040300
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

May 20 18:54:03 virtual syslogd 1.4.1: restart.
May 20 18:54:03 virtual syslog: syslogd startup succeeded
May 20 18:54:03 virtual syslog: klogd startup succeeded
May 20 18:54:03 virtual kernel: klogd 1.4.1, log source = /proc/kmsg started.
May 20 18:54:03 virtual kernel: Linux version 2.4.18-4bigmem (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu May 2 18:06:05 EDT 2002
May 20 18:54:03 virtual kernel: BIOS-provided physical RAM map:
May 20 18:54:03 virtual kernel:  BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
May 20 18:54:03 virtual kernel:  BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
May 20 18:54:03 virtual kernel:  BIOS-e820: 0000000000100000 - 00000000fbff0000 (usable)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000fbff0000 - 00000000fbfff000 (ACPI data)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000fbfff000 - 00000000fc000000 (ACPI NVS)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
May 20 18:54:03 virtual kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
May 20 18:54:03 virtual kernel:  BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
May 20 18:54:03 virtual portmap: portmap startup succeeded
May 20 18:54:03 virtual kernel: 5248MB HIGHMEM available.
May 20 18:54:03 virtual kernel: found SMP MP-table at 000ff780
May 20 18:54:03 virtual kernel: hm, page 000ff000 reserved twice.
May 20 18:54:03 virtual kernel: hm, page 00100000 reserved twice.
May 20 18:54:03 virtual kernel: hm, page 000f1000 reserved twice.
May 20 18:54:03 virtual kernel: hm, page 000f2000 reserved twice.
May 20 18:54:04 virtual kernel: On node 0 totalpages: 1572864
May 20 18:54:04 virtual kernel: zone(0): 4096 pages.
May 20 18:54:04 virtual keytable: Loading keymap:  succeeded
May 20 18:54:04 virtual kernel: zone(1): 225280 pages.
May 20 18:54:04 virtual kernel: zone(2): 1343488 pages.
May 20 18:54:04 virtual kernel: Intel MultiProcessor Specification v1.4
May 20 18:54:04 virtual keytable: Loading system font:  succeeded
May 20 18:54:04 virtual kernel:     Virtual Wire compatibility mode.
May 20 18:54:04 virtual kernel: OEM ID: INTEL    Product ID: SCB20        APIC at: 0xFEE00000
May 20 18:54:04 virtual kernel: Processor #3 Pentium(tm) Pro APIC version 17
May 20 18:54:04 virtual kernel: Processor #0 Pentium(tm) Pro APIC version 17
May 20 18:54:04 virtual kernel: I/O APIC #4 Version 17 at 0xFEC00000.
May 20 18:54:04 virtual kernel: I/O APIC #5 Version 17 at 0xFEC01000.
May 20 18:54:04 virtual random: Initializing random number generator:  succeeded
May 20 18:54:04 virtual kernel: Processors: 2
May 20 18:54:04 virtual kernel: Kernel command line: ro root=/dev/sda1 vga=0x0F07
May 20 18:54:04 virtual kernel: Initializing CPU#0
May 20 18:54:04 virtual kernel: Detected 1263.496 MHz processor.
May 20 18:54:04 virtual kernel: Console: colour VGA+ 80x60
May 20 18:54:04 virtual kernel: Calibrating delay loop... 2523.13 BogoMIPS
May 20 18:54:04 virtual kernel: Memory: 6135556k/6291456k available (1235k kernel code, 89896k reserved, 854k data, 304k init, 5308352k highmem)
May 20 18:54:04 virtual kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
May 20 18:54:04 virtual kernel: Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
May 20 18:54:04 virtual netfs: Mounting other filesystems:  succeeded
May 20 18:54:04 virtual kernel: Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
May 20 18:54:04 virtual kernel: Buffer cache hash table entries: 524288 (order: 9, 2097152 bytes)
May 20 18:54:04 virtual kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
May 20 18:54:04 virtual kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 20 18:54:04 virtual kernel: CPU: L2 cache: 512K
May 20 18:54:04 virtual kernel: Intel machine check architecture supported.
May 20 18:54:04 virtual kernel: Intel machine check reporting enabled on CPU#0.
May 20 18:54:04 virtual kernel: Enabling fast FPU save and restore... done.
May 20 18:54:04 virtual kernel: Enabling unmasked SIMD FPU exception support... done.
May 20 18:54:04 virtual kernel: Checking 'hlt' instruction... OK.
May 20 18:54:04 virtual kernel: POSIX conformance testing by UNIFIX
May 20 18:54:04 virtual kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
May 20 18:54:04 virtual kernel: mtrr: detected mtrr type: Intel
May 20 18:54:04 virtual kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 20 18:54:04 virtual kernel: CPU: L2 cache: 512K
May 20 18:54:04 virtual kernel: Intel machine check reporting enabled on CPU#0.
May 20 18:54:04 virtual kernel: CPU0: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
May 20 18:54:04 virtual kernel: per-CPU timeslice cutoff: 1462.38 usecs.
May 20 18:54:04 virtual autofs: automount startup succeeded
May 20 18:54:04 virtual kernel: task migration cache decay timeout: 10 msecs.
May 20 18:54:04 virtual kernel: enabled ExtINT on CPU#0
May 20 18:54:04 virtual kernel: ESR value before enabling vector: 00000004
May 20 18:54:04 virtual kernel: ESR value after enabling vector: 00000000
May 20 18:54:04 virtual kernel: Booting processor 1/0 eip 2000
May 20 18:54:04 virtual kernel: Initializing CPU#1
May 20 18:54:04 virtual kernel: masked ExtINT on CPU#1
May 20 18:54:04 virtual kernel: ESR value before enabling vector: 00000000
May 20 18:54:04 virtual kernel: ESR value after enabling vector: 00000000
May 20 18:54:04 virtual kernel: Calibrating delay loop... 2523.13 BogoMIPS
May 20 18:54:04 virtual kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 20 18:54:04 virtual kernel: CPU: L2 cache: 512K
May 20 18:54:04 virtual kernel: Intel machine check reporting enabled on CPU#1.
May 20 18:54:04 virtual kernel: CPU1: Intel(R) Pentium(R) III CPU family      1266MHz stepping 01
May 20 18:54:04 virtual kernel: Total of 2 processors activated (5046.27 BogoMIPS).
May 20 18:54:04 virtual kernel: ENABLING IO-APIC IRQs
May 20 18:54:04 virtual kernel: Setting 4 in the phys_id_present_map
May 20 18:54:04 virtual kernel: ...changing IO-APIC physical APIC ID to 4 ... ok.
May 20 18:54:04 virtual kernel: Setting 5 in the phys_id_present_map
May 20 18:54:04 virtual kernel: ...changing IO-APIC physical APIC ID to 5 ... ok.
May 20 18:54:04 virtual kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
May 20 18:54:04 virtual kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
May 20 18:54:04 virtual kernel: ...trying to set up timer (IRQ0) through the 8259A ... 
May 20 18:54:04 virtual kernel: ..... (found pin 0) ...works.
May 20 18:54:04 virtual sshd: Starting sshd:
May 20 18:54:04 virtual kernel: testing the IO APIC.......................
May 20 18:54:04 virtual kernel: 
May 20 18:54:05 virtual kernel: 
May 20 18:54:05 virtual kernel: .................................... done.
May 20 18:54:05 virtual kernel: Using local APIC timer interrupts.
May 20 18:54:05 virtual kernel: calibrating APIC timer ...
May 20 18:54:05 virtual kernel: ..... CPU clock speed is 1263.5036 MHz.
May 20 18:54:05 virtual kernel: ..... host bus clock speed is 132.9998 MHz.
May 20 18:54:05 virtual kernel: cpu: 0, clocks: 1329998, slice: 443332
May 20 18:54:05 virtual kernel: CPU0<T0:1329984,T1:886640,D:12,S:443332,C:1329998>
May 20 18:54:05 virtual kernel: cpu: 1, clocks: 1329998, slice: 443332
May 20 18:54:05 virtual kernel: CPU1<T0:1329984,T1:443312,D:8,S:443332,C:1329998>
May 20 18:54:05 virtual kernel: checking TSC synchronization across CPUs: passed.
May 20 18:54:05 virtual kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb65, last bus=2
May 20 18:54:05 virtual kernel: PCI: Using configuration type 1
May 20 18:54:05 virtual kernel: PCI: Probing PCI hardware
May 20 18:54:05 virtual kernel: PCI: Discovered primary peer bus 01 [IRQ]
May 20 18:54:05 virtual kernel: PCI: Discovered primary peer bus 02 [IRQ]
May 20 18:54:05 virtual kernel: PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B0,I3,P0) -> 21
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B0,I4,P0) -> 20
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 18
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 10
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 10
May 20 18:54:05 virtual kernel: PCI->APIC IRQ transform: (B1,I8,P0) -> 31
May 20 18:54:05 virtual kernel: isapnp: Scanning for PnP cards...
May 20 18:54:05 virtual kernel: isapnp: No Plug & Play device found
May 20 18:54:05 virtual kernel: Linux NET4.0 for Linux 2.4
May 20 18:54:05 virtual kernel: Based upon Swansea University Computer Society NET3.039
May 20 18:54:05 virtual kernel: Initializing RT netlink socket
May 20 18:54:05 virtual kernel: apm: BIOS not found.
May 20 18:54:05 virtual kernel: Starting kswapd
May 20 18:54:05 virtual kernel: allocated 256 pages and 256 bhs reserved for the highmem bounces
May 20 18:54:05 virtual kernel: VFS: Diskquotas version dquot_6.5.0 initialized
May 20 18:54:05 virtual sshd:  succeeded
May 20 18:54:05 virtual kernel: pty: 2048 Unix98 ptys configured
May 20 18:54:05 virtual kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
May 20 18:54:05 virtual sshd: ^[[60G[  
May 20 18:54:05 virtual kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
May 20 18:54:05 virtual kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 20 18:54:05 virtual kernel: Real Time Clock Driver v1.10e
May 20 18:54:05 virtual kernel: block: 1024 slots per queue, batch=256
May 20 18:54:05 virtual sshd: 
May 20 18:54:05 virtual kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 20 18:54:05 virtual rc: Starting sshd:  succeeded
May 20 18:54:05 virtual kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 20 18:54:05 virtual kernel: SvrWks CSB5: IDE controller on PCI bus 00 dev 79
May 20 18:54:05 virtual kernel: PCI: Device 00:0f.1 not available because of resource collisions
May 20 18:54:05 virtual kernel: SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.
May 20 18:54:05 virtual kernel: hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
May 20 18:54:05 virtual kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 20 18:54:05 virtual kernel: ide-floppy driver 0.99.newide
May 20 18:54:05 virtual kernel: Floppy drive(s): fd0 is 1.44M
May 20 18:54:05 virtual kernel: FDC 0 is a National Semiconductor PC87306
May 20 18:54:05 virtual kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
May 20 18:54:05 virtual kernel: ide-floppy driver 0.99.newide
May 20 18:54:05 virtual kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
May 20 18:54:05 virtual kernel: md: Autodetecting RAID arrays.
May 20 18:54:05 virtual kernel: md: autorun ...
May 20 18:54:05 virtual kernel: md: ... autorun DONE.
May 20 18:54:05 virtual kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.4
May 20 18:54:05 virtual kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 20 18:54:05 virtual kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May 20 18:54:05 virtual kernel: IP: routing cache hash table of 65536 buckets, 512Kbytes
May 20 18:54:05 virtual kernel: TCP: Hash tables configured (established 262144 bind 65536)
May 20 18:54:05 virtual kernel: Linux IP multicast router 0.06 plus PIM-SM
May 20 18:54:05 virtual kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 20 18:54:05 virtual kernel: RAMDISK: Compressed image found at block 0
May 20 18:54:05 virtual kernel: Freeing initrd memory: 216k freed
May 20 18:54:05 virtual kernel: VFS: Mounted root (ext2 filesystem).
May 20 18:54:05 virtual kernel: SCSI subsystem driver Revision: 1.00
May 20 18:54:05 virtual kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
May 20 18:54:05 virtual kernel: Configuring GDT-PCI HA at 1/8 IRQ 31
May 20 18:54:05 virtual kernel: scsi0 : SRCU31
May 20 18:54:05 virtual kernel:   Vendor: Intel     Model: Host Drive  #00   Rev:     
May 20 18:54:05 virtual kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May 20 18:54:05 virtual kernel:   Vendor: ESG-SHV   Model: SCA HSBP M16      Rev: 0.04
May 20 18:54:05 virtual kernel:   Type:   Processor                          ANSI SCSI revision: 02
May 20 18:54:05 virtual kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
May 20 18:54:05 virtual kernel: SCSI device sda: 143219475 512-byte hdwr sectors (73328 MB)
May 20 18:54:05 virtual kernel: Partition check:
May 20 18:54:05 virtual kernel:  sda: sda1 sda2 sda3
May 20 18:54:05 virtual kernel: Journalled Block Device driver loaded
May 20 18:54:05 virtual kernel: kjournald starting.  Commit interval 5 seconds
May 20 18:54:05 virtual kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 20 18:54:05 virtual kernel: Freeing unused kernel memory: 304k freed
May 20 18:54:05 virtual kernel: Adding Swap: 2096472k swap-space (priority -1)
May 20 18:54:05 virtual kernel: Adding Swap: 2096472k swap-space (priority -2)
May 20 18:54:05 virtual kernel: usb.c: registered new driver usbdevfs
May 20 18:53:45 virtual rc.sysinit: Mounting proc filesystem:  succeeded 
May 20 18:54:06 virtual kernel: usb.c: registered new driver hub
May 20 18:53:45 virtual rc.sysinit: Unmounting initrd:  succeeded 
May 20 18:54:06 virtual kernel: usb-ohci.c: USB OHCI at membase 0xf8a89000, IRQ 10
May 20 18:53:45 virtual sysctl: net.ipv4.ip_forward = 0 
May 20 18:54:06 virtual kernel: usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
May 20 18:53:45 virtual sysctl: net.ipv4.conf.default.rp_filter = 1 
May 20 18:54:06 virtual kernel: usb.c: new USB bus registered, assigned bus number 1
May 20 18:53:45 virtual sysctl: kernel.sysrq = 0 
May 20 18:54:06 virtual kernel: hub.c: USB hub found
May 20 18:53:45 virtual sysctl: kernel.core_uses_pid = 1 
May 20 18:54:06 virtual kernel: hub.c: 4 ports detected
May 20 18:53:45 virtual rc.sysinit: Configuring kernel parameters:  succeeded 
May 20 18:54:06 virtual kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
May 20 18:53:45 virtual date: Mon May 20 18:53:40 MDT 2002 
May 20 18:54:06 virtual kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
May 20 18:53:45 virtual rc.sysinit: Setting clock  (localtime): Mon May 20 18:53:40 MDT 2002 succeeded 
May 20 18:54:06 virtual kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
May 20 18:53:45 virtual rc.sysinit: Loading default keymap succeeded 
May 20 18:54:06 virtual kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:47:BD:61:DD, IRQ 21.
May 20 18:53:45 virtual rc.sysinit: Activating swap partitions:  succeeded 
May 20 18:54:06 virtual kernel:   Board assembly fab600-000, Physical connectors present: RJ45
May 20 18:53:45 virtual rc.sysinit: Setting hostname virtual.palb.com:  succeeded 
May 20 18:53:45 virtual rc.sysinit: Mounting USB filesystem:  succeeded 
May 20 18:53:45 virtual rc.sysinit: Initializing USB controller (usb-ohci):  succeeded 
May 20 18:54:06 virtual kernel:   Primary interface chip i82555 PHY #1.
May 20 18:53:45 virtual fsck: /: clean, 42896/8437760 files, 1298451/16854185 blocks 
May 20 18:54:06 virtual kernel:   General self-test: passed.
May 20 18:53:45 virtual rc.sysinit: Checking root filesystem succeeded 
May 20 18:54:06 virtual kernel:   Serial sub-system self-test: passed.
May 20 18:53:45 virtual rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
May 20 18:54:06 virtual kernel:   Internal registers self-test: passed.
May 20 18:54:06 virtual kernel:   ROM checksum self-test: passed (0xb874c1d3).
May 20 18:53:47 virtual rc.sysinit: Finding module dependencies:  succeeded 
May 20 18:54:06 virtual kernel: eth1: OEM i82557/i82558 10/100 Ethernet, 00:03:47:BD:61:DF, IRQ 20.
May 20 18:54:06 virtual kernel:   Board assembly fab600-000, Physical connectors present: RJ45
May 20 18:53:47 virtual rc.sysinit: Checking filesystems succeeded 
May 20 18:54:06 virtual kernel:   Primary interface chip i82555 PHY #1.
May 20 18:54:06 virtual kernel:   General self-test: passed.
May 20 18:53:47 virtual rc.sysinit: Mounting local filesystems:  succeeded 
May 20 18:54:06 virtual kernel:   Serial sub-system self-test: passed.
May 20 18:54:06 virtual kernel:   Internal registers self-test: passed.
May 20 18:53:47 virtual rc.sysinit: Enabling local filesystem quotas:  succeeded 
May 20 18:54:06 virtual kernel:   ROM checksum self-test: passed (0xb874c1d3).
May 20 18:53:47 virtual rc.sysinit: Enabling swap space:  succeeded 
May 20 18:53:49 virtual init: Entering runlevel: 3 
May 20 18:53:49 virtual kudzu: Updating /etc/fstab succeeded 
May 20 18:54:00 virtual kudzu:  succeeded 
May 20 18:54:00 virtual sysctl: net.ipv4.ip_forward = 0 
May 20 18:54:00 virtual sysctl: net.ipv4.conf.default.rp_filter = 1 
May 20 18:54:00 virtual sysctl: kernel.sysrq = 0 
May 20 18:54:00 virtual sysctl: kernel.core_uses_pid = 1 
May 20 18:54:00 virtual network: Setting network parameters:  succeeded 
May 20 18:54:01 virtual network: Bringing up loopback interface:  succeeded 
May 20 18:54:03 virtual network: Bringing up interface eth0:  succeeded 
May 20 18:54:06 virtual xinetd[740]: xinetd Version 2002.03.28 started with libwrap options compiled in.
May 20 18:54:06 virtual xinetd[740]: Started working: 0 available services
May 20 18:54:08 virtual xinetd: xinetd startup succeeded
May 20 18:54:09 virtual sendmail: sendmail startup succeeded
May 20 18:54:09 virtual gpm: gpm startup succeeded
May 20 18:54:10 virtual crond: crond startup succeeded
May 20 18:54:10 virtual xfs: xfs startup succeeded
May 20 18:54:10 virtual anacron: anacron startup succeeded
May 20 18:54:10 virtual xfs: listening on port 7100 
May 20 18:54:10 virtual atd: atd startup succeeded
May 20 18:54:11 virtual xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/share/fonts/default/TrueType (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/share/fonts/default/Type1 (unreadable) 
May 20 18:54:11 virtual xfs: ignoring font path element /usr/share/AbiSuite/fonts (unreadable) 
May 20 18:55:20 virtual sshd(pam_unix)[904]: session opened for user root by (uid=0)

--------------000507040007030406040300--

