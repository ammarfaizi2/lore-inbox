Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTEOCDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTEOCDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:03:37 -0400
Received: from dp.samba.org ([66.70.73.150]:21894 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263656AbTEOCDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:03:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au, rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __optional and __keep
Date: Thu, 15 May 2003 12:09:25 +1000
Message-Id: <20030515021624.B814B2C017@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Does anyone else find __attribute_used__ confusing, or is it just me?
In the tradition of likely() and unlikely(), I think __optional and
__keep are clearer.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __keep and __optional attributes
Author: Rusty Russell
Status: Trivial

D: Renames __attribute_used to __keep, and introduces __optional.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21892-linux-2.5.69-bk9/include/linux/compiler.h .21892-linux-2.5.69-bk9.updated/include/linux/compiler.h
--- .21892-linux-2.5.69-bk9/include/linux/compiler.h	2003-04-20 18:05:14.000000000 +1000
+++ .21892-linux-2.5.69-bk9.updated/include/linux/compiler.h	2003-05-15 11:11:19.000000000 +1000
@@ -51,10 +51,11 @@
  * would be warned about except with attribute((unused)).
  */
 #if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
+#define __keep		__attribute__((__used__))
 #else
-#define __attribute_used__	__attribute__((__unused__))
+#define __keep		__attribute__((__unused__))
 #endif
+#define __optional	__attribute__((__unused__))
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21892-linux-2.5.69-bk9/scripts/modpost.c .21892-linux-2.5.69-bk9.updated/scripts/modpost.c
--- .21892-linux-2.5.69-bk9/scripts/modpost.c	2003-05-05 12:37:16.000000000 +1000
+++ .21892-linux-2.5.69-bk9.updated/scripts/modpost.c	2003-05-15 11:11:19.000000000 +1000
@@ -466,7 +466,7 @@ add_depends(struct buffer *b, struct mod
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const char __module_depends[]\n");
-	buf_printf(b, "__attribute_used__\n");
+	buf_printf(b, "__keep\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
