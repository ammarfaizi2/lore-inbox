Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSLaWWW>; Tue, 31 Dec 2002 17:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSLaWWW>; Tue, 31 Dec 2002 17:22:22 -0500
Received: from ns.netrox.net ([64.118.231.130]:34811 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S264767AbSLaWWV>;
	Tue, 31 Dec 2002 17:22:21 -0500
Subject: [PATCH] __deprecated requires gcc 3.1
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041373958.1013.9.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 31 Dec 2002 17:32:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

James Bottomley confirmed the "deprecated" attribute requires gcc 3.1
and onward, not gcc 3.0.

Attached patch updates the check in compiler.h to require gcc 3.1 or
greater.

Patch is against current BK, please apply.

	Robert Love

 include/linux/compiler.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -urN linux-2.5.53/include/linux/compiler.h linux/include/linux/compiler.h
--- linux-2.5.53/include/linux/compiler.h~	2002-12-31 17:27:53.000000000 -0500
+++ linux/include/linux/compiler.h	2002-12-31 17:29:09.000000000 -0500
@@ -17,10 +17,9 @@
  * Allow us to mark functions as 'deprecated' and have gcc emit a nice
  * warning for each use, in hopes of speeding the functions removal.
  * Usage is:
- * 		int deprecated foo(void)
- * and then gcc will emit a warning for each usage of the function.
+ * 		int __deprecated foo(void)
  */
-#if __GNUC__ >= 3
+#if ( __GNUC__ == 3 && __GNUC_MINOR > 0 ) || __GNUC__ > 3
 #define __deprecated	__attribute__((deprecated))
 #else
 #define __deprecated



