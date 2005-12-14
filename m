Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVLNXiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVLNXiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVLNXiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:38:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:64431 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965043AbVLNXiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:38:09 -0500
Date: Wed, 14 Dec 2005 17:37:05 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, muli@il.ibm.com,
       jgarzik@pobox.com
Subject: Re: 2.6.15-rc5-mm2 does not boot on AMD64 with sata_sil
Message-ID: <20051214233705.GA22464@us.ibm.com>
References: <20051213103156.GD23695@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213103156.GD23695@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I regressed only the sata_sil driver changes in the git-libata-all.patch,
and my system now find the SATA disks.  While not the final solution,
it's a quick fix.

Jeff, I'll be happy to test any fixes or debug drivers.

Thanks,
Jon

On Tue, Dec 13, 2005 at 12:31:56PM +0200, Muli Ben-Yehuda wrote:
> My dual AMD64 no longer boots with 2.6.15-rc5-mm2 because it can't
> find its disks. 2.6.15-rc5-gitX works fine. Boot logs and lscpi
> attached.
> 
> Interesting parts of the diff between vanillalog and mmlog (trying
> pci=routeirq and pci=noacpi didn't help):
> 
> @@ -84,6 +87,11 @@
>  usbcore: registered new driver hub
>  PCI: Using ACPI for IRQ routing
>  PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> +PCI: Cannot allocate resource region 0 of device 0000:01:02.0
> +PCI: Cannot allocate resource region 1 of device 0000:01:02.0
> +PCI: Cannot allocate resource region 2 of device 0000:01:02.0
> +PCI: Cannot allocate resource region 3 of device 0000:01:02.0
> +PCI: Cannot allocate resource region 4 of device 0000:01:02.0
>  agpgart: Detected AMD 8151 AGP Bridge rev B3
>  agpgart: AGP aperture is 256M @ 0xe0000000
>  PCI-DMA: Disabling IOMMU.
> @@ -164,28 +175,21 @@
>  Uniform CD-ROM driver Revision: 3.20
>  GSI 17 sharing vector 0xB1 and IRQ 17
>  ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 177
> -ata1: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmdma 0x7ata2: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmdma 0x7ata1: no device found (phy stat 00000000)
> +ata1: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmdma 0x7ata2: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmdma 0x7ata1: SATA link down (SStatus 0)
>  scsi0 : sata_sil
> -ata2: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA
> -ata2: dev 0 configured for UDMA/100
> +ata2: SATA link up 1.5 Gbps (SStatus 113)
> +ata2: dev 0 not supported, ignoring
>  scsi1 : sata_sil
> -  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
> -  Type:   Direct-Access                      ANSI SCSI revision: 05
> -SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
> -SCSI device sda: drive cache: write back
> -SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
> -SCSI device sda: drive cache: write back
> - sda: sda1 sda2
> -sd 1:0:0:0: Attached scsi disk sda
> -Fusion MPT base driver 3.03.04
> +Fusion MPT base driver 3.03.05
>  Copyright (c) 1999-2005 LSI Logic Corporation
> -Fusion MPT SPI Host driver 3.03.04
> +Fusion MPT SPI Host driver 3.03.05
>  GSI 18 sharing vector 0xB9 and IRQ 18
>  ACPI: PCI Interrupt 0000:01:03.2[C] -> GSI 16 (level, low) -> IRQ 185
>  ehci_hcd 0000:01:03.2: EHCI Host Controller
>  ehci_hcd 0000:01:03.2: new USB bus registered, assigned bus number 1
>  ehci_hcd 0000:01:03.2: irq 185, io mem 0xf9550000
>  ehci_hcd 0000:01:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> +usb usb1: configuration #1 chosen from 1 choice
>  hub 1-0:1.0: USB hub found
>  hub 1-0:1.0: 5 ports detected
>  GSI 19 sharing vector 0xC1 and IRQ 19
> 
> 
> Cheers,
> Muli
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org | http://mulix.livejournal.com/
> 

> ;; welcome, muli, to the one true editor!
> Bootdata ok (command line is root=/dev/sda2 selinux=0 console=ttyS1,19200n8)
> Linux version 2.6.15-rc5-mm2 (muli@rhun) (gcc version 3.4.1) #3 SMP Tue Dec 135BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
>  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000dff60000 (usable)
>  BIOS-e820: 00000000dff60000 - 00000000dff72000 (ACPI data)
>  BIOS-e820: 00000000dff72000 - 00000000dff80000 (ACPI NVS)
>  BIOS-e820: 00000000dff80000 - 00000000e0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> SRAT: PXM 0 -> APIC 0 -> Node 0
> SRAT: PXM 1 -> APIC 1 -> Node 1
> SRAT: Node 0 PXM 0 0-a0000
> SRAT: Node 0 PXM 0 0-e0000000
> Bootmem setup node 0 0000000000000000-00000000dff60000
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:5 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xf9220000] gsi_base[24])
> IOAPIC[1]: apic_id 3, version 17, address 0xf9220000, GSI 24-27
> ACPI: IOAPIC (id[0x04] address[0xf9230000] gsi_base[28])
> IOAPIC[2]: apic_id 4, version 17, address 0xf9230000, GSI 28-31
> ACPI: IOAPIC (id[0x05] address[0xf9200000] gsi_base[32])
> IOAPIC[3]: apic_id 5, version 17, address 0xf9200000, GSI 32-35
> ACPI: IOAPIC (id[0x06] address[0xf9210000] gsi_base[36])
> IOAPIC[4]: apic_id 6, version 17, address 0xf9210000, GSI 36-39
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> Setting APIC routing to flat
> DMI present.
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
> Checking aperture...
> CPU 0: aperture @ e0000000 size 256 MB
> CPU 1: aperture @ e0000000 size 256 MB
> Built 1 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/sda2 selinux=0 console=ttyS1,19200n8
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 3.579545 MHz PM timer.
> time.c: Detected 2393.242 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Memory: 3606672k/3669376k available (3311k kernel code, 62308k reserved, 1441k)Calibrating delay using timer specific routine.. 4796.16 BogoMIPS (lpj=9592329)Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0(1) -> Node 0 -> Core 0
> mtrr: v2.0 (20020519)
> Using local APIC timer interrupts.
> Detected 12.464 MHz APIC timer.
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4786.72 BogoMIPS (lpj=9573445)CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(1) -> Node 0 -> Core 0
> AMD Opteron(tm) Processor 250 stepping 0a
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff -20 cycles, maxerr 1228 cycles)
> Brought up 2 CPUs
> Disabling vsyscall due to use of PM timer
> time.c: Using PM based timekeeping.
> testing NMI watchdog ... CPU#1: NMI appears to be stuck (19->19)!
> migration_cost=866
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20050916
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 11) *9
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
> ACPI: PCI Root Bridge [PCI1] (0000:08)
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Cannot allocate resource region 0 of device 0000:01:02.0
> PCI: Cannot allocate resource region 1 of device 0000:01:02.0
> PCI: Cannot allocate resource region 2 of device 0000:01:02.0
> PCI: Cannot allocate resource region 3 of device 0000:01:02.0
> PCI: Cannot allocate resource region 4 of device 0000:01:02.0
> agpgart: Detected AMD 8151 AGP Bridge rev B3
> agpgart: AGP aperture is 256M @ 0xe0000000
> PCI-DMA: Disabling IOMMU.
> PCI: Bridge: 0000:00:06.0
>   IO window: 2000-2fff
>   MEM window: f9500000-f95fffff
>   PREFETCH window: f9000000-f90fffff
> PCI: Bridge: 0000:00:0a.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:0b.0
>   IO window: disabled.
>   MEM window: f9600000-f96fffff
>   PREFETCH window: disabled.
> PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
> PCI: Bridge: 0000:08:01.0
>   IO window: disabled.
>   MEM window: f8000000-f8ffffff
>   PREFETCH window: f0000000-f7ffffff
> PCI: Bridge: 0000:08:03.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:08:04.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Total HugeTLB memory allocated, 0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (FF) [SLPF]
> ACPI: Power Button (CM) [PWRB]
> Real Time Clock Driver v1.12
> hw_random: AMD768 system management I/O registers at 0x8000.
> hw_random hardware driver 1.0.0 loaded
> Linux agpgart interface v0.101 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> mice: PS/2 mouse device common for all mice
> FDC 0 is a National Semiconductor PC87306
> input: AT Translated Set 2 keyboard as /class/input/input0
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
> Copyright (c) 1999-2005 Intel Corporation.
> e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> tg3.c:v3.44 (Dec 6, 2005)
> GSI 16 sharing vector 0xA9 and IRQ 16
> ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 28 (level, low) -> IRQ 169
> eth0: Tigon3 [partno(none) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/100100:0d:60:53:1f:cf
> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth0: dma_rwctrl[769f4000]
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.47.
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> netconsole: not configured, aborting
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:00:07.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
> hdc: LITE-ON LTR-48327S, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> GSI 17 sharing vector 0xB1 and IRQ 17
> ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 177
> ata1: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmdma 0x7ata2: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmdma 0x7ata1: SATA link down (SStatus 0)
> scsi0 : sata_sil
> ata2: SATA link up 1.5 Gbps (SStatus 113)
> ata2: dev 0 not supported, ignoring
> scsi1 : sata_sil
> Fusion MPT base driver 3.03.05
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.03.05
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:01:03.2[C] -> GSI 16 (level, low) -> IRQ 185
> ehci_hcd 0000:01:03.2: EHCI Host Controller
> ehci_hcd 0000:01:03.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:01:03.2: irq 185, io mem 0xf9550000
> ehci_hcd 0000:01:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> GSI 19 sharing vector 0xC1 and IRQ 19
> ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 18 (level, low) -> IRQ 193
> ohci_hcd 0000:01:03.0: OHCI Host Controller
> ohci_hcd 0000:01:03.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:01:03.0: irq 193, io mem 0xf9530000
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> GSI 20 sharing vector 0xC9 and IRQ 20
> ACPI: PCI Interrupt 0000:01:03.1[B] -> GSI 19 (level, low) -> IRQ 201
> ohci_hcd 0000:01:03.1: OHCI Host Controller
> ohci_hcd 0000:01:03.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:01:03.1: irq 201, io mem 0xf9540000
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> USB Universal Host Controller Interface driver v2.3
> usbcore: registered new driver usblp
> /home/muli/w/iommu/dma_ops/mm/drivers/usb/class/usblp.c: v0.13: USB Printer DerInitializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> /home/muli/w/iommu/dma_ops/mm/drivers/usb/input/hid-core.c: v2.6:USB HID core rdevice-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
> Intel 810 + AC97 Audio, version 1.01, 11:43:14 Dec 13 2005
> ACPI: PCI Interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 177
> i810: AMD-8111 IOHub found at IO 0x1400 and 0x1000, MEM 0x0000 and 0x0000, IRQ7i810_audio: Audio Controller supports 6 channels.
> i810_audio: Defaulting to base 2 channel mode.
> i810_audio: Resetting connection 0
> ac97_codec: AC97  codec, id: ALG96 (Unknown)
> i810_audio: only 48Khz playback available.
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present),2oprofile: using NMI interrupt.
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
> powernow-k8: MP systems not supported by PSB BIOS structure
> powernow-k8: MP systems not supported by PSB BIOS structure
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Insert root floppy and press ENTER

