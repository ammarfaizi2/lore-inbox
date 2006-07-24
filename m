Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWGXCOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWGXCOA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 22:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWGXCOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 22:14:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWGXCN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 22:13:59 -0400
Message-ID: <44C42C7D.6040409@osdl.org>
Date: Sun, 23 Jul 2006 19:12:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Anthony DeRobertis <asd@suespammers.org>
CC: Andreas Kleen <ak@suse.de>, Martin Michlmayr <tbm@cyrius.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       kevin@sysexperts.com
Subject: Re: skge error; hangs w/ hardware memory hole
References: <20060703205238.GA10851@deprecation.cyrius.com> <20060707141843.73fc6188@dxpl.pdx.osdl.net> <200607072328.51282.ak@suse.de> <44B46276.5030006@suespammers.org> <121226.1152672894714.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <44C317FF.8030705@suespammers.org>
In-Reply-To: <44C317FF.8030705@suespammers.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DeRobertis wrote:
> Andreas Kleen wrote:
>
>   
>> You need to use iommu=soft swiotlb=force
>>
>> The standard IOMMU is also broken on VIA, but forced swiotlb should
>> work.
>>     
>
> Didn't work :-(
>
> Excepts from the log:
>
> Bootdata ok (command line is BOOT_IMAGE=2.6.17-1-smp ro root=902
> iommu=soft swiotlb=force single)
> ...
> skge eth0: enabling interface
> skge 0000:00:0a.0: PCI error cmd=0x117 status=0x22b0
> skge unable to clear error (so ignoring them)
> skge eth0: Link is up at 1000 Mbps, full duplex, flow control tx and rx
>
> And then the NIC didn't work. Attaching full dmesg.
>
>   
> ------------------------------------------------------------------------
>
> Bootdata ok (command line is BOOT_IMAGE=2.6.17-1-smp ro root=902 iommu=soft swiotlb=force single)
> Linux version 2.6.17-1-amd64-k8-smp (Debian 2.6.17-2) (waldi@debian.org) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 SMP Thu Jun 29 23:03:09 CEST 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000d7fb0000 (usable)
>  BIOS-e820: 00000000d7fb0000 - 00000000d7fc0000 (ACPI data)
>  BIOS-e820: 00000000d7fc0000 - 00000000d7ff0000 (ACPI NVS)
>  BIOS-e820: 00000000d7ff0000 - 00000000d8000000 (reserved)
>  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000124000000 (usable)
> DMI 2.3 present.
> ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa7c0
> ACPI: XSDT (v001 A M I  OEMXSDT  0x10000506 MSFT 0x00000097) @ 0x00000000d7fb0100
> ACPI: FADT (v003 A M I  OEMFACP  0x10000506 MSFT 0x00000097) @ 0x00000000d7fb0290
> ACPI: MADT (v001 A M I  OEMAPIC  0x10000506 MSFT 0x00000097) @ 0x00000000d7fb0390
> ACPI: OEMB (v001 A M I  OEMBIOS  0x10000506 MSFT 0x00000097) @ 0x00000000d7fc0040
> ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
> Scanning NUMA topology in Northbridge 24
> Number of nodes 1
> Node 0 MemBase 0000000000000000 Limit 0000000124000000
> NUMA: Using 63 for the hash shift.
> Using node hash shift of 63
> Bootmem setup node 0 0000000000000000-0000000124000000
> On node 0 totalpages: 1014222
>   DMA zone: 2502 pages, LIFO batch:0
>   DMA32 zone: 866280 pages, LIFO batch:31
>   Normal zone: 145440 pages, LIFO batch:31
> Looks like a VIA chipset. Disabling IOMMU. Override with "iommu=allowed"
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:3 APIC version 16
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 15:3 APIC version 16
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Setting APIC routing to physical flat
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at dc000000 (gap: d8000000:27780000)
> SMP: Allowing 2 CPUs, 0 hotplug CPUs
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=2.6.17-1-smp ro root=902 iommu=soft swiotlb=force single
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Disabling vsyscall due to use of PM timer
> time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
> time.c: Detected 2202.921 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Placing software IO TLB between 0x163a000 - 0x563a000
> Memory: 3984540k/4784128k available (1870k kernel code, 143520k reserved, 820k data, 172k init)
> Calibrating delay using timer specific routine.. 4411.18 BogoMIPS (lpj=8822378)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Capability LSM initialized
> Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0/0(2) -> Node 0 -> Core 0
> Using local APIC timer interrupts.
> result 12516619
> Detected 12.516 MHz APIC timer.
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4405.96 BogoMIPS (lpj=8811936)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1/1(2) -> Node 0 -> Core 1
> AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff -82 cycles, maxerr 637 cycles)
> Brought up 2 CPUs
> testing NMI watchdog ... OK.
> migration_cost=632
> checking if image is initramfs... it is
> Freeing initrd memory: 1348k freed
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20060127
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Quirk-MSI-K8T Soundcard On
> PCI: Unexpected Value in PCI-Register: no Change!
> PCI: enabled onboard AC97/MC97 devices
> Boot video device is 0000:01:00.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: ACPI device : hid PNP0A03
> pnp: ACPI device : hid PNP0200
> pnp: ACPI device : hid PNP0B00
> pnp: ACPI device : hid PNP0303
> pnp: ACPI device : hid PNP0F03
> pnp: ACPI device : hid PNP0800
> pnp: ACPI device : hid PNP0C04
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0C02
> pnp: ACPI device : hid PNP0501
> pnp: ACPI device : hid PNP0501
> pnp: ACPI device : hid PNP0C01
> pnp: PnP ACPI: found 13 devices
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
> agpgart: Detected AGP bridge 0
> agpgart: AGP aperture is 64M @ 0xdc000000
> pnp: the driver 'system' has been registered
> pnp: match found with the PnP device '00:07' and the driver 'system'
> pnp: 00:07: ioport range 0x680-0x6ff has been reserved
> pnp: 00:07: ioport range 0x290-0x297 has been reserved
> pnp: match found with the PnP device '00:08' and the driver 'system'
> pnp: match found with the PnP device '00:09' and the driver 'system'
> pnp: match found with the PnP device '00:0c' and the driver 'system'
> PCI: Bridge: 0000:00:01.0
>   IO window: e000-efff
>   MEM window: fbe00000-fbffffff
>   PREFETCH window: e0000000-faffffff
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> audit: initializing netlink socket (disabled)
> audit(1153618957.340:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Real Time Clock Driver v1.12ac
> Linux agpgart interface v0.101 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> pnp: the driver 'serial' has been registered
> pnp: match found with the PnP device '00:0a' and the driver 'serial'
> 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> pnp: match found with the PnP device '00:0b' and the driver 'serial'
> 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
> usbmon: debugfs is not available
> pnp: the driver 'i8042 kbd' has been registered
> pnp: match found with the PnP device '00:03' and the driver 'i8042 kbd'
> pnp: the driver 'i8042 aux' has been registered
> pnp: match found with the PnP device '00:04' and the driver 'i8042 aux'
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 8
> NET: Registered protocol family 20
> ACPI wakeup devices: 
> PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB 
> ACPI: (supports S0 S1 S3 S4 S5)
> Freeing unused kernel memory: 172k freed
> USB Universal Host Controller Interface driver v3.0
> GSI 16 sharing vector 0xA9 and IRQ 16
> ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 169
> PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 9
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
> uhci_hcd 0000:00:10.0: irq 169, io base 0x0000c400
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> input: AT Translated Set 2 keyboard as /class/input/input0
> ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 169
> PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 9
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.1: irq 169, io base 0x0000c800
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 169
> PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 9
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.2: irq 169, io base 0x0000d000
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 169
> PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 9
> uhci_hcd 0000:00:10.3: UHCI Host Controller
> uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:10.3: irq 169, io base 0x0000d400
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-1: new full speed USB device using uhci_hcd and address 2
> ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 169
> ehci_hcd 0000:00:10.4: EHCI Host Controller
> ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:10.4: irq 169, io mem 0xfbd00000
> ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 8 ports detected
> usb 1-1: device not accepting address 2, error -71
> usbcore: registered new driver hiddev
> usb 1-1: new full speed USB device using uhci_hcd and address 4
> usb 1-1: configuration #1 chosen from 1 choice
> usb 1-2: new low speed USB device using uhci_hcd and address 5
> usb 1-2: configuration #1 chosen from 1 choice
> usb 2-2: new full speed USB device using uhci_hcd and address 2
> usb 2-2: configuration #1 chosen from 1 choice
> input: stereo-link stereo-link 1200 USB DAC as /class/input/input1
> input: USB HID v1.00 Device [stereo-link stereo-link 1200 USB DAC] on usb-0000:00:10.0-1
> hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1500 FW:8.g8 .D USB FW:g8 ] on usb-0000:00:10.0-2
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> SCSI subsystem initialized
> libata version 1.20 loaded.
> sata_promise 0000:00:08.0: version 1.04
> GSI 17 sharing vector 0xB1 and IRQ 17
> ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 177
> ata1: SATA max UDMA/133 cmd 0xFFFFC20000006200 ctl 0xFFFFC20000006238 bmdma 0x0 irq 177
> ata2: SATA max UDMA/133 cmd 0xFFFFC20000006280 ctl 0xFFFFC200000062B8 bmdma 0x0 irq 177
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
> ata1: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_promise
> ata2: SATA link up 1.5 Gbps (SStatus 113)
> ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
> ata2: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
> ata2: dev 0 configured for UDMA/133
> scsi1 : sata_promise
>   Vendor: ATA       Model: ST3200826AS       Rev: 3.03
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST3200826AS       Rev: 3.03
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4
> sd 0:0:0:0: Attached scsi disk sda
> SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb: sdb1 sdb2 sdb3 sdb4
> sd 1:0:0:0: Attached scsi disk sdb
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> md: raid1 personality registered for level 1
> md: md2 stopped.
> md: bind<sdb3>
> md: bind<sda3>
> raid1: raid set md2 active with 2 out of 2 mirrors
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: md2: orphan cleanup on readonly fs
> ext3_orphan_cleanup: deleting unreferenced inode 3008056
> ext3_orphan_cleanup: deleting unreferenced inode 3008055
> ext3_orphan_cleanup: deleting unreferenced inode 2998284
> ext3_orphan_cleanup: deleting unreferenced inode 2998283
> ext3_orphan_cleanup: deleting unreferenced inode 2998281
> ext3_orphan_cleanup: deleting unreferenced inode 2998278
> ext3_orphan_cleanup: deleting unreferenced inode 2998277
> ext3_orphan_cleanup: deleting unreferenced inode 2998276
> EXT3-fs: md2: 8 orphan inodes deleted
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185
> skge 1.5 addr 0xfbb00000 irq 185 chip Yukon-Lite rev 9
> skge eth0: addr 00:13:d4:21:77:e5
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> GSI 19 sharing vector 0xC1 and IRQ 19
> ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
> PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> ieee1394: Initialized config rom entry `ip1394'
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> usbcore: registered new driver usbserial
> drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
> usbcore: registered new driver usbserial_generic
> drivers/usb/serial/usb-serial.c: USB Serial Driver core
> drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
> pl2303 2-2:1.0: pl2303 converter detected
> usb 2-2: pl2303 converter now attached to ttyUSB0
> usbcore: registered new driver pl2303
> drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
> usbcore: registered new driver snd-usb-audio
> Probing IDE interface ide1...
> input: PS/2 Generic Mouse as /class/input/input2
> hdc: TSSTcorpCD/DVDW TS-H552U, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> sata_via 0000:00:0f.0: version 1.1
> ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
> sata_via 0000:00:0f.0: routed to hard irq line 10
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 193
> ata4: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 193
> ata3: SATA link down (SStatus 0)
> scsi2 : sata_via
> ata4: SATA link down (SStatus 0)
> scsi3 : sata_via
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> PCI: Enabling device 0000:00:11.6 (0000 -> 0001)
> GSI 20 sharing vector 0xC9 and IRQ 20
> ACPI: PCI Interrupt 0000:00:11.6[C] -> GSI 22 (level, low) -> IRQ 201
> PCI: Setting latency timer of device 0000:00:11.6 to 64
> VIA 82xx Modem: probe of 0000:00:11.6 failed with error -13
> ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> GSI 21 sharing vector 0xD1 and IRQ 21
> ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 209
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[209]  MMIO=[fb700000-fb7007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> hdc: ATAPI 126X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d800003edb31]
> eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> EXT3 FS on md2, internal journal
> Probing IDE interface ide0...
> powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.2)
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
> powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
> cpu_init done, current fid 0xe, vid 0x8
> w83627hf 9191-0290: Reading VID from GPIO5
> device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
> md: md3 stopped.
> md: bind<sdb4>
> md: bind<sda4>
> md: raid0 personality registered for level 0
> md3: setting max_sectors to 128, segment boundary to 32767
> raid0: looking at sda4
> raid0:   comparing sda4(35142080) with sda4(35142080)
> raid0:   END
> raid0:   ==> UNIQUE
> raid0: 1 zones
> raid0: looking at sdb4
> raid0:   comparing sdb4(35142080) with sda4(35142080)
> raid0:   EQUAL
> raid0: FINAL 1 zones
> raid0: done.
> raid0 : md_size is 70284160 blocks.
> raid0 : conf->hash_spacing is 70284160 blocks.
> raid0 : nb_zone is 1.
> raid0 : Allocating 8 bytes for hash.
> md: md1 stopped.
> md: bind<sdb2>
> md: bind<sda2>
> raid1: raid set md1 active with 2 out of 2 mirrors
> md: md0 stopped.
> md: bind<sdb1>
> md: bind<sda1>
> raid1: raid set md0 active with 2 out of 2 mirrors
> ReiserFS: md3: found reiserfs format "3.6" with standard journal
> ReiserFS: md3: using ordered data mode
> ReiserFS: md3: journal params: device md3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: md3: checking transaction log (md3)
> ReiserFS: md3: Using r5 hash to sort names
> Adding 3903672k swap on /dev/md1.  Priority:-1 extents:1 across:3903672k
> skge eth0: enabling interface
> skge 0000:00:0a.0: PCI error cmd=0x117 status=0x22b0
> skge unable to clear error (so ignoring them)
> skge eth0: Link is up at 1000 Mbps, full duplex, flow control tx and rx
>   
You could always stop the device from allowing highdma with a patch. But 
that delays the inevitable failure
of another device.  The only real fix is to either getr tie MMU working, 
or have the kernel limit to 4G mem (and drop
the hole).
