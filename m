Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbTFLVlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265004AbTFLVlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:41:23 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:46520 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S265010AbTFLVkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:40:21 -0400
Subject: [PATCH] Fix perfctr on x86_64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-LY9JbX/ISlQI5xr6QzjS"
Message-Id: <1055454843.1043.21.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 14:54:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LY9JbX/ISlQI5xr6QzjS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Mikael -

One of Andi's pre-2.5.70 x86_64 merges converted the x86_64 APIC code to
using the new driver model.  This patch against perfctr-2.5.4 fixes the
kernel portion of the perfctr build.

	<b

--=-LY9JbX/ISlQI5xr6QzjS
Content-Description: 
Content-Disposition: attachment; filename=perfctr-2.5.4.patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1441  -> 1.1442 
#	drivers/perfctr/x86_64.c	1.1     -> 1.2    
#	drivers/perfctr/x86_64_setup.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/12	bos@serpentine.com	1.1442
# x86_64_setup.c, x86_64.c:
#   perfctr: Use new driver model for x86_64.
# --------------------------------------------
#
diff -Nru a/drivers/perfctr/x86_64.c b/drivers/perfctr/x86_64.c
--- a/drivers/perfctr/x86_64.c	Thu Jun 12 14:50:18 2003
+++ b/drivers/perfctr/x86_64.c	Thu Jun 12 14:50:18 2003
@@ -533,8 +533,8 @@
 	printk("perfctr: PM resume\n");
 }
 
-/* XXX: x86_64 hasn't converted apic & nmi to driver model yet */
-#if 0 && LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,67)
+/* x86_64 didn't convert apic & nmi to driver model until 2.5.70 */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,70)
 
 #include <linux/device.h>
 
@@ -623,8 +623,8 @@
 
 #ifdef NMI_LOCAL_APIC
 
-/* XXX: x86_64 hasn't converted apic & nmi to driver model yet */
-#if 1 || LINUX_VERSION_CODE < KERNEL_VERSION(2,5,67)
+/* XXX: x86_64 didn't convert apic & nmi to driver model until 2.5.70 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,70)
 static void __init disable_lapic_nmi_watchdog(void)
 {
 #ifdef CONFIG_PM
diff -Nru a/drivers/perfctr/x86_64_setup.c b/drivers/perfctr/x86_64_setup.c
--- a/drivers/perfctr/x86_64_setup.c	Thu Jun 12 14:50:18 2003
+++ b/drivers/perfctr/x86_64_setup.c	Thu Jun 12 14:50:18 2003
@@ -59,8 +59,8 @@
 #ifdef NMI_LOCAL_APIC
 EXPORT_SYMBOL(nmi_perfctr_msr);
 
-/* XXX: x86_64 hasn't converted apic & nmi to driver model yet */
-#if /*LINUX_VERSION_CODE < KERNEL_VERSION(2,5,67) &&*/ defined(CONFIG_PM)
+/* x86_64 didn't convert apic & nmi to driver model until 2.5.70 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,70) && defined(CONFIG_PM)
 EXPORT_SYMBOL(apic_pm_register);
 EXPORT_SYMBOL(apic_pm_unregister);
 EXPORT_SYMBOL(nmi_pmdev);

--=-LY9JbX/ISlQI5xr6QzjS--

