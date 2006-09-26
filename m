Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWIZHpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWIZHpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWIZHpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:45:30 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:43844 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750757AbWIZHp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:45:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NtyKaQaxKsvjPFIG9G/yImEkjEFz5fziYMkGcKQzcLvc+JpaHGtXUMbYtjGA0HuvmC18TmZzQfVGedBVwHTZtEyIzSIGJmPw/lduQXOePwdn1wD1WL+5fqIN/5dKiWWC3KCbwtx/PxF3yx2uMl9GHL7YrVvA6c2LRjL5aj5BphA=
Message-ID: <1e1a7e1b0609260045l41161c2bp5b520efb68d97fce@mail.gmail.com>
Date: Tue, 26 Sep 2006 17:45:26 +1000
From: James <iphitus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Nokia 6280 + provided USB cable throws BUG's and hardlocks.
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com, oliver@neukum.name
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

Attempting to connect and use my Nokia 6280 with the supplied Nokia
USB cable (reads: 'Type: CA-53') causes the kernel to through BUG's,
and has on occasion caused a complete lock up of the system.

This is running 2.6.18, and also occurs on the 2.6.17 series, which
was what I was using when I received the phone. I have no idea about
kernels before.

Linux sara 2.6.18-ARCH #1 SMP PREEMPT Fri Sep 22 12:13:37 CEST 2006
i686 Intel(R) Pentium(R) D CPU 2.80GHz GenuineIntel GNU/Linux

Only modification to kernel is the addition of this a patch to add
jmicron IDE support, however it still occurs without this patch
applied.

If i blacklist cdc-ether and cdc-acm, I cannot reproduce the error,
and my phone works fine as a usb-storage device.

I repeated the following trials to reproduce, each on a fresh boot:
1) Plug phone onto cable, already attached to computer. dmesg shows no
recognition of the connection and it's the same as that on a clean
boot.
2) Cancel on the phone, or select it's default mode
3) dmesg show's kernel BUG. dmesg after bug is below.

If I select USB storage, the phone goes into storage mode fine,
however upon leaving the storage mode, it drops back to it's default
mode, and causes the above BUG. This seems to be the only BUG i can
continually and safely reproduce, the others issues such as hardlocks
seem random and sporadic, and have at times occured many minutes after
unplugging the phone.

Occasionally, it doesnt bug, and I experience a wide range of lockups
or problems. I gave up my debugging when, after it entering default
mode, all my app's started dying, and would not restart saying my
libc.so file was too short, however it was fine after a reboot. The
lockups are hard lockups, sysrq is completely ignored. a trace has
been output only once upon lockup, which i am attempting to get off
the phone in question.

Kernel is a stock distro kernel, which has only one patch applied, to
add support for a jmicron IDE controller, however removing this does
not make a difference. This problem occurs on two different computers:
desktop, Asus P5LD2 motherboard, 945P chipset, Pentium D. SMP kernel
laptop, Early centrino, pretty sure it's 855 chipset, Pentium M 1.4,
SMP distro kernel.

I've attempted to CC all the correct people from the maintainer's
file, sorry if i have left anyone out or added anyone extra by
accident.

Thanks for your help, id there's anything you'd like me to try or
further information you would like, dont hesitate to ask, im greatful
for anything you can do to help.

James

Below are all the mentioned things in REPORTING-BUGS. Excuse any
nvidia mentions in the proc files, nvidia was blacklisted before
booting to do the tests and was never loaded for the tests. nor was it
loaded in the dmesg below.

config is linked as I was unsure whether it was too big. it's a stock
distro config so it has nearly everythin.
http://archlinux.org/~james/config

Linux version 2.6.18-ARCH (root@Wohnung) (gcc version 4.1.1) #1 SMP
PREEMPT Fri Sep 22 12:13:37 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffa0000 (usable)
 BIOS-e820: 000000003ffa0000 - 000000003ffae000 (ACPI data)
 BIOS-e820: 000000003ffae000 - 000000003ffe0000 (ACPI NVS)
 BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262048
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32672 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fad00
ACPI: XSDT (v001 A M I  OEMXSDT  0x05000531 MSFT 0x00000097) @ 0x3ffa0100
ACPI: FADT (v003 A M I  OEMFACP  0x05000531 MSFT 0x00000097) @ 0x3ffa0290
ACPI: MADT (v001 A M I  OEMAPIC  0x05000531 MSFT 0x00000097) @ 0x3ffa0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000531 MSFT 0x00000097) @ 0x3ffae040
  >>> ERROR: Invalid checksum
