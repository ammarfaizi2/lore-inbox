Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277141AbRJHV2t>; Mon, 8 Oct 2001 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277147AbRJHV2j>; Mon, 8 Oct 2001 17:28:39 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:11792 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S277144AbRJHV23>; Mon, 8 Oct 2001 17:28:29 -0400
Subject: [PATCH] 2.4.10-ac9: EXPORT_SYMBOLS compile fix
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk, kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 08 Oct 2001 17:29:13 -0400
Message-Id: <1002576557.8568.199.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached is against 2.4.10-ac9.  The problem cropped up in ac8.

The kernel will not compile without modules.  This is from a patch by
Keith Owens for 2.4.11-pre5 which has the same problem.  Keith, I assume
this is right?

--- linux-2.4.10-ac9/include/linux/module.h	Mon Oct  8 16:47:36 2001
+++ linux/include/linux/module.h	Mon Oct  8 17:19:10 2001
@@ -348,9 +348,6 @@
 #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
 #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
 
-#elif !defined(EXPORT_SYMTAB)
-
-#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
 #define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
 #define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
 #define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
@@ -362,6 +359,13 @@
 #define EXPORT_SYMBOL_NOVERS(var)
 #define EXPORT_SYMBOL_GPL(var)
 
+#elif !defined(EXPORT_SYMTAB)
+
+#define __EXPORT_SYMBOL(sym,str)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL(var)	  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_NOVERS(var) error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_GPL(var)	  error this_object_must_be_defined_as_export_objs_in_the_Makefile 
+
 #else
 
 #define __EXPORT_SYMBOL(sym, str)			\


	Robert Love

