Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSKZIJZ>; Tue, 26 Nov 2002 03:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSKZIJZ>; Tue, 26 Nov 2002 03:09:25 -0500
Received: from fmr05.intel.com ([134.134.136.6]:5851 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id <S265647AbSKZIJY>;
	Tue, 26 Nov 2002 03:09:24 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601F11696@pdsmsx32.pd.intel.com>
From: "Wang, Stanley" <stanley.wang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>
Subject: [BUG] [2.5.49] symbol_get doesn't work
Date: Tue, 26 Nov 2002 16:14:29 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the symbol_get()/symbol_put() didn't work on my 2.5.49 build.
I think the root cause is a wrong macro definition. The following patch
could 
fix this bug.

diff -Naur -X dontdiff linux-2.5.49/include/linux/module.h
linux-2.5.49-bugfix/include/linux/module.h
--- linux-2.5.49/include/linux/module.h	2002-11-26 16:06:36.000000000 +0800
+++ linux-2.5.49-bugfix/include/linux/module.h	2002-11-26
16:01:52.000000000 +0800
@@ -86,7 +86,7 @@
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
+#define symbol_get(x) ((typeof(&x))(__symbol_get(x)))
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define EXPORT_SYMBOL(sym)				\
@@ -166,7 +166,7 @@
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
-#define symbol_put(x) __symbol_put(#x)
+#define symbol_put(x) __symbol_put(x)
 void symbol_put_addr(void *addr);
 
 /* We only need protection against local interrupts. */


Your Sincerely,
Stanley Wang 

SW Engineer, Intel Corporation.
Intel China Software Lab. 
Tel: 021-52574545 ext. 1171 
iNet: 8-752-1171 
 
Opinions expressed are those of the author and do not represent Intel
Corporation
