Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbUB1AJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbUB1AJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:09:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:48293 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263216AbUB1AJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:44 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <10779269834095@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:43 -0800
Message-Id: <1077926983983@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1618, 2004/02/24 14:02:08-08:00, greg@kroah.com

PCI Hotplug: remove unneeded ACPI Makefile rules.


 drivers/pci/hotplug/Makefile |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)


diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Fri Feb 27 15:57:13 2004
+++ b/drivers/pci/hotplug/Makefile	Fri Feb 27 15:57:13 2004
@@ -55,13 +55,6 @@
 				shpchp_sysfs.o	\
 				shpchp_hpc.o
 
-ifdef CONFIG_HOTPLUG_PCI_ACPI
-  EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
-  ifdef CONFIG_ACPI_DEBUG
-    EXTRA_CFLAGS += -DACPI_DEBUG_OUTPUT
-  endif
-endif
-
 ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM),y)
 	cpqphp-objs += cpqphp_nvram.o
 endif
@@ -70,16 +63,14 @@
   pciehp-objs += pciehprm_nonacpi.o
 else
   pciehp-objs += pciehprm_acpi.o
-  EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi -I$(TOPDIR)/drivers/acpi/include 
 endif
 
 ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY),y)
   shpchp-objs += shpchprm_legacy.o
 else
-   ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_NONACPI),y)
-     shpchp-objs += shpchprm_nonacpi.o
-   else
-      shpchp-objs += shpchprm_acpi.o
-      EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi 
-   endif
+  ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_NONACPI),y)
+    shpchp-objs += shpchprm_nonacpi.o
+  else
+    shpchp-objs += shpchprm_acpi.o
+  endif
 endif