ACPI: MCFG (v001 A M I  OEMMCFG  0x05000531 MSFT 0x00000097) @ 0x3ffa85e0
ACPI: DSDT (v001  A0227 A0227000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Detected 2810.202 MHz processor.
Built 1 zonelists.  Total pages: 262048
Kernel command line: root=/dev/sda7 elevator=deadline ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034276k/1048192k available (2256k kernel code, 13180k
reserved, 708k data, 228k init, 130688k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5625.24 BogoMIPS (lpj=11250485)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000
0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000
0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180
0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
checking if image is initramfs... it is
Freeing initrd memory: 586k freed
ACPI: Core revision 20060707
ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
CPU0: Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5620.41 BogoMIPS (lpj=11240835)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000
0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000
0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000180
0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
Total of 2 processors activated (11245.66 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=641
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:08: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: caf00000-cfffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: c000-cfff
  MEM window: cae00000-caefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: a000-bfff
  MEM window: cad00000-cadfffff
  PREFETCH window: 50000000-500fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 228k freed
Time: tsc clocksource has been installed.
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x9800 ctl 0x9402 bmdma 0x8400 irq 18
ata2: SATA max UDMA/133 cmd 0x9000 ctl 0x8802 bmdma 0x8408 irq 18
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x9007
  Vendor: ATA       Model: ST3160812AS       Rev: 2AAA
  Type:   Direct-Access                      ANSI SCSI revision: 05
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 19
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
Probing IDE interface ide0...
hdb: HITACHI GD-2000, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
IT8212: IDE controller at PCI slot 0000:01:03.0
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 20 (level, low) -> IRQ 20
IT8212: chipset revision 17
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 20
    ide1: BM-DMA at 0xa400-0xa407, BIOS settings: hdc:pio, hdd:pio
    ide2: BM-DMA at 0xa408-0xa40f, BIOS settings: hde:pio, hdf:pio
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
hdd: ST3200826A, ATA DISK drive
ide1 at 0xb800-0xb807,0xb402 on irq 20
Probing IDE interface ide2...
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
hdb: ATAPI 20X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
hdd: max request size: 512KiB
hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 >
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with journal data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00007000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 21, io base 0x00007400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 22, io base 0x00007800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
CSLIP: code copyright 1989 Regents of the University of California
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 17, io base 0x00008000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
PPP generic driver version 2.4.2
usb 1-1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1b.0 to 64
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Linux agpgart interface v0.101 (c) Dave Jones
usb 1-2: new full speed USB device using uhci_hcd and address 3
Intel 82802 RNG detected
Real Time Clock Driver v1.12ac
usb 1-2: configuration #1 chosen from 1 choice
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
usb 2-2: new low speed USB device using uhci_hcd and address 2
agpgart: Detected an Intel 945G Chipset.
agpgart: AGP aperture is 256M @ 0x0
Initializing USB Mass Storage driver...
usb 2-2: configuration #1 chosen from 1 choice
usb 3-2: new low speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xcacff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 3-2: USB disconnect, address 2
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.5 addr 0xcaefc000 irq 17 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:13:d4:3f:99:22
usb 1-1: USB disconnect, address 2
lp0: using parport0 (interrupt-driven).
usb 1-2: USB disconnect, address 3
ppdev: user-space parallel port driver
usb 2-2: USB disconnect, address 2
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as
/class/input/input0
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:1d.1-2
EXT3 FS on sda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with journal data mode.
usb 1-1: new low speed USB device using uhci_hcd and address 4
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd5, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd6, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd7, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd8, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
usb 1-1: configuration #1 chosen from 1 choice
input: Microsoft Natural(r) Ergonomic Keyboard 4000 as /class/input/input1
input: USB HID v1.11 Keyboard [Microsoft Natural(r) Ergonomic Keyboard
4000] on usb-0000:00:1d.0-1
input: Microsoft Natural(r) Ergonomic Keyboard 4000 as /class/input/input2
input: USB HID v1.11 Device [Microsoft Natural(r) Ergonomic Keyboard
4000] on usb-0000:00:1d.0-1
usb 1-2: new full speed USB device using uhci_hcd and address 5
usb 1-2: configuration #1 chosen from 1 choice
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft Wireless Optical Mouse(r) 1.0A as /class/input/input3
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical
Mouse(r) 1.0A] on usb-0000:00:1d.2-2
sky2 eth0: enabling interface
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
  Vendor: MATSHITA  Model: SD-USB-R/W        Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sdb: 29120 512-byte hdwr sectors (15 MB)
sdb: Write Protect is off
sdb: Mode Sense: 18 00 00 08
sdb: assuming drive cache: write through
SCSI device sdb: 29120 512-byte hdwr sectors (15 MB)
sdb: Write Protect is off
sdb: Mode Sense: 18 00 00 08
sdb: assuming drive cache: write through
 sdb: sdb1
sd 3:0:0:0: Attached scsi removable disk sdb
usb-storage: device scan complete
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Adding 979924k swap on /dev/sda5.  Priority:-1 extents:1 across:979924k
i2c /dev entries driver
eth0: no IPv6 routers present
usb 2-1: new full speed USB device using uhci_hcd and address 4
usb 2-1: configuration #1 chosen from 1 choice
drivers/usb/class/cdc-acm.c: Ignoring extra header, type -3, length 4
cdc_acm 2-1:1.1: ttyACM0: USB ACM device
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver
for USB modems and ISDN adapters
usbcore: registered new driver cdc_ether
rndis_host 2-1:1.9: RNDIS init failed, -110
usb%d: unregister 'rndis_host' usb-0000:00:1d.1-1, RNDIS device
unregister_netdevice: device usb%d/f6de8000 never was registered
------------[ cut here ]------------
kernel BUG at mm/slab.c:595!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in: rndis_host cdc_ether usbnet cdc_acm w83627ehf
eeprom i2c_isa i2c_dev ipv6 nls_cp437 vfat fat ppdev lp usb_storage
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device usbhid
snd_pcm_oss snd_mixer_oss rtc intel_rng i2c_i801 sky2 i2c_core
ehci_hcd intel_agp agpgart parport_pc parport snd_hda_intel
snd_hda_codec snd_pcm snd_timer snd soundcore joydev ppp_generic slhc
snd_page_alloc evdev uhci_hcd serio_raw usbcore ide_disk ide_cd cdrom
sd_mod reiserfs ext3 mbcache jbd it821x piix ide_core ata_piix libata
CPU:    0
EIP:    0060:[<c0168188>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-ARCH #1)
EIP is at kfree+0x78/0x90
eax: 80000000   ebx: ffffff92   ecx: f6de8000   edx: c16dbc20
esi: f6de1b92   edi: 00000282   ebp: f6de8400   esp: f6d7bda0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3823, ti=f6d7a000 task=c1bc6ab0 task.ti=f6d7a000)
Stack: ffffff92 f8a6b920 f8a6b580 f8a6c188 c03aab14 c03aab0c 00000000 00000001
       f6d7bde4 c011c918 00000000 00000000 00000003 00000202 f7c0ce00 00000000
       f7f60a00 f8a93820 f6de8000 f7942888 f7a66400 dffc4200 f7d3dc80 00000001
Call Trace:
 [<f8a6b920>] usbnet_start_xmit+0x0/0x200 [usbnet]
 [<f8a6b580>] usbnet_change_mtu+0x0/0x50 [usbnet]
 [<f8a6c188>] usbnet_probe+0x2f8/0x620 [usbnet]
 [<c011c918>] __wake_up+0x38/0x50
 [<f88f1b48>] usb_probe_interface+0x68/0xa0 [usbcore]
 [<c0283184>] driver_probe_device+0x44/0xc0
 [<c02832d4>] __driver_attach+0x64/0x70
 [<c0282afa>] bus_for_each_dev+0x3a/0x60
 [<c02830c6>] driver_attach+0x16/0x20
 [<c0283270>] __driver_attach+0x0/0x70
 [<c028274c>] bus_add_driver+0x8c/0x140
 [<f88f1909>] usb_register_driver+0x89/0x110 [usbcore]
 [<c01427bd>] sys_init_module+0x15d/0x1ac0
 [<c010325d>] sysenter_past_esp+0x56/0x79
Code: 1d 89 74 83 18 40 89 03 57 9d 8b 1c 24 8b 74 24 04 8b 7c 24 08
83 c4 0c c3 8b 52 0c eb c6 89 c8 89 da e8 ac fe ff ff 8b 03 eb d6 <0f>
0b 53 02 b5 4d 35 c0 eb b5 8d b4 26 00 00 00 00 8d bc 27 00
EIP: [<c0168188>] kfree+0x78/0x90 SS:ESP 0068:f6d7bda

lsmod before bug:
Module                  Size  Used by
w83627ehf              12556  0
eeprom                  5904  0
i2c_isa                 3968  1 w83627ehf
i2c_dev                 7556  0
ipv6                  237472  12
usb_storage            76736  1
nls_cp437               5888  2
vfat                   10624  2
fat                    45596  1 vfat
usbhid                 47776  0
snd_seq_oss            29440  0
snd_seq_midi_event      6528  1 snd_seq_oss
snd_seq                47184  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          6924  2 snd_seq_oss,snd_seq
snd_pcm_oss            39072  0
snd_mixer_oss          14592  2 snd_pcm_oss
intel_rng               2688  0
ppdev                   7556  0
rtc                    10292  0
lp                      9604  0
joydev                  8256  0
snd_hda_intel          14484  1
snd_hda_codec         146304  1 snd_hda_intel
snd_pcm                67972  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              19204  2 snd_seq,snd_pcm
snd                    42724  9
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               7776  2 snd
snd_page_alloc          7816  2 snd_hda_intel,snd_pcm
intel_agp              19740  1
ppp_generic            24084  0
slhc                    6656  1 ppp_generic
sky2                   35076  0
ehci_hcd               29576  0
agpgart                25944  1 intel_agp
i2c_i801                7308  0
serio_raw               5636  0
evdev                   7936  0
i2c_core               17280  5 w83627ehf,eeprom,i2c_isa,i2c_dev,i2c_i801
parport_pc             35684  1
parport                31432  3 ppdev,lp,parport_pc
uhci_hcd               21004  0
usbcore               110852  5 usb_storage,usbhid,ehci_hcd,uhci_hcd
ide_disk               13440  6
ide_cd                 35616  0
cdrom                  34464  1 ide_cd
sd_mod                 16640  6
reiserfs              236544  0
ext3                  122504  6
mbcache                 7044  1 ext3
jbd                    55080  1 ext3
it821x                  7300  0 [permanent]
piix                    9220  0 [permanent]
ide_core              109256  5 usb_storage,ide_disk,ide_cd,it821x,piix
ata_piix               10760  3
libata                 85908  1 ata_piix

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) D CPU 2.80GHz
stepping        : 4
cpu MHz         : 2810.184
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts a
pi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni monitor ds_cpl
cid cx16 xtpr
bogomips        : 5625.19

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) D CPU 2.80GHz
stepping        : 4
cpu MHz         : 2810.184
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts a
pi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni monitor ds_cpl
cid cx16 xtpr
bogomips        : 5620.39

