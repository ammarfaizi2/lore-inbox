Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJDNTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJDNTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUJDNTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:19:12 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:17024 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266619AbUJDNTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:19:06 -0400
Date: Mon, 4 Oct 2004 14:27:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: swsusp: add comments at critical places
Message-ID: <20041004122734.GA2648@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

apm.c needs save_processor_state and friends. Add a comment to keep
people from removing it. Describe a way to make swsusp work on non-PSE
machines. Document purpose of acpi_restore_state.
								Pavel

Index: linux/arch/i386/power/cpu.c
===================================================================
--- linux.orig/arch/i386/power/cpu.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-10-01 00:47:37.000000000 +0200
@@ -148,6 +148,6 @@
 	__restore_processor_state(&saved_context);
 }
 
-
+/* Needed by apm.c */
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);
Index: linux/include/asm-i386/suspend.h
===================================================================
--- linux.orig/include/asm-i386/suspend.h	2004-10-01 12:24:26.000000000 +0200
+++ linux/include/asm-i386/suspend.h	2004-08-19 12:18:51.000000000 +0200
@@ -9,6 +9,9 @@
 static inline int
 arch_prepare_suspend(void)
 {
+	/* If you want to make non-PSE machine work, turn off paging
+           in do_magic. swsusp_pg_dir should have identity mapping, so
+           it could work...  */
 	if (!cpu_has_pse)
 		return -EPERM;
 	return 0;
Index: linux/arch/i386/kernel/acpi/sleep.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/sleep.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/arch/i386/kernel/acpi/sleep.c	2004-10-01 00:47:36.000000000 +0200
@@ -56,11 +56,11 @@
 }
 
 /*
- * acpi_restore_state
+ * acpi_restore_state - undo effects of acpi_save_state_mem
  */
 void acpi_restore_state_mem (void)
 {
-	zap_low_mappings();
+	zap_low_mappings();
 }
 
 /**


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
