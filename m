Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWGKSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWGKSgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWGKSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:36:06 -0400
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:8905 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932075AbWGKSgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:36:05 -0400
X-IronPort-AV: i="4.06,230,1149480000"; 
   d="scan'208"; a="1907683919:sNHT61307912"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17587.42397.168635.821696@stoffel.org>
Date: Tue, 11 Jul 2006 09:20:29 -0400
From: "John Stoffel" <john@stoffel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6.18-rc1-mm1 - bad serial port count messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I've just booted up 2.6.18-rc1-mm1 last night after 29 days of uptime
running 2.6.17-rc4.  Aside from not having any Virtual Consoles due to
the missing /sbin/gettyps, things look ok so far, though bootup is
fairly slow.  

I'm getting the following messages in dmesg:

  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count for ttyS0: -1
  uart_close: bad serial port count for ttyS0: -1
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count for ttyS0: -1
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0
  uart_close: bad serial port count; tty->count is 1, state->count is 0

Which I suspect might be because I'm running a serial console to catch
an oops.  The first time I booted 2.6.18-rc1-mm1, I got an OOM from
ext2.fsck, which is strange since I have 768mb of RAM.  Since I didn't
have the serial console hooked up, I couldn't get any debug output
from there.  

The second boot worked (eventually, had to do other stuff and couldn't
watch it boot).  

