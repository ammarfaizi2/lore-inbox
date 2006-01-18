Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWARWlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWARWlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWARWlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:41:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20923 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932550AbWARWlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:41:07 -0500
Date: Wed, 18 Jan 2006 23:40:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>
Subject: Re: 2.6.16-rc1-mm1 usb hub problems
Message-ID: <20060118224043.GA1595@elf.ucw.cz>
References: <20060118205752.GA1520@elf.ucw.cz> <20060118135336.58fee9b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118135336.58fee9b9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...
> > ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level,
> > low) -> IRQ 9
> > PCI: Setting latency timer of device 0000:00:1d.2 to 64
> > uhci_hcd 0000:00:1d.2: UHCI Host Controller
> > uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> > uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
> > usb usb4: configuration #1 chosen from 1 choice
> > hub 4-0:1.0: USB hub found
> > hub 4-0:1.0: 2 ports detected
> > ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably
> > using the wrong IRQ.
> > 
> >
> > Any ideas?
> 
> I guess ACPI IRQ routing would be a suspect.  Can you generate the -rc1
> dmesg and the -rc1-mm1 dmesg, diff them, look for ACPI differences?

I did not have -rc1 handy, but this git should be close enough. Hope
this helps.

Uff, I hate acpi. They had to reinvent printk, making it useless to
diffing :-(

evgpeblk-0941:
         ~~~~ and this changes.

65 _STA methods are missing?

--- /tmp/rc1.mesg	2006-01-18 23:24:01.000000000 +0100
+++ /tmp/rc1-mm1.mesg	2006-01-18 23:32:24.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.15-dirty (pavel@amd) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #190 SMP PREEMPT Mon Jan 16 13:48:34 CET 2006
+Linux version 2.6.16-rc1-mm1 (pavel@amd) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #6 Wed Jan 18 20:48:34 CET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
@@ -50,32 +49,28 @@
 CPU: L2 cache: 2048K
 CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
 mtrr: v2.0 (20020519)
+CPU: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
 Checking 'hlt' instruction... OK.
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
-Parsing all Control Methods:..........................................................................................................................................................................................................................................................................................................................................................................................................................................................
+Parsing all Control Methods:
 Table [DSDT](id 0006) - 1407 Objects with 65 Devices 442 Methods 19 Regions
-Parsing all Control Methods:.
+Parsing all Control Methods:
 Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
-ACPI Namespace successfully loaded at root c07d3b58
+ACPI Namespace successfully loaded at root c076ccb8
 ACPI: setting ELCR to 0200 (from 0a20)
 evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
-CPU0: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
-SMP motherboard not detected.
-Local APIC not detected. Using dummy APIC emulation.
-Brought up 1 CPUs
-migration_cost=0
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=15
 PCI: Using configuration type 1
-ACPI: Subsystem revision 20050902
-evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
-evgpeblk-0996 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
+ACPI: Subsystem revision 20051216
+evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
+evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 0 Runtime GPEs in this block
 ACPI: Found ECDT
 Completing Region/Field/Buffer/Package initialization:..........................................................................................................................................................................................................................................
 Initialized 11/19 Regions 123/123 Fields 58/58 Buffers 42/49 Packages (1417 nodes)
 Executing all Device _STA and_INI methods:....................................................................
-68 Devices found containing: 68 _STA, 11 _INI methods
+68 Devices found containing: 3 _STA, 11 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
@@ -93,11 +88,13 @@
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 Boot video device is 0000:01:00.0
 PCI: Transparent bridge - 0000:00:1e.0
+PCI: Found IBM Dock II Cardbus Bridge applying quirk
+PCI: Found IBM Dock II Cardbus Bridge applying quirk
 PCI: Transparent bridge - 0000:02:03.0
 PCI: Bus #10 (-#13) may be hidden behind transparent bridge #02 (-#0f) (try 'pci=assign-busses')
 PCI: Bus #14 (-#17) may be hidden behind transparent bridge #02 (-#0f) (try 'pci=assign-busses')
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: Embedded Controller [EC] (gpe 28)
+ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
 ACPI: Power Resource [PUBS] (on)
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
@@ -150,14 +147,24 @@
   MEM window: b0200000-c00fffff
   PREFETCH window: e8000000-efffffff
 PCI: Setting latency timer of device 0000:00:1e.0 to 64
-acpi_bus-0201 [86] bus_set_power         : Device is not power manageable
+acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
+**** SET: Misaligned resource pointer: c1e0bb02 Type 07 Len 0
+ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 PCI: setting IRQ 11 as level-triggered
-acpi_bus-0201 [86] bus_set_power         : Device is not power manageable
+ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
+acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
+**** SET: Misaligned resource pointer: c1e0bb02 Type 07 Len 0
+ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
 PCI: setting IRQ 5 as level-triggered
-acpi_bus-0201 [86] bus_set_power         : Device is not power manageable
-acpi_bus-0201 [86] bus_set_power         : Device is not power manageable
+ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
+acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
+acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
+**** SET: Misaligned resource pointer: c1e0bb02 Type 07 Len 0
+ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
 PCI: setting IRQ 9 as level-triggered
-acpi_bus-0201 [86] bus_set_power         : Device is not power manageable
+ACPI: PCI Interrupt 0000:09:02.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
+acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
+ACPI: PCI Interrupt 0000:09:02.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 Simple Boot Flag at 0x35 set to 0x1
 IBM machine detected. Enabling interrupts during APM calls.
 apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
@@ -173,9 +180,7 @@
 io scheduler deadline registered
 io scheduler cfq registered
 pci_hotplug: PCI Hot Plug PCI Core version: 0.5
-ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
-acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
-acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
+ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 radeonfb: Retrieved PLL infos from BIOS
 radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, System=144.00 MHz
 radeonfb: PLL min 12000 max 35000
@@ -198,20 +203,17 @@
 ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
 ACPI: Processor [CPU] (supports 8 throttling states)
 ACPI: Thermal Zone [THM0] (58 C)
-ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
-ibm_acpi: http://ibm-acpi.sf.net/
-acpi_bus-0073 [256] bus_get_device        : No context for object [c1d29adc]
-ibm_acpi: bay device not present
 lp: driver loaded but no devices found
-Real Time Clock Driver v1.12ac
 Linux agpgart interface v0.101 (c) Dave Jones
 [drm] Initialized drm 1.0.1 20051102
+ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 [drm] Initialized radeon 1.21.0 20051229 on minor 0
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
-acpi_bus-0201 [257] bus_set_power         : Device is not power manageable
+acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
+ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 ACPI: PCI interrupt for device 0000:00:1f.6 disabled
 parport0: PC-style at 0x3bc [PCSPP(,...)]
 lp0: using parport0 (polling).
@@ -220,9 +222,10 @@
 pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
 Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
 Copyright (c) 1999-2005 Intel Corporation.
+ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
 pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
...
@@ -237,6 +240,7 @@
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 ICH4: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
+ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 ICH4: chipset revision 1
 ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
@@ -251,10 +255,12 @@
 hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4
 Driver 'ide-scsi' needs updating - please use bus_type methods
+ACPI: PCI Interrupt 0000:02:00.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[b0211000-b02117ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
 ieee1394: raw1394: /dev/raw1394 device initialized
 ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
 ieee1394: sbp2: Try serialize_io=0 for better performance
+ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 Yenta: CardBus bridge found at 0000:02:00.0 [1014:0532]
 Yenta: ISA IRQ mask 0x0498, PCI irq 11
 Socket status: 30000006
@@ -262,6 +268,7 @@
 cs: IO port probe 0x4000-0x9fff: clean.
 pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xc00fffff
 pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
+ACPI: PCI Interrupt 0000:02:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 Yenta: CardBus bridge found at 0000:02:00.1 [1014:0532]
 Yenta: ISA IRQ mask 0x0498, PCI irq 5
 Socket status: 30000006
@@ -269,10 +276,40 @@
 cs: IO port probe 0x4000-0x9fff: clean.
 pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xc00fffff
 pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
+ACPI: PCI Interrupt 0000:09:02.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 Yenta: CardBus bridge found at 0000:09:02.0 [1014:0148]
 Yenta: Using INTVAL to route CSC interrupts to PCI
 Yenta: Routing CardBus interrupts to PCI
 Yenta TI: socket 0000:09:02.0, mfunc 0x00001002, devctl 0x66
+irq 11: nobody cared (try booting with the "irqpoll" option)
+ [<c013c904>] __report_bad_irq+0x24/0x90
+ [<c013c9ec>] note_interrupt+0x7c/0x1f0
+ [<c013c3e3>] handle_IRQ_event+0x33/0x70
+ [<c013c4ce>] __do_IRQ+0xae/0xc0
+ [<c0105309>] do_IRQ+0x19/0x30
+ [<c01036ca>] common_interrupt+0x1a/0x20
+ [<c013c3c7>] handle_IRQ_event+0x17/0x70
+ [<c013c482>] __do_IRQ+0x62/0xc0
+ [<c0105309>] do_IRQ+0x19/0x30
+ [<c01036ca>] common_interrupt+0x1a/0x20
+ [<c03bd433>] yenta_probe_cb_irq+0x83/0xf0
+ [<c03bd5cf>] ti12xx_override+0x12f/0x610
+ [<c047de1a>] pci_write+0x2a/0x30
+ [<c03bd224>] yenta_probe+0x4e4/0x550
+ [<c025ae3b>] pci_device_probe+0x5b/0x80
+ [<c03064dc>] driver_probe_device+0x4c/0xe0
+ [<c030663a>] __driver_attach+0x5a/0x60
+ [<c0305a6a>] bus_for_each_dev+0x3a/0x60
+ [<c0306386>] driver_attach+0x16/0x20
+ [<c03065e0>] __driver_attach+0x0/0x60
+ [<c0305d9c>] bus_add_driver+0x7c/0x140
+ [<c025a9f4>] __pci_register_driver+0x54/0x90
+ [<c01002f8>] init+0x88/0x210
+ [<c0100270>] init+0x0/0x210
+ [<c0101005>] kernel_thread_helper+0x5/0x10
+handlers:
+[<c03bc6d0>] (yenta_interrupt+0x0/0xc0)
+Disabling IRQ #11
 Yenta: ISA IRQ mask 0x04d8, PCI irq 9
 Socket status: 30000006
 pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
@@ -283,6 +320,7 @@
 pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xc00fffff
 pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b032904c34f]
+ACPI: PCI Interrupt 0000:09:02.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 Yenta: CardBus bridge found at 0000:09:02.1 [1014:0148]
 Yenta: Using INTVAL to route CSC interrupts to PCI
 Yenta: Routing CardBus interrupts to PCI
@@ -298,6 +336,9 @@
 pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xefffffff
 Intel ISA PCIC probe: not found.
 Databook TCIC-2 PCMCIA probe: not found.
+**** SET: Misaligned resource pointer: c1fad5c2 Type 07 Len 0
+ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
+ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.7 to 64
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 ehci_hcd 0000:00:1d.7: debug port 1
@@ -309,7 +350,8 @@
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 6 ports detected
 ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
-USB Universal Host Controller Interface driver v2.3
+USB Universal Host Controller Interface driver v3.0
+ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
@@ -317,6 +359,9 @@
 usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
+**** SET: Misaligned resource pointer: f7f9ef02 Type 07 Len 0
+ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
+ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
 PCI: Setting latency timer of device 0000:00:1d.1 to 64
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
@@ -325,6 +370,7 @@
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
 usb 1-1: new high speed USB device using ehci_hcd and address 2
+ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
 uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
@@ -332,9 +378,14 @@
 usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
-usb 1-1: configuration #1 chosen from 1 choice
-hub 1-1:1.0: USB hub found
-hub 1-1:1.0: 4 ports detected
+ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
+usb 1-1: device not accepting address 2, error -110
+usb 1-1: new high speed USB device using ehci_hcd and address 3
+usb 1-1: device not accepting address 3, error -110
+usb 1-1: new high speed USB device using ehci_hcd and address 4
+usb 1-1: device not accepting address 4, error -110
+usb 1-1: new high speed USB device using ehci_hcd and address 5
+usb 1-1: device not accepting address 5, error -110
 usbcore: registered new driver cdc_acm
 drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
 usbcore: registered new driver usblp
@@ -364,18 +414,20 @@
...
 Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
+ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 input: PS/2 Generic Mouse as /class/input/input2
-intel8x0_measure_ac97_clock: measured 55311 usecs
+intel8x0_measure_ac97_clock: measured 56003 usecs
 intel8x0: clocking to 48000
 ALSA device list:
   #0: Intel 82801DB-ICH4 with AD1981B at 0xb0000c00, irq 5
...

							Pavel

-- 
Thanks, Sharp!
