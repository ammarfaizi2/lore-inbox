Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277659AbRJIAT4>; Mon, 8 Oct 2001 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277660AbRJIATg>; Mon, 8 Oct 2001 20:19:36 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:44552 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277659AbRJIATd>;
	Mon, 8 Oct 2001 20:19:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robert Love <rml@tech9.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac9: EXPORT_SYMBOLS compile fix 
In-Reply-To: Your message of "08 Oct 2001 17:29:13 -0400."
             <1002576557.8568.199.camel@phantasy> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 10:19:50 +1000
Message-ID: <13322.1002586790@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Oct 2001 17:29:13 -0400, 
Robert Love <rml@tech9.net> wrote:
>The attached is against 2.4.10-ac9.  The problem cropped up in ac8.
>
>The kernel will not compile without modules.  This is from a patch by
>Keith Owens for 2.4.11-pre5 which has the same problem.  Keith, I assume
>this is right?
>
>--- linux-2.4.10-ac9/include/linux/module.h	Mon Oct  8 16:47:36 2001
>+++ linux/include/linux/module.h	Mon Oct  8 17:19:10 2001
>@@ -348,9 +348,6 @@
> #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
> #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
> 
>-#elif !defined(EXPORT_SYMTAB)
>-
>-#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
> #define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
> #define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
> #define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
>@@ -362,6 +359,13 @@
> #define EXPORT_SYMBOL_NOVERS(var)
> #define EXPORT_SYMBOL_GPL(var)
> 
>+#elif !defined(EXPORT_SYMTAB)
>+
>+#define __EXPORT_SYMBOL(sym,str)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
>+#define EXPORT_SYMBOL(var)	  error this_object_must_be_defined_as_export_objs_in_the_Makefile
>+#define EXPORT_SYMBOL_NOVERS(var) error this_object_must_be_defined_as_export_objs_in_the_Makefile
>+#define EXPORT_SYMBOL_GPL(var)	  error this_object_must_be_defined_as_export_objs_in_the_Makefile 
>+
> #else
> 
> #define __EXPORT_SYMBOL(sym, str)			\

The patch is incomplete, you left some lines behind.  This is the patch
against 2.4.11-pre5.

Index: 11-pre5.1/include/linux/module.h
--- 11-pre5.1/include/linux/module.h Mon, 08 Oct 2001 10:58:25 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6 644)
+++ 11-pre5.1(w)/include/linux/module.h Mon, 08 Oct 2001 11:08:09 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6 644)
@@ -348,19 +348,19 @@ extern struct module *module_list;
 #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
 #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
 
-#elif !defined(EXPORT_SYMTAB)
-
-#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
-
 #elif !defined(CONFIG_MODULES)
 
 #define __EXPORT_SYMBOL(sym,str)
 #define EXPORT_SYMBOL(var)
 #define EXPORT_SYMBOL_NOVERS(var)
 #define EXPORT_SYMBOL_GPL(var)
+
+#elif !defined(EXPORT_SYMTAB)
+
+#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
 
 #else
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


