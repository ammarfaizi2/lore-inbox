Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTGCQCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTGCP7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:59:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:14077 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264850AbTGCP6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:58:54 -0400
Date: Thu, 3 Jul 2003 18:13:18 +0200 (MEST)
Message-Id: <200307031613.h63GDID8007098@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH][2.5.74] x86_64 apic/nmi driver model conversion cleanups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

There is still cruft remaining in x86-64 from the apic/nmi
system device model conversion, including obsolete #includes
and whitespace/intendation breakage.

While non-critical from a functional standpoint, please apply
this cleanup patch.

/Mikael

--- linux-2.5.74/arch/x86_64/kernel/apic.c.~1~	2003-06-17 12:51:19.000000000 +0200
+++ linux-2.5.74/arch/x86_64/kernel/apic.c	2003-07-03 17:19:59.000000000 +0200
@@ -441,9 +441,6 @@
 
 #ifdef CONFIG_PM
 
-#include <linux/device.h>
-#include <linux/module.h>
-
 static struct {
 	/* 'active' is true if the local APIC was enabled by us and
 	   not the BIOS; this signifies that we are also responsible
@@ -540,7 +537,6 @@
 	.suspend	= lapic_suspend,
 };
 
-/* not static, needed by child devices */
 static struct sys_device device_lapic = {
 	.id		= 0,
 	.cls		= &lapic_sysclass,
--- linux-2.5.74/arch/x86_64/kernel/nmi.c.~1~	2003-07-03 12:32:44.000000000 +0200
+++ linux-2.5.74/arch/x86_64/kernel/nmi.c	2003-07-03 17:19:59.000000000 +0200
@@ -141,14 +141,14 @@
 	/* tell do_nmi() and others that we're not active any more */
 	nmi_watchdog = 0;
 }
+
 void enable_lapic_nmi_watchdog(void)
-  {
+{
 	if (nmi_active < 0) {
 		nmi_watchdog = NMI_LOCAL_APIC;
 		setup_apic_nmi_watchdog();
 	}
-  }
-
+}
 
 void disable_timer_nmi_watchdog(void)
 {
@@ -173,8 +173,6 @@
 
 #ifdef CONFIG_PM
 
-#include <linux/device.h>
-
 static int nmi_pm_active; /* nmi_active before suspend */
 
 static int lapic_nmi_suspend(struct sys_device *dev, u32 state)
@@ -187,7 +185,7 @@
 static int lapic_nmi_resume(struct sys_device *dev)
 {
 	if (nmi_pm_active > 0)
-	enable_lapic_nmi_watchdog();
+		enable_lapic_nmi_watchdog();
 	return 0;
 }
 
@@ -199,7 +197,7 @@
 
 static struct sys_device device_lapic_nmi = {
 	.id		= 0,
-	.cls	= &nmi_sysclass,
+	.cls		= &nmi_sysclass,
 };
 
 static int __init init_lapic_nmi_sysfs(void)
--- linux-2.5.74/include/asm-x86_64/apic.h.~1~	2003-07-03 12:32:46.000000000 +0200
+++ linux-2.5.74/include/asm-x86_64/apic.h	2003-07-03 17:19:59.000000000 +0200
@@ -84,10 +84,6 @@
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 
-#ifdef CONFIG_PM
-extern struct sys_device device_lapic;
-#endif
-
 extern int check_nmi_watchdog (void);
 
 extern unsigned int nmi_watchdog;