lspci -vvv as root:
00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub (rev 81)
	Subsystem: Intel Corporation Unknown device 2580
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation 945G/P PCI Express Graphics Port
(rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 04
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: caf00000-cfffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dff00000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 817f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 04
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at cacf8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 04
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 1, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 04
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: cae00000-caefffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 7000 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at 7400 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 22
	Region 4: I/O ports at 7800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 17
	Region 4: I/O ports at 8000 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at cacff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
(prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: cad00000-cadfffff
	Prefetchable memory behind bridge: 0000000050000000-0000000050000000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master
SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 2601
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 18
	Region 0: I/O ports at 9800 [size=8]
	Region 1: I/O ports at 9400 [size=4]
	Region 2: I/O ports at 9000 [size=8]
	Region 3: I/O ports at 8800 [size=4]
	Region 4: I/O ports at 8400 [size=16]
	Region 5: Memory at cacffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8179
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at 0400 [size=32]

01:02.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus
Reference Card (rev 01)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 6834
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at cadde000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.0 Mass storage controller: Integrated Technology Express, Inc.
ITE 8211F Single Channel UDMA 133 (ASUS 8211 (ITE IT8212 ATA RAID
Controller)) (rev 11)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8138
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Expansion ROM at 50000000 [disabled] [size=128K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053
Gigabit Ethernet Controller (rev 19)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet
Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 04
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at caefc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at c800 [size=256]
	Expansion ROM at caec0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

04:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
6600 GT] (rev a2) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology Unknown device 3125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=64M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at cb000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at cafe0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

/proc/iomem:
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ff9ffff : System RAM
  00100000-003340cc : Kernel code
  003340cd-003e51ff : Kernel data
3ffa0000-3ffadfff : ACPI Tables
3ffae000-3ffdffff : ACPI Non-volatile Storage
3ffe0000-3fffffff : reserved
50000000-500fffff : PCI Bus #01
  50000000-5001ffff : 0000:01:03.0
cacf8000-cacfbfff : 0000:00:1b.0
  cacf8000-cacfbfff : ICH HD audio
cacff800-cacffbff : 0000:00:1d.7
  cacff800-cacffbff : ehci_hcd
cacffc00-cacfffff : 0000:00:1f.2
  cacffc00-cacfffff : libata
cad00000-cadfffff : PCI Bus #01
  cadde000-caddffff : 0000:01:02.0
cae00000-caefffff : PCI Bus #02
  caec0000-caedffff : 0000:02:00.0
  caefc000-caefffff : 0000:02:00.0
    caefc000-caefffff : sky2
caf00000-cfffffff : PCI Bus #04
  cafe0000-caffffff : 0000:04:00.0
  cb000000-cbffffff : 0000:04:00.0
  cc000000-cfffffff : 0000:04:00.0
    cc000000-cfffffff : nvidia
d0000000-dfffffff : PCI Bus #04
  d0000000-dfffffff : 0000:04:00.0
ffb80000-ffffffff : reserved

/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0290-0297 : pnp 00:08
  0295-0296 : w83627ehf
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-041f : i801_smbus
0778-077a : parport0
0800-0803 : ACPI PM1a_EVT_BLK
0804-0805 : ACPI PM1a_CNT_BLK
0808-080b : ACPI PM_TMR
0810-0815 : ACPI CPU throttle
0820-0820 : ACPI PM2_CNT_BLK
0828-082f : ACPI GPE0_BLK
0cf8-0cff : PCI conf1
7000-701f : 0000:00:1d.0
  7000-701f : uhci_hcd
7400-741f : 0000:00:1d.1
  7400-741f : uhci_hcd
7800-781f : 0000:00:1d.2
  7800-781f : uhci_hcd
8000-801f : 0000:00:1d.3
  8000-801f : uhci_hcd
8400-840f : 0000:00:1f.2
  8400-840f : libata
8800-8803 : 0000:00:1f.2
  8800-8803 : libata
9000-9007 : 0000:00:1f.2
  9000-9007 : libata
9400-9403 : 0000:00:1f.2
  9400-9403 : libata
9800-9807 : 0000:00:1f.2
  9800-9807 : libata
a000-bfff : PCI Bus #01
  a400-a40f : 0000:01:03.0
    a400-a407 : ide1
    a408-a40f : ide2
  a800-a803 : 0000:01:03.0
  b000-b007 : 0000:01:03.0
  b400-b403 : 0000:01:03.0
    b402-b402 : ide1
  b800-b807 : 0000:01:03.0
    b800-b807 : ide1
c000-cfff : PCI Bus #02
  c800-c8ff : 0000:02:00.0
    c800-c8ff : sky2
d000-dfff : PCI Bus #03
e000-efff : PCI Bus #04
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0

-- 
iphitus - Beyond Maintainer, Arch Trusted User, Arch Developer.
Home:iphitus.loudas.com
