Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUHVEca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUHVEca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUHVEca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:32:30 -0400
Received: from pumpkin.explorerforum.com ([209.209.36.42]:58836 "EHLO
	pumpkin.explorerforum.com") by vger.kernel.org with ESMTP
	id S266065AbUHVEcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:32:10 -0400
Message-ID: <412821C4.7060402@lbl.gov>
Date: Sat, 21 Aug 2004 21:32:04 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
References: <20040820031919.413d0a95.akpm@osdl.org>
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070105070509080102030008"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.9 (pumpkin.explorerforum.com [209.209.36.42]); Sat, 21 Aug 2004 21:40:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105070509080102030008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
> 
> - Added three more bk trees:
> 
> 	bk-fb:		Some ARM framebuffer driver (rmk)
> 	bk-mmc:		ARM-specific media drivers(?)
> 	bk-watchdog:	watchdog drivers
> 
> - I'm totally unclear on what's happening with the release_task
>   sleep-while-atomic bug, and with the CPU hotplug BUG.  This kernel will
>   probably emit might_sleep warnings.  Turn off CONFIG_PREEMPT if it gets
>   irritating.
> 
> - Added Nick Piggin's CPU scheduler to see what happens.  See inside the
>   patch for details.  Please test, benchmark, report.
> 
> - This is (very) lightly tested.  Mainly a resync with various parties.
> 

Not sure what does what - I'm in the process of going back to 2.6.8.1, and see if any of this goes away..

1) the ub device kills my SanDisk 8 in 1 reader (SDDR-88)  I have to yank it out of the USB port to fix it.  fixed by removing the UB device from my config outright.

2) do not try to modprobe -r ub; it will do wonky things to your machine (I tried in a KDE Konsole, and lost the keyboard, and the terminal just scrolled blank lines..)

3) Interactivity performance when compiling a kernel (make rpm) sucks.  I have a Dell Poweredge 400SC, with a Hyper threaded P4/1GB of ram, ATI Radeon 9600 based video.  Load average jumps to the 4's, and stays there - while each cpu in the hyper thread shows about 50% idle time.  Mouse pointer jumps all over the place, mouse clicks are lost, menus are slow to drop down, etc..

4) why does this happen (hdd is reported to be PIO, but it's not..)

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio

[root@pinkie root]# /sbin/hdparm /dev/hdd

/dev/hdd:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24321/255/63, sectors = 390721968, start = 0

thomas

--------------070105070509080102030008
Content-Type: text/plain;
 name="dmesg-2.6.8.1-mm3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.8.1-mm3.txt"

Linux version 2.6.8.1-mm3 (root@pinkie) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #2 SMP Sat Aug 21 20:53:47 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
 BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262004
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32628 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                      ) @ 0x000feb90
ACPI: RSDT (v001 DELL    PE400SC 0x00000007 ASL  0x00000061) @ 0x000fd145
ACPI: FADT (v001 DELL    PE400SC 0x00000007 ASL  0x00000061) @ 0x000fd17d
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc8a27
ACPI: MADT (v001 DELL    PE400SC 0x00000007 ASL  0x00000061) @ 0x000fd1f1
ACPI: BOOT (v001 DELL    PE400SC 0x00000007 ASL  0x00000061) @ 0x000fd25d
ACPI: ASF! (v016 DELL    PE400SC 0x00000007 ASL  0x00000061) @ 0x000fd285
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda5
CPU 0 irqstacks, hard=c03f4000 soft=c03ec000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2792.918 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034704k/1048016k available (1919k kernel code, 12688k reserved, 844k data, 204k init, 130512k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5521.40 BogoMIPS (lpj=2760704)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.09 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c03f5000 soft=c03ed000
Initializing CPU#1
Calibrating delay loop... 5570.56 BogoMIPS (lpj=2785280)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11091.96 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 03
  groups: 01 02
  domain 1: span 03
   groups: 03
CPU1:  online
 domain 0: span 03
  groups: 02 01
  domain 1: span 03
   groups: 03
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfba63, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
pnp: 00:00: ioport range 0x800-0x8df could not be reserved
pnp: 00:00: ioport range 0xc00-0xc7f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=203.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon AP  SDR SGRAM 256 MB
Simple Boot Flag value 0x87 read from CMOS RAM was invalid
Simple Boot Flag at 0x7a set to 0x1
Machine check exception polling timer started.
Starting balanced_irq
highmem bounce pool size: 64 pages
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST340014A, ATA DISK drive
hdb: WDC WD1000BB-00CCB0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
hdd: HDS722525VLAT80, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2
hdd: max request size: 1024KiB
hdd: 390721968 sectors (200049 MB) w/7938KiB Cache, CHS=24321/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS2++ Logitech Mouse on isa0060/serio1
i2c /dev entries driver
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8187 buckets, 65496 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
VBTN PCI0 USB0 USB1 USB2 USB3 PCI1  KBD 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Real Time Clock Driver v1.12
EXT3 FS on hda5, internal journal
Adding 2096472k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 22 (level, low) -> IRQ 22
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]  MMIO=[fe8df800-fe8dffff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0001080030000afa]
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: No suitable data for CPU0
microcode: No suitable data for CPU1
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000ff80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000ff60
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000ff40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000ff20
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f99d4800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 5-1: new high speed USB device using address 2
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 0, lun 1,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 0, lun 2,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 0, lun 1
Attached scsi removable disk sdc at scsi0, channel 0, id 0, lun 2
Attached scsi removable disk sdd at scsi0, channel 0, id 0, lun 3
Attached scsi generic sg3 at scsi0, channel 0, id 0, lun 3,  type 0
inserting floppy driver for 2.6.8.1-mm3
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
floppy: controller ACPI FDC at I/O 0x3f7-0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
usb 3-2: new full speed USB device using address 2
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.3: new full speed USB device using address 3
usb 3-2.4: new full speed USB device using address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x0832 pid 0x5850
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
floppy0: no floppy controllers found
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 18 (level, low) -> IRQ 18
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Bluetooth: L2CAP ver 2.3
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
lp0: using parport0 (interrupt-driven).
Linux agpgart interface v0.100 (c) Dave Jones
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 51575 usecs
intel8x0: clocking to 48000
usb 5-1: USB disconnect, address 2
inserting floppy driver for 2.6.8.1-mm3
usb 5-1: new high speed USB device using address 4
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 1
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 1,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 2
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 2,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9139
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 3
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 3,  type 0
USB Mass Storage device found at 4
inserting floppy driver for 2.6.8.1-mm3

--------------070105070509080102030008--
