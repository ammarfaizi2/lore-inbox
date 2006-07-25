Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGYUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGYUEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWGYUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:04:21 -0400
Received: from math.ut.ee ([193.40.36.2]:52977 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S964848AbWGYUEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:04:20 -0400
Date: Tue, 25 Jul 2006 23:04:16 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Kristen Accardi <kristen.kml@gmail.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: yenta irq disabled on IBM X20 with dock
In-Reply-To: <512afbf90607251133ob56f706oc3f39a0198e52f2a@mail.gmail.com>
Message-ID: <Pine.SOC.4.61.0607252302340.10774@math.ut.ee>
References: <Pine.SOC.4.61.0607240016590.26491@math.ut.ee>
 <512afbf90607251133ob56f706oc3f39a0198e52f2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you mind seeing if you have the same problem with 2.6.16?

Yes, seems the same. Here is the excerpt of dmesg with some context:

ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:08.0 [1014:0185]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:08.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:08.1 [1014:0185]
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:02.0 [1014:0148]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:02.0, mfunc 0x00001002, devctl 0x66
irq 11: nobody cared (try booting with the "irqpoll" option)
  [<b012f12f>] __report_bad_irq+0x2b/0x69
  [<b012f2e3>] note_interrupt+0x176/0x1a7
  [<b012ed4b>] handle_IRQ_event+0x20/0x4c
  [<b012eddc>] __do_IRQ+0x65/0x91
  [<b0104a1b>] do_IRQ+0x1d/0x2a
  [<b010335a>] common_interrupt+0x1a/0x20
  [<b012ed40>] handle_IRQ_event+0x15/0x4c
  [<b012edca>] __do_IRQ+0x53/0x91
  [<b0104a1b>] do_IRQ+0x1d/0x2a
  [<b010335a>] common_interrupt+0x1a/0x20
  [<b888c925>] yenta_probe_cb_irq+0x83/0xcf [yenta_socket]
  [<b888caa5>] ti12xx_override+0x134/0x4e8 [yenta_socket]
  [<b888c5a6>] yenta_probe+0x2a9/0x499 [yenta_socket]
  [<b01a974c>] pci_device_probe+0x38/0x59
  [<b01f94f6>] driver_probe_device+0x42/0x8c
  [<b01f9597>] __driver_attach+0x0/0x5c
  [<b01f95ce>] __driver_attach+0x37/0x5c
  [<b01f8c67>] bus_for_each_dev+0x46/0x6c
  [<b01f93f0>] driver_attach+0x14/0x18
  [<b01f9597>] __driver_attach+0x0/0x5c
  [<b01f8f20>] bus_add_driver+0x5b/0xe6
  [<b01a93f3>] __pci_register_driver+0x5e/0x82
  [<b883a00f>] yenta_socket_init+0xf/0x12 [yenta_socket]
  [<b012962e>] sys_init_module+0x1369/0x143f
  [<b0137355>] vma_prio_tree_insert+0x1a/0x35
  [<b013ada5>] vma_link+0x85/0x8d
  [<b013c670>] do_mmap_pgoff+0x4ec/0x646
  [<b01068c6>] sys_mmap2+0x60/0x8f
  [<b01028bb>] sysenter_past_esp+0x54/0x75
handlers:
[<b8896b5b>] (usb_hcd_irq+0x0/0x54 [usbcore])
[<b888bdee>] (yenta_interrupt+0x0/0xb5 [yenta_socket])
[<b888bdee>] (yenta_interrupt+0x0/0xb5 [yenta_socket])
Disabling IRQ #11
Yenta: ISA IRQ mask 0x0438, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
pcmcia: parent PCI bridge Memory window: 0x14000000 - 0x17ffffff
ACPI: PCI Interrupt 0000:02:02.1[A] -> Link [LNKC] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:02.1 [1014:0148]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:02.1, mfunc 0x00001002, devctl 0x66
Yenta: ISA IRQ mask 0x0438, PCI irq 9
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x4000 - 0x4fff
cs: IO port probe 0x4000-0x4fff: clean.
pcmcia: parent PCI bridge Memory window: 0x10000000 - 0x13ffffff
pcmcia: parent PCI bridge Memory window: 0x14000000 - 0x17ffffff
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11

-- 
Meelis Roos (mroos@linux.ee)
