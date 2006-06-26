Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933023AbWFZVB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbWFZVB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933024AbWFZVB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:01:28 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:227 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S933023AbWFZVB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:01:27 -0400
Subject: [PATCH] voyager: fix compile after setup rework
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 16:01:11 -0500
Message-Id: <1151355671.2673.35.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following

[PATCH] Clean up and refactor i386 sub-architecture setup

Doesn't quite work, since it leaves out an include of asm/io.h, without
which the use of inb/outb in the setup file won.t work.  This corrects
that and also removes a spurious acpi reference that apparently crept in
ages ago but should never have been there.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

Index: linux-2.6/arch/i386/mach-voyager/setup.c
===================================================================
--- linux-2.6.orig/arch/i386/mach-voyager/setup.c	2006-06-26 10:56:43.000000000 -0500
+++ linux-2.6/arch/i386/mach-voyager/setup.c	2006-06-26 11:29:50.000000000 -0500
@@ -5,10 +5,10 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/acpi.h>
 #include <asm/arch_hooks.h>
 #include <asm/voyager.h>
 #include <asm/e820.h>
+#include <asm/io.h>
 #include <asm/setup.h>
 
 void __init pre_intr_init_hook(void)
@@ -27,8 +27,7 @@
 	smp_intr_init();
 #endif
 
-	if (!acpi_ioapic)
-		setup_irq(2, &irq2);
+	setup_irq(2, &irq2);
 }
 
 void __init pre_setup_arch_hook(void)


