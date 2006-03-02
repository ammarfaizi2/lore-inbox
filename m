Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWCBVhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWCBVhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCBVhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:37:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:24452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932306AbWCBVhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:37:51 -0500
X-Authenticated: #342784
From: jensmh@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 'lost' cpu
Date: Thu, 2 Mar 2006 21:37:39 +0000
User-Agent: KMail/1.9.1
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200603020505.13108.jensmh@gmx.de> <Pine.LNX.4.64.0603020734200.28074@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0603020734200.28074@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603022137.40710.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
> On Thu, 2 Mar 2006, jensmh@gmx.de wrote:
> 
> > This is a dual xeon system with hyper threading enabled, so there should
> > be 4 cpus
> > 
> > jm@voyager ~ $ ll /proc/acpi/processor/
> > total 0
> > dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU0
> > dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU1
> > dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU3
> 
> Can you try sending dmesg output too?

here it is, but this time all 4 cpus are detected. Later I will try some reboots
and check if I can reproduce the problem.

Linux version 2.6.16-rc5 (root@voyager) (gcc version 3.4.5 (Gentoo Hardened 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP PREEMPT Wed Mar 1 02:29:54 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff75000 (usable)
 BIOS-e820: 000000007ff75000 - 000000007ff77000 (ACPI NVS)
 BIOS-e820: 000000007ff77000 - 000000007ff98000 (ACPI data)
 BIOS-e820: 000000007ff98000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 524149
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294773 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000febc0
ACPI: RSDT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd4d4
ACPI: FADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd50c
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xffff373d
ACPI: MADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd580
ACPI: BOOT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd604
ACPI: ASF! (v016 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd62c
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Built 1 zonelists
Kernel command line: udev root=/dev/ram0 init=/linuxrc real_root=/dev/hda7 vga=ext
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80800)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c05af000 soft=c05a7000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2791.896 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2071896k/2096596k available (3030k kernel code, 23456k reserved, 1473k data, 232k init, 1179092k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5588.75 BogoMIPS (lpj=2794375)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c05b0000 soft=c05a8000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5581.18 BogoMIPS (lpj=2790590)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 2/6 eip 2000
CPU 2 irqstacks, hard=c05b1000 soft=c05a9000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5581.31 BogoMIPS (lpj=2790659)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Booting processor 3/7 eip 2000
CPU 3 irqstacks, hard=c05b2000 soft=c05aa000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5581.34 BogoMIPS (lpj=2790673)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
Total of 4 processors activated (22332.59 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
migration_cost=1000,2000
checking if image is initramfs... it is
Freeing initrd memory: 753k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfbdd5, last bus=5
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0b: ioport range 0x800-0x85f could not be reserved
pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0b: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:02:1d.0
  IO window: e000-efff
  MEM window: fe300000-fe4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:1f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe100000-fe4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: f9000000-fbffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
Using specific hotkey driver
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel E7505 Chipset.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized drm 1.0.1 20051102
PNP: PS/2 Controller [PNP0303:KBD] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.3.9-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:03:0e.0[A] -> GSI 24 (level, low) -> IRQ 169
e1000: 0000:03:0e.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:0d:56:09:09:fb
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: IC35L120AVV207-1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 234375000 sectors (120000 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdb: max request size: 512KiB
hdb: 234375000 sectors (120000 MB) w/7965KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 < hdb5 >
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
SCSI Media Changer driver v0.25 
ACPI: PCI Interrupt 0000:05:0c.0[A] -> GSI 20 (level, low) -> IRQ 185
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[185]  MMIO=[fbeff800-fbefffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
i2c /dev entries driver
parport0: cannot grant exclusive access for device i2c-parport
i2c-parport: Unable to register with parport
 : Detection failed at step 5
i2c_adapter i2c-0: Unsupported chip (man_id=0x55, chip_id=0x20).
i2c_adapter i2c-0: detect fail: address match, 0x2d
pc87360: PC8736x not detected, module not inserted.
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3536.000 MB/sec
raid5: using function: pIII_sse (3536.000 MB/sec)
raid6: int32x1    808 MB/s
raid6: int32x2    972 MB/s
raid6: int32x4    656 MB/s
raid6: int32x8    500 MB/s
raid6: mmxx1     1929 MB/s
raid6: mmxx2     2546 MB/s
raid6: sse1x1    1292 MB/s
raid6: sse1x2    2367 MB/s
raid6: sse2x1    3062 MB/s
raid6: sse2x2    2804 MB/s
raid6: using algorithm sse2x1 (3062 MB/s)
md: raid6 personality registered for level 6
md: faulty personality registered for level -5
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Mar  1 2006
MC: drivers/edac/edac_mc.c: edac_sysfs_memctrl_setup()
Registered '.../edac/mc' kobject
MC: drivers/edac/edac_mc.c: edac_sysfs_pci_setup()
Registered '.../edac/pci' kobject
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50991 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Virtual MIDI Card 1
  #1: Intel 82801DB-ICH4 with AD1981B at 0xfe500400, irq 193
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 232k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 201, io mem 0xfe500800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[86ffffffffffff00]
usb 1-2: new high speed USB device using ehci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 209, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 217, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 177, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
Linux video capture interface: v1.00
cx2388x v4l2 driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:05:0e.0[A] -> GSI 22 (level, low) -> IRQ 225
CORE cx88[0]: subsystem: 153b:1166, board: Conexant DVB-T reference design [card=19,insmod option]
TV tuner 4 at 0x1fe, Radio tuner -1 at 0x1fe
cx88[0]/0: found at 0000:05:0e.0, rev: 5, irq: 225, latency: 64, mmio: 0xfa000000
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
set_control id=0x980900 reg=0x310110 val=0x00 (mask 0xff)
set_control id=0x980901 reg=0x310110 val=0x3f00 (mask 0xff00)
set_control id=0x980903 reg=0x310118 val=0x00 (mask 0xff)
set_control id=0x980902 reg=0x310114 val=0x5a7f (mask 0xffff)
set_control id=0x980909 reg=0x320594 val=0x40 (mask 0x40) [shadowed]
set_control id=0x980905 reg=0x320594 val=0x20 (mask 0x3f) [shadowed]
set_control id=0x980906 reg=0x320598 val=0x40 (mask 0x7f) [shadowed]
cx2388x dvb driver version 0.0.5 loaded
ACPI: PCI Interrupt 0000:05:0e.2[A] -> GSI 22 (level, low) -> IRQ 225
cx88[0]/2: found at 0000:05:0e.2, rev: 5, irq: 225, latency: 64, mmio: 0xf9000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Conexant CX22702 DVB-T)...
microcode: CPU1 updated from revision 0xf to 0x2d, date = 08112004 
microcode: CPU3 updated from revision 0xf to 0x2d, date = 08112004 
microcode: CPU0 updated from revision 0xf to 0x2d, date = 08112004 
microcode: CPU2 updated from revision 0xf to 0x2d, date = 08112004 
Adding 987988k swap on /dev/mapper/swap1.  Priority:-1 extents:1 across:987988k
Adding 987988k swap on /dev/mapper/swap2.  Priority:-2 extents:1 across:987988k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
ReiserFS: dm-2: found reiserfs format "3.6" with standard journal
ReiserFS: dm-2: using ordered data mode
ReiserFS: dm-2: journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-2: checking transaction log (dm-2)
ReiserFS: dm-2: Using r5 hash to sort names
