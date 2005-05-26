Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVEZUzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEZUzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVEZUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:52:58 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:41699 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261758AbVEZUwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:52:10 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: quirk_via_irqpic() must not be __devinit for S1
From: Alexander Nyberg <alexn@telia.com>
To: akpm@osdl.org, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 26 May 2005 21:43:52 +0200
Message-Id: <1117136632.6564.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

Got this testing echo 1 > /proc/acpi/sleep on a box 2.6.12-rc5-mm1. 
Reference to discarded function, patch at bottom. Works nice otherwise :-)

EIP is at quirk_via_irqpic+0x1/0xc0
 [<c010414f>] show_stack+0x7f/0xa0
 [<c01042e6>] show_registers+0x156/0x1c0
 [<c01044e0>] die+0xf0/0x1a0
 [<c010463e>] do_trap+0xae/0xb0
 [<c0104791>] do_int3+0x81/0x90
 [<c0103f1a>] int3+0x1e/0x24
 [<c01b7713>] pci_fixup_device+0x43/0x70
 [<c01b6eb5>] pci_enable_device+0x35/0x40
 [<c01b79ba>] pci_default_resume+0x3a/0x50
 [<c01b79f2>] pci_device_resume+0x22/0x30
 [<c0200a26>] resume_device+0xa6/0xb0
 [<c0200ad8>] dpm_resume+0xa8/0xb0
 [<c0200af4>] device_resume+0x14/0x30
 [<c0131eeb>] suspend_finish+0xb/0x40
 [<c0131fa5>] enter_state+0x85/0xb0
 [<c013200e>] pm_suspend+0x1e/0x30
 [<c01d318e>] acpi_suspend+0x2e/0x3c
 [<c01d3286>] acpi_system_write_sleep+0x73/0x86
 [<c0155ac5>] vfs_write+0xa5/0x170
 [<c0155c5b>] sys_write+0x4b/0x80
 [<c01032e9>] syscall_call+0x7/0xb

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: akpm/drivers/pci/quirks.c
===================================================================
--- akpm.orig/drivers/pci/quirks.c	2005-05-26 12:52:03.000000000 +0200
+++ akpm/drivers/pci/quirks.c	2005-05-26 21:35:08.000000000 +0200
@@ -499,7 +499,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 


