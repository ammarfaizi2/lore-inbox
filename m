Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWASAAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWASAAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWARX7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:43 -0500
Received: from [151.97.230.9] ([151.97.230.9]:13289 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030481AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/8] uml: skas0-hold-own-ldt fixups for x86-64
Date: Thu, 19 Jan 2006 00:55:15 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235514.4626.78783.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a recent fixup i386 code was copied raw to x86_64 subarch to make it compile
again.

Here there are some little fixups and resyncs needed for it (mainly for
cleanliness sake) - I did an audit and found the rest of the code to be safe.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/ldt-x86_64.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-um/ldt-x86_64.h b/include/asm-um/ldt-x86_64.h
index 57159f1..96b35aa 100644
--- a/include/asm-um/ldt-x86_64.h
+++ b/include/asm-um/ldt-x86_64.h
@@ -39,11 +39,13 @@ typedef struct uml_ldt {
 } uml_ldt_t;
 
 /*
- * macros stolen from include/asm-i386/desc.h
+ * macros stolen from include/asm-x86_64/desc.h
  */
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
+/* Don't allow setting of the lm bit. It is useless anyways because
+ * 64bit system calls require __USER_CS. */
 #define LDT_entry_b(info) \
 	(((info)->base_addr & 0xff000000) | \
 	(((info)->base_addr & 0x00ff0000) >> 16) | \
@@ -54,6 +56,7 @@ typedef struct uml_ldt {
 	((info)->seg_32bit << 22) | \
 	((info)->limit_in_pages << 23) | \
 	((info)->useable << 20) | \
+	/* ((info)->lm << 21) | */ \
 	0x7000)
 
 #define LDT_empty(info) (\
@@ -64,6 +67,7 @@ typedef struct uml_ldt {
 	(info)->seg_32bit	== 0	&& \
 	(info)->limit_in_pages	== 0	&& \
 	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
+	(info)->useable		== 0	&& \
+	(info)->lm              == 0)
 
 #endif

