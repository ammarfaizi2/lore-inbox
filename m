Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270125AbUKATcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270125AbUKATcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291984AbUKATcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:32:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291914AbUKATaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:30 -0500
Date: Mon, 1 Nov 2004 19:30:21 GMT
Message-Id: <200411011930.iA1JULar023202@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 7/14] FRV: GDB stub dependent additional BUG()'s
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a couple of extra BUG() calls if a GDB stub is
configured in the kernel. These allow the GDB stub to catch bad_page() and
panic().

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-gdbstub-2610rc1bk10.diff
 kernel/panic.c  |    3 +++
 mm/page_alloc.c |    3 +++
 2 files changed, 6 insertions(+)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/panic.c linux-2.6.10-rc1-bk10-frv/kernel/panic.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/panic.c	2004-10-27 17:32:38.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/kernel/panic.c	2004-11-01 11:47:05.162632657 +0000
@@ -59,6 +59,9 @@
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
+#ifdef CONFIG_GDBSTUB
+	BUG();
+#endif
 	bust_spinlocks(0);
 
 #ifdef CONFIG_SMP
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/page_alloc.c linux-2.6.10-rc1-bk10-frv/mm/page_alloc.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/page_alloc.c	2004-11-01 11:45:35.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/mm/page_alloc.c	2004-11-01 11:47:05.230626996 +0000
@@ -83,6 +83,9 @@
 		page->mapping, page_mapcount(page), page_count(page));
 	printk(KERN_EMERG "Backtrace:\n");
 	dump_stack();
+#ifdef CONFIG_GDBSTUB
+	BUG();
+#endif
 	printk(KERN_EMERG "Trying to fix it up, but a reboot is needed\n");
 	page->flags &= ~(1 << PG_private	|
 			1 << PG_locked	|
