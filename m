Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317806AbSFSHxJ>; Wed, 19 Jun 2002 03:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317807AbSFSHxI>; Wed, 19 Jun 2002 03:53:08 -0400
Received: from [148.246.77.237] ([148.246.77.237]:10500 "EHLO zion.sytes.net")
	by vger.kernel.org with ESMTP id <S317806AbSFSHxH>;
	Wed, 19 Jun 2002 03:53:07 -0400
Date: Wed, 19 Jun 2002 02:53:00 -0500
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Compaq hotplug fix for 2.5.23
Message-ID: <20020619075300.GA1098@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This one makes posible to compile the compaq hotplug module.

-- 
Felipe Contreras

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpq-hotplug.diff"

diff -ur linux-2.5.23/drivers/hotplug/cpqphp.h linux-shx/drivers/hotplug/cpqphp.h
--- linux-2.5.23/drivers/hotplug/cpqphp.h	Sun Jun  9 00:28:26 2002
+++ linux-shx/drivers/hotplug/cpqphp.h	Wed Jun 19 02:13:23 2002
@@ -30,6 +30,7 @@
 
 #include "pci_hotplug.h"
 #include <asm/io.h>		/* for read? and write? functions */
+#include <linux/tqueue.h>
 
 
 #if !defined(CONFIG_HOTPLUG_PCI_COMPAQ_MODULE)
diff -ur linux-2.5.23/drivers/hotplug/cpqphp_pci.c linux-shx/drivers/hotplug/cpqphp_pci.c
--- linux-2.5.23/drivers/hotplug/cpqphp_pci.c	Sun Jun  9 00:31:23 2002
+++ linux-shx/drivers/hotplug/cpqphp_pci.c	Wed Jun 19 02:13:24 2002
@@ -37,6 +37,8 @@
 #include "cpqphp_nvram.h"
 #include "../../arch/i386/pci/pci.h"	/* horrible hack showing how processor dependant we are... */
 
+#define TRUE  1
+#define FALSE 0
 
 u8 cpqhp_nic_irq;
 u8 cpqhp_disk_irq;
@@ -150,7 +152,7 @@
 	//Notify the drivers of the change
 	if (temp_func->pci_dev) {
 		pci_proc_attach_device(temp_func->pci_dev);
-		pci_announce_device_to_drivers(temp_func->pci_dev);
+		run_sbin_hotplug(temp_func->pci_dev, TRUE);
 	}
 
 	return 0;
diff -ur linux-2.5.23/drivers/pci/hotplug.c linux-shx/drivers/pci/hotplug.c
--- linux-2.5.23/drivers/pci/hotplug.c	Sun Jun  9 00:31:22 2002
+++ linux-shx/drivers/pci/hotplug.c	Wed Jun 19 02:12:33 2002
@@ -101,3 +101,4 @@
 
 EXPORT_SYMBOL(pci_insert_device);
 EXPORT_SYMBOL(pci_remove_device);
+EXPORT_SYMBOL(run_sbin_hotplug);

--8t9RHnE3ZwKMSgU+--
