Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbUDMQlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMQlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:41:18 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:44266 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263376AbUDMQlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:41:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI MSI Kconfig consolidation
Date: Tue, 13 Apr 2004 10:41:06 -0600
User-Agent: KMail/1.6.1
Cc: linux-ia64@vger.kernel.org, tom.l.nguyen@intel.com,
       Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131041.06275.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidates the PCI MSI configuration into drivers/pci/Kconfig,
removing it from the i386, x86_64, and ia64 Kconfig.

It also changes the default for ia64 from "y" to "n".  The default on
i386 is "n" already, and I'm not sure why ia64 should be different.

===== arch/i386/Kconfig 1.116 vs edited =====
--- 1.116/arch/i386/Kconfig	Mon Apr 12 11:54:45 2004
+++ edited/arch/i386/Kconfig	Tue Apr 13 10:26:55 2004
@@ -1095,25 +1095,6 @@
 	select ACPI_BOOT
 	default y
 
-config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing (MSI)"
-	depends on X86_LOCAL_APIC && X86_IO_APIC
-	default n
-	help
-	   This replaces the current existing IRQ-based index interrupt scheme
-	   with the vector-base index scheme. The advantages of vector base
-	   over IRQ base are listed below:
-	   1) Support MSI implementation.
-	   2) Support future IOxAPIC hotplug
-
-	   Note that this allows the device drivers to enable MSI, Message
-	   Signaled Interrupt, on all MSI capable device functions detected.
-	   Message Signal Interrupt enables an MSI-capable hardware device to
-	   send an inbound Memory Write on its PCI bus instead of asserting
-	   IRQ signal on device IRQ pin.
-
-	   If you don't know what to do here, say N.
-
 source "drivers/pci/Kconfig"
 
 config ISA
===== arch/ia64/Kconfig 1.69 vs edited =====
--- 1.69/arch/ia64/Kconfig	Mon Apr 12 19:50:46 2004
+++ edited/arch/ia64/Kconfig	Tue Apr 13 10:30:55 2004
@@ -361,16 +361,6 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
-config PCI_USE_VECTOR
-	bool
-	default y if IA64
-	help
-	   This enables MSI, Message Signaled Interrupt, on specific
-	   MSI capable device functions detected upon requests from the
-	   device drivers. Message Signal Interrupt enables an MSI-capable
-	   hardware device to send an inbound Memory Write on its PCI bus
-	   instead of asserting IRQ signal on device IRQ pin.
-
 config PCI_DOMAINS
 	bool
 	default PCI
===== arch/x86_64/Kconfig 1.47 vs edited =====
--- 1.47/arch/x86_64/Kconfig	Mon Apr 12 11:53:56 2004
+++ edited/arch/x86_64/Kconfig	Tue Apr 13 10:29:09 2004
@@ -336,26 +336,6 @@
 	depends on PCI
 	select ACPI_BOOT
 
-# the drivers/pci/msi.c code needs to be fixed first before enabling
-config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing"
-	depends on X86_LOCAL_APIC && NOTWORKING
-	default n
-	help
-	   This replaces the current existing IRQ-based index interrupt scheme
-	   with the vector-base index scheme. The advantages of vector base
-	   over IRQ base are listed below:
-	   1) Support MSI implementation.
-	   2) Support future IOxAPIC hotplug
-
-	   Note that this enables MSI, Message Signaled Interrupt, on all
-	   MSI capable device functions detected if users also install the
-	   MSI patch. Message Signal Interrupt enables an MSI-capable
-	   hardware device to send an inbound Memory Write on its PCI bus
-	   instead of asserting IRQ signal on device IRQ pin.
-
-	   If you don't know what to do here, say N.
-
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
===== drivers/pci/Kconfig 1.3 vs edited =====
--- 1.3/drivers/pci/Kconfig	Thu Jan  9 17:14:51 2003
+++ edited/drivers/pci/Kconfig	Tue Apr 13 10:30:17 2004
@@ -1,6 +1,25 @@
 #
 # PCI configuration
 #
+config PCI_USE_VECTOR
+	bool "Vector-based interrupt indexing (MSI)"
+	depends on (X86_LOCAL_APIC && X86_IO_APIC && !X86_64) || IA64
+	default n
+	help
+	   This replaces the current existing IRQ-based index interrupt scheme
+	   with the vector-base index scheme. The advantages of vector base
+	   over IRQ base are listed below:
+	   1) Support MSI implementation.
+	   2) Support future IOxAPIC hotplug
+
+	   Note that this allows the device drivers to enable MSI, Message
+	   Signaled Interrupt, on all MSI capable device functions detected.
+	   Message Signal Interrupt enables an MSI-capable hardware device to
+	   send an inbound Memory Write on its PCI bus instead of asserting
+	   IRQ signal on device IRQ pin.
+
+	   If you don't know what to do here, say N.
+
 config PCI_LEGACY_PROC
 	bool "Legacy /proc/pci interface"
 	depends on PCI
