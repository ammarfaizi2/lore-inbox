Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWAFKqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWAFKqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWAFKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17043 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964906AbWAFKpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:51 -0500
Subject: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:45:09 +0100
Message-Id: <1136544309.2940.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: when CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining
From: Ingo Molnar <mingo@elte.hu>

if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
to decide what to inline and what not - instead of the kernel forcing gcc
to inline all the time. This requires several places that require to be 
inlined to be marked as such, previous patches in this series do that.
This is probably the most flame-worthy patch of the series.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/linux/compiler-gcc4.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.15/include/linux/compiler-gcc4.h
===================================================================
--- linux-2.6.15.orig/include/linux/compiler-gcc4.h
+++ linux-2.6.15/include/linux/compiler-gcc4.h
@@ -3,9 +3,11 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
+#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
+# define inline			inline		__attribute__((always_inline))
+# define __inline__		__inline__	__attribute__((always_inline))
+# define __inline		__inline	__attribute__((always_inline))
+#endif
 #define __always_inline		inline __attribute__((always_inline))
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))


