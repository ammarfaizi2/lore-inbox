Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbULZQPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbULZQPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbULZQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:15:46 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:4545 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261690AbULZQOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:14:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Ho ho ho - Linux v2.6.10 (module strangeness)
Date: Sun, 26 Dec 2004 11:14:13 -0500
User-Agent: KMail/1.7
Cc: Chris Rankin <rankincj@yahoo.com>
References: <20041226114820.72564.qmail@web52902.mail.yahoo.com>
In-Reply-To: <20041226114820.72564.qmail@web52902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261114.13332.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.45.252] at Sun, 26 Dec 2004 10:14:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 06:48, Chris Rankin wrote:
>I'm also seeing "unresolved symbols" messages (with
>ohci1394), but the modules are present and do load.
>
>The eth1394 module was also managing to grab "eth0"
>from e1000, despite this line in my modprobe.conf
>file:
>
>install eth1394 { /sbin/modprobe e1000; /sbin/modprobe
>--ignore-install eth1394; }
>
>I had to blacklist the eth1394 module so that the
>hot-plugging would ignore it.
>
>"pci=routeirq" was used because my radeon DRM module
>wouldn't behave without it.
>
>And the ttyS0 and ttyS1 ports are being reported twice
>by the serial code. Very strange.
>
>Cheers,
>Chris

I can confirm this last item, except its 3 times here on this box, 
from my /var/log/dmesg:
-----------------------
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing 
enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
------------------------

And I note this just above that:
------------------------
vesafb: probe of vesafb0 failed with error -6
------------------------
The video card is an agp, Radeon 9200 SE, 128 megs ram.  Is its vesa 
broken? An append to the kernel line in grub.conf of vga=791 gets a 
blank screen till I log in blind and do a startx.

