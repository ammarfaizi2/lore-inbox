Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVKAPRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVKAPRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVKAPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:17:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:20651 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750851AbVKAPRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:17:17 -0500
Date: Tue, 1 Nov 2005 15:17:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc bug.h namespace pollution
Message-ID: <20051101151716.GY7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	DATA_TYPE is really not a good thing to put into header that
gets included all over the tree...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/include/asm-powerpc/bug.h current/include/asm-powerpc/bug.h
--- RC14-base/include/asm-powerpc/bug.h	2005-11-01 02:39:50.000000000 -0500
+++ current/include/asm-powerpc/bug.h	2005-11-01 04:50:01.000000000 -0500
@@ -15,12 +15,12 @@
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".llong " #label "\n .long " #line "\n .llong " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: tdnei " #ra ", " #rb "\n"
-#define DATA_TYPE long long
+#define BUG_DATA_TYPE long long
 #else 
 #define BUG_TABLE_ENTRY(label, line, file, func) \
 	".long " #label ", " #line ", " #file ", " #func "\n"
 #define TRAP_OP(ra, rb) "1: twnei " #ra ", " #rb "\n"
-#define DATA_TYPE int
+#define BUG_DATA_TYPE int
 #endif /* __powerpc64__ */
 
 struct bug_entry {
@@ -55,7 +55,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)), "i" (__LINE__),	\
+		: : "r" ((BUG_DATA_TYPE)(x)), "i" (__LINE__),	\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
@@ -65,7 +65,7 @@
 		".section __bug_table,\"a\"\n\t"		\
 		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
 		".previous"					\
-		: : "r" ((DATA_TYPE)(x)),			\
+		: : "r" ((BUG_DATA_TYPE)(x)),			\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
