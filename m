Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVF3TTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVF3TTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVF3TTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:19:00 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:5559 "EHLO mail1.w2cog.org")
	by vger.kernel.org with ESMTP id S262971AbVF3TR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:17:57 -0400
Date: Thu, 30 Jun 2005 14:17:48 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.12.1 gives panic with ata_piix (irq 11: nobody cared!)
Message-ID: <Pine.LNX.4.62.0506301406280.8723@hammer.psislidell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I attempt to load the "ata_piix" module under a stock 2.6.12.1 kernel 
I get a panic message (see below)


On my screen:

root@psi-sli-bk:/lib/modules/2.6.12.1/kernel/drivers/scsi# modprobe ata_piix


Message from syslogd@psi-sli-bk at Thu Jun 30 08:24:18 2005 ...
psi-sli-bk kernel: Disabling IRQ #11




Partial dmesg output:

ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x20C8 ctl 0x20EE bmdma 0x20A0 irq 11
ata2: SATA max UDMA/133 cmd 0x20C0 ctl 0x20EA bmdma 0x20A8 irq 11
irq 11: nobody cared!
  [<c0131972>] __report_bad_irq+0x22/0x90
  [<c0131a68>] note_interrupt+0x58/0x90
  [<c01315f8>] __do_IRQ+0xb8/0xc0
  [<c010473a>] do_IRQ+0x1a/0x30
  [<c010307a>] common_interrupt+0x1a/0x20
  [<c01314ec>] handle_IRQ_event+0x1c/0x70
  [<c01315c5>] __do_IRQ+0x85/0xc0
  [<c010473a>] do_IRQ+0x1a/0x30
  [<c010307a>] common_interrupt+0x1a/0x20
  [<c011b700>] __do_softirq+0x30/0x90
  [<c011b795>] do_softirq+0x35/0x40
  [<c010473f>] do_IRQ+0x1f/0x30
  [<c010307a>] common_interrupt+0x1a/0x20
  [<f8953a26>] ata_std_dev_select+0x36/0x50 [libata]
  [<f89537c6>] ata_pio_devchk+0x16/0x70 [libata]
  [<f8954968>] ata_bus_reset+0x1d8/0x200 [libata]
  [<f8953f87>] ata_bus_probe+0x17/0xb0 [libata]
  [<f89568a0>] ata_device_add+0x190/0x220 [libata]
  [<f8956d08>] ata_pci_init_one+0x128/0x2f0 [libata]
  [<c0197e30>] pci_bus_read_config_word+0x30/0x50
  [<f894665a>] pci_enable_intx+0x1a/0x60 [ata_piix]
  [<f89467ab>] piix_init_one+0x8b/0x190 [ata_piix]
  [<c019b762>] pci_device_probe_static+0x32/0x50
  [<c019b7a7>] __pci_device_probe+0x27/0x40
  [<c019b7dc>] pci_device_probe+0x1c/0x40
  [<c01ffbc4>] driver_probe_device+0x24/0x80
  [<c01ffd17>] driver_attach+0x57/0x90
  [<c020019b>] bus_add_driver+0x7b/0xb0
  [<c02006e3>] driver_register+0x23/0x30
  [<c019ba20>] pci_register_driver+0x60/0x80
  [<f880400a>] piix_init+0xa/0x1c [ata_piix]
  [<c012efc2>] sys_init_module+0x122/0x1b0
  [<c0102e09>] syscall_call+0x7/0xb
handlers:
[<c02552e0>] (usb_hcd_irq+0x0/0x60)
[<c02552e0>] (usb_hcd_irq+0x0/0x60)
[<c02552e0>] (usb_hcd_irq+0x0/0x60)
[<f8956230>] (ata_interrupt+0x0/0x100 [libata])
Disabling IRQ #11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 1 ATA, max UDMA/133, 490234752 sectors: lba48


lspci output:
00:00.0 Host bridge: Intel Corp.: Unknown device 2580 (rev 04)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2582 (rev 
04)
00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 03)
00:1c.0 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 0 (rev 
03)
00:1c.1 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 1 (rev 
03)
00:1c.2 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 2 (rev 
03)
00:1c.3 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 3 (rev 
03)
00:1d.0 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.1 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.2 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.3 USB Controller: Intel Corp. I/O Controller Hub USB (rev 03)
00:1d.7 USB Controller: Intel Corp. I/O Controller Hub USB2 (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corp. I/O Controller Hub LPC (rev 03)
00:1f.1 IDE interface: Intel Corp. I/O Controller Hub PATA (rev 03)
00:1f.2 IDE interface: Intel Corp. I/O Controller Hub SATA cc=ide (rev 03)
00:1f.3 SMBus: Intel Corp. I/O Controller Hub SMBus (rev 03)
02:00.0 Ethernet controller: Marvell: Unknown device 4361 (rev 17)
05:05.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)


