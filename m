Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbTEHW5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTEHW47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:56:59 -0400
Received: from dp.samba.org ([66.70.73.150]:15831 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262233AbTEHWyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:54:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_arch_cleanup() 
In-reply-to: Your message of "Thu, 08 May 2003 18:41:17 +0200."
             <20030508184117.A26726@lst.de> 
Date: Fri, 09 May 2003 09:02:58 +1000
Message-Id: <20030508230732.906A92C018@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030508184117.A26726@lst.de> you write:
> IA64 needs to be able to hook into module unloading to get rid of
> the unwind tables for modules.  (The actual implementation already
> is in arch/ia64/kernel/module.c, David just seems to be to shy to
> submit core changes :))

Or he was waiting for me.  Sorry David.  Linus, please apply.

Name: module_arch_cleanup hook
Author: David Mosberger
Status: Trivial

D: The patch below updates the other platforms with
D: module_arch_cleanup().  Also, I added more debug output to
D: kernel/module.c since I found it useful to be able to see the final
D: section layout.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/alpha/kernel/module.c .12078-linux-2.5.69.updated/arch/alpha/kernel/module.c
--- .12078-linux-2.5.69/arch/alpha/kernel/module.c	2003-04-08 11:13:37.000000000 +1000
+++ .12078-linux-2.5.69.updated/arch/alpha/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -300,3 +300,8 @@ module_finalize(const Elf_Ehdr *hdr, con
 {
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/arm/kernel/module.c .12078-linux-2.5.69.updated/arch/arm/kernel/module.c
--- .12078-linux-2.5.69/arch/arm/kernel/module.c	2003-02-07 19:21:51.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/arm/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -159,3 +159,8 @@ module_finalize(const Elf32_Ehdr *hdr, c
 {
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/i386/kernel/module.c .12078-linux-2.5.69.updated/arch/i386/kernel/module.c
--- .12078-linux-2.5.69/arch/i386/kernel/module.c	2003-05-05 12:36:54.000000000 +1000
+++ .12078-linux-2.5.69.updated/arch/i386/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -123,3 +123,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	} 	
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/parisc/kernel/module.c .12078-linux-2.5.69.updated/arch/parisc/kernel/module.c
--- .12078-linux-2.5.69/arch/parisc/kernel/module.c	2003-03-25 12:16:58.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/parisc/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -568,3 +568,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 #endif
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/ppc/kernel/module.c .12078-linux-2.5.69.updated/arch/ppc/kernel/module.c
--- .12078-linux-2.5.69/arch/ppc/kernel/module.c	2003-02-07 19:21:52.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/ppc/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -269,3 +269,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/ppc64/kernel/module.c .12078-linux-2.5.69.updated/arch/ppc64/kernel/module.c
--- .12078-linux-2.5.69/arch/ppc64/kernel/module.c	2003-02-11 14:25:58.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/ppc64/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -386,3 +386,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		      me->extable.entry + me->extable.num_entries);
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/s390/kernel/module.c .12078-linux-2.5.69.updated/arch/s390/kernel/module.c
--- .12078-linux-2.5.69/arch/s390/kernel/module.c	2003-04-20 18:05:03.000000000 +1000
+++ .12078-linux-2.5.69.updated/arch/s390/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -386,3 +386,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		kfree(me->arch.syminfo);
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/sparc/kernel/module.c .12078-linux-2.5.69.updated/arch/sparc/kernel/module.c
--- .12078-linux-2.5.69/arch/sparc/kernel/module.c	2003-04-08 11:13:48.000000000 +1000
+++ .12078-linux-2.5.69.updated/arch/sparc/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -145,3 +145,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/sparc64/kernel/module.c .12078-linux-2.5.69.updated/arch/sparc64/kernel/module.c
--- .12078-linux-2.5.69/arch/sparc64/kernel/module.c	2003-04-08 11:13:50.000000000 +1000
+++ .12078-linux-2.5.69.updated/arch/sparc64/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -273,3 +273,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/v850/kernel/module.c .12078-linux-2.5.69.updated/arch/v850/kernel/module.c
--- .12078-linux-2.5.69/arch/v850/kernel/module.c	2003-02-07 19:21:52.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/v850/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -230,3 +230,8 @@ int apply_relocate_add (Elf32_Shdr *sech
 
 	return 0;
 }
+
+void
+module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/arch/x86_64/kernel/module.c .12078-linux-2.5.69.updated/arch/x86_64/kernel/module.c
--- .12078-linux-2.5.69/arch/x86_64/kernel/module.c	2003-02-17 11:37:44.000000000 +1100
+++ .12078-linux-2.5.69.updated/arch/x86_64/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -231,3 +231,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/include/linux/moduleloader.h .12078-linux-2.5.69.updated/include/linux/moduleloader.h
--- .12078-linux-2.5.69/include/linux/moduleloader.h	2003-02-07 19:21:54.000000000 +1100
+++ .12078-linux-2.5.69.updated/include/linux/moduleloader.h	2003-05-05 12:47:35.000000000 +1000
@@ -41,4 +41,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+/* Any cleanup needed when module leaves. */
+void module_arch_cleanup(struct module *mod);
+
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12078-linux-2.5.69/kernel/module.c .12078-linux-2.5.69.updated/kernel/module.c
--- .12078-linux-2.5.69/kernel/module.c	2003-05-05 12:37:13.000000000 +1000
+++ .12078-linux-2.5.69.updated/kernel/module.c	2003-05-05 12:47:35.000000000 +1000
@@ -910,6 +910,9 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	/* Arch-specific cleanup. */
+	module_arch_cleanup(mod);
+
 	/* Module unload stuff */
 	module_unload_free(mod);
 
@@ -1276,6 +1279,7 @@ static struct module *load_module(void _
 	mod->module_init = ptr;
 
 	/* Transfer each section which specifies SHF_ALLOC */
+	DEBUGP("final section addresses:\n");
 	for (i = 0; i < hdr->e_shnum; i++) {
 		void *dest;
 
@@ -1293,6 +1297,7 @@ static struct module *load_module(void _
 			       sechdrs[i].sh_size);
 		/* Update sh_addr to point to copy in image. */
 		sechdrs[i].sh_addr = (unsigned long)dest;
+		DEBUGP("\t0x%lx %s\n", sechdrs[i].sh_addr, secstrings + sechdrs[i].sh_name);
 	}
 	/* Module has been moved. */
 	mod = (void *)sechdrs[modindex].sh_addr;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
