Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSL1Ujy>; Sat, 28 Dec 2002 15:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSL1Ujy>; Sat, 28 Dec 2002 15:39:54 -0500
Received: from ns.netrox.net ([64.118.231.130]:27391 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S265612AbSL1Ujx>;
	Sat, 28 Dec 2002 15:39:53 -0500
Subject: Re: [PATCH] deprecated function attribute
From: Robert Love <rml@tech9.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021228185355.GA22304@nevyn.them.org>
References: <20021228035319.903502C04B@lists.samba.org>
	 <20021228153009.GA29614@groucho.verza.com> <1041097877.1066.9.camel@icbm>
	 <1041098631.1066.13.camel@icbm>  <20021228185355.GA22304@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1041108612.948.22.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Dec 2002 15:50:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 13:53, Daniel Jacobowitz wrote:

> > If we want to be preemptive, we can rename the above to "__deprecated__"
> > but I think plain "deprecated" is much better looking.
> 
> Eek, please call it something else - something that looks visibly like
> a syntax rather than a name.  __deprecated or __deprecated__ or
> DEPRECATED.

Like I said, that is fine with me...

Attached.  Still untested :-)

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
+#define __deprecated__		__attribute__((deprecated))
+#else
+#define __deprecated__
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\



