Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJ2Wgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTJ2Wgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:36:53 -0500
Received: from docsis106-17.menta.net ([62.57.106.17]:48261 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261705AbTJ2Wgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:36:50 -0500
Date: Wed, 29 Oct 2003 23:36:49 +0100 (CET)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: irq 11: nobody cared! and immediate oops in 2.6.0test9
Message-ID: <Pine.LNX.4.44.0310292335170.4541-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I boot (with acpi=off because otherwise the laptop hangs) I get this 
oops:

Oct 29 19:05:33 pau kernel: drivers/usb/core/usb.c: registered new driver 
usbfs
Oct 29 19:05:33 pau kernel: drivers/usb/core/usb.c: registered new driver 
hub
Oct 29 19:05:33 pau kernel: PCI: IRQ 0 for device 0000:00:10.3 doesn't 
match PIRQ mask - try pci=usepirqmask
Oct 29 19:05:33 pau kernel: PCI: No IRQ known for interrupt pin D of 
device 0000:00:10.3. Please try using pci=biosirq.
Oct 29 19:05:33 pau kernel: drivers/usb/core/hcd-pci.c: Found HC with no 
IRQ.  Check BIOS/PCI 0000:00:10.3 setup!
Oct 29 19:05:33 pau kernel: drivers/usb/host/uhci-hcd.c: USB Universal 
Host Controller Interface driver v2.1
Oct 29 19:05:33 pau kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Oct 29 19:05:33 pau kernel: irq 11: nobody cared!
Oct 29 19:05:33 pau kernel: Call Trace:
Oct 29 19:05:33 pau kernel:  [<c010d80a>] __report_bad_irq+0x2a/0x90
Oct 29 19:05:33 pau kernel:  [<c010d8fc>] note_interrupt+0x6c/0xa0
Oct 29 19:05:33 pau kernel:  [<c010dbdb>] do_IRQ+0x12b/0x140
Oct 29 19:05:33 pau kernel:  [<c010be24>] common_interrupt+0x18/0x20
Oct 29 19:05:33 pau kernel:  [<c0125fc0>] do_softirq+0x40/0xa0
Oct 29 19:05:33 pau kernel:  [<c010dbb7>] do_IRQ+0x107/0x140
Oct 29 19:05:33 pau kernel:  [<c010be24>] common_interrupt+0x18/0x20
Oct 29 19:05:33 pau kernel:  [<c010e16c>] setup_irq+0x9c/0xf0
Oct 29 19:05:33 pau kernel:  [<ee86c530>] usb_hcd_irq+0x0/0x60 [usbcore]
Oct 29 19:05:33 pau kernel:  [<c010dc98>] request_irq+0xa8/0xe0
Oct 29 19:05:33 pau kernel:  [<ee86fbdf>] usb_hcd_pci_probe+0x27f/0x4a0 
[usbcore]
Oct 29 19:05:33 pau kernel:  [<ee86c530>] usb_hcd_irq+0x0/0x60 [usbcore]
Oct 29 19:05:33 pau kernel:  [<c01ab7c2>] 
pci_device_probe_static+0x52/0x70
Oct 29 19:05:33 pau kernel:  [<c01ab81b>] __pci_device_probe+0x3b/0x50
Oct 29 19:05:33 pau kernel:  [<c01ab85c>] pci_device_probe+0x2c/0x50
Oct 29 19:05:33 pau kernel:  [<c01ec74f>] bus_match+0x3f/0x70
Oct 29 19:05:33 pau kernel:  [<c01ec879>] driver_attach+0x59/0x90
Oct 29 19:05:33 pau kernel:  [<c01ecb1d>] bus_add_driver+0x8d/0xa0
Oct 29 19:05:33 pau kernel:  [<c01ecf9f>] driver_register+0x2f/0x40
Oct 29 19:05:33 pau kernel:  [<c01aba4c>] pci_register_driver+0x5c/0x90
Oct 29 19:05:33 pau kernel:  [<ee8000e2>] uhci_hcd_init+0xe2/0x144 
[uhci_hcd]
Oct 29 19:05:33 pau kernel:  [<c0138e5c>] sys_init_module+0x12c/0x250
Oct 29 19:05:33 pau kernel:  [<c010b465>] sysenter_past_esp+0x52/0x71
Oct 29 19:05:33 pau kernel: 
Oct 29 19:05:33 pau kernel: handlers:
Oct 29 19:05:33 pau kernel: [<ee86c530>] (usb_hcd_irq+0x0/0x60 [usbcore])
Oct 29 19:05:33 pau kernel: Disabling IRQ #11
Oct 29 19:05:33 pau kernel: uhci_hcd 0000:00:10.0: irq 11, io base 
00001200
Oct 29 19:05:33 pau kernel: uhci_hcd 0000:00:10.0: new USB bus registered, 
assigned bus number 1
Oct 29 19:05:33 pau kernel: hub 1-0:1.0: USB hub found
Oct 29 19:05:33 pau kernel: hub 1-0:1.0: 2 ports detected
Oct 29 19:05:33 pau kernel: PCI: IRQ 0 for device 0000:00:10.1 doesn't 
match PIRQ mask - try pci=usepirqmask
Oct 29 19:05:33 pau kernel: PCI: No IRQ known for interrupt pin B of 
device 0000:00:10.1. Please try using pci=biosirq.
Oct 29 19:05:33 pau kernel: drivers/usb/core/hcd-pci.c: Found HC with no 
IRQ.  Check BIOS/PCI 0000:00:10.1 setup!
Oct 29 19:05:33 pau kernel: drivers/usb/core/usb.c: registered new driver 
hid
Oct 29 19:05:33 pau kernel: drivers/usb/input/hid-core.c: v2.0:USB HID 
core driver


-- 

Pau

