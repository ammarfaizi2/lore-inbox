Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWARVRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWARVRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWARVRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:17:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30376 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161000AbWARVRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:17:32 -0500
Date: Wed, 18 Jan 2006 21:57:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc1-mm1 usb hub problems
Message-ID: <20060118205752.GA1520@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I boot -mm1 in docking station, I get problems. First is ugly
warning near yenta:

Yenta: CardBus bridge found at 0000:09:02.0 [1014:0148]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:09:02.0, mfunc 0x00001002, devctl 0x66
irq 11: nobody cared (try booting with the "irqpoll" option)
 [<c013c904>] __report_bad_irq+0x24/0x90
 [<c013c9ec>] note_interrupt+0x7c/0x1f0
 [<c013c3e3>] handle_IRQ_event+0x33/0x70
 [<c013c4ce>] __do_IRQ+0xae/0xc0
 [<c0105309>] do_IRQ+0x19/0x30
 [<c01036ca>] common_interrupt+0x1a/0x20
 [<c013c3c7>] handle_IRQ_event+0x17/0x70
 [<c013c482>] __do_IRQ+0x62/0xc0
 [<c0105309>] do_IRQ+0x19/0x30
 [<c01036ca>] common_interrupt+0x1a/0x20
 [<c03bd433>] yenta_probe_cb_irq+0x83/0xf0
 [<c03bd5cf>] ti12xx_override+0x12f/0x610
 [<c047de1a>] pci_write+0x2a/0x30
 [<c03bd224>] yenta_probe+0x4e4/0x550
 [<c025ae3b>] pci_device_probe+0x5b/0x80
 [<c03064dc>] driver_probe_device+0x4c/0xe0
 [<c030663a>] __driver_attach+0x5a/0x60
 [<c0305a6a>] bus_for_each_dev+0x3a/0x60
 [<c0306386>] driver_attach+0x16/0x20
 [<c03065e0>] __driver_attach+0x0/0x60
 [<c0305d9c>] bus_add_driver+0x7c/0x140
 [<c025a9f4>] __pci_register_driver+0x54/0x90
 [<c01002f8>] init+0x88/0x210
 [<c0100270>] init+0x0/0x210
 [<c0101005>] kernel_thread_helper+0x5/0x10
handlers:
[<c03bc6d0>] (yenta_interrupt+0x0/0xc0)
Disabling IRQ #11
Yenta: ISA IRQ mask 0x04d8, PCI irq 9
...

and then I get problems with USB hub:

...
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level,
low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably
using the wrong IRQ.
usb 1-1: device not accepting address 2, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 3
usb 1-1: device not accepting address 3, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new high speed USB device using ehci_hcd and address 5
usb 1-1: device not accepting address 5, error -110
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver
for USB modems and ISDN adapters
usbcore: registered new driver usblp
...

pavel@amd:~$ cat /proc/interrupts
           CPU0
  0:      39166          XT-PIC  timer
  1:        745          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  yenta, Intel 82801DB-ICH4
  9:        422          XT-PIC  acpi, ohci1394, yenta, yenta, uhci_hcd:usb4
 11:     100000          XT-PIC  yenta, ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, eth0
 12:       1221          XT-PIC  i8042
 14:       1700          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
pavel@amd:~$

Any ideas?
							Pavel
-- 
Thanks, Sharp!
