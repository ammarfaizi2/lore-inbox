Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWHJUAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWHJUAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWHJT7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62955 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932647AbWHJTgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:51 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [93/145] i386/x86-64: Move acpi_disabled variables into acpi/boot.c
Message-Id: <20060810193650.AA00313B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:50 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Removes code duplication between i386/x86-64.

Not needed anymore in setup.c since early_param cleanup

Cc: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    7 +++++++
 arch/i386/kernel/setup.c     |    7 -------
 arch/x86_64/kernel/setup.c   |    3 ---
 3 files changed, 7 insertions(+), 10 deletions(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -38,6 +38,13 @@
 
 int __initdata acpi_force = 0;
 
+#ifdef	CONFIG_ACPI
+int acpi_disabled = 0;
+#else
+int acpi_disabled = 1;
+#endif
+EXPORT_SYMBOL(acpi_disabled);
+
 #ifdef	CONFIG_X86_64
 
 extern void __init clustered_apic_check(void);
Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c
+++ linux/arch/i386/kernel/setup.c
@@ -89,13 +89,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
 
-#ifdef	CONFIG_ACPI
-	int acpi_disabled = 0;
-#else
-	int acpi_disabled = 1;
-#endif
-EXPORT_SYMBOL(acpi_disabled);
-
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
 #ifdef CONFIG_MCA
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -74,9 +74,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
 
-int acpi_disabled;
-EXPORT_SYMBOL(acpi_disabled);
-
 int acpi_numa __initdata;
 
 /* Boot loader ID as an integer, for the benefit of proc_dointvec */
