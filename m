Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312306AbSCUAQg>; Wed, 20 Mar 2002 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312308AbSCUAQR>; Wed, 20 Mar 2002 19:16:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:63242 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312306AbSCUAQF>;
	Wed, 20 Mar 2002 19:16:05 -0500
Subject: [PATCH] 2.4: BUG_ON (1/2)
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 20 Mar 2002 19:15:54 -0500
Message-Id: <1016669760.15474.265.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo and Alan,

The attached patch adds 2.5's BUG_ON construct to the 2.4 kernel.  This
is done to facilitate portability and back-porting 2.4 <=> 2.5, because
BUG_ON is a very readable construct, and because it is a small
optimization over standard BUG.

For the unaware,  BUG_ON(condition) is basically

	if (unlikely(condition) != 0) BUG();

There was some talk in one of Andrew's aa-vm threads over introducing 
BUG_ON in 2.4 - so I resend this patch.  There was also talk of a new
name (Jeff Garzik mentioned kassert).  This is fine, but since much of
the goal is portability between 2.4 and 2.5 the change needs to
subsequently be made in 2.5.  We can handle that later, if need be.

This patch is against 2.4.19-pre4, but also applies to 2.4.19-ac.  Alan
and Marcelo - please apply.

	Robert Love

diff -urN linux-2.4.19-pre4/include/linux/kernel.h linux/include/linux/kernel.h
--- linux-2.4.19-pre4/include/linux/kernel.h	Wed Mar 20 17:43:58 2002
+++ linux/include/linux/kernel.h	Wed Mar 20 17:51:38 2002
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