> Bootdata ok (command line is root=/dev/sda2 selinux=0 console=ttyS1,19200n8)
> Linux version 2.6.15-rc5 (muli@rhun) (gcc version 3.4.1) #1 SMP Tue Dec 13 11:5BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
>  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000dff60000 (usable)
>  BIOS-e820: 00000000dff60000 - 00000000dff72000 (ACPI data)
>  BIOS-e820: 00000000dff72000 - 00000000dff80000 (ACPI NVS)
>  BIOS-e820: 00000000dff80000 - 00000000e0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> SRAT: PXM 0 -> APIC 0 -> Node 0
> SRAT: PXM 1 -> APIC 1 -> Node 1
> SRAT: Node 0 PXM 0 0-a0000
> SRAT: Node 0 PXM 0 0-e0000000
> Bootmem setup node 0 0000000000000000-00000000dff60000
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:5 APIC version 16
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:5 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xf9220000] gsi_base[24])
> IOAPIC[1]: apic_id 3, version 17, address 0xf9220000, GSI 24-27
> ACPI: IOAPIC (id[0x04] address[0xf9230000] gsi_base[28])
> IOAPIC[2]: apic_id 4, version 17, address 0xf9230000, GSI 28-31
> ACPI: IOAPIC (id[0x05] address[0xf9200000] gsi_base[32])
> IOAPIC[3]: apic_id 5, version 17, address 0xf9200000, GSI 32-35
> ACPI: IOAPIC (id[0x06] address[0xf9210000] gsi_base[36])
> IOAPIC[4]: apic_id 6, version 17, address 0xf9210000, GSI 36-39
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
> Checking aperture...
> CPU 0: aperture @ e0000000 size 256 MB
> CPU 1: aperture @ e0000000 size 256 MB
> Built 1 zonelists
> Kernel command line: root=/dev/sda2 selinux=0 console=ttyS1,19200n8
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> time.c: Using 3.579545 MHz PM timer.
> time.c: Detected 2393.249 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Memory: 3606736k/3669376k available (3220k kernel code, 62244k reserved, 1400k)Calibrating delay using timer specific routine.. 4795.95 BogoMIPS (lpj=9591905)Mount-cache hash table entries: 256
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0(1) -> Node 0 -> Core 0
> mtrr: v2.0 (20020519)
> Using local APIC timer interrupts.
> Detected 12.464 MHz APIC timer.
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 4786.72 BogoMIPS (lpj=9573444)CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 1(1) -> Node 0 -> Core 0
> AMD Opteron(tm) Processor 250 stepping 0a
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff -9 cycles, maxerr 1225 cycles)
> Brought up 2 CPUs
> Disabling vsyscall due to use of PM timer
> time.c: Using PM based timekeeping.
> testing NMI watchdog ... OK.
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> ACPI: Subsystem revision 20050902
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 11) *9
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
> ACPI: PCI Root Bridge [PCI1] (0000:08)
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> agpgart: Detected AMD 8151 AGP Bridge rev B3
> agpgart: AGP aperture is 256M @ 0xe0000000
> PCI-DMA: Disabling IOMMU.
> PCI: Bridge: 0000:00:06.0
>   IO window: 2000-2fff
>   MEM window: f9500000-f95fffff
>   PREFETCH window: f9000000-f90fffff
> PCI: Bridge: 0000:00:0a.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:0b.0
>   IO window: disabled.
>   MEM window: f9600000-f96fffff
>   PREFETCH window: disabled.
> PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:09:00.0
> PCI: Bridge: 0000:08:01.0
>   IO window: disabled.
>   MEM window: f8000000-f8ffffff
>   PREFETCH window: f0000000-f7ffffff
> PCI: Bridge: 0000:08:03.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:08:04.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
> Total HugeTLB memory allocated, 0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> PCI: MSI quirk detected. pci_msi_quirk set.
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (FF) [SLPF]
> ACPI: Power Button (CM) [PWRB]
> Real Time Clock Driver v1.12
> hw_random: AMD768 system management I/O registers at 0x8000.
> hw_random hardware driver 1.0.0 loaded
> Linux agpgart interface v0.101 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> FDC 0 is a National Semiconductor PC87306
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
> Copyright (c) 1999-2005 Intel Corporation.
> e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> tg3.c:v3.44 (Dec 6, 2005)
> GSI 16 sharing vector 0xA9 and IRQ 16
> ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 28 (level, low) -> IRQ 169
> eth0: Tigon3 [partno(none) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/100feth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
> eth0: dma_rwctrl[769f4000]
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.47.
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> netconsole: not configured, aborting
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD8111: IDE controller at PCI slot 0000:00:07.1
> AMD8111: chipset revision 3
> AMD8111: not 100% native mode: will probe irqs later
> AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
>     ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
> hdc: LITE-ON LTR-48327S, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> GSI 17 sharing vector 0xB1 and IRQ 17
> ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 177
> ata1: SATA max UDMA/100 cmd 0xFFFFC20000006080 ctl 0xFFFFC2000000608A bmdma 0x7ata2: SATA max UDMA/100 cmd 0xFFFFC200000060C0 ctl 0xFFFFC200000060CA bmdma 0x7ata1: no device found (phy stat 00000000)
> scsi0 : sata_sil
> ata2: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_sil
>   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2
> sd 1:0:0:0: Attached scsi disk sda
> Fusion MPT base driver 3.03.04
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.03.04
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:01:03.2[C] -> GSI 16 (level, low) -> IRQ 185
> ehci_hcd 0000:01:03.2: EHCI Host Controller
> ehci_hcd 0000:01:03.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:01:03.2: irq 185, io mem 0xf9550000
> ehci_hcd 0000:01:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> GSI 19 sharing vector 0xC1 and IRQ 19
> ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 18 (level, low) -> IRQ 193
> ohci_hcd 0000:01:03.0: OHCI Host Controller
> ohci_hcd 0000:01:03.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:01:03.0: irq 193, io mem 0xf9530000
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> GSI 20 sharing vector 0xC9 and IRQ 20
> ACPI: PCI Interrupt 0000:01:03.1[B] -> GSI 19 (level, low) -> IRQ 201
> ohci_hcd 0000:01:03.1: OHCI Host Controller
> ohci_hcd 0000:01:03.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:01:03.1: irq 201, io mem 0xf9540000
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> USB Universal Host Controller Interface driver v2.3
> usbcore: registered new driver usblp
> /home/muli/kernel/hg/drivers/usb/class/usblp.c: v0.13: USB Printer Device ClasrInitializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> /home/muli/kernel/hg/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> mice: PS/2 mouse device common for all mice
> device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
> input: AT Translated Set 2 keyboard as /class/input/input0
> Intel 810 + AC97 Audio, version 1.01, 11:24:59 Dec 13 2005
> ACPI: PCI Interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 177
> i810: AMD-8111 IOHub found at IO 0x1400 and 0x1000, MEM 0x0000 and 0x0000, IRQ7input: PS/2 Generic Mouse as /class/input/input1
> i810_audio: Audio Controller supports 6 channels.
> i810_audio: Defaulting to base 2 channel mode.
> i810_audio: Resetting connection 0
> ac97_codec: AC97  codec, id: ALG96 (Unknown)
> i810_audio: only 48Khz playback available.
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present),2oprofile: using NMI interrupt.
> NET: Registered protocol family 2
> IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 262144 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
> powernow-k8: MP systems not supported by PSB BIOS structure
> powernow-k8: MP systems not supported by PSB BIOS structure
> ReiserFS: sda2: found reiserfs format "3.6" with standard journal

