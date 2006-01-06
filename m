Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752454AbWAFQah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbWAFQah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbWAFQaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752459AbWAFQaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:06 -0500
Date: Fri, 6 Jan 2006 16:29:36 GMT
Message-Id: <200601061629.k06GTaoV011373@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 7/17] FRV: Add module support stubs
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds stubs for FRV module support. 

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-modules-2615.diff
 arch/frv/kernel/Makefile |    1 
 arch/frv/kernel/module.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-frv/module.h |   16 +++++++--
 3 files changed, 93 insertions(+), 4 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/Makefile linux-2.6.15-frv/arch/frv/kernel/Makefile
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/Makefile	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/Makefile	2006-01-06 14:43:43.000000000 +0000
@@ -20,3 +20,4 @@ obj-$(CONFIG_FUJITSU_MB93493)	+= irq-mb9
 obj-$(CONFIG_PM)		+= pm.o cmode.o
 obj-$(CONFIG_MB93093_PDK)	+= pm-mb93093.o
 obj-$(CONFIG_SYSCTL)		+= sysctl.o
+obj-$(CONFIG_MODULES)		+= module.o
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/module.c linux-2.6.15-frv/arch/frv/kernel/module.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/module.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/kernel/module.c	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1,80 @@
+/* module.c: FRV specific module loading bits
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/i386/kernel/module.c, Copyright (C) 2001 Rusty Russell.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/moduleloader.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt...)
+#endif
+
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+
+	return vmalloc_exec(size);
+}
+
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
+/* We don't need anything special. */
+int module_frob_arch_sections(Elf_Ehdr *hdr,
+			      Elf_Shdr *sechdrs,
+			      char *secstrings,
+			      struct module *mod)
+{
+	return 0;
+}
+
+int apply_relocate(Elf32_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n", me->name);
+	return -ENOEXEC;
+}
+
+int apply_relocate_add(Elf32_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *me)
+{
+	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n", me->name);
+	return -ENOEXEC;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	return 0;
+}
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/module.h linux-2.6.15-frv/include/asm-frv/module.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/module.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/module.h	2006-01-06 14:43:43.000000000 +0000
@@ -11,10 +11,18 @@
 #ifndef _ASM_MODULE_H
 #define _ASM_MODULE_H
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
+struct mod_arch_specific
+{
+};
+
+#define Elf_Shdr	Elf32_Shdr
+#define Elf_Sym		Elf32_Sym
+#define Elf_Ehdr	Elf32_Ehdr
+
+/*
+ * Include the architecture version.
+ */
+#define MODULE_ARCH_VERMAGIC __stringify(PROCESSOR_MODEL_NAME) " "
 
 #endif /* _ASM_MODULE_H */
 
