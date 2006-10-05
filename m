Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWJEB2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWJEB2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWJEB2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:28:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:16996 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751304AbWJEB2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:28:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q7BwaCWXalMoMuCzOLR0Chuq5QSfgXki9wkUpi4ZaJO6sKUc329Hz+JL4/X/w1j+6L/NGj74kyFhqa4BxW27c/4jyW3HRl6OtYMYBpV15e145vWus3A4pAzae2n3M3M/Okrz/HVceqOMQBbHBf08xe92Q16NVCdMJf4u/VCVl7w=
Message-ID: <9a0545880610041828w658d7aaco20348d54e9321d8f@mail.gmail.com>
Date: Wed, 4 Oct 2006 18:28:35 -0700
From: "Steve Hindle" <mech422@gmail.com>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: PROBLEM: Hardlock with 2.6.1[678] on Abit AI7, ICH5 + XFS, SATA under heavy I/O load
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  My machine is hardlocking with recent kernels (including 2.6.18-mm3)
under heavy I/O load (for instance, just compiling the kernel is
enough to lock the machine).  No bug,oops,or panic and nothing in the
system logs.  Hasn't seemed to cause any fs corruption (which strikes
me as odd, since its generally writing files when it hangs..)

Steve

Environment, dmesg, interrupts, etc:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux blackie 2.6.16-2-686-smp #1 SMP Sun Jul 16 01:23:04 UTC 2006
i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.81
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2.2
e2fsprogs              1.37
reiserfsprogs          3.6.19
xfsprogs               2.6.20
PPP                    2.4.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   100
Modules Loaded         ipv6 bridge dummy loop sr_mod sbp2 ide_generic
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
snd_pcm mousedev snd_timer ath_pci snd ath_rate_sample wlan ath_hal
evdev psmouse i2c_i801 shpchp pci_hotplug soundcore snd_page_alloc
tsdev joydev parport_pc serio_raw intel_agp agpgart pcspkr i2c_core
parport eth1394 rtc floppy xfs exportfs ide_disk ide_cd cdrom usbhid
sd_mod 8139too piix ata_piix libata scsi_mod ehci_hcd 8139cp mii
ohci1394 ieee1394 generic uhci_hcd usbcore ide_core thermal processor
fan
Linux version 2.6.16-2-686-smp (Debian 2.6.16-16bpo1)
(nobse@backports.org) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP
Sun Jul 16 01:23:04 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
1023MB LOWMEM available.
found SMP MP-table at 000f5f20
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 258032 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f7ae0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7240
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sdb4 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3061.173 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1030796k/1048512k available (1568k kernel code, 17056k
reserved, 630k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6131.50 BogoMIPS (lpj=12263011)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180
0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6121.53 BogoMIPS (lpj=12243064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180
0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Total of 2 processors activated (12253.03 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=8000
checking if image is initramfs... it is
Freeing initrd memory: 4307k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfba70, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8000000-faffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:1e.0
  IO window: a000-afff
  MEM window: fb000000-fb0fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
audit: initializing netlink socket (disabled)
audit(1159985293.348:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI No-Shortcut mode
ACPI wakeup devices:
PCI0 HUB0 UAR1 USB0 USB1 USB2 USB3 USBE MODM
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 180k freed
ACPI: Thermal Zone [THRM] (20 C)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 169, io base 0x0000bc00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 177, io base 0x0000b000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000b400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000b800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 193
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]
MMIO=[fb015000-fb0157ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
SCSI subsystem initialized
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 201, io mem 0xfb100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
libata version 1.20 loaded.
usb 1-2: device descriptor read/all, error -71
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 185
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 185
ata1: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 86:1801 87:4003 88:207f
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:207f
ata2: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-00HK  Rev: 13.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD1600JD-22H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
8139cp: pci dev 0000:02:02.0 (id 10ec:8139 rev 10) is not an 8139C+
compatible chip
8139cp: Try the "8139too" driver instead.
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
8139too Fast Ethernet driver 0.9.27
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: Attached scsi disk sdb
usb 1-2: new full speed USB device using uhci_hcd and address 4
hda: MAXTOR 6L020J1, ATA DISK drive
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-2.2: new low speed USB device using uhci_hcd and address 5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508d0000d4d663]
usb 1-2.2: configuration #1 chosen from 1 choice
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
usb 1-2.3: new low speed USB device using uhci_hcd and address 6
usb 1-2.3: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input0
input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000]
on usb-0000:00:1d.0-2.2
input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input1
input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on
usb-0000:00:1d.0-2.2
input: Logitech USB-PS/2 Trackball as /class/input/input2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:1d.0-2.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hdc: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 185
eth0: RealTek RTL8139 at 0xa000, 00:50:8d:d5:d6:63, IRQ 185
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
hda: max request size: 128KiB
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hda: 40132503 sectors (20547 MB) w/1819KiB Cache, CHS=39813/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
SGI XFS with ACLs, security attributes, realtime, large block numbers,
no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sdb4
Ending clean XFS mount for filesystem: sdb4
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.12ac
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
input: PC Speaker as /class/input/input3
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 128M @ 0xf0000000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
ts: Compaq touchscreen protocol output
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
wlan: 0.8.6.0 (EXPERIMENTAL)
ath_rate_sample: 1.2
ath_pci: 0.9.6.0 (EXPERIMENTAL)
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 22 (level, low) -> IRQ 209
Build date: Jul 17 2006
Debugging version (IEEE80211)
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps
24Mbps 36Mbps 48Mbps 54Mbps
ath0: turboG rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: H/W encryption support: WEP AES AES_CCM TKIP
ath0: mac 7.9 phy 4.5 radio 5.6
ath0: Use hw queue 1 for WME_AC_BE traffic
ath0: Use hw queue 0 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Use hw queue 8 for CAB traffic
ath0: Use hw queue 9 for beacons
Debugging version (ATH)
ath0: Atheros 5212: mem=0xfb000000, irq=209
mice: PS/2 mouse device common for all mice
hw_random: RNG not detected
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 57705 usecs
intel8x0: clocking to 48000
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
loop: loaded (max 32 devices)
hw_random: RNG not detected
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Bridge firewalling registered
device dummy0 entered promiscuous mode
xenbr0: port 1(dummy0) entering learning state
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
xenbr0: topology change detected, propagating
xenbr0: port 1(dummy0) entering forwarding state
dummy0: no IPv6 routers present
xenbr0: no IPv6 routers present
eth0: no IPv6 routers present
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 1
cpu MHz		: 3061.173
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc
pni monitor ds_cpl cid xtpr
bogomips	: 6131.50

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 1
cpu MHz		: 3061.173
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc
pni monitor ds_cpl cid xtpr
bogomips	: 6121.53

steve@blackie:~$ cat /proc/interrupts
           CPU0       CPU1
  0:     300651          0    IO-APIC-edge  timer
  7:          0          0    IO-APIC-edge  parport0
  8:          4          0    IO-APIC-edge  rtc
  9:          1          0   IO-APIC-level  acpi
 14:         84          0    IO-APIC-edge  ide0
 15:         29          0    IO-APIC-edge  ide1
169:      20371          0   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb4
177:          0          0   IO-APIC-level  uhci_hcd:usb2
185:       7655          0   IO-APIC-level  uhci_hcd:usb3, libata, eth0
193:          3          0   IO-APIC-level  ohci1394, Intel ICH5
201:          2          0   IO-APIC-level  ehci_hcd:usb5
209:          0          0   IO-APIC-level  ath0
NMI:          0          0
LOC:     300588     300587
ERR:          0
MIS:          0
