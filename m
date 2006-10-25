Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWJYVqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWJYVqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJYVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:46:07 -0400
Received: from toxygen.net ([213.146.59.4]:34830 "EHLO toxygen.net")
	by vger.kernel.org with ESMTP id S1750794AbWJYVqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:46:04 -0400
Message-ID: <453FDAD8.7040809@toxygen.net>
Date: Wed, 25 Oct 2006 23:44:56 +0200
From: Wojtek Kaniewski <wojtekka@toxygen.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ppc4xx: Compilation fixes for PCI-less configs
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation without PCI support for Bubinga, CPCI405 and EP405.
bios_fixup() for these boards uses functions available only with
CONFIG_PCI, so linker fails.

Signed-Off-By: Wojtek Kaniewski <wojtekka@toxygen.net>

--- linux-2.6.19-rc3.orig/arch/ppc/platforms/4xx/bubinga.c	2006-10-25 22:29:35.000000000 +0200
+++ linux-2.6.19-rc3/arch/ppc/platforms/4xx/bubinga.c	2006-10-25 23:12:09.000000000 +0200
@@ -116,6 +116,7 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI

 	unsigned int bar_response, bar;
 	/*
@@ -212,6 +213,7 @@
 	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));

 #endif
+#endif
 }

 void __init
--- linux-2.6.19-rc3.orig/arch/ppc/platforms/4xx/cpci405.c	2006-10-25 22:29:35.000000000 +0200
+++ linux-2.6.19-rc3/arch/ppc/platforms/4xx/cpci405.c	2006-10-25 22:54:55.000000000 +0200
@@ -126,6 +126,7 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;

 	/* Disable region first */
@@ -167,6 +168,7 @@
 					PCI_FUNC(hose->first_busno), bar,
 					&bar_response);
 	}
+#endif
 }

 void __init
--- linux-2.6.19-rc3.orig/arch/ppc/platforms/4xx/ep405.c	2006-10-25 22:29:35.000000000 +0200
+++ linux-2.6.19-rc3/arch/ppc/platforms/4xx/ep405.c	2006-10-25 23:01:20.000000000 +0200
@@ -68,6 +68,7 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;
 	/*
 	 * Expected PCI mapping:
@@ -130,6 +131,7 @@
 		    PCI_FUNC(hose->first_busno), bar, bar_response);
 	}
 	/* end work arround */
+#endif
 }

 void __init
