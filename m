Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWAXNTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWAXNTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWAXNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:19:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:10955 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030473AbWAXNTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:19:31 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: linux-kernel@vger.kernel.org
Subject: AMD64, 4GB, mttr questions
Date: Tue, 24 Jan 2006 14:33:46 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6088464.unlEJXfBHR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601241433.50625.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6088464.unlEJXfBHR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have a machine with 4GB RAM, an Athlon64 X2 and following mttr entries:

reg00: base=3D0x00000000 (   0MB), size=3D4096MB: write-back, count=3D1
reg01: base=3D0x100000000 (4096MB), size=3D2048MB: write-back, count=3D1
reg02: base=3D0x80000000 (2048MB), size=3D2048MB: uncachable, count=3D1

=46irst of all, why is there an uncachable region? Is it the upper half of=
=20
memory? Or is this just a hole and the remaining 2GB are seated at=20
0x100000000 ?

I am also wondering why the kernel doesn't propery set up write-combining=20
regions: (I noticed this on 32bit x86, as well, on various machines)

lspci -v|grep Mem
        Memory behind bridge: fc700000-fc7fffff
        Memory behind bridge: fc800000-fc8fffff
        Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
        Memory behind bridge: fc900000-fe9fffff
        Memory behind bridge: fea00000-feafffff
        Memory at febff000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at febfec00 (32-bit, non-prefetchable) [size=3D256]
        Memory at febfd000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at febfc000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at febfb000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at febfe800 (32-bit, non-prefetchable) [size=3D256]
        Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
        Memory at b0000000 (32-bit, prefetchable) [size=3D128M]

X also comlains about this:

mtrr: type mismatch for b0000000,2000000 old: write-back new: write-combini=
ng

following complete dmesg, lspci -v and .config:

Bootdata ok (command line is root=3D/dev/sda5 elevator=3Dcfq quiet)
Linux version 2.6.15 (root@varma) (gcc-Version 3.4.5 (Gentoo 3.4.5)) #1 SMP=
=20
PREEMPT Thu Jan 12 14:50:12 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f9b=
b0
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000506 MSFT 0x00000097) @=20
0x000000007ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000506 MSFT 0x00000097) @=20
0x000000007ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000506 MSFT 0x00000097) @=20
0x000000007ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000506 MSFT 0x00000097) @=20
0x000000007ffc0040
ACPI: DSDT (v001  939M2 939M2150 0x00000150 INTL 0x02002026) @=20
0x0000000000000000
On node 0 totalpages: 1025626
  DMA zone: 2674 pages, LIFO batch:0
  DMA32 zone: 505832 pages, LIFO batch:31
  Normal zone: 517120 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Built 1 zonelists
