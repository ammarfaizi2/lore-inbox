Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVGNKhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVGNKhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVGNKhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:37:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:62086 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263002AbVGNKhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:37:17 -0400
Date: Thu, 14 Jul 2005 12:36:57 +0200 (MEST)
Message-Id: <200507141036.j6EAaveO029891@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: len.brown@intel.com
Subject: 2.6.13-rc3 ACPI regression and hang on x86-64
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my x86-64 laptop (Targa Visionary 811: Athlon64 + VIA chipset,
Arima OEM:d HW also sold by eMachines and others), ACPI is broken
and hangs the x86-64 2.6.13-rc3 kernel.

During boot, ACPI reduces the screen's brightness (it's always
done this in the x86-64 kernels but not the i386 ones), so I
have to press a specific key combination (Fn+F8) to increase the
brightness. This worked up to and including the 2.6.13-rc2 kernel,
but with 2.6.13-rc3 it causes an error message:

acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail

on the console, and then the machine is hung hard.

With the i386 kernel, both this key combination and the other one
for reducing the brightness work as expected.

A diff between the dmesg logs for 2.6.13-rc2 and -rc3 (included below)
indicates that APCI experiences several new errors in rc3.

/Mikael

--- dmesg-2.6.13-rc2-x86_64	2005-07-14 11:59:58.000000000 +0200
+++ dmesg-2.6.13-rc3-x86_64	2005-07-14 11:59:59.000000000 +0200
@@ -1,5 +1,5 @@
 Bootdata ok (command line is ro root=/dev/hda7)
-Linux version 2.6.13-rc2 (mikpe@saaz) (gcc version 4.0.1) #1 Fri Jul 8 15:44:53 CEST 2005
+Linux version 2.6.13-rc3 (mikpe@saaz) (gcc version 4.0.1) #1 Wed Jul 13 17:51:48 CEST 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
@@ -37,46 +37,49 @@
 Initializing CPU#0
 PID hash table entries: 2048 (order: 11, 65536 bytes)
 time.c: Using 1.193182 MHz PIT timer.
-time.c: Detected 1603.693 MHz processor.
+time.c: Detected 1603.705 MHz processor.
 time.c: Using PIT/TSC based timekeeping.
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
-Memory: 511408k/523200k available (1653k kernel code, 11012k reserved, 941k data, 128k init)
-Calibrating delay using timer specific routine.. 3211.68 BogoMIPS (lpj=16058428)
+Memory: 511408k/523200k available (1656k kernel code, 11012k reserved, 941k data, 128k init)
+Calibrating delay using timer specific routine.. 3211.67 BogoMIPS (lpj=16058383)
 Mount-cache hash table entries: 256
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
+mtrr: v2.0 (20020519)
 CPU: Mobile AMD Athlon(tm) 64 Processor 2800+ stepping 0a
- tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
+ tbxface-0120 [02] acpi_load_tables      : ACPI Tables successfully acquired
 Parsing all Control Methods:....................................................................................................................................................
 Table [DSDT](id F005) - 482 Objects with 46 Devices 148 Methods 16 Regions
 Parsing all Control Methods:
 Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
-ACPI Namespace successfully loaded at root ffffffff803ac6e0
-evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
+ACPI Namespace successfully loaded at root ffffffff803ad260
+evxfevnt-0096 [03] acpi_enable           : Transition to ACPI mode successful
 Using local APIC timer interrupts.
 Detected 12.528 MHz APIC timer.
 testing NMI watchdog ... OK.
 NET: Registered protocol family 16
+ACPI: bus type pci registered
 PCI: Using configuration type 1
-mtrr: v2.0 (20020519)
-ACPI: Subsystem revision 20050309
-evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0xA
-evgpeblk-0987 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
+ACPI: Subsystem revision 20050408
+evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0xA
+evgpeblk-1024 [06] ev_create_gpe_block   : Found 7 Wake, Enabled 0 Runtime GPEs in this block
 Completing Region/Field/Buffer/Package initialization:...................................................
 Initialized 16/16 Regions 0/0 Fields 18/18 Buffers 17/27 Packages (494 nodes)
-Executing all Device _STA and_INI methods:..........................[ACPI Debug] String: [0x24] "---------------------------- AC _STA"
+Executing all Device _STA and_INI methods:..........................[ACPI Debug]  String: [0x24] "---------------------------- AC _STA"
 .......................
 49 Devices found containing: 49 _STA, 2 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
-nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
-nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
-nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
-nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
+nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
+nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
+nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
+nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname is relative
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
+ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
+[ACPI Debug]  String: [0x24] "---------------------------- AC _STA"
 Boot video device is 0000:01:00.0
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
@@ -87,8 +90,8 @@
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 12 14 15)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 11 12 14 15) *10
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
-[ACPI Debug] String: [0x24] "---------------------------- AC _STA"
-[ACPI Debug] String: [0x24] "---------------------------- AC _STA"
+[ACPI Debug]  String: [0x24] "---------------------------- AC _STA"
+[ACPI Debug]  String: [0x24] "---------------------------- AC _STA"
 ACPI: Embedded Controller [EC] (gpe 1)
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
@@ -97,17 +100,21 @@
   MEM window: d0100000-d01fffff
   PREFETCH window: d8000000-dfffffff
 PCI: Bus 2, cardbus bridge: 0000:00:0a.0
-  IO window: 00003000-000030ff
-  IO window: 00003400-000034ff
+  IO window: 00003000-00003fff
+  IO window: 00004000-00004fff
   PREFETCH window: 20000000-21ffffff
   MEM window: 22000000-23ffffff
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 PCI: Setting latency timer of device 0000:00:01.0 to 64
 ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 16
 IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
-ACPI: Power Button (FF) [PWRF]
+evxfevnt-0203 [07] acpi_enable_event     : Could not enable power_button event
+ evxface-0157 [06] acpi_install_fixed_eve: Could not enable fixed event.
+acpi_button-0224 [05] acpi_button_add       : Error installing notify handler
+ACPI: Power Button (CM) [PWRB]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Lid Switch [LID]
-ACPI: CPU0 (power states: C1[C1] C2[C2])
+ACPI: CPU0 (power states: C1[C1])
 Real Time Clock Driver v1.12
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
@@ -157,13 +164,17 @@
 ACPI wakeup devices: 
 SLPB  LID PCI0 PS2K USB1 USB2 USB3 Z00A CRD0 NICD 
 ACPI: (supports S0 S3 S4 S5)
+evxfevnt-0203 [02] acpi_enable_event     : Could not enable real_time_clock event
+ evxface-0157 [01] acpi_install_fixed_eve: Could not enable fixed event.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 128k freed
+ evevent-0299: *** Error: No installed handler for fixed event [00000000]
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
+ acpi_ec-0217 [20] acpi_ec_leave_burst_mo: ------->status fail
 ACPI: PCI Interrupt Link [ALKB] disabled and referenced, BIOS bug.
 ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 23
 ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 23
@@ -171,9 +182,11 @@
 PCI: Via IRQ fixup for 0000:00:12.0, from 9 to 1
 eth0: VIA Rhine II at 0x11800, 00:03:25:10:dc:69, IRQ 17.
 eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
+ evevent-0299: *** Error: No installed handler for fixed event [00000000]
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected AGP bridge 0
 agpgart: AGP aperture is 256M @ 0xe0000000
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [ALKD] disabled and referenced, BIOS bug.
 ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 21
 ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 21
@@ -186,6 +199,7 @@
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 6 ports detected
 USB Universal Host Controller Interface driver v2.3
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 18
 PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 2
 uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
@@ -193,6 +207,7 @@
 uhci_hcd 0000:00:10.0: irq 18, io base 0x00001c80
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 18
 PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 2
 uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
@@ -200,6 +215,7 @@
 uhci_hcd 0000:00:10.1: irq 18, io base 0x00001ca0
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 18
 PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 2
 uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
@@ -207,21 +223,21 @@
 uhci_hcd 0000:00:10.2: irq 18, io base 0x00001cc0
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
+usb 2-1: new low speed USB device using uhci_hcd and address 2
+input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:10.0-1
+usbcore: registered new driver usbhid
+drivers/usb/input/hid-core.c: v2.01:USB HID core driver
 SCSI subsystem initialized
 ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
 scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: TOSHIBA   Model: ODD-DVD SD-R6372  Rev: 1030
   Type:   CD-ROM                             ANSI SCSI revision: 02
-usb 2-1: new low speed USB device using uhci_hcd and address 2
 Initializing USB Mass Storage driver...
+usbcore: registered new driver usb-storage
+USB Mass Storage support registered.
 sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
 Uniform CD-ROM driver Revision: 3.20
 Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
-usbcore: registered new driver usb-storage
-USB Mass Storage support registered.
-input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:10.0-1
-usbcore: registered new driver usbhid
-drivers/usb/input/hid-core.c: v2.01:USB HID core driver
 EXT3 FS on hda7, internal journal
 kjournald starting.  Commit interval 5 seconds
 EXT3 FS on hda3, internal journal
