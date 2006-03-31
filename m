Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWCaEfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCaEfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 23:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWCaEfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 23:35:36 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:53642 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1750715AbWCaEff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 23:35:35 -0500
Date: Thu, 30 Mar 2006 23:33:27 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] No arch-specific strpbrk implementations
Message-ID: <20060331043327.GG31321@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up parisc_ksyms.c earlier, I noticed that strpbrk wasn't
being exported from lib/string.c. Investigating further, I noticed a
changeset that removed its export and added it to _ksyms.c on a few
more architectures. The justification was that "other arches do it."

I think this is wrong, since no architecture currently defines
__HAVE_ARCH_STRPBRK, there's no reason for any of them to be exporting
it themselves. Therefore, consolidate the export to lib/string.c.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---
diff --git a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
index 1898ea7..5cfed18 100644
--- a/arch/alpha/kernel/alpha_ksyms.c
+++ b/arch/alpha/kernel/alpha_ksyms.c
@@ -76,7 +76,6 @@ EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strncat);
 EXPORT_SYMBOL(strstr);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(memcmp);
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 1574941..696bbd0 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -109,7 +109,6 @@ EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(memset);
diff --git a/arch/arm26/kernel/armksyms.c b/arch/arm26/kernel/armksyms.c
index 811a637..3bbae18 100644
--- a/arch/arm26/kernel/armksyms.c
+++ b/arch/arm26/kernel/armksyms.c
@@ -152,7 +152,6 @@ EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(memset);
diff --git a/arch/cris/kernel/crisksyms.c b/arch/cris/kernel/crisksyms.c
index de39725..d578590 100644
--- a/arch/cris/kernel/crisksyms.c
+++ b/arch/cris/kernel/crisksyms.c
@@ -39,7 +39,6 @@ EXPORT_SYMBOL(loops_per_usec);
 /* String functions */
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strchr);
diff --git a/arch/frv/kernel/frv_ksyms.c b/arch/frv/kernel/frv_ksyms.c
index aa6b7d0..0f1c6cb 100644
--- a/arch/frv/kernel/frv_ksyms.c
+++ b/arch/frv/kernel/frv_ksyms.c
@@ -27,7 +27,6 @@ EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 
 EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strchr);
diff --git a/arch/h8300/kernel/h8300_ksyms.c b/arch/h8300/kernel/h8300_ksyms.c
index 69d6ad3..5cc76ef 100644
--- a/arch/h8300/kernel/h8300_ksyms.c
+++ b/arch/h8300/kernel/h8300_ksyms.c
@@ -25,7 +25,6 @@ extern char h8300_debug_device[];
 /* platform dependent support */
 
 EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strchr);
diff --git a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
index 0553250..036a985 100644
--- a/arch/i386/kernel/i386_ksyms.c
+++ b/arch/i386/kernel/i386_ksyms.c
@@ -19,7 +19,6 @@ EXPORT_SYMBOL(__put_user_2);
 EXPORT_SYMBOL(__put_user_4);
 EXPORT_SYMBOL(__put_user_8);
 
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
 #ifdef CONFIG_SMP
diff --git a/arch/m32r/kernel/m32r_ksyms.c b/arch/m32r/kernel/m32r_ksyms.c
index be8b711..0e4af36 100644
--- a/arch/m32r/kernel/m32r_ksyms.c
+++ b/arch/m32r/kernel/m32r_ksyms.c
@@ -42,7 +42,6 @@ EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
 
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
 EXPORT_SYMBOL(strncpy_from_user);
diff --git a/arch/m68k/kernel/m68k_ksyms.c b/arch/m68k/kernel/m68k_ksyms.c
index 3d7f200..70e394e 100644
--- a/arch/m68k/kernel/m68k_ksyms.c
+++ b/arch/m68k/kernel/m68k_ksyms.c
@@ -57,7 +57,6 @@ EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(kernel_thread);
diff --git a/arch/m68knommu/kernel/m68k_ksyms.c b/arch/m68knommu/kernel/m68k_ksyms.c
index d844c75..eddb8d3 100644
--- a/arch/m68knommu/kernel/m68k_ksyms.c
+++ b/arch/m68knommu/kernel/m68k_ksyms.c
@@ -26,7 +26,6 @@ EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strchr);
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 86e42c6..e042f9d 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -39,7 +39,6 @@ EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strncmp);
 #endif
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strncat);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 47ca5c0..fc107ad 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -31,7 +31,6 @@
 
 #include <linux/string.h>
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(strpbrk);
 
 #include <asm/atomic.h>
 EXPORT_SYMBOL(__xchg8);
diff --git a/arch/sh/kernel/sh_ksyms.c b/arch/sh/kernel/sh_ksyms.c
index 1cf94a6..d5d0325 100644
--- a/arch/sh/kernel/sh_ksyms.c
+++ b/arch/sh/kernel/sh_ksyms.c
@@ -37,7 +37,6 @@ EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(no_irq_type);
 
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
diff --git a/arch/sh64/kernel/sh_ksyms.c b/arch/sh64/kernel/sh_ksyms.c
index de29c45..6f3a1c9 100644
--- a/arch/sh64/kernel/sh_ksyms.c
+++ b/arch/sh64/kernel/sh_ksyms.c
@@ -41,7 +41,6 @@ EXPORT_SYMBOL(kernel_thread);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy);
 
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
 #ifdef CONFIG_VT
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 2c21d79..ec1c968 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -263,7 +263,6 @@ EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(page_kernel);
 
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index f5e8db1..62d8a99 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -276,7 +276,6 @@ EXPORT_SYMBOL(__prom_getsibling);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(__strlen_user);
 EXPORT_SYMBOL(__strnlen_user);
-EXPORT_SYMBOL(strpbrk);
 
 #ifdef CONFIG_SOLARIS_EMUL_MODULE
 EXPORT_SYMBOL(linux_sparc_syscall);
diff --git a/arch/v850/kernel/v850_ksyms.c b/arch/v850/kernel/v850_ksyms.c
index 8ffc29c..6bcfcfe 100644
--- a/arch/v850/kernel/v850_ksyms.c
+++ b/arch/v850/kernel/v850_ksyms.c
@@ -43,7 +43,6 @@ EXPORT_SYMBOL (strncmp);
 EXPORT_SYMBOL (strchr);
 EXPORT_SYMBOL (strlen);
 EXPORT_SYMBOL (strnlen);
-EXPORT_SYMBOL (strpbrk);
 EXPORT_SYMBOL (strrchr);
 EXPORT_SYMBOL (strstr);
 EXPORT_SYMBOL (memset);
diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index d96a934..f3fa57a 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -124,7 +124,6 @@ extern void * __memcpy(void *,const void
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index efae56a..3e6b488 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -48,7 +48,6 @@ EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strncat);
 EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strrchr);
diff --git a/lib/string.c b/lib/string.c
index b3c28a3..037a48a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -403,6 +403,7 @@ char *strpbrk(const char *cs, const char
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(strpbrk);
 #endif
 
 #ifndef __HAVE_ARCH_STRSEP
