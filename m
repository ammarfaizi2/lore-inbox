Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVA2WUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVA2WUb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVA2WUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:20:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:25263 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261577AbVA2WTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:19:12 -0500
Date: Sat, 29 Jan 2005 23:19:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] Kconfig: cleanup bus options menu
Message-ID: <Pine.LNX.4.61.0501292318580.7637@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the bus options menu.
Merge the two MCA menu entries.
Remove unnecessary "default n" options.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/i386/Kconfig        |    8 ++------
 drivers/pci/Kconfig      |    2 +-
 drivers/pci/pcie/Kconfig |    2 +-
 drivers/pcmcia/Kconfig   |   11 ++++++-----
 4 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-2.6.11/drivers/pcmcia/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/pcmcia/Kconfig	2005-01-29 22:50:43.566918306 +0100
+++ linux-2.6.11/drivers/pcmcia/Kconfig	2005-01-29 22:55:48.773348778 +0100
@@ -20,9 +20,10 @@ config PCCARD
 	  To compile this driver as modules, choose M here: the
 	  module will be called pcmcia_core.
 
+if PCCARD
+
 config PCMCIA_DEBUG
 	bool "Enable PCCARD debugging"
-	depends on PCCARD != n
 	help
 	  Say Y here to enable PCMCIA subsystem debugging.  You
 	  will need to choose the debugging level either via the
@@ -41,7 +42,6 @@ config PCMCIA_DEBUG
 
 config PCMCIA
 	tristate "16-bit PCMCIA support"
-	depends on PCCARD
 	default y
 	---help---
 	   This option enables support for 16-bit PCMCIA cards. Most older
@@ -60,7 +60,7 @@ config PCMCIA
 
 config CARDBUS
 	bool "32-bit CardBus support"	
-	depends on PCCARD && PCI
+	depends on PCI
 	default y
 	---help---
 	  CardBus is a bus mastering architecture for PC-cards, which allows
@@ -77,7 +77,7 @@ comment "PC-card bridges"
 
 config YENTA
 	tristate "CardBus yenta-compatible bridge support"
-	depends on PCCARD && PCI
+	depends on PCI
 #fixme: remove dependendcy on CARDBUS
 	depends on CARDBUS
 	select PCCARD_NONSTATIC
@@ -197,6 +197,7 @@ config PCMCIA_VRC4173
 
 config PCCARD_NONSTATIC
 	tristate
-	depends on PCCARD
+
+endif	# PCCARD
 
 endmenu
Index: linux-2.6.11/drivers/pci/pcie/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/pci/pcie/Kconfig	2005-01-29 22:50:43.566918306 +0100
+++ linux-2.6.11/drivers/pci/pcie/Kconfig	2005-01-29 22:55:48.773348778 +0100
@@ -3,8 +3,8 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express support"
+	depends on PCI
 	depends on PCI_GOMMCONFIG || PCI_GOANY
-	default n
 
 	---help---
 	This automatically enables PCI Express Port Bus support. Users can
Index: linux-2.6.11/drivers/pci/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/pci/Kconfig	2005-01-29 22:50:43.566918306 +0100
+++ linux-2.6.11/drivers/pci/Kconfig	2005-01-29 22:55:48.773348778 +0100
@@ -3,8 +3,8 @@
 #
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
+	depends on PCI
 	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
-	default n
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
Index: linux-2.6.11/arch/i386/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig	2005-01-29 22:50:43.566918306 +0100
+++ linux-2.6.11/arch/i386/Kconfig	2005-01-29 22:55:48.774348606 +0100
@@ -1200,18 +1200,14 @@ config EISA
 source "drivers/eisa/Kconfig"
 
 config MCA
-	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	bool "MCA support" if !(X86_VISWS || X86_VOYAGER)
+	default y if X86_VOYAGER
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
-config MCA
-	depends on X86_VOYAGER
-	default y if X86_VOYAGER
-
 source "drivers/mca/Kconfig"
 
 config SCx200
