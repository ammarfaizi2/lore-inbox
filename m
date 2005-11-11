Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVKKIhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVKKIhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKKIgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:42 -0500
Received: from i121.durables.org ([64.81.244.121]:11214 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932237AbVKKIgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:21 -0500
Date: Fri, 11 Nov 2005 02:35:57 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <15.282480653@selenic.com>
Message-Id: <16.282480653@selenic.com>
Subject: [PATCH 15/15] misc: Configurable support for PCI serial ports
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configurable support for PCI serial devices

This allows disabling support for _non_-legacy PCI serial devices.

   text    data     bss     dec     hex filename
3332260  529420  190812 4052492  3dd60c vmlinux
3327944  523060  190812 4041816  3dac58 vmlinux-pci-serial

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/drivers/serial/Makefile
===================================================================
--- 2.6.14-misc.orig/drivers/serial/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/drivers/serial/Makefile	2005-11-09 11:27:28.000000000 -0800
@@ -8,7 +8,7 @@ serial-8250-y :=
 serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
-serial-8250-$(CONFIG_PCI) += 8250_pci.o
+serial-8250-$(CONFIG_SERIAL_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_HP300) += 8250_hp300.o
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:26.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:27:28.000000000 -0800
@@ -473,6 +473,15 @@ config BOOTFLAG
 	help
 	  This enables support for the Simple Bootflag Specification.
 
+config SERIAL_PCI
+	depends PCI && SERIAL_8250
+	default y
+	bool "Enable standard PCI serial support" if EMBEDDED
+	help
+	  This builds standard PCI serial support. You may be able to disable
+          this feature if you are only need legacy serial support.
+	  Saves about 9K.
+
 endmenu		# General setup
 
 config TINY_SHMEM
