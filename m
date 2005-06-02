Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFBIZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFBIZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFBIYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:24:09 -0400
Received: from smtp2.rz.uni-karlsruhe.de ([129.13.185.218]:22408 "EHLO
	smtp2.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S261248AbVFBISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:18:32 -0400
Subject: IRQ problems with 915gm chipset
From: Tilo Lutz <TiloLutz@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 02 Jun 2005 10:18:09 +0200
Message-Id: <1117700289.7865.3.camel@Notebook.stud.uni-karlsruhe.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have some problems getting linux work on my
Acer Travelmat 3002 notebook. I run Suse Linux 9.3
with linux 2.6.11.4

Floppy is not present therefore irq6 is free.
com1 and lpt1 are disabled -> irq4 and 7 are free for pci

I get best results with
1. pci=noacpi
2. acpi_irq_balance acpi_irq_pci=5,4,7,10
Disabling acpi completly makes it worse both times.
With apic bootup locks and the screen is blank as
soon as the kernel is loaded.
I also tried the current kernel 2.6.12rc5 with no result.

Not working devices with result1:
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
This device should be connected with [LNKE].
Bios did not assing an irq for this link. The driver fails to load
because
no irq is provided.
pci=biosirq don't help.

Not working devices with result2:
0000:06:07.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:06:07.2 FireWire (IEEE 1394): Texas Instruments: Unknown device
8032
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #2 (rev 04)
All not working devices are connected with irq11.
PCI Interrupt Link [LNKF] and [LNKG] were not used during bootup.
Is that OK?

How can I get everything work?
I think result1 is the better way to start because more devices are
working.
Does anyone have an idea how I can get everything work.

Sound would be nice but I also need ieee1394 for my cdrom.

Regards, Tilo Lutz

Notebook:/home/tilo # cat /proc/interrupts #result1
           CPU0
  0:     152849          XT-PIC  timer
  1:        171          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:        605          XT-PIC  acpi
10:       1182          XT-PIC  uhci_hcd, ipw2200, eth0
11:          3          XT-PIC  ohci1394, uhci_hcd, uhci_hcd, uhci_hcd,
ehci_hcd, yenta
12:      11793          XT-PIC  i8042
14:      12606          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

Notebook:/home/tilo # cat /proc/interrupts #result2:
           CPU0
  0:    2415737          XT-PIC  timer
  1:       6083          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  uhci_hcd, ehci_hcd
  7:     100000          XT-PIC  uhci_hcd
  8:          2          XT-PIC  rtc
  9:       7792          XT-PIC  acpi
10:      32472          XT-PIC  uhci_hcd, HDA Intel, eth0
11:     100000          XT-PIC  ohci1394, uhci_hcd, yenta
12:     308415          XT-PIC  i8042
14:      22665          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

part of dmesg, result1:
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Please try
using pci=biosirq.
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pcie_portdrv_probe->Dev[2660:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Please try
using pci=biosirq.
PCI: Setting latency timer of device 0000:00:1c.1 to 64
pcie_portdrv_probe->Dev[2662:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. Please try
using pci=biosirq.
PCI: Setting latency timer of device 0000:00:1c.2 to 64
pcie_portdrv_probe->Dev[2664:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
[...]
PCI: No IRQ known for interrupt pin A of device 0000:00:1b.0. Please try
using pci=biosirq.
ALSA /tmp/alsa/alsa-driver/alsa-kernel/pci/hda/hda_intel.c:1332:
hda-intel: unable to grab IRQ 0
HDA Intel: probe of 0000:00:1b.0 failed with error -16


part of dmesg, result2:
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
[...]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1c.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1c.1[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI interrupt 0000:00:1c.2[C] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
[...]
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
[...]
ieee1394: Initialized config rom entry `ip1394'
ieee1394: raw1394: /dev/raw1394 device initialized
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
    ACPI-0367: *** Warning: Unable to derive IRQ for device 0000:06:07.2
ACPI: PCI interrupt 0000:06:07.2[A]: no GSI - using IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]
MMIO=[b0117000-b01177ff]  Max Packet=[2048]
[...]
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 5 (level, low) -> IRQ 5
[...]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
[...]
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
[...]
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
irq 7: nobody cared!
[<c0134fdc>] __report_bad_irq+0x1c/0x70
[<c01350bb>] note_interrupt+0x5b/0x80
[<c0134c7b>] __do_IRQ+0xdb/0xf0
[<c0105288>] do_IRQ+0x38/0x60
[<c0103cba>] common_interrupt+0x1a/0x20
[<c011007b>] acpi_copy_wakeup_routine+0x1b/0xa0
[<c0134b59>] handle_IRQ_event+0x29/0x70
[<c0134c33>] __do_IRQ+0x93/0xf0
[<c0105288>] do_IRQ+0x38/0x60
[<c0103cba>] common_interrupt+0x1a/0x20
[<c013007b>] __pm_unregister+0x2b/0x40
[<c011e171>] __do_softirq+0x31/0xa0
[<c011e206>] do_softirq+0x26/0x30
[<c010528d>] do_IRQ+0x3d/0x60
[<c0103cba>] common_interrupt+0x1a/0x20
[<c0134e59>] setup_irq+0x89/0xd0
[<e0716d00>] usb_hcd_irq+0x0/0x60 [usbcore]
[<c0134fa1>] request_irq+0x71/0x90
[<e071a5fa>] usb_hcd_pci_probe+0x1aa/0x450 [usbcore]
[<c01dafa2>] pci_device_probe_static+0x32/0x50
[<c01dafe7>] __pci_device_probe+0x27/0x40
[<c01db01b>] pci_device_probe+0x1b/0x40
[<c0234fd1>] driver_probe_device+0x21/0x60
[<c02350fd>] driver_attach+0x4d/0x80
[<c023551d>] bus_add_driver+0x6d/0xa0
[<c0235a18>] driver_register+0x28/0x30
[<c01db1d9>] pci_register_driver+0x49/0x60
[<e0040087>] uhci_hcd_init+0x87/0xd7 [uhci_hcd]
[<c012e9a4>] sys_init_module+0x104/0x180
[<c0102c49>] sysenter_past_esp+0x52/0x79
handlers:
[<e0716d00>] (usb_hcd_irq+0x0/0x60 [usbcore])
Disabling IRQ #7
uhci_hcd 0000:00:1d.2: irq 7, io base 0x1860
[...]
ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 10 (level, low) -> IRQ 10
[...]
ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 5 (level, low) -> IRQ 5
[...]
    ACPI-0367: *** Warning: Unable to derive IRQ for device 0000:06:06.0
ACPI: PCI interrupt 0000:06:06.0[A]: no GSI - using IRQ 10
[...]
ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 10 (level, low) -> IRQ 10
[...]
ACPI: PCI interrupt 0000:06:07.0[A]: no GSI - using IRQ 11
[...]
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:06:08.0[A] -> GSI 10 (level, low) -> IRQ 10
[...]
irq 11: nobody cared!
[<c0134fdc>] __report_bad_irq+0x1c/0x70
[<c01350bb>] note_interrupt+0x5b/0x80
[<c0134c7b>] __do_IRQ+0xdb/0xf0
[<c0105288>] do_IRQ+0x38/0x60
[<c0103cba>] common_interrupt+0x1a/0x20
[<c013007b>] __pm_unregister+0x2b/0x40
[<c011e171>] __do_softirq+0x31/0xa0
[<c011e206>] do_softirq+0x26/0x30
[<c010528d>] do_IRQ+0x3d/0x60
[<c0103cba>] common_interrupt+0x1a/0x20
handlers:
[<e0694480>] (ohci_irq_handler+0x0/0x640 [ohci1394])
[<e0716d00>] (usb_hcd_irq+0x0/0x60 [usbcore])
[<e07af7a0>] (yenta_interrupt+0x0/0x30 [yenta_socket])
Disabling IRQ #11


lspci:
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
0000:00:02.1 Display controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 04)
0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 2 (rev 04)
0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 3 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
d4)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC
Interface Bridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) IDE Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) SMBus Controller (rev 04)
0000:06:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
Gigabit Ethernet (rev 03)
0000:06:07.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:06:07.2 FireWire (IEEE 1394): Texas Instruments: Unknown device
8032
0000:06:07.3 Unknown mass storage controller: Texas Instruments: Unknown
device 8033
0000:06:08.0 Network controller: Intel Corporation PRO/Wireless 2200BG
(rev 05)


