Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbTFSAO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265671AbTFSAO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:14:29 -0400
Received: from palrel10.hp.com ([156.153.255.245]:37048 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265654AbTFSANL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:13:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.851.854673.480758@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 17:26:59 -0700
To: torvalds@transmeta.com
Cc: davidm@hpl.hp.com, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: re-enable the building of 8250_hcdp and 8250_acpi (v2)
In-Reply-To: <16112.53360.599744.11117@napali.hpl.hp.com>
References: <16112.53360.599744.11117@napali.hpl.hp.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a better version of the previous patch.  As per your
suggestion, it adds a separate SERIAL_8250_ACPI config option and
makes the 8250_acpi.c code dependent on ACPI_BUS (since
acpi_bus_register_driver() is a prerequisite).

Thanks,

	--david

diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	Wed Jun 18 17:23:47 2003
+++ b/drivers/serial/Kconfig	Wed Jun 18 17:23:47 2003
@@ -77,7 +77,15 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 	  If unsure, say N.
 
-config SERIAL_HCDP
+config SERIAL_8250_ACPI
+	bool "8250/16550 device discovery via ACPI namespace"
+	default y if IA64
+	depends on ACPI_BUS
+	---help---
+	  If you wish to enable serial port discovery via the ACPI
+	  namespace, say Y here.  If unsure, say N.
+
+config SERIAL_8250_HCDP
 	bool "8250/16550 device discovery support via EFI HCDP table"
 	depends on IA64
 	---help---
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	Wed Jun 18 17:23:46 2003
+++ b/drivers/serial/Makefile	Wed Jun 18 17:23:46 2003
@@ -8,7 +8,8 @@
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
-serial-8250-$(CONFIG_SERIAL_HCDP) += 8250_hcdp.o
+serial-8250-$(CONFIG_SERIAL_8250_HCDP) += 8250_hcdp.o
+serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
 
 obj-$(CONFIG_SERIAL_CORE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