> 0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=69
> 	I/O behind bridge: 00002000-00002fff
> 	Memory behind bridge: f9500000-f95fffff
> 	Prefetchable memory behind bridge: fff00000-000fffff
> 	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [c0] #08 [0086]
> 	Capabilities: [f0] #08 [8000]
> 00: 22 10 60 74 17 00 30 02 07 00 04 06 00 40 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 01 45 20 20 00 02
> 20: 50 f9 50 f9 f0 ff 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 06 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 04 06 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 14 10 b7 02 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 08 f0 86 00 20 00 00 00 d0 00 00 00 22 00 01 00
> d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 0d 00 00 00 0d 00 00 00 18 00 00 00 00 00
> f0: 08 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 00: 22 10 68 74 0f 00 20 02 05 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 80 30 07 b1 01 00 00 82 2f 00 00 01 00 00 00 c0
> 50: 00 00 00 00 8d 71 00 00 4e 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 14 10 b7 02 01 81 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Region 4: I/O ports at 1460 [size=16]
> 00: 22 10 69 74 05 00 00 02 03 8a 01 01 00 40 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 61 14 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
> 40: 43 f0 00 00 00 00 00 00 5e 20 5e 5e a2 00 20 ff
> 50: 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 14 10 b7 02 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin D routed to IRQ 19
> 	Region 0: I/O ports at 1440 [size=32]
> 00: 22 10 6a 74 01 00 00 02 02 00 05 0c 00 40 00 00
> 10: 41 14 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
> 40: 02 00 05 0c 14 10 b7 02 06 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 6b 74 00 00 80 02 05 00 80 06 00 40 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 80 b1 09 07 00 00 00 00 20 04 40 00 00 00 00 00
> 50: 01 81 00 00 0f 00 95 ba 01 80 00 00 00 00 00 00
> 60: 00 00 80 06 13 00 00 00 00 00 00 00 00 00 00 00
> 70: 06 29 4b d5 0c 00 00 00 00 00 00 00 14 10 b7 02
> 80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 fe 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: b3 31 5c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Interrupt: pin B routed to IRQ 17
> 	Region 0: I/O ports at 1000 [size=256]
> 	Region 1: I/O ports at 1400 [size=64]
> 00: 22 10 6d 74 05 00 00 02 03 00 01 04 00 40 00 00
> 10: 01 10 00 00 01 14 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
> 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
> 	Capabilities: [c0] #08 [004a]
> 00: 22 10 50 74 17 01 30 02 12 00 04 06 00 40 81 00
> 10: 00 00 00 00 00 00 00 00 00 02 02 40 f1 01 20 02
> 20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 07 00
> 40: 04 00 1f 00 01 00 00 00 02 0d 00 00 01 2c 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 07 b8 c3 00 50 00 03 00 0e 00 ff ff 02 00 ff ff
> b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 03
> c0: 08 00 4a 00 20 00 11 11 20 00 00 00 22 04 35 00
> d0: 02 00 35 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 11 00 00 00 12 00 00 00 14 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at f9220000 (64-bit, non-prefetchable) [size=4K]
> 00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
> 10: 04 00 22 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 51 74
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 03 00 00 00 04 00 22 f9 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: f9600000-f96fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
> 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
> 00: 22 10 50 74 17 01 30 02 12 00 04 06 00 40 81 00
> 10: 00 00 00 00 00 00 00 00 00 03 03 40 f1 01 20 02
> 20: 60 f9 60 f9 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 07 00
> 40: 04 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 07 b8 83 00 58 00 03 00 0e 00 ff ff 02 00 ff ff
> b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 04
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at f9230000 (64-bit, non-prefetchable) [size=4K]
> 00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
> 10: 04 00 23 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 51 74
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 03 00 00 00 04 00 23 f9 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Capabilities: [80] #08 [2101]
> 	Capabilities: [a0] #08 [2101]
> 	Capabilities: [c0] #08 [2101]
> 00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
> 40: 01 01 05 00 04 04 01 00 01 01 01 00 01 01 01 00
> 50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
> 60: 10 00 01 00 e4 02 00 00 00 c8 00 0f 1c 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 08 a0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
> 90: 56 04 51 02 00 08 ff 00 07 00 00 00 00 00 00 00
> a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
> b0: 13 56 13 04 00 00 00 00 03 00 00 00 00 00 00 00
> c0: 08 00 01 21 20 00 11 11 22 04 75 80 02 00 00 00
> d0: 56 04 51 02 00 00 07 00 07 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 03 00 00 00 00 00 ff 00 00 00 00 01 01 00 00 00
> 50: 00 00 00 01 02 00 00 00 00 00 00 01 03 00 00 00
> 60: 00 00 00 01 04 00 00 00 00 00 00 01 05 00 00 00
> 70: 00 00 00 01 06 00 00 00 00 00 00 01 07 00 00 00
> 80: 03 22 f9 00 20 6f f9 00 00 00 00 00 00 00 00 00
> 90: 03 00 f8 00 00 21 f9 00 03 00 e0 00 00 ff f7 00
> a0: 03 c0 fe 00 20 c0 fe 00 03 0a 00 00 00 0b 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 23 00 00 00 20 20 00 00 13 f0 ff 01 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 03 02 00 07 03 00 08 ff 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 01 00 00 00 00 00 00 00 01 20 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 de e0 0f 00 00 00 00 00 de e0 0f 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 55 00 00 00 00 00 00 00 42 35 82 13 21 0b 10 00
> 90: 00 8c 33 08 08 0a 7b 0e 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 8e d6 50 be 66 00 00 00 c5 34 0c 02 40 00 40 0c
> c0: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: b6 d6 1e 5c 5e e1 8f 9f 78 25 36 ad 9e c2 1d 37
> e0: df f4 9e ff cd 60 eb 5f c5 0d 9d d6 c7 93 bf 37
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: ff 3b 00 00 44 00 40 02 00 00 00 00 00 00 00 00
> 50: f8 ff ff ff ff 00 00 00 00 00 02 00 40 44 1c 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
> 80: 00 00 07 23 13 21 13 00 00 00 00 00 00 00 00 00
> 90: 07 00 00 00 70 00 00 00 00 d0 37 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 3f 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 00 00
> e0: 00 00 00 00 20 0d 59 00 1b 01 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Capabilities: [80] #08 [2101]
> 	Capabilities: [a0] #08 [2101]
> 	Capabilities: [c0] #08 [2101]
> 00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
> 40: 04 04 01 00 01 01 05 00 01 01 01 00 01 01 01 00
> 50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
> 60: 11 00 01 00 e4 00 00 00 00 c8 00 0f 04 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 08 a0 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
> 90: 02 30 10 06 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 08 c0 01 21 20 00 11 11 22 05 75 80 02 00 00 00
> b0: 13 56 13 04 00 00 00 00 03 00 00 00 00 00 00 00
> c0: 08 00 01 21 d0 00 11 77 22 00 75 80 02 00 00 00
> d0: 26 16 00 01 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 03 00 00 00 00 00 ff 00 00 00 00 01 01 00 00 00
> 50: 00 00 00 01 02 00 00 00 00 00 00 01 03 00 00 00
> 60: 00 00 00 01 04 00 00 00 00 00 00 01 05 00 00 00
> 70: 00 00 00 01 06 00 00 00 00 00 00 01 07 00 00 00
> 80: 03 22 f9 00 20 6f f9 00 00 00 00 00 00 00 00 00
> 90: 03 00 f8 00 00 21 f9 00 03 00 e0 00 00 ff f7 00
> a0: 03 c0 fe 00 20 c0 fe 00 03 0a 00 00 00 0b 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 23 00 00 00 20 20 00 00 13 f0 ff 01 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 03 02 00 07 03 00 08 ff 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 08 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 62 43 56 be 66 00 00 00 55 af 00 00 09 00 40 10
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 51 ff e2 ae c3 88 b6 82 06 0d e9 6e 35 d8 00 d1
> e0: 49 7f fb cc 53 d2 b6 ff 82 85 e5 3a 54 fb 84 ea
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: ff 3b 00 00 44 00 40 02 00 00 00 00 00 00 00 00
> 50: f8 7b 00 00 fa 00 00 00 00 00 02 00 80 00 20 10
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
> 80: 00 00 07 23 13 21 13 00 00 00 00 00 00 00 00 00
> 90: 07 00 00 00 70 00 00 00 00 d0 37 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 3e 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 07 07 e2 04 00 00 00 00 00 25 25 00
> e0: 00 00 00 00 20 0c 59 00 1b 01 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:01:02.0 IDE interface: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01) (prog-if 85 [Master SecO PriO])
> 	Subsystem: IBM: Unknown device 3512
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, cache line size 10
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: I/O ports at 2020 [size=8]
> 	Region 1: I/O ports at 2014 [size=4]
> 	Region 2: I/O ports at 2018 [size=8]
> 	Region 3: I/O ports at 2010 [size=4]
> 	Region 4: I/O ports at 2000 [size=16]
> 	Region 5: Memory at f9520000 (32-bit, non-prefetchable) [size=512]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 00: 95 10 12 35 07 00 b0 02 01 85 01 01 10 40 00 00
> 10: 21 20 00 00 15 20 00 00 19 20 00 00 11 20 00 00
> 20: 01 20 00 00 00 00 52 f9 00 00 00 00 14 10 12 35
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 00
> 40: 02 00 00 00 97 dd d2 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 60 00 00 00 cd de
> 80: 22 00 00 00 03 00 00 00 00 00 00 00 67 9d 76 1d
> 90: 00 00 00 08 ff ff 00 00 00 00 00 08 ff 00 00 00
> a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
> b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
> c0: 84 01 00 00 13 01 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:01:03.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (250ns min, 10500ns max), cache line size 10
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: Memory at f9530000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 33 10 35 00 16 00 10 02 43 10 03 0c 10 40 80 00
> 10: 00 00 53 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 01 2a
> 40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 05 33 b0 6c 20 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:01:03.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (250ns min, 10500ns max), cache line size 10
> 	Interrupt: pin B routed to IRQ 19
> 	Region 0: Memory at f9540000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 33 10 35 00 16 00 10 02 43 10 03 0c 10 40 00 00
> 10: 00 00 54 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 02 01 2a
> 40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:01:03.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 132 (4000ns min, 8500ns max), cache line size 10
> 	Interrupt: pin C routed to IRQ 16
> 	Region 0: Memory at f9550000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 33 10 e0 00 16 00 10 02 04 20 03 0c 10 84 00 00
> 10: 00 00 55 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 05 03 10 22
> 40: 01 00 02 7e 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 20 20 3f 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 05 33 b0 6c 20 00 00 00 01 00 00 00 00 00 08 c0
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:01:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min, 1000ns max), cache line size 10
> 	Interrupt: pin A routed to IRQ 19
> 	Region 0: Memory at f9570000 (32-bit, non-prefetchable) [size=2K]
> 	Region 1: Memory at f9560000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> 00: 4c 10 23 80 16 00 10 02 00 10 00 0c 10 40 00 00
> 10: 00 00 57 f9 00 00 56 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 04
> 40: 00 00 00 00 01 00 02 7e 00 80 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00
> f0: 10 00 00 00 82 10 00 00 14 10 b7 02 00 00 00 00
> 
> 0000:03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
> 	Subsystem: IBM: Unknown device 026f
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (16000ns min), cache line size 10
> 	Interrupt: pin A routed to IRQ 28
> 	Region 0: Memory at f9600000 (64-bit, non-prefetchable) [size=64K]
> 	Capabilities: [40] PCI-X non-bridge device.
> 		Command: DPERE- ERO- RBC=2 OST=0
> 		Status: Bus=3 Dev=2 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-	Capabilities: [48] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
> 		Address: 0260d4c6cb641f4c  Data: b315
> 00: e4 14 a7 16 06 00 b0 02 02 00 00 02 10 40 00 00
> 10: 04 00 60 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6f 02
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 40 00
> 40: 07 48 08 00 11 03 43 04 01 50 02 c0 00 20 00 64
> 50: 03 58 44 00 f5 71 4e 18 05 00 86 00 4c 1f 64 cb
> 60: c6 d4 60 02 15 b3 00 00 98 00 02 10 00 40 9f 76
> 70: e2 10 00 00 a6 00 00 80 4c 5b 03 00 00 00 00 00
> 80: 00 00 00 00 02 37 98 90 34 00 13 04 82 10 08 00
> 90: 09 97 00 01 01 00 00 00 00 00 00 00 6e 01 00 00
> a0: 00 00 00 00 a6 00 00 00 00 00 00 00 aa 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 14)
> 	Subsystem: IBM: Unknown device 02b7
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
> 	Capabilities: [a0] AGP version 3.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh+ GART64- HTrans- 64bit+ FW+ AGP3+ Rate=x4,x8
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
> 	Capabilities: [c0] #08 [0060]
> 00: 22 10 54 74 02 00 10 02 14 00 00 06 00 00 00 00
> 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 b7 02
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
> 40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 0b 00 19 00 0b 00 19 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 02 c0 30 00 3b 0b 00 1f 00 02 00 00 00 00 00 00
> b0: 00 01 00 00 00 0f 01 00 00 00 00 00 00 00 00 00
> c0: 08 00 60 00 20 00 11 11 20 00 00 00 22 05 35 00
> d0: 02 02 35 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 08 08 0d 00 08 08 0e 00 0f 0f 15 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 14) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 99
> 	Bus: primary=08, secondary=09, subordinate=0d, sec-latency=68
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: f8000000-f8ffffff
> 	Prefetchable memory behind bridge: f0000000-f7ffffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 00: 22 10 55 74 07 00 20 02 14 00 04 06 00 63 01 00
> 10: 00 00 00 00 00 00 00 00 08 09 0d 44 f1 01 20 22
> 20: 00 f8 f0 f8 00 f0 f0 f7 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=08, secondary=0e, subordinate=12, sec-latency=64
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
> 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
> 	Capabilities: [c0] #08 [0043]
> 00: 22 10 50 74 17 01 30 02 12 00 04 06 00 40 81 00
> 10: 00 00 00 00 00 00 00 00 08 0e 12 40 f1 01 20 22
> 20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 07 00
> 40: 04 00 1f 00 01 00 00 00 02 0b 00 00 01 2c 00 00
> 50: 00 00 03 00 00 00 05 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 07 b8 83 00 18 08 03 00 0e 00 ff ff 02 00 ff ff
> b0: 00 00 00 00 00 00 00 00 08 c0 00 80 00 00 00 05
> c0: 08 00 43 00 20 00 11 00 d0 00 00 77 22 02 35 00
> d0: 02 00 35 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 0f 00 00 00 0d 00 00 00 15 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:03.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at f9200000 (64-bit, non-prefetchable) [size=4K]
> 00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
> 10: 04 00 20 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 51 74
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 03 00 00 00 04 00 20 f9 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:04.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=08, secondary=13, subordinate=17, sec-latency=64
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
> 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
> 00: 22 10 50 74 17 01 30 02 12 00 04 06 00 40 81 00
> 10: 00 00 00 00 00 00 00 00 08 13 17 40 f1 01 20 22
> 20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 07 00
> 40: 04 00 1f 00 01 00 00 00 00 00 00 00 01 2c 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 07 b8 83 00 20 08 03 00 0e 00 ff ff 02 00 ff ff
> b0: 00 00 00 00 00 00 00 00 08 00 00 80 00 00 00 06
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:08:04.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at f9210000 (64-bit, non-prefetchable) [size=4K]
> 00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
> 10: 04 00 21 f9 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 51 74
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 03 00 00 00 04 00 21 f9 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 0000:09:00.0 VGA compatible controller: nVidia Corporation NV36GL [Quadro FX 1100] (rev a1) (prog-if 00 [VGA])
> 	Subsystem: nVidia Corporation: Unknown device 01da
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (1250ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 16
> 	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [44] AGP version 3.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 00: de 10 4e 03 07 00 b0 02 a1 00 00 03 00 40 00 00
> 10: 00 00 00 f8 08 00 00 f0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 da 01
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
> 40: de 10 da 01 02 00 30 00 1b 0e 00 1f 00 00 00 00
> 50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
> 60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 

