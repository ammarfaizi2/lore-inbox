Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTAQEl5>; Thu, 16 Jan 2003 23:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267369AbTAQEl5>; Thu, 16 Jan 2003 23:41:57 -0500
Received: from dp.samba.org ([66.70.73.150]:11743 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267365AbTAQEl4>;
	Thu, 16 Jan 2003 23:41:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: [PATCH] Richard Henderson for President!
Date: Fri, 17 Jan 2003 15:49:15 +1100
Message-Id: <20030117045054.9A2F72C073@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  Makes symbol_get work if !CONFIG_MODULE.

Name: symbol_get fix
Author: Rusty Russell
Status: Trivial

D: Make symbol_get() use undefined weak symbols if !CONFIG_MODULE.
D: Many thanks to RTH for introducing undef weak symbols to me.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .932-linux-2.5-bk/include/linux/module.h .932-linux-2.5-bk.updated/include/linux/module.h
--- .932-linux-2.5-bk/include/linux/module.h	2003-01-17 12:59:22.000000000 +1100
+++ .932-linux-2.5-bk.updated/include/linux/module.h	2003-01-17 15:44:57.000000000 +1100
@@ -344,7 +344,7 @@ static inline int module_text_address(un
 }
 
 /* Get/put a kernel symbol (calls should be symmetric) */
-#define symbol_get(x) (&(x))
+#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(x) do { } while(0)
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