lspci -n
00:00.0 Class 0600: 8086:2580 (rev 04)
00:02.0 Class 0300: 8086:2582 (rev 04)
00:1b.0 Class 0403: 8086:2668 (rev 03)
00:1c.0 Class 0604: 8086:2660 (rev 03)
00:1c.1 Class 0604: 8086:2662 (rev 03)
00:1c.2 Class 0604: 8086:2664 (rev 03)
00:1c.3 Class 0604: 8086:2666 (rev 03)
00:1d.0 Class 0c03: 8086:2658 (rev 03)
00:1d.1 Class 0c03: 8086:2659 (rev 03)
00:1d.2 Class 0c03: 8086:265a (rev 03)
00:1d.3 Class 0c03: 8086:265b (rev 03)
00:1d.7 Class 0c03: 8086:265c (rev 03)
00:1e.0 Class 0604: 8086:244e (rev d3)
00:1f.0 Class 0601: 8086:2640 (rev 03)
00:1f.1 Class 0101: 8086:266f (rev 03)
00:1f.2 Class 0101: 8086:2651 (rev 03)
00:1f.3 Class 0c05: 8086:266a (rev 03)
02:00.0 Class 0200: 11ab:4361 (rev 17)
05:05.0 Class 0c00: 11c1:5811 (rev 61)


Contents of /proc/interrupts
            CPU0
   0:   13181886          XT-PIC  timer
   1:       4106          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
   9:      26913          XT-PIC  acpi, ohci1394, eth0
  10:          1          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb2
  11:     100000          XT-PIC  uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5, libata
  14:       4695          XT-PIC  ide0
NMI:          0
ERR:          0


I tried removing the USB drivers which seem to share the IRQ, but with no 
change (though the panic changed slightly)

libata version 1.11 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x20C8 ctl 0x20EE bmdma 0x20A0 irq 11
ata2: SATA max UDMA/133 cmd 0x20C0 ctl 0x20EA bmdma 0x20A8 irq 11
irq 11: nobody cared!
  [<c0131972>] __report_bad_irq+0x22/0x90
  [<c0131a68>] note_interrupt+0x58/0x90
  [<c01315f8>] __do_IRQ+0xb8/0xc0
  [<c010473a>] do_IRQ+0x1a/0x30
  [<c010307a>] common_interrupt+0x1a/0x20
  [<c011b700>] __do_softirq+0x30/0x90
  [<c011b795>] do_softirq+0x35/0x40
  [<c010473f>] do_IRQ+0x1f/0x30
  [<c010307a>] common_interrupt+0x1a/0x20
  [<f8b01a26>] ata_std_dev_select+0x36/0x50 [libata]
  [<f8b017c6>] ata_pio_devchk+0x16/0x70 [libata]
  [<f8b02968>] ata_bus_reset+0x1d8/0x200 [libata]
  [<f8b01f87>] ata_bus_probe+0x17/0xb0 [libata]
  [<f8b048a0>] ata_device_add+0x190/0x220 [libata]
  [<f8b04d08>] ata_pci_init_one+0x128/0x2f0 [libata]
  [<c0197e30>] pci_bus_read_config_word+0x30/0x50
  [<f89a965a>] pci_enable_intx+0x1a/0x60 [ata_piix]
  [<f89a97ab>] piix_init_one+0x8b/0x190 [ata_piix]
  [<c019b762>] pci_device_probe_static+0x32/0x50
  [<c019b7a7>] __pci_device_probe+0x27/0x40
  [<c019b7dc>] pci_device_probe+0x1c/0x40
  [<c01ffbc4>] driver_probe_device+0x24/0x80
  [<c01ffd17>] driver_attach+0x57/0x90
  [<c020019b>] bus_add_driver+0x7b/0xb0
  [<c02006e3>] driver_register+0x23/0x30
  [<c019ba20>] pci_register_driver+0x60/0x80
  [<f880400a>] piix_init+0xa/0x1c [ata_piix]
  [<c012efc2>] sys_init_module+0x122/0x1b0
  [<c0102e09>] syscall_call+0x7/0xb
handlers:
[<f8b04230>] (ata_interrupt+0x0/0x100 [libata])
Disabling IRQ #11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 1 ATA, max UDMA/133, 490234752 sectors: lba48

root@psi-sli-bk:~# cat /proc/interrupts
            CPU0
   0:     236151          XT-PIC  timer
   1:          8          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
   9:       1565          XT-PIC  acpi, eth0, ohci1394
  11:     100000          XT-PIC  libata
  14:       1703          XT-PIC  ide0
NMI:          0
ERR:          0



Any ideas ?


 	Roy Keene
 	Planning Systems Inc.
