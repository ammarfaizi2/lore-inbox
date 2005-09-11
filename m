Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVIKRoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVIKRoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVIKRoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:44:44 -0400
Received: from mout.perfora.net ([217.160.230.41]:9680 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S964987AbVIKRon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:44:43 -0400
Date: Sun, 11 Sep 2005 10:44:37 -0700
From: donate <donate@madrone.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [RFC] [PATCH] make add_taint() inline
Message-Id: <20050911104437.6445ff20.donate@madrone.org>
In-Reply-To: <20050911103757.7cc1f50f.rdunlap@xenotime.net>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net>
Organization: nil
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:e4dbf5087eeb6d426001e537f1b78e1a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

add_taint() is a trivial function.
No need to call it out-of-line, just make it inline and
remove its export.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 arch/x86_64/kernel/mce_intel.c |    1 +
 include/linux/kernel.h         |    5 ++++-
 kernel/panic.c                 |    6 ------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff -Naurp linux-2613-git10/arch/x86_64/kernel/mce_intel.c~add_taint_inline linux-2613-git10/arch/x86_64/kernel/mce_intel.c
--- linux-2613-git10/arch/x86_64/kernel/mce_intel.c~add_taint_inline	2005-09-10 21:58:37.000000000 -0700
+++ linux-2613-git10/arch/x86_64/kernel/mce_intel.c	2005-09-10 21:58:55.000000000 -0700
@@ -5,6 +5,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
diff -Naurp linux-2613-git10/include/linux/kernel.h~add_taint_inline linux-2613-git10/include/linux/kernel.h
--- linux-2613-git10/include/linux/kernel.h~add_taint_inline	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git10/include/linux/kernel.h	2005-09-10 21:54:13.000000000 -0700
@@ -172,7 +172,10 @@ extern int panic_timeout;
 extern int panic_on_oops;
 extern int tainted;
 extern const char *print_tainted(void);
-extern void add_taint(unsigned);
+static inline void add_taint(unsigned flag)
+{
+	tainted |= flag;
+}
 
 /* Values used for system_state */
 extern enum system_states {
diff -Naurp linux-2613-git10/kernel/panic.c~add_taint_inline linux-2613-git10/kernel/panic.c
--- linux-2613-git10/kernel/panic.c~add_taint_inline	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git10/kernel/panic.c	2005-09-10 21:55:04.000000000 -0700
@@ -167,9 +167,3 @@ const char *print_tainted(void)
 		snprintf(buf, sizeof(buf), "Not tainted");
 	return(buf);
 }
-
-void add_taint(unsigned flag)
-{
-	tainted |= flag;
-}
-EXPORT_SYMBOL(add_taint);
