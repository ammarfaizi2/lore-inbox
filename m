Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVIOOVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVIOOVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVIOOVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:21:08 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:46751 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S965228AbVIOOVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:21:07 -0400
Date: Thu, 15 Sep 2005 16:21:34 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: jan@kcore.org
Subject: Re: ACPI S3 and ieee1394 don't get along
Message-ID: <20050915142134.GD2428@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found, that if you insert module ohci1394 before S3, than everything is ok
after resume.

Next, if you do not do that, then after resume modprobe ohci1394 fails:
(I added dump_stack() to see what happened)
 ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
 ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 16 (level, low) -> IRQ 16
 ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
  [pg0+526438805/1069020160] set_phy_reg+0xc5/0xe0 [ohci1394]
  [pg0+526440116/1069020160] ohci_initialize+0xb4/0x330 [ohci1394]
  [pg0+526449792/1069020160] ohci_irq_handler+0x0/0x850 [ohci1394]
  [request_irq+142/192] request_irq+0x8e/0xc0
  [pg0+526457413/1069020160] ohci1394_pci_probe+0x455/0x6b0 [ohci1394]
  [pg0+526449792/1069020160] ohci_irq_handler+0x0/0x850 [ohci1394]
  [__pci_device_probe+95/112] __pci_device_probe+0x5f/0x70
  [pci_device_probe+47/96] pci_device_probe+0x2f/0x60
  [driver_probe_device+56/208] driver_probe_device+0x38/0xd0
  [__driver_attach+0/80] __driver_attach+0x0/0x50
  [__driver_attach+65/80] __driver_attach+0x41/0x50
  [bus_for_each_dev+93/128] bus_for_each_dev+0x5d/0x80
  [driver_attach+37/48] driver_attach+0x25/0x30
  [__driver_attach+0/80] __driver_attach+0x0/0x50
  [bus_add_driver+132/240] bus_add_driver+0x84/0xf0
  [pci_register_driver+109/128] pci_register_driver+0x6d/0x80
  [pg0+524607503/1069020160] ohci1394_init+0xf/0x11 [ohci1394]
  [sys_init_module+330/512] sys_init_module+0x14a/0x200
  [syscall_call+7/11] syscall_call+0x7/0xb
 ohci1394: fw-host0: Runaway loop while stopping context: ...

However, module is loaded but nonfunctional. BUT if you do S3 again, then after 
resume module can be unloaded and next modprobe ohci1394 is now working! (Tested
right now.)

-- 
Luká¹ Hejtmánek
