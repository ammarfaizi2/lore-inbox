Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUB1AQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbUB1AN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:13:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:52645 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263221AbUB1AJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:56 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <1077926983983@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:44 -0800
Message-Id: <10779269841823@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1619, 2004/02/24 14:04:40-08:00, greg@kroah.com

PCI Hotplug: clean up the Makefile a bit more.

Still need to fix up the pcie and shpc options to be saner for distros to use.


 drivers/pci/hotplug/Makefile |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Fri Feb 27 15:57:08 2004
+++ b/drivers/pci/hotplug/Makefile	Fri Feb 27 15:57:08 2004
@@ -25,6 +25,8 @@
 				cpqphp_ctrl.o	\
 				cpqphp_sysfs.o	\
 				cpqphp_pci.o
+cpqphp-$(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM) += cpqphp_nvram.o
+cpqphp-objs += $(cpqphp-y)
 
 ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_ebda.o	\
@@ -49,21 +51,17 @@
 				pciehp_sysfs.o	\
 				pciehp_hpc.o
 
-shpchp-objs		:=	shpchp_core.o	\
-				shpchp_ctrl.o	\
-				shpchp_pci.o	\
-				shpchp_sysfs.o	\
-				shpchp_hpc.o
-
-ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM),y)
-	cpqphp-objs += cpqphp_nvram.o
-endif
-
 ifeq ($(CONFIG_HOTPLUG_PCI_PCIE_PHPRM_NONACPI),y)
   pciehp-objs += pciehprm_nonacpi.o
 else
   pciehp-objs += pciehprm_acpi.o
 endif
+
+shpchp-objs		:=	shpchp_core.o	\
+				shpchp_ctrl.o	\
+				shpchp_pci.o	\
+				shpchp_sysfs.o	\
+				shpchp_hpc.o
 
 ifeq ($(CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY),y)
   shpchp-objs += shpchprm_legacy.o

