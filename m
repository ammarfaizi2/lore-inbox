Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUJLARL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUJLARL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUJLARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:17:10 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:9859
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269377AbUJLAQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:16:56 -0400
Subject: [patch 6/6] uml: export more Symbols
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:16:35 +0200
Message-Id: <20041012001636.12CB88693@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds a lot more EXPORT_SYMBOLS calls.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/irq.c     |    2 ++
 linux-2.6.9-current-paolo/arch/um/kernel/ksyms.c   |    1 +
 linux-2.6.9-current-paolo/arch/um/kernel/physmem.c |    5 +++++
 3 files changed, 8 insertions(+)

diff -puN arch/um/kernel/irq.c~uml-export-Symbols arch/um/kernel/irq.c
--- linux-2.6.9-current/arch/um/kernel/irq.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/irq.c	2004-10-12 01:22:08.000000000 +0200
@@ -441,6 +441,8 @@ int um_request_irq(unsigned int irq, int
 		err = activate_fd(irq, fd, type, dev_id);
 	return(err);
 }
+EXPORT_SYMBOL(um_request_irq);
+EXPORT_SYMBOL(reactivate_fd);
 
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction * new)
diff -puN arch/um/kernel/ksyms.c~uml-export-Symbols arch/um/kernel/ksyms.c
--- linux-2.6.9-current/arch/um/kernel/ksyms.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/ksyms.c	2004-10-12 01:22:08.000000000 +0200
@@ -60,6 +60,7 @@ EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
 #endif
+EXPORT_SYMBOL(uml_strdup);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff -puN arch/um/kernel/physmem.c~uml-export-Symbols arch/um/kernel/physmem.c
--- linux-2.6.9-current/arch/um/kernel/physmem.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/physmem.c	2004-10-12 01:22:08.000000000 +0200
@@ -8,6 +8,7 @@
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
+#include "linux/module.h"
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
@@ -220,6 +221,10 @@ void physmem_forget_descriptor(int fd)
 	kfree(desc);
 }
 
+EXPORT_SYMBOL(physmem_forget_descriptor);
+EXPORT_SYMBOL(physmem_remove_mapping);
+EXPORT_SYMBOL(physmem_subst_mapping);
+
 void arch_free_page(struct page *page, int order)
 {
 	void *virt;
_
