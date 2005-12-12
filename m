Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLLWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLLWuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLLWuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:50:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:49622 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932086AbVLLWuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:50:21 -0500
X-Authenticated: #704063
Subject: [Patch] es7000 broken without acpi
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 12 Dec 2005 23:50:19 +0100
Message-Id: <1134427819.18385.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

a make randconfig gave me a situation where es7000 was enabled, but acpi wasnt 
( dont know if this makes sense ), gcc gave me some compiling errors, which the
following patch fixes. Please cc me as i am not on the list. Thanks.


Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


diff -up linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h
--- linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h	2005-12-12 23:44:39.000000000 +0100
+++ linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h	2005-12-12 23:43:51.000000000 +0100
@@ -83,6 +83,7 @@ struct es7000_oem_table {
 	struct psai psai;
 };
 
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
 struct acpi_table_sdt {
 	unsigned long pa;
 	unsigned long count;
@@ -98,6 +99,7 @@ struct oem_table {
 	u32 OEMTableAddr;
 	u32 OEMTableSize;
 };
+#endif
 
 struct mip_reg {
 	unsigned long long off_0;
diff -up linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c	2005-12-12 23:44:39.000000000 +0100
+++ linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c	2005-12-12 23:43:20.000000000 +0100
@@ -92,7 +92,9 @@ setup_unisys(void)
 		es7000_plat = ES7000_ZORRO;
 	else
 		es7000_plat = ES7000_CLASSIC;
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
 	ioapic_renumber_irq = es7000_rename_gsi;
+#endif
 }
 
 /*
@@ -160,6 +162,7 @@ parse_unisys_oem (char *oemptr)
 	return es7000_plat;
 }
 
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
 int __init
 find_unisys_acpi_oem_table(unsigned long *oem_addr)
 {
@@ -212,6 +215,7 @@ find_unisys_acpi_oem_table(unsigned long
 	}
 	return -1;
 }
+#endif
 
 static void
 es7000_spin(int n)


