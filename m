Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUHDQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUHDQAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUHDP7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:59:20 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.70]:55020 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267328AbUHDP63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:58:29 -0400
Date: Wed, 04 Aug 2004 11:57:57 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
In-reply-to: <1091588367.2297.49.camel@dhcppc4>
To: Len Brown <len.brown@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>,
       =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>
Message-id: <41110785.4040000@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_yX7zE2d40MRXFAqdGoFEMw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
References: <41103F22.4090303@optonline.net> <1091588367.2297.49.camel@dhcppc4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_yX7zE2d40MRXFAqdGoFEMw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


Len-

Attached is a respin based on your comments.

Len Brown wrote:

>> static int
>>+acpi_pci_link_resume (
>>+	struct acpi_pci_link	*link)
>>+{
>>+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
>>+	
>>+	if (link->irq.active && link->irq.setonboot)
>>    
>>
>
>I think that before this change, irq.setonboot was a NOP
>and a candidate for being deleted.  However, it does seem
>to have a use here, where we want to re-program only those
>links that were programmed.  ("setonboot" would probably
>be better called "initialized" or "programmed").
>  
>
Agree, changed to "initialized"

>> static int __init acpi_pci_link_init (void)
>> {
>> 	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
>> 
>>-	if (acpi_pci_disabled)
>>+	if (acpi_disabled || acpi_noirq)
>>    
>>
>
>I think that testing acpi_noirq is sufficient here.
>  
>
I'll take your word for it. changed.

--Boundary_(ID_yX7zE2d40MRXFAqdGoFEMw)
Content-type: text/plain; name=acpi-fixes.patch2
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=acpi-fixes.patch2

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/04 11:32:42-04:00 nbryant@optonline.net 
#   [ACPI] drivers/acpi/pci_link.c: misc cleanups per suggestions
# 
# drivers/acpi/pci_link.c
#   2004/08/04 11:32:33-04:00 nbryant@optonline.net +6 -8
#   [ACPI] drivers/acpi/pci_link.c: misc cleanups per suggestions
# 
# ChangeSet
#   2004/08/04 10:53:42-04:00 nbryant@optonline.net 
#   Merge optonline.net:/home/nathan/linux-acpi-test-2.6.8
#   into optonline.net:/home/nathan/acpi-fixes
# 
# BitKeeper/etc/ignore
#   2004/08/04 10:53:30-04:00 nbryant@optonline.net +1 -2
#   auto-union
# 
# ChangeSet
#   2004/08/03 19:37:56-04:00 nbryant@optonline.net 
#   drivers/acpi/pci_link.c: use device_initcall(irqrouter_init_sysfs);
# 
# drivers/acpi/pci_link.c
#   2004/08/03 19:37:47-04:00 nbryant@optonline.net +13 -3
#   use device_initcall(irqrouter_init_sysfs);
# 
# ChangeSet
#   2004/08/03 18:09:20-04:00 nbryant@optonline.net 
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:09:12-04:00 nbryant@optonline.net +1 -1
#   fix ACPI_FUNCTION_TRACE("irqrouter_resume");
# 
# ChangeSet
#   2004/08/03 18:03:39-04:00 nbryant@optonline.net 
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/03 18:03:31-04:00 nbryant@optonline.net +51 -14
#   drivers/acpi/pci_link.c: register us as a sys_device so that we can get
#   resume callbacks and restore interrupt state. Fixes interrupt problems
#   reported on the mailing lists:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# ChangeSet
#   2004/08/02 20:41:54-04:00 nbryant@optonline.net 
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/02 20:41:45-04:00 nbryant@optonline.net +23 -0
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# BitKeeper/etc/ignore
#   2004/08/02 20:41:45-04:00 nbryant@optonline.net +2 -0
#   Added Module.symvers drivers/acpi/pci_link.c~ to the ignore list
# 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-08-04 11:33:50 -04:00
+++ b/drivers/acpi/pci_link.c	2004-08-04 11:33:50 -04:00
@@ -29,6 +29,7 @@
  *	   for IRQ management (e.g. start()->_SRS).
  */
 
+#include <linux/sysdev.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -71,7 +72,7 @@
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
 	u8			active_high_low;	/* All IRQs */
-	u8			setonboot;
+	u8			initialized;
 	u8			resource_type;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
@@ -517,7 +518,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
-	if (link->irq.setonboot)
+	if (link->irq.initialized)
 		return_VALUE(0);
 
 	/*
@@ -571,7 +572,7 @@
 			acpi_device_bid(link->device), link->irq.active);
 	}
 
-	link->irq.setonboot = 1;
+	link->irq.initialized = 1;
 
 	return_VALUE(0);
 }
@@ -695,6 +696,42 @@
 
 
 static int
+acpi_pci_link_resume (
+	struct acpi_pci_link	*link)
+{
+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
+	
+	if (link->irq.active && link->irq.initialized)
+		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+	else
+		return_VALUE(0);
+}
+
+
+static int
+irqrouter_resume(
+	struct sys_device *dev)
+{
+	struct list_head        *node = NULL;
+	struct acpi_pci_link    *link = NULL;
+
+	ACPI_FUNCTION_TRACE("irqrouter_resume");
+
+	list_for_each(node, &acpi_link.entries) {
+
+		link = list_entry(node, struct acpi_pci_link, node);
+		if (!link) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+			continue;
+		}
+
+		acpi_pci_link_resume(link);
+	}
+	return_VALUE(0);
+}
+
+
+static int
 acpi_pci_link_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -786,11 +823,42 @@
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
 
+static struct sysdev_class irqrouter_sysdev_class = {
+        set_kset_name("irqrouter"),
+        .resume = irqrouter_resume,
+};
+
+
+static struct sys_device device_irqrouter = {
+	.id     = 0,
+	.cls    = &irqrouter_sysdev_class,
+};
+
+
+static int __init irqrouter_init_sysfs(void)
+{
+	int error;
+
+	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
+
+	if (acpi_disabled || acpi_noirq)
+		return_VALUE(0);
+
+        error = sysdev_class_register(&irqrouter_sysdev_class);
+        if (!error)
+        	error = sysdev_register(&device_irqrouter);
+
+        return_VALUE(error);
+}                                        
+
+device_initcall(irqrouter_init_sysfs);
+
+
 static int __init acpi_pci_link_init (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
 
-	if (acpi_pci_disabled)
+	if (acpi_noirq)
 		return_VALUE(0);
 
 	acpi_link.count = 0;

--Boundary_(ID_yX7zE2d40MRXFAqdGoFEMw)--
