Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290828AbSAYXJg>; Fri, 25 Jan 2002 18:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSAYXJZ>; Fri, 25 Jan 2002 18:09:25 -0500
Received: from zero.tech9.net ([209.61.188.187]:12299 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288781AbSAYXJG>;
	Fri, 25 Jan 2002 18:09:06 -0500
Subject: [PATCH] add BUG_ON to 2.4 #1
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 18:14:05 -0500
Message-Id: <1012000446.3799.77.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the BUG_ON (as seen on TV and 2.5) define to
the 2.4 kernel.  This will help in portability and back-porting from 2.5
to 2.4, plus BUG_ON is a nice optimization and aids readability.

For the unaware, BUG_ON(condition) calls bug on !condition, which is
marked unlikely().

This is the generalized arch-independent BUG_ON as in later 2.5 kernels.

Marcelo, please apply.

	Robert Love

--- linux-2.4.18-pre7/include/linux/kernel.h	Thu Jan 24 13:48:18 2002
+++ linux/include/linux/kernel.h	Fri Jan 25 17:53:54 2002
@@ -11,6 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
@@ -181,4 +182,5 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #endif