>----------------------------------------------------
>
>Linux version 2.6.10 (chris@volcano.underworld) (gcc
>version 3.4.3) #1 SMP Sun Dec 26 00:02:33 GMT 2004
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 00000000000a0000
>(usable)
> BIOS-e820: 00000000000f0000 - 0000000000100000
>(reserved)
> BIOS-e820: 0000000000100000 - 000000003ff75000
>(usable)
> BIOS-e820: 000000003ff75000 - 000000003ff77000 (ACPI
>NVS)
> BIOS-e820: 000000003ff77000 - 000000003ff98000 (ACPI
>data)
> BIOS-e820: 000000003ff98000 - 0000000040000000
>(reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec90000
>(reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee10000
>(reserved)
> BIOS-e820: 00000000ffb00000 - 0000000100000000
>(reserved)
>127MB HIGHMEM available.
>896MB LOWMEM available.
>found SMP MP-table at 000fe710
>On node 0 totalpages: 262005
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 225280 pages, LIFO batch:16
>  HighMem zone: 32629 pages, LIFO batch:7
>DMI 2.3 present.
>ACPI: RSDP (v000 DELL
>) @ 0x000febc0
>ACPI: RSDT (v001 DELL    WS 650  0x00000008 ASL
>0x00000061) @ 0x000fd4d4
>ACPI: FADT (v001 DELL    WS 650  0x00000008 ASL
>0x00000061) @ 0x000fd50c
>ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT
>0x0100000d) @ 0xffff373d
>ACPI: MADT (v001 DELL    WS 650  0x00000008 ASL
>0x00000061) @ 0x000fd580
>ACPI: BOOT (v001 DELL    WS 650  0x00000008 ASL
>0x00000061) @ 0x000fd604
>ACPI: ASF! (v016 DELL    WS 650  0x00000008 ASL
>0x00000061) @ 0x000fd62c
>ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT
>0x0100000d) @ 0x00000000
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>Processor #0 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
>Processor #6 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
>Processor #1 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
>Processor #7 15:2 APIC version 20
>ACPI: IOAPIC (id[0x08] address[0xfec00000]
>gsi_base[0])
>IOAPIC[0]: apic_id 8, version 32, address 0xfec00000,
>GSI 0-23
>ACPI: IOAPIC (id[0x09] address[0xfec80000]
>gsi_base[24])
>IOAPIC[1]: apic_id 9, version 32, address 0xfec80000,
>GSI 24-47
>ACPI: IOAPIC (id[0x0a] address[0xfec80800]
>gsi_base[48])
>IOAPIC[2]: apic_id 10, version 32, address 0xfec80800,
>GSI 48-71
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
>dfl)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
>level)
>ACPI: IRQ0 used by override.
>ACPI: IRQ2 used by override.
>ACPI: IRQ9 used by override.
>Enabling APIC mode:  Flat.  Using 3 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Built 1 zonelists
>Kernel command line: ro root=LABEL=/ nmi_watchdog=1
>pci=routeirq console=ttyS0,115200n8 console=tty0
>mapped APIC to ffffd000 (fee00000)
>mapped IOAPIC to ffffc000 (fec00000)
>mapped IOAPIC to ffffb000 (fec80000)
>mapped IOAPIC to ffffa000 (fec80800)
>Initializing CPU#0
>CPU 0 irqstacks, hard=c0356000 soft=c034e000
>PID hash table entries: 4096 (order: 12, 65536 bytes)
>Detected 2659.014 MHz processor.
>Using tsc for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7,
>524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6,
>262144 bytes)
>Memory: 1034968k/1048020k available (1466k kernel
>code, 12384k reserved, 693k data, 176k init, 130516k
>highmem)
>Checking if this processor honours the WP bit even in
>supervisor mode... Ok.
>Calibrating delay loop... 5242.88 BogoMIPS
>(lpj=2621440)
>Mount-cache hash table entries: 512 (order: 0, 4096
>bytes)
>CPU: After generic identify, caps: bfebfbff 00000000
>00000000 00000000
>CPU: After vendor identify, caps:  bfebfbff 00000000
>00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps:        bfebfbff 00000000
>00000000 00000080
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
>per-CPU timeslice cutoff: 1462.47 usecs.
>task migration cache decay timeout: 2 msecs.
>Booting processor 1/1 eip 3000
>CPU 1 irqstacks, hard=c0357000 soft=c034f000
>Initializing CPU#1
>Calibrating delay loop... 5308.41 BogoMIPS
>(lpj=2654208)
>CPU: After generic identify, caps: bfebfbff 00000000
>00000000 00000000
>CPU: After vendor identify, caps:  bfebfbff 00000000
>00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps:        bfebfbff 00000000
>00000000 00000080
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#1.
>CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU1: Thermal monitoring enabled
>CPU1: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
>Booting processor 2/6 eip 3000
>CPU 2 irqstacks, hard=c0358000 soft=c0350000
>Initializing CPU#2
>Calibrating delay loop... 5308.41 BogoMIPS
>(lpj=2654208)
>CPU: After generic identify, caps: bfebfbff 00000000
>00000000 00000000
>CPU: After vendor identify, caps:  bfebfbff 00000000
>00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 3
>CPU: After all inits, caps:        bfebfbff 00000000
>00000000 00000080
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#2.
>CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU2: Thermal monitoring enabled
>CPU2: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
>Booting processor 3/7 eip 3000
>CPU 3 irqstacks, hard=c0359000 soft=c0351000
>Initializing CPU#3
>Calibrating delay loop... 5308.41 BogoMIPS
>(lpj=2654208)
>CPU: After generic identify, caps: bfebfbff 00000000
>00000000 00000000
>CPU: After vendor identify, caps:  bfebfbff 00000000
>00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 3
>CPU: After all inits, caps:        bfebfbff 00000000
>00000000 00000080
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#3.
>CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU3: Thermal monitoring enabled
>CPU3: Intel(R) Xeon(TM) CPU 2.66GHz stepping 09
>Total of 4 processors activated (21168.12 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=-1
>testing NMI watchdog ... OK.
>checking TSC synchronization across 4 CPUs: passed.
>Brought up 4 CPUs
>CPU0:
> domain 0: span 03
>  groups: 01 02
>  domain 1: span 0f
>   groups: 03 0c
>CPU1:
> domain 0: span 03
>  groups: 02 01
>  domain 1: span 0f
>   groups: 03 0c
>CPU2:
> domain 0: span 0c
>  groups: 04 08
>  domain 1: span 0f
>   groups: 0c 03
>CPU3:
> domain 0: span 0c
>  groups: 08 04
>  domain 1: span 0f
>   groups: 0c 03
>checking if image is initramfs...it isn't (no cpio
>magic); looks like an initrd
>Freeing initrd memory: 407k freed
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfbdd5, last
>bus=5
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20041105
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
>PCI: Transparent bridge - 0000:00:1e.0
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table
>[\_SB_.PCI0.PCI1._PRT]
>ACPI: PCI Interrupt Routing Table
>[\_SB_.PCI0.PCI1.PCI2._PRT]
>ACPI: PCI Interrupt Routing Table
>[\_SB_.PCI0.PCI1.PCI3._PRT]
>ACPI: PCI Interrupt Routing Table
>[\_SB_.PCI0.PCI4._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10
>11 12 15)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10
>11 12 15)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10
>*11 12 15)
>Linux Plug and Play Support v0.97 (c) Adam Belay
>pnp: PnP ACPI init
>pnp: PnP ACPI: found 12 devices
>PCI: Using ACPI for IRQ routing
>** Routing PCI interrupts for all devices because
>"pci=routeirq"
>** was specified.  If this was required to make a
>driver work,
>** please email the output of "lspci" to
>bjorn.helgaas@hp.com
>** so I can fix the driver.
>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level,
>low) -> IRQ 16
>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level,
>low) -> IRQ 19
>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level,
>low) -> IRQ 18
>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level,
>low) -> IRQ 23
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level,
>low) -> IRQ 18
>ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level,
>low) -> IRQ 17
>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level,
>low) -> IRQ 17
>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
>low) -> IRQ 16
>ACPI: PCI interrupt 0000:03:0e.0[A] -> GSI 24 (level,
>low) -> IRQ 24
>ACPI: PCI interrupt 0000:05:0c.0[A] -> GSI 20 (level,
>low) -> IRQ 20
>ACPI: PCI interrupt 0000:05:0d.0[A] -> GSI 21 (level,
>low) -> IRQ 21
>ACPI: PCI interrupt 0000:05:0d.2[B] -> GSI 22 (level,
>low) -> IRQ 22
>pnp: 00:0b: ioport range 0x800-0x85f could not be
>reserved
>pnp: 00:0b: ioport range 0xc00-0xc7f has been reserved
>pnp: 00:0b: ioport range 0x860-0x8ff could not be
>reserved
>Simple Boot Flag at 0x7a set to 0x80
>Machine check exception polling timer started.
>highmem bounce pool size: 64 pages
>VFS: Disk quotas dquot_6.5.1
>Dquot-cache hash table entries: 1024 (order 0, 4096
>bytes)
>Initializing Cryptographic API
>Real Time Clock Driver v1.12
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports,
>IRQ sharing enabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>io scheduler noop registered
>io scheduler cfq registered
>elevator: using cfq as default io scheduler
>Floppy drive(s): fd0 is 1.44M
>FDC 0 is a post-1991 82077
>RAMDISK driver initialized: 16 RAM disks of 4096K size
>1024 blocksize
>Uniform Multi-Platform E-IDE driver Revision:
>7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes;
>override with idebus=xx
>ICH4: IDE controller at PCI slot 0000:00:1f.1
>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level,
>low) -> IRQ 18
>ICH4: chipset revision 1
>ICH4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
>hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
>hdc:DMA, hdd:DMA
>Probing IDE interface ide0...
>hda: IC35L090AVV207-0, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Probing IDE interface ide1...
>hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
>hdd: SONY CD-RW CRX216E, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 1024KiB
>hda: 156250000 sectors (80000 MB) w/1821KiB Cache,
>CHS=16383/255/63, UDMA(100)
>hda: cache flushes supported
> hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
>mice: PS/2 mouse device common for all mice
>input: AT Translated Set 2 keyboard on isa0060/serio0
>device-mapper: 4.3.0-ioctl (2004-09-30) initialised:
>dm-devel@redhat.com
>NET: Registered protocol family 2
>IP: routing cache hash table of 8192 buckets, 64Kbytes
>TCP: Hash tables configured (established 262144 bind
>65536)
>NET: Registered protocol family 1
>Starting balanced_irq
>ACPI wakeup devices:
>VBTN PCI0 USB0 USB1 USB2 PCI1 PCI2 PCI3 PCI4  KBD
>ACPI: (supports S0 S1 S3 S4 S5)
>RAMDISK: Compressed image found at block 0
>VFS: Mounted root (ext2 filesystem).
>kjournald starting.  Commit interval 5 seconds
>EXT3-fs: mounted filesystem with ordered data mode.
>Freeing unused kernel memory: 176k freed
>EXT3 FS on hda5, internal journal
>Adding 2040212k swap on /dev/hda6.  Priority:-1
>extents:1
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda3, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
>Uniform CD-ROM driver Revision: 3.20
>hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache,
>UDMA(33)
>IA-32 Microcode Update Driver: v1.14
><tigran@veritas.com>
>microcode: CPU2 updated from revision 0xf to 0x2d,
>date = 08112004
>microcode: CPU1 updated from revision 0xf to 0x2d,
>date = 08112004
>microcode: CPU3 updated from revision 0xf to 0x2d,
>date = 08112004
>microcode: CPU0 updated from revision 0xf to 0x2d,
>date = 08112004
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected an Intel E7505 Chipset.
>agpgart: Maximum main memory to use for agp memory:
>941M
>agpgart: AGP aperture is 128M @ 0xe0000000
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>USB Universal Host Controller Interface driver v2.2
>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level,
>low) -> IRQ 16
>uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM
>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
>PCI: Setting latency timer of device 0000:00:1d.0 to
>64
>uhci_hcd 0000:00:1d.0: irq 16, io base 0xff80
>uhci_hcd 0000:00:1d.0: new USB bus registered,
>assigned bus number 1
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 2 ports detected
>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level,
>low) -> IRQ 19
>uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM
>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
>PCI: Setting latency timer of device 0000:00:1d.1 to
>64
>uhci_hcd 0000:00:1d.1: irq 19, io base 0xff60
>uhci_hcd 0000:00:1d.1: new USB bus registered,
>assigned bus number 2
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 2 ports detected
>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level,
>low) -> IRQ 18
>uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM
>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
>PCI: Setting latency timer of device 0000:00:1d.2 to
>64
>uhci_hcd 0000:00:1d.2: irq 18, io base 0xff40
>uhci_hcd 0000:00:1d.2: new USB bus registered,
>assigned bus number 3
>hub 3-0:1.0: USB hub found
>hub 3-0:1.0: 2 ports detected
>usb 2-1: new full speed USB device using uhci_hcd and
>address 2
>Linux video capture interface: v1.00
>pwc Philips webcam module version 10.0.5-unofficial
>loaded.
>pwc Supports Philips PCA645/646, PCVC675/680/690,
>PCVC720[40]/730/740/750 & PCVC830/840.
>pwc Also supports the Askey VC010, various Logitech
>Quickcams, Samsung MPC-C10 and MPC-C30,
>pwc the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye
>and Visionite VCS-UC300 and VCS-UM100.
>pwc Default image size set to qcif [176x144].
>pwc Enabling power save on open/close.
>pwc Logitech QuickCam Zoom (new model) USB webcam
>detected.
>pwc Registered as /dev/video0.
>usbcore: registered new driver Philips webcam
>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level,
>low) -> IRQ 23
>ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM
>(ICH4/ICH4-M) USB 2.0 EHCI Controller
>PCI: Setting latency timer of device 0000:00:1d.7 to
>64
>ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xffa20800
>ehci_hcd 0000:00:1d.7: new USB bus registered,
>assigned bus number 4
>PCI: cache line size of 128 is not supported by device
>0000:00:1d.7
>ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00,
>driver 26 Oct 2004
>usbcore: registered new driver snd-usb-audio
>hub 4-0:1.0: USB hub found
>hub 4-0:1.0: 6 ports detected
>usb 2-1: USB disconnect, address 2
>ieee1394: Initialized config rom entry `ip1394'
>ohci1394: Unknown symbol hpsb_iso_wake
>ohci1394: Unknown symbol hpsb_packet_received
>ohci1394: Unknown symbol dma_prog_region_free
>ohci1394: Unknown symbol hpsb_add_host
>ohci1394: Unknown symbol dma_region_sync_for_device
>ohci1394: Unknown symbol dma_prog_region_init
>ohci1394: Unknown symbol dma_prog_region_alloc
>ohci1394: Unknown symbol dma_region_offset_to_bus
>ohci1394: Unknown symbol hpsb_alloc_host
>ohci1394: Unknown symbol hpsb_selfid_complete
>ohci1394: Unknown symbol hpsb_remove_host
>ohci1394: Unknown symbol hpsb_iso_packet_received
>ohci1394: Unknown symbol hpsb_iso_packet_sent
>ohci1394: Unknown symbol hpsb_packet_sent
>ohci1394: Unknown symbol dma_region_sync_for_cpu
>ohci1394: Unknown symbol hpsb_selfid_received
>ohci1394: Unknown symbol hpsb_bus_reset
>ohci1394: Unknown symbol hpsb_iso_wake
>ohci1394: Unknown symbol hpsb_packet_received
>ohci1394: Unknown symbol dma_prog_region_free
>ohci1394: Unknown symbol hpsb_add_host
>usb 2-1: new full speed USB device using uhci_hcd and
>address 3
>ohci1394: Unknown symbol dma_region_sync_for_device
>ohci1394: Unknown symbol dma_prog_region_init
>ohci1394: Unknown symbol dma_prog_region_alloc
>ohci1394: Unknown symbol dma_region_offset_to_bus
>ohci1394: Unknown symbol hpsb_alloc_host
>ohci1394: Unknown symbol hpsb_selfid_complete
>ohci1394: Unknown symbol hpsb_remove_host
>ohci1394: Unknown symbol hpsb_iso_packet_received
>ohci1394: Unknown symbol hpsb_iso_packet_sent
>ohci1394: Unknown symbol hpsb_packet_sent
>ohci1394: Unknown symbol dma_region_sync_for_cpu
>ohci1394: Unknown symbol hpsb_selfid_received
>ohci1394: Unknown symbol hpsb_bus_reset
>ohci1394: $Rev: 1223 $ Ben Collins
><bcollins@debian.org>
>ACPI: PCI interrupt 0000:05:0c.0[A] -> GSI 20 (level,
>low) -> IRQ 20
>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]
>MMIO=[ff2ff800-ff2fffff]  Max Packet=[2048]
>ACPI: PCI interrupt 0000:05:0d.2[B] -> GSI 22 (level,
>low) -> IRQ 22
>ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[22]
>MMIO=[ff2ff000-ff2ff7ff]  Max Packet=[2048]
>pwc Logitech QuickCam Zoom (new model) USB webcam
>detected.
>pwc Registered as /dev/video0.
>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level,
>low) -> IRQ 17
>PCI: Setting latency timer of device 0000:00:1f.5 to
>64
>intel8x0_measure_ac97_clock: measured 50031 usecs
>intel8x0: clocking to 48000
>usb 2-1: khubd timed out on ep0out
>ieee1394: Node added: ID:BUS[0-00:1023]
>GUID[0050c500001076df]
>ieee1394: Host added: ID:BUS[0-01:1023]
>GUID[84ffffffffffff00]
>ieee1394: unsolicited response packet received - no
>tlabel match
>usb 2-1: khubd timed out on ep0in
>ieee1394: raw1394: /dev/raw1394 device initialized
>video1394: Installed video1394 module
>ieee1394: Host added: ID:BUS[1-00:1023]
>GUID[00023c00a1037111]
>Intel(R) PRO/1000 Network Driver - version
>5.5.4-k2-NAPI
>Copyright (c) 1999-2004 Intel Corporation.
>ACPI: PCI interrupt 0000:03:0e.0[A] -> GSI 24 (level,
>low) -> IRQ 24
>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network
>Connection
>ACPI: PCI interrupt 0000:05:0d.0[A] -> GSI 21 (level,
>low) -> IRQ 21
>parport_pc: Ignoring new-style parameters in presence
>of obsolete ones
>parport: PnPBIOS parport detected.
>parport0: PC-style at 0x378 (0x778), irq 7, dma 1
>[PCSPP,TRISTATE,COMPAT,ECP,DMA]
>ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller
>(OHCI) Driver (PCI)
>NET: Registered protocol family 17
>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps
>Full Duplex
>nfs warning: mount version older than kernel
>SCSI subsystem initialized
>NET: Registered protocol family 10
>Disabled Privacy Extensions on device c02eb2a0(lo)
>IPv6 over IPv4 tunneling driver
>Installing knfsd (copyright (C) 1996
>okir@monad.swb.de).
>lp0: using parport0 (interrupt-driven).
>/home/chris/LINUX/linux-2.6.10/drivers/usb/serial/usb-serial.c:
>USB Serial support registered for Generic
>usbcore: registered new driver usbserial_generic
>usbcore: registered new driver usbserial
>/home/chris/LINUX/linux-2.6.10/drivers/usb/serial/usb-serial.c:
>USB Serial Driver core v2.0
>IA-32 Microcode Update Driver v1.14 unregistered
>p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock
>Modulation available
>input: PC Speaker
>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
>ACPI: Power Button (FF) [PWRF]
>NET: Registered protocol family 15
>radeon: Ignoring new-style parameters in presence of
>obsolete ones
>[drm] Initialized radeon 1.13.0 20041207 on minor 0:
>ATI Technologies Inc RV280 [Radeon 9200]
>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
>low) -> IRQ 16
>agpgart: Found an AGP 3.0 compliant device at
>0000:00:00.0.
>agpgart: X passes broken AGP3 flags (1f00420f). Fixed.
>agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x
>mode
>agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x
>mode
>pwc Failed to restore power to the camera! (-32)
>pwc Failed to set LED on/off time.
>pwc set_video_mode(176x144 @ 10, palette 15).
>pwc decode_size = 1.
>pwc Using alternate setting 1.
>[drm] Loading R200 Microcode
>mask: 0000000000000001 usage: 0000000000000000
>video1394_0: Iso receive DMA: 10 buffers of size
>155648 allocated for a frame size 153600, each with 39
>prgs
>video1394_0: iso context 0 listen on channel 0
>video1394_0: Iso context 0 stop talking on channel 0
>pwc set_video_mode(160x120 @ 10, palette 15).
>pwc decode_size = 1.
>pwc Using alternate setting 1.
>pwc set_video_mode(160x120 @ 10, palette 15).
>pwc decode_size = 1.
>pwc Using alternate setting 1.
>
>--------------------------------------------------------------------
>----
>
>Module                  Size  Used by
>snd_pcm_oss            46752  0
>snd_mixer_oss          17024  1 snd_pcm_oss
>radeon                127520  2
>i2c_algo_bit            9224  1 radeon
>emu10k1_gp              3712  0
>gameport                4480  1 emu10k1_gp
>snd_rtctimer            3344  0
>deflate                 3712  0
>zlib_deflate           22040  1 deflate
>zlib_inflate           17664  1 deflate
>twofish                38784  0
>serpent                15616  0
>aes_i586               38772  0
>blowfish                9088  0
>des                    12544  0
>sha256                  9984  0
>crypto_null             2944  0
>af_key                 28048  2
>binfmt_misc             9864  1
>eeprom                  6680  0
>i2c_sensor              3840  1 eeprom
>button                  5904  0
>processor              16512  0
>psmouse                19080  0
>pcspkr                  4300  0
>p4_clockmod             5412  2
>speedstep_lib           4096  1 p4_clockmod
>usbserial              25576  0
>lp                      9736  0
>nfsd                  191264  9
>exportfs                5760  1 nfsd
>md5                     4736  1
>ipv6                  223488  20
>sd_mod                 13184  0
>scsi_mod               98944  1 sd_mod
>autofs                 13440  0
>nfs                   186212  1
>lockd                  58280  3 nfsd,nfs
>sunrpc                125284  21 nfsd,nfs,lockd
>af_packet              17160  0
>ohci_hcd               19720  0
>parport_pc             37828  1
>parport                31304  2 lp,parport_pc
>snd_emu10k1            86916  0
>snd_util_mem            4224  1 snd_emu10k1
>snd_hwdep               8224  1 snd_emu10k1
>e1000                  79540  0
>video1394              15820  0
>raw1394                25196  0
>snd_intel8x0           27936  0
>snd_ac97_codec         67936  2
>snd_emu10k1,snd_intel8x0
>i2c_i801                8204  0
>i2c_core               18176  4
>i2c_algo_bit,eeprom,i2c_sensor,i2c_i801
>ohci1394               30084  1 video1394
>ieee1394              289464  3
>video1394,raw1394,ohci1394
>ehci_hcd               27652  0
>snd_usb_audio          60864  0
>snd_pcm                79364  5
>snd_pcm_oss,snd_emu10k1,snd_intel8x0,snd_ac97_codec,snd_usb_audio
>snd_timer              21252  3
>snd_rtctimer,snd_emu10k1,snd_pcm
>snd_page_alloc          8196  3
>snd_emu10k1,snd_intel8x0,snd_pcm
>snd_usb_lib            11776  1 snd_usb_audio
>snd_rawmidi            20256  2
>snd_emu10k1,snd_usb_lib
>snd_seq_device          7820  2
>snd_emu10k1,snd_rawmidi
>snd                    45028  13
>snd_pcm_oss,snd_mixer_oss,snd_rtctimer,snd_emu10k1,snd_hwdep,snd_int
>el8x0,snd_ac97_codec,snd_usb_audio,snd_pcm,snd_timer,snd_usb_lib,snd
>_rawmidi,snd_seq_device soundcore               7904  1 snd
>pwc                    78448  0
>videodev                8192  1 pwc
>uhci_hcd               29200  0
>usbcore                99704  8
>usbserial,ohci_hcd,ehci_hcd,snd_usb_audio,snd_usb_lib,pwc,uhci_hcd
>intel_agp              18972  1
>agpgart                27308  1 intel_agp
>ide_cd                 36100  0
>cdrom                  36252  1 ide_cd
>ext3                  113800  2
>jbd                    52888  1 ext3
>
>
>
>
>
>
>___________________________________________________________
>ALL-NEW Yahoo! Messenger - all new features - even more fun!
> http://uk.messenger.yahoo.com -
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