Here's the full dmesg output of my bootup:

  Linux version 2.6.18-rc1-mm1 (john@jfsnew) (gcc version 4.1.2 20060630 (prerelease) (Debian 4.1.1-6)) #17 SMP Mon Jul 10 10:22:55 EDT 2006
  BIOS-provided physical RAM map:
  sanitize start
  sanitize end
  copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 00000000000a0000 type: 1
  copy_e820_map() type is E820_RAM
  add_memory_region(0000000000000000, 00000000000a0000, 1)
  copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
  add_memory_region(00000000000f0000, 0000000000010000, 2)
  copy_e820_map() start: 0000000000100000 size: 000000002fefe000 end: 000000002fffe000 type: 1
  copy_e820_map() type is E820_RAM
  add_memory_region(0000000000100000, 000000002fefe000, 1)
  copy_e820_map() start: 000000002fffe000 size: 0000000000002000 end: 0000000030000000 type: 2
  add_memory_region(000000002fffe000, 0000000000002000, 2)
  copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
  add_memory_region(00000000fec00000, 0000000000010000, 2)
  copy_e820_map() start: 00000000fee00000 size: 0000000000010000 end: 00000000fee10000 type: 2
  add_memory_region(00000000fee00000, 0000000000010000, 2)
  copy_e820_map() start: 00000000ffe00000 size: 0000000000200000 end: 0000000100000000 type: 2
  add_memory_region(00000000ffe00000, 0000000000200000, 2)
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
   BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
   BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
   BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
   BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
   BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
  early console enabled
  767MB LOWMEM available.
  found SMP MP-table at 000fe710
  On node 0 totalpages: 196606
    DMA zone: 4096 pages, LIFO batch:0
    Normal zone: 192510 pages, LIFO batch:31
  DMI 2.2 present.
  ACPI: RSDP (v000 DELL                                  ) @ 0x000fdee0
  ACPI: RSDT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdef4
  ACPI: FADT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdf20
  ACPI: MADT (v001 DELL    WS 610  0x00000002 ASL  0x00000061) @ 0x000fdf94
  ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000b) @ 0x00000000
  ACPI: PM-Timer IO Port: 0x808
  ACPI: Local APIC address 0xfee00000
  ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
  Processor #0 6:7 APIC version 17
  ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
  Processor #1 6:7 APIC version 17
  ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x4])
  ACPI: NMI not connected to LINT 1!
  ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
  IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
  ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
  ACPI: IRQ0 used by override.
  ACPI: IRQ2 used by override.
  ACPI: IRQ9 used by override.
  Enabling APIC mode:  Flat.  Using 1 I/O APICs
  Using ACPI (MADT) for SMP configuration information
  Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
  Detected 547.189 MHz processor.
  Built 1 zonelists.  Total pages: 196606
  Kernel command line: root=/dev/sda2 ro console=tty0  console=ttyS0,9600n8 earlyprintk=serial
  mapped APIC to ffffd000 (fee00000)
  mapped IOAPIC to ffffc000 (fec00000)
  Enabling fast FPU save and restore... done.
  Enabling unmasked SIMD FPU exception support... done.
  Initializing CPU#0
  CPU 0 irqstacks, hard=c059c000 soft=c059a000
  PID hash table entries: 4096 (order: 12, 16384 bytes)
  disabling early console
  Console: colour VGA+ 80x25
  Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
  Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
  Memory: 773832k/786424k available (2990k kernel code, 12068k reserved, 1420k data, 256k init, 0k highmem)
  Checking if this processor honours the WP bit even in supervisor mode... Ok.
  Calibrating delay using timer specific routine.. 1094.94 BogoMIPS (lpj=547471)
  Mount-cache hash table entries: 512
  CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
  CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
  CPU: L1 I cache: 16K, L1 D cache: 16K
  CPU: L2 cache: 512K
  CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#0.
  Compat vDSO mapped to ffffe000.
  Checking 'hlt' instruction... OK.
  Freeing SMP alternatives: 20k freed
  ACPI: Core revision 20060623
  CPU0: Intel Pentium III (Katmai) stepping 03
  Booting processor 1/1 eip 2000
  CPU 1 irqstacks, hard=c059d000 soft=c059b000
  Initializing CPU#1
  Calibrating delay using timer specific routine.. 1094.26 BogoMIPS (lpj=547132)
  CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
  CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
  CPU: L1 I cache: 16K, L1 D cache: 16K
  CPU: L2 cache: 512K
  CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
  Intel machine check architecture supported.
  Intel machine check reporting enabled on CPU#1.
  CPU1: Intel Pentium III (Katmai) stepping 03
  Total of 2 processors activated (2189.20 BogoMIPS).
  ENABLING IO-APIC IRQs
  ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
  checking TSC synchronization across 2 CPUs: passed.
  Brought up 2 CPUs
  migration_cost=3617
  NET: Registered protocol family 16
  ACPI: bus type pci registered
  PCI: PCI BIOS revision 2.10 entry at 0xfca1e, last bus=3
  Setting up standard PCI resources
  ACPI: Interpreter enabled
  ACPI: Using IOAPIC for interrupt routing
  ACPI: PCI Root Bridge [PCI0] (0000:00)
  PCI: Probing PCI hardware (bus 00)
  ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
  * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
  * this clock source is slow. Consider trying other clock sources
  PCI quirk: region 0800-083f claimed by PIIX4 ACPI
  PCI quirk: region 0850-085f claimed by PIIX4 SMB
  Boot video device is 0000:01:00.0
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
  ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
  ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 15)
  ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
  ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 15)
  ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
  Linux Plug and Play Support v0.97 (c) Adam Belay
  pnp: PnP ACPI init
  pnp: PnP ACPI: found 13 devices
  PnPBIOS: Disabled by ACPI PNP
  SCSI subsystem initialized
  usbcore: registered new driver usbfs
  usbcore: registered new driver hub
  PCI: Using ACPI for IRQ routing
  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
  pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
  PCI: Bridge: 0000:00:01.0
    IO window: disabled.
    MEM window: fc000000-fdffffff
    PREFETCH window: f2000000-f5ffffff
  PCI: Bridge: 0000:02:06.0
    IO window: disabled.
    MEM window: fa000000-fbffffff
    PREFETCH window: f1000000-f1ffffff
  PCI: Bridge: 0000:00:13.0
    IO window: e000-efff
    MEM window: f8000000-fbffffff
    PREFETCH window: f0000000-f1ffffff
  Device `[PCI1]' is not power manageable
  NET: Registered protocol family 2
  IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
  TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
  TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
  TCP: Hash tables configured (established 131072 bind 65536)
  TCP reno registered
  IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
  Initializing Cryptographic API
  io scheduler noop registered
  io scheduler anticipatory registered (default)
  io scheduler deadline registered
  io scheduler cfq registered
  ACPI: Power Button (FF) [PWRF]
  ibm_acpi: ec object not found
  isapnp: Scanning for PnP cards...
  isapnp: No Plug & Play device found
  Cyclades driver 2.3.2.20 2004/02/25 18:14:16
	  built Jul 10 2006 10:02:34
  Cyclom-Y/ISA #1: 0xc00de000-0xc00dffff, IRQ11, 8 channels starting from port 0.
  Real Time Clock Driver v1.12ac
  Linux agpgart interface v0.101 (c) Dave Jones
  agpgart: Detected an Intel 440GX Chipset.
  agpgart: AGP aperture is 64M @ 0xec000000
  [drm] Initialized drm 1.0.1 20051102
  ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
  [drm] Initialized mga 3.2.1 20051102 on minor 0
  Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
  serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
  00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
  Floppy drive(s): fd0 is 1.44M
  FDC 0 is a National Semiconductor PC87306
  loop: loaded (max 8 devices)
  ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
  3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
  0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at f0802000.
  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  PIIX4: IDE controller at PCI slot 0000:00:07.1
  PIIX4: chipset revision 1
  PIIX4: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
  Probing IDE interface ide0...
  hda: SAMSUNG CDRW/DVD SM-352B, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  HPT302: IDE controller at PCI slot 0000:00:0d.0
  ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
  HPT302: chipset revision 1
  HPT302: DPLL base: 66 MHz, f_CNT: 102, assuming 33 MHz PCI
  HPT302: using 66 MHz DPLL clock
  HPT302: 100% native mode on irq 16
      ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
      ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
  Probing IDE interface ide2...
  hde: WDC WD1200JB-00CRA1, ATA DISK drive
  ide2 at 0xdcd8-0xdcdf,0xdcd2 on irq 16
  Probing IDE interface ide3...
  hdg: WDC WD1200JB-00EVA0, ATA DISK drive
  ide3 at 0xdcc0-0xdcc7,0xdcba on irq 16
  Probing IDE interface ide1...
  hde: max request size: 128KiB
  hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
  hde: cache flushes not supported
   hde: hde1
  hdg: max request size: 512KiB
  hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
  hdg: cache flushes supported
   hdg: hdg1
  hda: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
  Uniform CD-ROM driver Revision: 3.20
  ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
  scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
	  <Adaptec aic7890/91 Ultra2 SCSI adapter>
	  aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

    Vendor: COMPAQ    Model: HC01841729        Rev: 3208
    Type:   Direct-Access                      ANSI SCSI revision: 02
  scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
   target0:0:0: Beginning Domain Validation
   target0:0:0: wide asynchronous
  scsi0: PCI error Interrupt at seqaddr = 0x8
  scsi0: Signaled a Target Abort
   target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
   target0:0:0: Domain Validation skipping write tests
   target0:0:0: Ending Domain Validation
    Vendor: COMPAQ    Model: BD018222CA        Rev: B016
    Type:   Direct-Access                      ANSI SCSI revision: 02
  scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
   target0:0:1: Beginning Domain Validation
   target0:0:1: wide asynchronous
  scsi0: PCI error Interrupt at seqaddr = 0x8
  scsi0: Signaled a Target Abort
   target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
   target0:0:1: Domain Validation skipping write tests
   target0:0:1: Ending Domain Validation
  ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
  scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
	  <Adaptec aic7880 Ultra SCSI adapter>
	  aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

    Vendor: SUN       Model: DLT7000           Rev: 245F
    Type:   Sequential-Access                  ANSI SCSI revision: 02
   target1:0:5: Beginning Domain Validation
   target1:0:5: wide asynchronous
   target1:0:5: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
   target1:0:5: Domain Validation skipping write tests
   target1:0:5: Ending Domain Validation
  st: Version 20050830, fixed bufsize 32768, s/g segs 256
  st 1:0:5:0: Attached scsi tape st0
  st0: try direct i/o: yes (alignment 512 B)
   target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
  SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
  sda: Write Protect is off
  sda: Mode Sense: c7 00 10 08
  SCSI device sda: drive cache: write through w/ FUA
  SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
  sda: Write Protect is off
  sda: Mode Sense: c7 00 10 08
  SCSI device sda: drive cache: write through w/ FUA
   sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
  sd 0:0:0:0: Attached scsi disk sda
   target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
  SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
  sdb: Write Protect is off
  sdb: Mode Sense: af 00 10 08
  SCSI device sdb: drive cache: write through w/ FUA
  SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
  sdb: Write Protect is off
  sdb: Mode Sense: af 00 10 08
  SCSI device sdb: drive cache: write through w/ FUA
   sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
  sd 0:0:1:0: Attached scsi disk sdb
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  sd 0:0:1:0: Attached scsi generic sg1 type 0
  st 1:0:5:0: Attached scsi generic sg2 type 1
  usbmon: debugfs is not available
  ACPI: PCI Interrupt 0000:03:08.2[C] -> GSI 16 (level, low) -> IRQ 16
  ehci_hcd 0000:03:08.2: EHCI Host Controller
  ehci_hcd 0000:03:08.2: new USB bus registered, assigned bus number 1
  ehci_hcd 0000:03:08.2: irq 16, io mem 0xfaffdc00
  ehci_hcd 0000:03:08.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
  usb usb1: new device found, idVendor=0000, idProduct=0000
  usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb1: Product: EHCI Host Controller
  usb usb1: Manufacturer: Linux 2.6.18-rc1-mm1 ehci_hcd
  usb usb1: SerialNumber: 0000:03:08.2
  usb usb1: configuration #1 chosen from 1 choice
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 5 ports detected
  PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
  serio: i8042 AUX port at 0x60,0x64 irq 12
  serio: i8042 KBD port at 0x60,0x64 irq 1
  mice: PS/2 mouse device common for all mice
  md: linear personality registered for level -1
  input: AT Translated Set 2 keyboard as /class/input/input0
  md: raid0 personality registered for level 0
  md: raid1 personality registered for level 1
  md: raid10 personality registered for level 10
  raid6: int32x1    132 MB/s
  raid6: int32x2    125 MB/s
  raid6: int32x4    132 MB/s
  raid6: int32x8    132 MB/s
  raid6: mmxx1      367 MB/s
  raid6: mmxx2      429 MB/s
  raid6: sse1x1     296 MB/s
  input: ImPS/2 Generic Wheel Mouse as /class/input/input1
  raid6: sse1x2     386 MB/s
  raid6: using algorithm sse1x2 (386 MB/s)
  md: raid6 personality registered for level 6
  md: raid5 personality registered for level 5
  md: raid4 personality registered for level 4
  raid5: automatically using best checksumming function: pIII_sse
     pIII_sse  :  1136.000 MB/sec
  raid5: using function: pIII_sse (1136.000 MB/sec)
  md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
  md: bitmap version 4.39
  device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
  EDAC MC: Ver: 2.0.1 Jul 10 2006
  TCP bic registered
  Initializing IPsec netlink socket
  NET: Registered protocol family 1
  NET: Registered protocol family 17
  NET: Registered protocol family 15
  Starting balanced_irq
  Using IPI Shortcut mode
  Time: tsc clocksource has been installed.
  Freeing unused kernel memory: 256k freed
  md: Autodetecting RAID arrays.
  md: invalid raid superblock magic on sda1
  md: sda1 has invalid sb, not importing!
  md: invalid raid superblock magic on sda2
  md: sda2 has invalid sb, not importing!
  md: invalid raid superblock magic on sda5
  md: sda5 has invalid sb, not importing!
  md: invalid raid superblock magic on sda6
  md: sda6 has invalid sb, not importing!
  md: autorun ...
  md: considering sdb6 ...
  md:  adding sdb6 ...
  md: sdb5 has different UUID to sdb6
  md: sdb3 has different UUID to sdb6
  md: sdb2 has different UUID to sdb6
  md: sdb1 has different UUID to sdb6
  md: hdg1 has different UUID to sdb6
  md: hde1 has different UUID to sdb6
  md: created md6
  md: bind<sdb6>
  md: running: <sdb6>
  raid1: raid set md6 active with 1 out of 2 mirrors
  md: considering sdb5 ...
  md:  adding sdb5 ...
  md: sdb3 has different UUID to sdb5
  md: sdb2 has different UUID to sdb5
  md: sdb1 has different UUID to sdb5
  md: hdg1 has different UUID to sdb5
  md: hde1 has different UUID to sdb5
  md: created md5
  md: bind<sdb5>
  md: running: <sdb5>
  raid1: raid set md5 active with 1 out of 2 mirrors
  md: considering sdb3 ...
  md:  adding sdb3 ...
  md: sdb2 has different UUID to sdb3
  md: sdb1 has different UUID to sdb3
  md: hdg1 has different UUID to sdb3
  md: hde1 has different UUID to sdb3
  md: created md3
  md: bind<sdb3>
  md: running: <sdb3>
  raid1: raid set md3 active with 1 out of 2 mirrors
  md: considering sdb2 ...
  md:  adding sdb2 ...
  md: sdb1 has different UUID to sdb2
  md: hdg1 has different UUID to sdb2
  md: hde1 has different UUID to sdb2
  md: created md2
  md: bind<sdb2>
  md: running: <sdb2>
  raid1: raid set md2 active with 1 out of 2 mirrors
  md: considering sdb1 ...
  md:  adding sdb1 ...
  md: hdg1 has different UUID to sdb1
  md: hde1 has different UUID to sdb1
  md: created md1
  md: bind<sdb1>
  md: running: <sdb1>
  raid1: raid set md1 active with 1 out of 2 mirrors
  md: considering hdg1 ...
  md:  adding hdg1 ...
  md:  adding hde1 ...
  md: created md0
  md: bind<hde1>
  md: bind<hdg1>
  md: running: <hdg1><hde1>
  raid1: raid set md0 active with 2 out of 2 mirrors
  md0: bitmap initialized from disk: read 15/15 pages, set 0 bits, status: 0
  created bitmap (224 pages) for device md0
  md: ... autorun DONE.
  kjournald starting.  Commit interval 5 seconds
  EXT3-fs: mounted filesystem with ordered data mode.
  ACPI: PCI Interrupt 0000:03:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
  ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[17]  MMIO=[faffd000-faffd7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
  ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
  ACPI: PCI Interrupt 0000:03:08.0[A] -> GSI 18 (level, low) -> IRQ 18
  ohci_hcd 0000:03:08.0: OHCI Host Controller
  ohci_hcd 0000:03:08.0: new USB bus registered, assigned bus number 2
  ohci_hcd 0000:03:08.0: irq 18, io mem 0xfafff000
  USB Universal Host Controller Interface driver v3.0
  ACPI: PCI Interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 19
  uhci_hcd 0000:00:07.2: UHCI Host Controller
  uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 3
  uhci_hcd 0000:00:07.2: irq 19, io base 0x0000dce0
  usb usb3: new device found, idVendor=0000, idProduct=0000
  usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb3: Product: UHCI Host Controller
  usb usb3: Manufacturer: Linux 2.6.18-rc1-mm1 uhci_hcd
  usb usb3: SerialNumber: 0000:00:07.2
  usb usb3: configuration #1 chosen from 1 choice
  hub 3-0:1.0: USB hub found
  hub 3-0:1.0: 2 ports detected
  ohci1394: fw-host0: Running dma failed because Node ID is not valid
  usb 3-1: new full speed USB device using uhci_hcd and address 2
  usb usb2: new device found, idVendor=0000, idProduct=0000
  usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb2: Product: OHCI Host Controller
  usb usb2: Manufacturer: Linux 2.6.18-rc1-mm1 ohci_hcd
  usb 3-1: new device found, idVendor=0451, idProduct=2046
  usb 3-1: new device strings: Mfr=0, Product=0, SerialNumber=0
  usb 3-1: configuration #1 chosen from 1 choice
  usb usb2: SerialNumber: 0000:03:08.0
  hub 3-1:1.0: USB hub found
  usb usb2: configuration #1 chosen from 1 choice
  hub 2-0:1.0: USB hub found
  hub 2-0:1.0: 3 ports detected
  hub 3-1:1.0: 4 ports detected
  ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
  ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
  ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 17
  usb 3-2: new full speed USB device using uhci_hcd and address 3
  ieee1394: Host added: ID:BUS[0-00:1023]  GUID[005042b500016243]
  usb 3-2: new device found, idVendor=0a5c, idProduct=3535
  usb 3-2: new device strings: Mfr=0, Product=0, SerialNumber=0
  usb 3-2: configuration #1 chosen from 1 choice
  hub 3-2:1.0: USB hub found
  hub 3-2:1.0: 3 ports detected
  ACPI: PCI Interrupt 0000:03:08.1[B] -> GSI 19 (level, low) -> IRQ 19
  ohci_hcd 0000:03:08.1: OHCI Host Controller
  ohci_hcd 0000:03:08.1: new USB bus registered, assigned bus number 4
  ohci_hcd 0000:03:08.1: irq 19, io mem 0xfaffe000
  usb 3-2.1: new full speed USB device using uhci_hcd and address 4
  usb 3-2.1: new device found, idVendor=047d, idProduct=105d
  usb 3-2.1: new device strings: Mfr=1, Product=2, SerialNumber=3
  usb 3-2.1: Product: BCM92035DG
  usb 3-2.1: Manufacturer: Broadcom
  usb 3-2.1: SerialNumber: 000C55F67D4C
  usb 3-2.1: configuration #1 chosen from 1 choice
  usb usb4: new device found, idVendor=0000, idProduct=0000
  usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
  usb usb4: Product: OHCI Host Controller
  usb usb4: Manufacturer: Linux 2.6.18-rc1-mm1 ohci_hcd
  usb usb4: SerialNumber: 0000:03:08.1
  usb usb4: configuration #1 chosen from 1 choice
  hub 4-0:1.0: USB hub found
  hub 4-0:1.0: 2 ports detected
  usb 3-2.2: new full speed USB device using uhci_hcd and address 5
  piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
  Bluetooth: Core ver 2.10
  NET: Registered protocol family 31
  Bluetooth: HCI device and connection manager initialized
  Bluetooth: HCI socket layer initialized
  Bluetooth: HCI USB driver ver 2.9
  usb 3-2.2: device descriptor read/all, error -110
  usb 3-2.2: new full speed USB device using uhci_hcd and address 6
  usb 3-2.2: new device found, idVendor=0a5c, idProduct=3502
  usb 3-2.2: new device strings: Mfr=0, Product=0, SerialNumber=3
  usb 3-2.2: SerialNumber: 000C55F67D4C
  usb 3-2.2: configuration #1 chosen from 1 choice
  usb 3-2.3: new full speed USB device using uhci_hcd and address 7
  usb 3-2.3: device descriptor read/all, error -110
  usb 3-2.3: new full speed USB device using uhci_hcd and address 8
  usb 3-2.3: device descriptor read/all, error -110
  usb 3-2.3: new full speed USB device using uhci_hcd and address 9
  usb 3-2.3: new device found, idVendor=0a5c, idProduct=3503
  usb 3-2.3: new device strings: Mfr=0, Product=0, SerialNumber=3
  usb 3-2.3: SerialNumber: 000C55F67D4C
  usb 3-2.3: configuration #1 chosen from 1 choice
  usbcore: registered new driver hiddev
  usbcore: registered new driver hci_usb
  input: HID 0a5c:3502 as /class/input/input2
  input: USB HID v1.11 Keyboard [HID 0a5c:3502] on usb-0000:00:07.2-2.2
  input: HID 0a5c:3503 as /class/input/input3
  input: USB HID v1.11 Mouse [HID 0a5c:3503] on usb-0000:00:07.2-2.3
  usbcore: registered new driver usbhid
  drivers/usb/input/hid-core.c: v2.6:USB HID core driver
  Adding 996020k swap on /dev/sda3.  Priority:-1 extents:1 across:996020k
  EXT3 FS on sda2, internal journal
   target1:0:5: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
  st0: Block limits 2 - 16777214 bytes.
  program stinit is using a deprecated SCSI ioctl, please convert it to SG_IO
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on sda5, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on sda1, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on sda6, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on dm-0, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on dm-1, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  kjournald starting.  Commit interval 5 seconds
  EXT3 FS on dm-2, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  eth0:  setting full-duplex.
  Bluetooth: L2CAP ver 2.8
  Bluetooth: L2CAP socket layer initialized
  Bluetooth: RFCOMM socket layer initialized
  Bluetooth: RFCOMM TTY layer initialized
  Bluetooth: RFCOMM ver 1.8
  usb 3-2.2: USB disconnect, address 6
  usb 3-2.3: USB disconnect, address 9
  agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
  agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
  agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
  [drm] Initialized card for AGP DMA.
  uart_close: bad serial port count; tty->count is 1, state->count is 0
