Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUKQKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUKQKdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUKQKcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:32:22 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:22673 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262042AbUKQK1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:27:18 -0500
Date: Wed, 17 Nov 2004 10:57:57 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix boot crash on VIA systems
Message-ID: <20041117095757.GA23673@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


quirk_via_irqpic cannot be __devinit because it runs at
pci_enable_device() time now.

This fixes a boot time crash on a VIA x86-64 machine.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c	2004-11-15 12:34:41.%N +0100
+++ linux/drivers/pci/quirks.c	2004-11-17 10:25:24.%N +0100
@@ -479,7 +479,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irqpic(struct pci_dev *dev)
 {
 	u8 irq, new_irq = dev->irq & 0xf;
 