Kernel command line: root=3D/dev/sda5 elevator=3Dcfq quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2000.122 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4095664k/6291456k available (3159k kernel code, 97584k reserved, 12=
67k=20
data, 212k init)
Calibrating delay using timer specific routine.. 4003.11 BogoMIPS=20
(lpj=3D2001559)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3999.60 BogoMIPS=20
(lpj=3D1999803)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 534 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
Boot video device is 0000:03:00.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
agpgart: Detected AGP bridge 20
Setting up ULi AGP.
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Reserving 128MB of IOMMU area in the AGP aperture
pnp: 00:0b: ioport range 0x290-0x29f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc700000-fc7fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: fc800000-fc8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: fc900000-fe9fffff
  PREFETCH window: aff00000-bfefffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: fea00000-feafffff
  PREFETCH window: disabled.
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/W].
fuse init (API version 7.3)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3=20
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
lp0: using parport0 (interrupt-driven).
lp0: console ready
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller at PCI slot 0000:00:12.0
GSI 18 sharing vector 0xD1 and IRQ 18
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, low) -> IRQ 209
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
libata version 1.20 loaded.
sata_uli 0000:00:12.1: version 0.5
ACPI: PCI Interrupt 0000:00:12.1[A] -> GSI 19 (level, low) -> IRQ 209
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE082 bmdma 0xD880 irq 209
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD888 irq 209
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663=20
88:007f
ata1: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_uli
ata2: no device found (phy stat 00000000)
scsi1 : sata_uli
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usbmon: debugfs is not available
GSI 19 sharing vector 0xD9 and IRQ 19
ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> IRQ 217
ehci_hcd 0000:00:13.3: EHCI Host Controller
ehci_hcd 0000:00:13.3: debug port 1
ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.3: irq 217, io mem 0xfebfe800
ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
GSI 20 sharing vector 0xE1 and IRQ 20
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, low) -> IRQ 225
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 225, io mem 0xfebfd000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
GSI 21 sharing vector 0xE9 and IRQ 21
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, low) -> IRQ 233
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 233, io mem 0xfebfc000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
GSI 22 sharing vector 0x32 and IRQ 22
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, low) -> IRQ 50
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 50, io mem 0xfebfb000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
I2O subsystem v1.288
i2o: max drivers =3D 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
ali1563: SMBus control =3D 0403
ali1563_probe: Returning 0
input: AT Translated Set 2 keyboard as /class/input/input0
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07=20
13:30:21 2005 UTC).
GSI 23 sharing vector 0x3A and IRQ 23
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 58
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
Unable to initialize codec #1
intel8x0_measure_ac97_clock: measured 50953 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: ALi M5455 with ALC850 at 0x0, irq 58
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xa (1300 mV)
cpu_init done, current fid 0xc, vid 0x8
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 212k freed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
GSI 24 sharing vector 0x42 and IRQ 24
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 66
eth0: ULi M5263 at pci0000:00:11.0, 00:13:8f:5d:2e:ea, irq 66.
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block=
=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: Using r5 hash to sort names
uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
mtrr: type mismatch for b0000000,2000000 old: write-back new: write-combini=
ng


00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and=
=20
HyperTransport]
        Flags: bus master, fast devsel, latency 0
        Capabilities: [40] HyperTransport: Slave or Primary Interface
        Capabilities: [5c] HyperTransport: MSI Mapping
        Capabilities: [68] HyperTransport: UnitID Clumping
        Capabilities: [74] HyperTransport: Interrupt Discovery and=20
Configuration
        Capabilities: [7c] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable-

00:01.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00 [Norm=
al=20
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        Memory behind bridge: fc700000-fc7fffff
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable+
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05

00:02.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00 [Norm=
al=20
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
        Memory behind bridge: fc800000-fc8fffff
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable+
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single=
=20
Chip]
        Flags: bus master, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
        Capabilities: [40] HyperTransport: Slave or Primary Interface
        Capabilities: [60] HyperTransport: Interrupt Discovery and=20
Configuration
        Capabilities: [80] AGP version 3.0

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00 [Normal=20
decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
64
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: aff00000-bfefffff

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if 01=20
[Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D=
32
        Memory behind bridge: fea00000-feafffff

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev =
70)
        Subsystem: ASRock Incorporation Unknown device 1563
        Flags: bus master, medium devsel, latency 0

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation Unknown device 7101
        Flags: medium devsel

00:08.0 Multimedia audio controller: ALi Corporation M5455 PCI AC-Link=20
Controller Audio Device (rev 20)
        Subsystem: ASRock Incorporation Unknown device 0850
        Flags: bus master, medium devsel, latency 32, IRQ 58
        I/O ports at e800 [size=3D256]
        Memory at febff000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [40] Power Management version 2

00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev=
=20
40)
        Subsystem: ASRock Incorporation Unknown device 5263
        Flags: bus master, medium devsel, latency 32, IRQ 66
        I/O ports at e400 [size=3D256]
        Memory at febfec00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a [Mast=
er=20
SecP PriP])
        Subsystem: ASRock Incorporation Unknown device 5229
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 209
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ff00 [size=3D16]

