Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUKYAfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUKYAfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUKYAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:34:16 -0500
Received: from pop.gmx.de ([213.165.64.20]:45985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262975AbUKXXZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:25:58 -0500
X-Authenticated: #20450766
Date: Wed, 24 Nov 2004 23:57:15 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [SMP, USB] UHCI interrupt wrongly routed?
Message-ID: <Pine.LNX.4.60.0411242352370.3896@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I guess, it is not a USB problem, really, it just appeared with USB. On a 
2-way running 2.6.9 the onboard UHCI device is configured to IRQ 9 via 
XT-PIC???

           CPU0       CPU1       
  0:     588054        123    IO-APIC-edge  timer
  1:        360          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          4          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 11:          0          0          XT-PIC  uhci_hcd
 15:          2          0    IO-APIC-edge  ide1
 16:        173          1   IO-APIC-level  ehci_hcd
 17:          0          0   IO-APIC-level  ohci_hcd
 18:          0          0   IO-APIC-level  ohci_hcd
 19:      99999          1   IO-APIC-level  ohci_hcd
 20:        332          0   IO-APIC-level  eth0
 21:       2576          0   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:     587726     587988 
ERR:          0
MIS:          0

Non-surprisingly, it doesn't work. Below is a complete dmesg (I first 
connected the card-reader to an ohci / ehci PCI board, and then 
re-connected it to an on-board UHCI port.

Thanks
Guennadi
---
Guennadi Liakhovetski

Linux version 2.6.9-rc4-tmscsim (lyakh@poirot.grange) (gcc version 3.3.2 (Debian)) #1 SMP Mon Oct 25 23:38:23 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB LOWMEM available.
found SMP MP-table at 000f6680
On node 0 totalpages: 32768
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28672 pages, LIFO batch:7
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000ec010
ACPI: RSDT (v001 COMPAQ LAREDO   0x00000001  0x00000000) @ 0x000ec080
ACPI: FADT (v001 COMPAQ LAREDO   0x00000001  0x00000000) @ 0x000ec0cc
ACPI: MADT (v001 COMPAQ LAREDO   0x00000001  0x00000000) @ 0x000ec140
ACPI: SSDT (v001 COMPAQ VILLTBL1 0x00000001 MSFT 0x01000005) @ 0x000ecad7
ACPI: SSDT (v001 COMPAQ PNP_PRSS 0x00000001 MSFT 0x01000005) @ 0x000ed6ec
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x01000005) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:5 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:5 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: Workstation  APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.9 ro root=803 console=ttyS0,57600 console=tty0 debug pci=noacpi
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 399.088 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 125660k/131072k available (2036k kernel code, 4968k reserved, 910k data, 280k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 790.52 BogoMIPS (lpj=395264)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1460.42 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/0 eip 3000
Initializing CPU#1
Calibrating delay loop... 796.67 BogoMIPS (lpj=398336)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 01
Total of 2 processors activated (1587.20 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xe10b4, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:14.0
PCI->APIC IRQ transform: (B0,I11,P0) -> 21
PCI->APIC IRQ transform: (B0,I12,P0) -> 20
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I13,P0) -> 17
PCI->APIC IRQ transform: (B0,I14,P0) -> 19
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P1) -> 17
PCI->APIC IRQ transform: (B0,I16,P2) -> 18
PCI->APIC IRQ transform: (B0,I16,P3) -> 19
PCI->APIC IRQ transform: (B0,I16,P0) -> 16
PCI: using PPB(B0,I1,P0) to get irq 22
PCI->APIC IRQ transform: (B1,I0,P0) -> 22
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Starting balanced_irq
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Console: switching to colour frame buffer device 80x30
fb0: TVP4020 frame buffer device, memory = 8192K.
isapnp: Scanning for PnP cards...
isapnp: Card 'ESS ES1869 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: COMPAQ CR-588, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
sym0: <875> rev 0x4 at pci 0000:00:0b.0 irq 21
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: COMPAQ    Model: DDRS-34560W       Rev: S97A
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
scsi(0:0:0:0): Domain Validation skipping write tests
scsi(0:0:0:0): Ending Domain Validation
  Vendor: QUANTUM   Model: VIKING II 4.5WSE  Rev: 4110
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:8:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:8:0): Beginning Domain Validation
sym0:8: wide asynchronous.
sym0:8: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
scsi(0:0:8:0): Domain Validation skipping write tests
scsi(0:0:8:0): Ending Domain Validation
SCSI device sda: 8386000 512-byte hdwr sectors (4294 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 8910423 512-byte hdwr sectors (4562 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 8, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 8, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0  RTC PS2M  KBD COM1 COM2 USB0 PBTN 
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
Adding 248996k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
SGI XFS with ACLs, security attributes, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:08:C7:82:82:3C, IRQ 20.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 695327-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:10.3: ALi Corporation USB 2.0 Controller
ehci_hcd 0000:00:10.3: irq 16, pci mem c8844000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:10.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:10.0: irq 17, pci mem c884e000
ohci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:10.1: ALi Corporation USB 1.1 Controller (#2)
ohci_hcd 0000:00:10.1: irq 18, pci mem c8850000
ohci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:10.2: ALi Corporation USB 1.1 Controller (#3)
ohci_hcd 0000:00:10.2: irq 19, pci mem c8852000
ohci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:14.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:14.2: irq 11, io base 000058a0
uhci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-6: new high speed USB device using address 2
Initializing USB Mass Storage driver...
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: SMSC      Model: 223 U HS-CF       Rev: 1.95
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdc: 375808 512-byte hdwr sectors (192 MB)
sdc: assuming Write Enabled
sdc: assuming drive cache: write through
 sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 sdc8 sdc9 >
Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
  Vendor: SMSC      Model: 223 U HS-MS       Rev: 1.95
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 1
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 1,  type 0
  Vendor: SMSC      Model: 223 U HS-SM       Rev: 1.95
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sde at scsi1, channel 0, id 0, lun 2
Attached scsi generic sg4 at scsi1, channel 0, id 0, lun 2,  type 0
  Vendor: SMSC      Model: 223 U HS-SD/MMC   Rev: 1.95
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdf at scsi1, channel 0, id 0, lun 3
Attached scsi generic sg5 at scsi1, channel 0, id 0, lun 3,  type 0
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 1-6: USB disconnect, address 2
usb 5-1: new full speed USB device using address 2
irq 19: nobody cared!
 [<c010602e>] dump_stack+0x1e/0x30
 [<c0107b5b>] __report_bad_irq+0x2b/0x90
 [<c0107c46>] note_interrupt+0x66/0xa0
 [<c0107f11>] do_IRQ+0x131/0x140
 [<c0105adc>] common_interrupt+0x18/0x20
 [<c0103102>] cpu_idle+0x42/0x60
 [<c03e49cb>] start_kernel+0x16b/0x190
 [<c0100211>] 0xc0100211
handlers:
[<c9086870>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #19
usb 5-1: control timeout on ep0out
uhci_hcd 0000:00:14.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
