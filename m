Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSL1RmO>; Sat, 28 Dec 2002 12:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSL1RmO>; Sat, 28 Dec 2002 12:42:14 -0500
Received: from ns.netrox.net ([64.118.231.130]:23500 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S266233AbSL1RmN>;
	Sat, 28 Dec 2002 12:42:13 -0500
Subject: [PATCH] deprecated function attribute
From: Robert Love <rml@tech9.net>
To: Alexander Kellett <lypanov@kde.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, william stinson <wstinson@wanadoo.fr>,
       trivial@rustcorp.com.au
In-Reply-To: <20021228153009.GA29614@groucho.verza.com>
References: <20021228035319.903502C04B@lists.samba.org>
	 <20021228153009.GA29614@groucho.verza.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041097877.1066.9.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Dec 2002 12:51:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 10:30, Alexander Kellett wrote:

> can gcc 3.2's __attribute__((deprecated)) be used?

I just tested it and it seems to work.  If we mark a function as
deprecated, then each use of the function emits a warning like:

	foo.c:12: warning: `baz' is deprecated (declared at bar.c:60)

Which is very informative, giving both the location of each usage and
where the little bastard is declared.

It seems like this was added in gcc 3.0, not 3.2?  It was at least in
3.1...

Attached patch adds support for usage of the attribute as "deprecated"
and is backward-compatible.  Usage is:

	int deprecated foo(void)

etc.. The attached patch is _entirely_ untested.

	Robert Love

 compiler.h |   13 +++++++++++++
 1 files changed, 13 insertions(+)


diff -urN linux-2.5.53/include/linux/compiler.h linux/include/linux/compiler.h
--- linux-2.5.53/include/linux/compiler.h	2002-12-28 12:38:56.000000000 -0500
+++ linux/include/linux/compiler.h	2002-12-28 12:45:03.000000000 -0500
@@ -13,6 +13,19 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+/*
+ * Allow us to mark functions as 'deprecated' and have gcc emit a nice
+ * warning for each use, in hopes of speeding the functions removal.
+ * Usage is:
+ * 		int deprecated foo(void)
+ * and then gcc will emit a warning for each usage of the function.
+ */
+#if __GNUC__ == 3
+#define deprecated	__attribute__((deprecated))
+#else
+#define deprecated
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\



