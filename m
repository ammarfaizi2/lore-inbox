Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTHWFGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 01:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTHWFGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 01:06:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:35803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbTHWFGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 01:06:45 -0400
Date: Fri, 22 Aug 2003 22:05:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: kai.germaschewski@gmx.de, rusty@rustcorp.com.au
Subject: [PATCH] eliminate gcc warnings on assert [__builtin_expect]
Message-Id: <20030822220500.6c0e1053.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building genksyms on ia64 (gcc 3.3.1) produces these warnings:

scripts/genksyms/genksyms.c: In function `copy_node':
scripts/genksyms/genksyms.c:224: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast
scripts/genksyms/genksyms.c: In function `expand_and_crc_list':
scripts/genksyms/genksyms.c:384: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast
scripts/genksyms/genksyms.c:390: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast
scripts/genksyms/genksyms.c:396: warning: passing arg 1 of `__builtin_expect' makes integer from pointer without a cast


Is there a problem with coercing the pointer parameter to be (int)?

--
~Randy


patch_name:	ksyms_assert.patch
patch_version:	2003-08-22.21:28:40
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	eliminate gcc warnings on assert/__builtin_expect();
product:	Linux
product_versions: 260-test4
diffstat:	=
 scripts/genksyms/genksyms.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./scripts/genksyms/genksyms.h~astype ./scripts/genksyms/genksyms.h
--- ./scripts/genksyms/genksyms.h~astype	Fri Aug  8 21:39:02 2003
+++ ./scripts/genksyms/genksyms.h	Fri Aug 22 21:14:59 2003
@@ -89,8 +89,8 @@
 
 #define MODUTILS_VERSION "<in-kernel>"
 
-#define xmalloc(size) ({ void *__ptr = malloc(size); assert(__ptr || size == 0); __ptr; })
-#define xstrdup(str)  ({ char *__str = strdup(str); assert(__str); __str; })
+#define xmalloc(size) ({ void *__ptr = malloc(size); assert((int)__ptr || size == 0); __ptr; })
+#define xstrdup(str)  ({ char *__str = strdup(str); assert((int)__str); __str; })
 
 
 #endif /* genksyms.h */
