Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUFPER4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUFPER4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUFPEQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:16:40 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:3713 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266166AbUFPENV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:13:21 -0400
Date: Wed, 16 Jun 2004 00:13:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616041313.GC13868@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org> <20040616024842.GC13672@porto.bmb.uga.edu> <20040615195822.7e7151aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615195822.7e7151aa.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:58:22PM -0700, Andrew Morton wrote:
> foo@porto.bmb.uga.edu wrote:
> >
> > On Tue, Jun 15, 2004 at 04:26:07PM -0700, Andrew Morton wrote:
> > > OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
> > > completion, causing that page to never be unlocked.
> > > 
> > > Please try the latest -mm kernel, which has a few devicemapper changes,
> > > although they are unlikely to fix this.
> > 
> > OK, this was fun...
> > 
> > LILO 22.2 boot: linux-mm
> > Loading Linux-mm.................................
> > 
> > This is all I see on the serial console.  The machine did boot, though;
> > a few minutes later I see this (and only this) from my syslog server:
> > 
> > xarello kernel: bonding: bond0: link status definitely up for interface
> > eth1.
> > 
> > Getty didn't come up on the serial console, and it's refusing ssh
> > requests, although it seems to be dropping lots of packets.
> 
> Lovely.  Please send over the kernel boot command line.

Here's the dmesg, extracted from the logs.

 klogd 1.4.1#10, log source = /proc/kmsg started.
 Cannot find map file.
 No module symbols loaded - kernel modules not enabled. 
 Bootdata ok (command line is BOOT_IMAGE=linux-mm ro root=851
console=ttyS0,19200n8)
 Linux version 2.6.7-rc3-mm2 (root@carignan) (gcc version 3.3.4
(Debian)) #1 SMP Tue Jun 15 22:30:28 EDT 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 Scanning NUMA topology in Northbridge 24
 Number of nodes 2 (10010)
 Node 0 MemBase 0000000000000000 Limit 000000003fffffff
 Node 1 MemBase 0000000040000000 Limit 000000007fff0000
 Using node hash shift of 24
 Bootmem setup node 0 0000000000000000-000000003fffffff
 Bootmem setup node 1 0000000040000000-000000007fff0000
 No mptable found.
 On node 0 totalpages: 262143
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 258047 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
 On node 1 totalpages: 262128
   DMA zone: 0 pages, LIFO batch:1
   Normal zone: 262128 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
 ACPI: RSDP (v002 ACPIAM                                    ) @
0x00000000000f4680
 ACPI: XSDT (v001 A M I  OEMXSDT  0x06000318 MSFT 0x00000097) @
0x000000007fff0100
 ACPI: FADT (v001 A M I  OEMFACP  0x06000318 MSFT 0x00000097) @
0x000000007fff0281
 ACPI: MADT (v001 A M I  OEMAPIC  0x06000318 MSFT 0x00000097) @
0x000000007fff0380
 ACPI: OEMB (v001 A M I  OEMBIOS  0x06000318 MSFT 0x00000097) @
0x000000007ffff040
 ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @
0x000000007fff3530
 ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @
0x0000000000000000
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
 Processor #0 15:5 APIC version 16
 ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
 Processor #1 15:5 APIC version 16
 ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
 IOAPIC[0]: Assigned apic_id 2
 IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
 ACPI: IOAPIC (id[0x03] address[0xfebfe000] gsi_base[24])
 IOAPIC[1]: Assigned apic_id 3
 IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
 ACPI: IOAPIC (id[0x04] address[0xfebff000] gsi_base[28])
 IOAPIC[2]: Assigned apic_id 4
 IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 Using ACPI (MADT) for SMP configuration information
 Checking aperture...
 CPU 0: aperture @ 1ee0000000 size 64 MB
 Aperture from northbridge cpu 0 beyond 4GB. Ignoring.
 No AGP bridge found
 Built 2 zonelists
 Initializing CPU#0
 Kernel command line: BOOT_IMAGE=linux-mm ro root=851