00:12.1 IDE interface: ALi Corporation ULi 5289 SATA (rev 10) (prog-if 8f=20
[Master SecP SecO PriP PriO])
        Subsystem: ASRock Incorporation Unknown device 5289
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 209
        I/O ports at ec00 [size=3D8]
        I/O ports at e080 [size=3D4]
        I/O ports at e000 [size=3D8]
        I/O ports at dc00 [size=3D4]
        I/O ports at d880 [size=3D16]

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f=20
10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 225
        Memory at febfd000 (32-bit, non-prefetchable) [size=3D4K]

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f=20
10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 233
        Memory at febfc000 (32-bit, non-prefetchable) [size=3D4K]

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-i=
f=20
10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 50
        Memory at febfb000 (32-bit, non-prefetchable) [size=3D4K]

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-i=
f=20
20 [EHCI])
        Subsystem: ASRock Incorporation Unknown device 5239
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 217
        Memory at febfe800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRA=
M=20
Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
Miscellaneous Control
        Flags: fast devsel

03:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS/Pr=
o]=20
(rev a3) (prog-if 00 [VGA])
        Subsystem: Elsa AG Gladiac
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
        Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
        Memory at b0000000 (32-bit, prefetchable) [size=3D128M]
        Expansion ROM at fe9f0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15
# Thu Jan 12 14:47:37 2006
#
CONFIG_X86_64=3Dy
CONFIG_64BIT=3Dy
CONFIG_X86=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_MMU=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy

#
# Block layer
#
CONFIG_LBD=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"

#
# Processor type and features
#
CONFIG_MK8=3Dy
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=3D64
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_MICROCODE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_MTRR=3Dy
CONFIG_SMP=3Dy
# CONFIG_SCHED_SMT is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
# CONFIG_NUMA is not set
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=3Dy
CONFIG_NR_CPUS=3D2
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_GART_IOMMU=3Dy
CONFIG_SWIOTLB=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_PHYSICAL_START=3D0x100000
CONFIG_KEXEC=3Dy
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy

#
# Power management options
#
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_HOTKEY=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=3Dy
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_ACPI_CPUFREQ=3Dy

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_UNORDERED_IO=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy
CONFIG_IA32_EMULATION=3Dy
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_UID16=3Dy

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dy
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=3D16
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=3Dy
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=3Dy
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=3Dy
CONFIG_SCSI_SATA_AHCI=3Dy
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
CONFIG_SCSI_SATA_ULI=3Dy
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=3Dy
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dy
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=3Dy
CONFIG_I2O_EXT_ADAPTEC=3Dy
CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy
CONFIG_I2O_CONFIG=3Dy
CONFIG_I2O_CONFIG_OLD_IOCTL=3Dy
CONFIG_I2O_BUS=3Dy
CONFIG_I2O_BLOCK=3Dy
CONFIG_I2O_SCSI=3Dy
CONFIG_I2O_PROC=3Dy

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dy
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=3Dy
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
CONFIG_ULI526X=3Dm
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_PRINTER=3Dy
CONFIG_LP_CONSOLE=3Dy
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=3Dy
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
CONFIG_AGP_AMD64=3Dy
# CONFIG_AGP_INTEL is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=3Dy
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=3Dy
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=3Dy
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=3Dy
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=3Dy
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dy
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM75=3Dy
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=3Dy
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Logo configuration
#
CONFIG_LOGO=3Dy
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=3Dy
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dy
CONFIG_SND_AC97_CODEC=3Dy
CONFIG_SND_AC97_BUS=3Dy
CONFIG_SND_TIMER=3Dy
CONFIG_SND_PCM=3Dy
CONFIG_SND_SEQUENCER=3Dy
CONFIG_SND_SEQ_DUMMY=3Dy
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dy
CONFIG_SND_PCM_OSS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dy
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=3Dy
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_DYNAMIC_MINORS=3Dy
CONFIG_USB_SUSPEND=3Dy
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_SPLIT_ISO=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=3Dy
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dy
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=3Dy

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_FUSE_FS=3Dy

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dy
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=3Dy
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dy
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dy
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=3Dy
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=3Dy
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dy
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_LOG_BUF_SHIFT=3D15
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=3Dy
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dy

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart6088464.unlEJXfBHR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD1iy+xU2n/+9+t5gRAhfpAJ9GEv2NpngO3p65zLHu2yIOgH5TvgCfUaje
kw1Yok3hAiVx4vNoa4Ydfvo=
=dTps
-----END PGP SIGNATURE-----

--nextPart6088464.unlEJXfBHR--
