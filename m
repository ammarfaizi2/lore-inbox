Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVKQOcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKQOcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKQOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:32:04 -0500
Received: from fmr24.intel.com ([143.183.121.16]:32397 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750869AbVKQOcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:32:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: maxcpus=1 broken, ACPI bug?
Date: Thu, 17 Nov 2005 06:31:44 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60065B5157@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: maxcpus=1 broken, ACPI bug?
Thread-Index: AcXrQNsWXhHdo6wbTn2INQ4EdvFrzgAQl8+w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <maneesh@in.ibm.com>, "LKML" <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 17 Nov 2005 14:31:46.0633 (UTC) FILETIME=[A3814B90:01C5EB83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am not yet able to see how this patch can cause a hang like that. My
initial guess is that it has got something to with idle routine and
preempt. I will look more into this and try to reproduce it locally. Can
you please try out disable preemption in your config and try 2.6.15-rc1
and let me know how it goes.

Thanks,
Venki

>-----Original Message-----
>From: Maneesh Soni [mailto:maneesh@in.ibm.com] 
>Sent: Wednesday, November 16, 2005 10:31 PM
>To: LKML
>Cc: Pallipadi, Venkatesh; Brown, Len; Andrew Morton; Linus Torvalds
>Subject: maxcpus=1 broken, ACPI bug?
>
>Hi,
>
>Using maxcpus=1 boot option, hangs the system while booting. It was
>working till 2.6.13-rc2. After git bisect I found that after backing
>out this ACPI patch it works again, though I had to manually sort the
>reject while backing out.
>
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.
6.git;a=commitdiff;h=acf05f4b7f558051ea0028e8e617144123650272
>
>This option is useful in case of kexec/kdump if only one cpu is
>desired to be up during second kernel boot. I tried this on a 4-way
>Xeon 2.5 MHz SMP system.
>
>Following is the boot log with 2.6.15-rc1 with maxcpus=1 
>option. .config 
>is also attached. 
>
>Thanks
>Maneesh
>
>--------------------------------------------------------------------
>  Booting 'test kernel'
>
>root (hd0,0)
> Filesystem type is ext2fs, partition type 0x83
>kernel /t ro root=/dev/sda2 rhgb console=tty0 
>console=ttyS0,38400 maxcpus=1
>   [Linux-bzImage, setup=0x1400, size=0x218992]
>module /initrd-2.6.9-5.ELsmp.img
>   [Linux-initrd @ 0x37f6f000, 0x80f5d bytes]
>
>Linux version 2.6.15-rc1 (root@llm11.in.ibm.com) (gcc version 
>3.4.3 20041212 (Red Hat 3.4.3-9.EL4)) #1 SMP PREEMPT Thu Nov 
>17 11:51:29 IST 2005
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
> BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000e97f5f40 (usable)
> BIOS-e820: 00000000e97f5f40 - 00000000e97ff800 (ACPI data)
> BIOS-e820: 00000000e97ff800 - 00000000e9800000 (reserved)
> BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
>4224MB HIGHMEM available.
>896MB LOWMEM available.
>found SMP MP-table at 0009dd40
>DMI 2.3 present.
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
>Processor #2 15:2 APIC version 20
>WARNING: maxcpus limit of 1 reached. Processor ignored.
>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
>Processor #4 15:2 APIC version 20
>WARNING: maxcpus limit of 1 reached. Processor ignored.
>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
>Processor #6 15:2 APIC version 20
>WARNING: maxcpus limit of 1 reached. Processor ignored.
>ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
>ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
>ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
>ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
>ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
>IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-15
>ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[16])
>IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 16-31
>ACPI: IOAPIC (id[0x0c] address[0xfec02000] gsi_base[32])
>IOAPIC[2]: apic_id 12, version 17, address 0xfec02000, GSI 32-47
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>Enabling APIC mode:  Flat.  Using 3 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Allocating PCI resources starting at ea000000 (gap: e9800000:15400000)
>Built 1 zonelists
>Kernel command line: ro root=/dev/sda2 rhgb console=tty0 
>console=ttyS0,38400 maxcpus=1
>Initializing CPU#0
>PID hash table entries: 4096 (order: 12, 65536 bytes)
>Detected 2488.816 MHz processor.
>Using tsc for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>Memory: 4819576k/5242880k available (3171k kernel code, 52464k 
>reserved, 1007k data, 244k init, 3956692k highmem)
>Checking if this processor honours the WP bit even in 
>supervisor mode... Ok.
>Calibrating delay using timer specific routine.. 4985.70 
>BogoMIPS (lpj=9971404)
>Mount-cache hash table entries: 512
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: L3 cache: 1024K
>CPU: Hyper-Threading is disabled
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>mtrr: v2.0 (20020519)
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
> tbxface-0109 [02] load_tables           : ACPI Tables 
>successfully acquired
>Parsing all Control 
>Methods:.......................................................
>...............................................................
>...............................................................
>...............................................................
>...............................................................
>...............................................................
>........................................................
>Table [DSDT](id 0005) - 986 Objects with 113 Devices 426 
>Methods 13 Regions
>ACPI Namespace successfully loaded at root c0576818
>evxfevnt-0091 [03] enable                : Transition to ACPI 
>mode successful
>CPU0: Intel(R) Xeon(TM) MP CPU 2.50GHz stepping 05
>Total of 1 processors activated (4985.70 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
>Brought up 1 CPUs
>checking if image is initramfs... it is
>Freeing initrd memory: 515k freed
>NET: Registered protocol family 16
>ACPI: bus type pci registered
>PCI: PCI BIOS revision 2.10 entry at 0xfd74c, last bus=12
>PCI: Using configuration type 1
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>ACPI: Subsystem revision 20050902
>evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 
>4 regs on int 0x7evgpeblk-0996 [06] ev_create_gpe_block   : 
>Found 1 Wake, Enabled 0 Runtime GPEs
>in this block
>evgpeblk-0988 [06] ev_create_gpe_block   : GPE 20 to 3F [_GPE] 
>4 regs on int 0x7evgpeblk-0996 [06] ev_create_gpe_block   : 
>Found 0 Wake, Enabled 1 Runtime GPEs
>in this block
>Completing Region/Field/Buffer/Package 
>initialization:......................................
>Initialized 13/13 Regions 0/0 Fields 8/8 Buffers 17/18 
>Packages (995 nodes)
>Executing all Device _STA and_INI 
>methods:.......................................................
>................................................................
>119 Devices found containing: 119 _STA, 1 _INI methods
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (0000:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
>ACPI: PCI Root Bridge [PCI1] (0000:01)
>PCI: Probing PCI hardware (bus 01)
>ACPI: PCI Root Bridge [PCI2] (0000:05)
>PCI: Probing PCI hardware (bus 05)
>ACPI: PCI Root Bridge [PCI3] (0000:08)
>PCI: Probing PCI hardware (bus 08)
>ACPI: PCI Root Bridge [PCI4] (0000:09)
>PCI: Probing PCI hardware (bus 09)
>ACPI: PCI Interrupt Link [LP00] (IRQs *10)
>pci_link-0119 [09] pci_link_check_possibl: Blank IRQ resource
>ACPI: PCI Interrupt Link [LP01] (IRQs) *0, disabled.
>pci_link-0119 [09] pci_link_check_possibl: Blank IRQ resource
>ACPI: PCI Interrupt Link [LP02] (IRQs) *0, disabled.
>pci_link-0119 [09] pci_link_check_possibl: Blank IRQ resource
>ACPI: PCI Interrupt Link [LP03] (IRQs) *0, disabled.
>ACPI: PCI Interrupt Link [LP04] (IRQs *5)
>ACPI: PCI Interrupt Link [LP05] (IRQs *5)
>ACPI: PCI Interrupt Link [LP06] (IRQs *5)
>ACPI: PCI Interrupt Link [LP07] (IRQs *5)
>ACPI: PCI Interrupt Link [LP08] (IRQs *5)
>ACPI: PCI Interrupt Link [LP09] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0A] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0B] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0C] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0D] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0E] (IRQs *5)
>ACPI: PCI Interrupt Link [LP0F] (IRQs *5)
>ACPI: PCI Interrupt Link [LP10] (IRQs *5)
>ACPI: PCI Interrupt Link [LP11] (IRQs *5)
>ACPI: PCI Interrupt Link [LP12] (IRQs *5)
>ACPI: PCI Interrupt Link [LP13] (IRQs *5)
>ACPI: PCI Interrupt Link [LP14] (IRQs *5)
>ACPI: PCI Interrupt Link [LP15] (IRQs *5)
>ACPI: PCI Interrupt Link [LP16] (IRQs *5)
>ACPI: PCI Interrupt Link [LP17] (IRQs *5)
>ACPI: PCI Interrupt Link [LP18] (IRQs *5)
>ACPI: PCI Interrupt Link [LP19] (IRQs *5)
>ACPI: PCI Interrupt Link [LP1A] (IRQs *5)
>ACPI: PCI Interrupt Link [LP1B] (IRQs *5)
>ACPI: PCI Interrupt Link [LP1C] (IRQs *9)
>ACPI: PCI Interrupt Link [LP1D] (IRQs *9)
>pci_link-0119 [09] pci_link_check_possibl: Blank IRQ resource
>ACPI: PCI Interrupt Link [LP1E] (IRQs) *0, disabled.
>ACPI: PCI Interrupt Link [LP1F] (IRQs *3)
>ACPI: PCI Interrupt Link [LPUS] (IRQs *11)
>Linux Plug and Play Support v0.97 (c) Adam Belay
>pnp: PnP ACPI init
>pnp: PnP ACPI: found 13 devices
>SCSI subsystem initialized
>PCI: Using ACPI for IRQ routing
>PCI: If a device doesn't work, try "pci=routeirq".  If it 
>helps, post a report
>pnp: 00:00: ioport range 0x900-0x93f has been reserved
>pnp: 00:00: ioport range 0x510-0x517 could not be reserved
>pnp: 00:00: ioport range 0x504-0x507 could not be reserved
>pnp: 00:00: ioport range 0x500-0x503 could not be reserved
>pnp: 00:00: ioport range 0x520-0x53f has been reserved
>pnp: 00:00: ioport range 0x420-0x427 has been reserved
>pnp: 00:00: ioport range 0x460-0x461 has been reserved
>pnp: 00:0a: ioport range 0x1ec-0x1ef has been reserved
>pnp: 00:0a: ioport range 0x400-0x4fe could not be reserved
>pnp: 00:0a: ioport range 0x600-0x600 has been reserved
>pnp: 00:0a: ioport range 0x800-0x80f has been reserved
>pnp: 00:0a: ioport range 0xc00-0xcfe could not be reserved
>pnp: 00:0a: ioport range 0xf50-0xf58 has been reserved
>Machine check exception polling timer started.
>audit: initializing netlink socket (disabled)
>audit(1132228762.256:1): initialized
>highmem bounce pool size: 64 pages
>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>usbmon: debugfs is not available
>USB Universal Host Controller Interface driver v2.3
>usbcore: registered new driver usblp
>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
>Initializing USB Mass Storage driver...
>usbcore: registered new driver usb-storage
>USB Mass Storage support registered.
>usbcore: registered new driver usbhid
>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
>usbcore: registered new driver touchkitusb
>usbcore: registered new driver cytherm
>drivers/usb/misc/cytherm.c: v1.0:Cypress USB Thermometer driver
>usbcore: registered new driver phidgetservo
>ACPI: Power Button (FF) [PWRF]
>ACPI: CPU0 (power states: C1[C1])
>acpi_processor-0507 [06] processor_get_info    : Error getting 
>cpuindex for acpiid 0x2
>acpi_processor-0507 [06] processor_get_info    : Error getting 
>cpuindex for acpiid 0x1
>ACPI: CPU0 (power states: C1[C1])
>lp: driver loaded but no devices found
>Linux agpgart interface v0.101 (c) Dave Jones
>[drm] Initialized drm 1.0.0 20040925
>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x64,0x60 irq 1,12
>PNP: PS/2 controller has invalid data port 0x64; using default 0x60
>PNP: PS/2 controller has invalid command port 0x60; using default 0x64
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
>sharing disabled
>serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>tg3.c:v3.43 (Oct 24, 2005)
>acpi_bus-0200 [01] bus_set_power         : Device is not power 
>manageable
>ACPI: PCI Interrupt 0000:09:08.0[A] -> GSI 47 (level, low) -> IRQ 16
>eth0: Tigon3 [partno(BCM95703) rev 1002 PHY(5703)] 
>(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:02:55:df:b4:13
>eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] 
>WireSpeed[1] TSOcap[1]
>eth0: dma_rwctrl[769f4000]
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override 
>with idebus=xx
>
><<<< hangs here >>>>
>
>
>-- 
>Maneesh Soni
>Linux Technology Center, 
>IBM India Software Labs,
>Bangalore, India
>email: maneesh@in.ibm.com
>Phone: 91-80-25044990
>