console=ttyS0,19200n8
 PID hash table entries: 16 (order 4: 256 bytes)
 time.c: Using 1.193182 MHz PIT timer.
 time.c: Detected 1394.628 MHz processor.
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
 Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
 Memory: 2056268k/2097088k available (2581k kernel code, 0k reserved,
1218k data, 180k init)
 Calibrating delay loop... 2736.12 BogoMIPS
 Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 Using local APIC NMI watchdog using perfctr0
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU0: AMD Opteron(tm) Processor 240 stepping 01
 per-CPU timeslice cutoff: 1023.75 usecs.
 task migration cache decay timeout: 2 msecs.
 Booting processor 1/1 rip 6000 rsp 10001e39f58
 Initializing CPU#1
 Calibrating delay loop... 2785.28 BogoMIPS
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 AMD Opteron(tm) Processor 240 stepping 01
 Total of 2 processors activated (5521.40 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 Using local APIC timer interrupts.
 Detected 12.452 MHz APIC timer.
 checking TSC synchronization across 2 CPUs: passed.
 time.c: Using PIT/TSC based timekeeping.
 Brought up 2 CPUs
 NET: Registered protocol family 16
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 ACPI: Subsystem revision 20040326
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 19
 ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 19
 ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 19
 ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 16 (level, low) -> IRQ 16
 ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 17 (level, low) -> IRQ 17
 ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 18
 ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 24
 ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 25
 ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 24 (level, low) -> IRQ 24
 ACPI: PCI interrupt 0000:02:0a.1[B] -> GSI 25 (level, low) -> IRQ 25
 testing the IO APIC.......................
 
 .................................... done.
 PCI-DMA: Disabling IOMMU.
 IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
 IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 ACPI: Power Button (FF) [PWRF]
 ACPI: Processor [CPU1] (supports C1, 8 throttling states)
 ACPI: Processor [CPU2] (supports C1)
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.12
 hpet_acpi_add: no address or irqs in _CRS
 hw_random: AMD768 system management I/O registers at 0x5000.
 hw_random hardware driver 1.0.0 loaded
 Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60
sec (nowayout= 0)
 Linux agpgart interface v0.100 (c) Dave Jones
 Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin
is 60 seconds).
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 parport0: PC-style at 0x378 [PCSPP(,...)]
 lp0: using parport0 (polling).
 Using anticipatory io scheduler
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 loop: loaded (max 8 devices)
 tg3.c:v3.5 (May 25, 2004)
 ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 24
 eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:c9
 eth0: HostTXDS[0] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0]
WireSpeed[1] TSOcap[1] 
 ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 25
 eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:ca
 eth1: HostTXDS[0] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0]
WireSpeed[1] TSOcap[1] 
 ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 16 (level, low) -> IRQ 16
 sym0: <875> rev 0x26 at pci 0000:03:04.0 irq 16
 sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
 sym0: open drain IRQ line driver, using on-chip SRAM
 sym0: using LOAD/STORE-based firmware.
 sym0: SCSI BUS has been reset.
 scsi0 : sym-2.1.18j
   Vendor: SONY      Model: SDX-400C          Rev: 0702
   Type:   Sequential-Access                  ANSI SCSI revision: 02
 scsi(0:0:4:0): Beginning Domain Validation
 sym0:4: wide asynchronous.
 sym0:4: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
 scsi(0:0:4:0): Domain Validation skipping write tests
 scsi(0:0:4:0): Ending Domain Validation
   Vendor: OVERLAND  Model: LIBRARYPRO        Rev: 0417
   Type:   Medium Changer                     ANSI SCSI revision: 02
 scsi(0:0:6:0): Beginning Domain Validation
 sym0:6: wide asynchronous.
 sym0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 15)
 scsi(0:0:6:0): Domain Validation skipping write tests
 scsi(0:0:6:0): Ending Domain Validation
 st: Version 20040403, fixed bufsize 32768, s/g segs 256
 Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
 st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA
1048575
 Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 1
 Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 8
 Fusion MPT base driver 3.01.07
 Copyright (c) 1999-2004 LSI Logic Corporation
 ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 24 (level, low) -> IRQ 24
 mptbase: Initiating ioc0 bringup
 ioc0: 53C1030: Capabilities={Initiator}
 ACPI: PCI interrupt 0000:02:0a.1[B] -> GSI 25 (level, low) -> IRQ 25
 mptbase: Initiating ioc1 bringup
 ioc1: 53C1030: Capabilities={Initiator}
 Fusion MPT SCSI Host driver 3.01.07
 scsi1 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=24
   Vendor: SUPER     Model: GEM318            Rev: 0   
   Type:   Processor                          ANSI SCSI revision: 02
 Attached scsi generic sg2 at scsi1, channel 0, id 8, lun 0,  type 3
   Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sda: 286749488 512-byte hdwr sectors (146816 MB)
 SCSI device sda: drive cache: write back
  sda: sda1
 Attached scsi disk sda at scsi1, channel 0, id 9, lun 0
 Attached scsi generic sg3 at scsi1, channel 0, id 9, lun 0,  type 0
   Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sdb: 286749488 512-byte hdwr sectors (146816 MB)
 SCSI device sdb: drive cache: write back
  sdb: sdb1
 Attached scsi disk sdb at scsi1, channel 0, id 10, lun 0
 Attached scsi generic sg4 at scsi1, channel 0, id 10, lun 0,  type 0
   Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sdc: 286749488 512-byte hdwr sectors (146816 MB)
 SCSI device sdc: drive cache: write back
  sdc: sdc1
 Attached scsi disk sdc at scsi1, channel 0, id 11, lun 0
 Attached scsi generic sg5 at scsi1, channel 0, id 11, lun 0,  type 0
   Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sdd: 286749488 512-byte hdwr sectors (146816 MB)
 SCSI device sdd: drive cache: write back
  sdd: sdd1
 Attached scsi disk sdd at scsi1, channel 0, id 12, lun 0
 Attached scsi generic sg6 at scsi1, channel 0, id 12, lun 0,  type 0
   Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sde: 286749488 512-byte hdwr sectors (146816 MB)
 SCSI device sde: drive cache: write back
  sde: sde1
 Attached scsi disk sde at scsi1, channel 0, id 13, lun 0
 Attached scsi generic sg7 at scsi1, channel 0, id 13, lun 0,  type 0
 scsi2 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=25
   Vendor: SEAGATE   Model: ST336607LW        Rev: 0007
   Type:   Direct-Access                      ANSI SCSI revision: 03
 SCSI device sdf: 71687372 512-byte hdwr sectors (36704 MB)
 SCSI device sdf: drive cache: write back
  sdf: sdf1 sdf2 sdf3 sdf4
 Attached scsi disk sdf at scsi2, channel 0, id 0, lun 0
 Attached scsi generic sg8 at scsi2, channel 0, id 0, lun 0,  type 0
 USB Universal Host Controller Interface driver v2.2
 Initializing USB Mass Storage driver...
 usbcore: registered new driver usb-storage
 USB Mass Storage support registered.
 mice: PS/2 mouse device common for all mice
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 i2c /dev entries driver
 md: raid1 personality registered as nr 3
 md: raid5 personality registered as nr 4
 raid5: measuring checksumming speed
    generic_sse:  4256.000 MB/sec
 raid5: using function: generic_sse (4256.000 MB/sec)
 md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
 device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
 NET: Registered protocol family 2
 IP: routing cache hash table of 8192 buckets, 128Kbytes
 TCP: Hash tables configured (established 262144 bind 65536)
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 md: Autodetecting RAID arrays.
 md: autorun ...
 md: considering sde1 ...
 md:  adding sde1 ...
 md:  adding sdd1 ...
 md:  adding sdc1 ...
 md:  adding sdb1 ...
 md:  adding sda1 ...
 md: created md0
 md: bind<sda1>
 md: bind<sdb1>
 md: bind<sdc1>
 md: bind<sdd1>
 md: bind<sde1>
 md: running: <sde1><sdd1><sdc1><sdb1><sda1>
 raid5: device sde1 operational as raid disk 4
 raid5: device sdd1 operational as raid disk 3
 raid5: device sdc1 operational as raid disk 2
 raid5: device sdb1 operational as raid disk 1
 raid5: device sda1 operational as raid disk 0
 raid5: allocated 5300kB for md0
 raid5: raid level 5 set md0 active with 5 out of 5 devices, algorithm 2
 RAID5 conf printout:
  --- rd:5 wd:5 fd:0
  disk 0, o:1, dev:sda1
  disk 1, o:1, dev:sdb1
  disk 2, o:1, dev:sdc1
  disk 3, o:1, dev:sdd1
  disk 4, o:1, dev:sde1
 md: ... autorun DONE.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 180k freed
 Adding 2097136k swap on /dev/sdf2.  Priority:-1 extents:1
 EXT3 FS on sdf1, internal journal
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on sdf3, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-32, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-34, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-33, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-35, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-0, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-2, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-3, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-1, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-4, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-5, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-6, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-7, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-8, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-9, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-10, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-11, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-12, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-13, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-14, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-15, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-16, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-17, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-18, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-19, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-20, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-21, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-22, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-23, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-24, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-25, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-26, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-27, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-28, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-29, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-30, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on dm-31, internal journal
 EXT3-fs: mounted filesystem with ordered data mode.
 Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
 bonding: MII link monitoring set to 100 ms
 bonding: bond0: enslaving eth0 as an active interface with a down link.
 bonding: bond0: enslaving eth1 as an active interface with a down link.
 tg3: eth0: Link is up at 1000 Mbps, full duplex.
 tg3: eth0: Flow control is off for TX and off for RX.
 bonding: bond0: link status definitely up for interface eth0.
 tg3: eth1: Link is up at 100 Mbps, full duplex.
 tg3: eth1: Flow control is off for TX and off for RX.
 bonding: bond0: link status definitely up for interface eth1.
 process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT

-ryan
