Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbUJ2JiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbUJ2JiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUJ2JiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:38:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19169 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263173AbUJ2Jhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:37:38 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 2.6.10-rc1] Include useful absolute symbols in kallsyms
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Oct 2004 19:37:01 +1000
Message-ID: <19397.1099042621@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some absolute symbols are useful, they can even appear in back traces.
Tweak kallsyms to retain the useful absolute symbols.

Signed-off-by: Keith Owens <kaos@sgi.com>

---

This list is from ia64, add absolute symbols from other architectures
as required.

Index: linux/scripts/kallsyms.c
===================================================================
--- linux.orig/scripts/kallsyms.c	Fri Oct 29 17:01:13 2004
+++ linux/scripts/kallsyms.c	Fri Oct 29 18:31:05 2004
@@ -121,7 +121,14 @@ read_symbol(FILE *in, struct sym_entry *
 		_sinittext = s->addr;
 	else if (strcmp(str, "_einittext") == 0)
 		_einittext = s->addr;
-	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
+	else if (toupper(s->type) == 'A') {
+		/* Keep these useful absolute symbols */
+		if (strcmp(str, "__kernel_syscall_via_break") &&
+		    strcmp(str, "__kernel_syscall_via_epc") &&
+		    strcmp(str, "__kernel_sigtramp") &&
+		    strcmp(str, "__gp"))
+			return -1;
+	} else if (toupper(s->type) == 'U')
 		return -1;
 
 	/* include the type field in the symbol name, so that it gets

