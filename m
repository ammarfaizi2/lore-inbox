Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWAFKpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWAFKpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWAFKpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10131 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932173AbWAFKpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:24 -0500
Subject: [patch 1/7] Make __always_inline actually force always inlining
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:37:05 +0100
Message-Id: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
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

From: Ingo Molnar <mingo@elte.he>

This patch is the first in a series that tries to optimize the kernel in terms of size
(and thus cache behavior, both cpu and pagecache).

This first patch changes __always_inline to be a forced inline instead of
the "regular" inline it was on everything except alpha. This forced inline
matches the intention of the define better as a matter of documentation.
There is no change in behavior by this patch, since "inline" currently is
mapped to a forced inline anyway.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

===================================================================
--- linux-2.6.15.orig/include/linux/compiler-gcc3.h
+++ linux-2.6.15/include/linux/compiler-gcc3.h
@@ -9,6 +9,8 @@
 # define __inline	__inline	__attribute__((always_inline))
 #endif
 
+#define __always_inline		inline __attribute__((always_inline))
+
 #if __GNUC_MINOR__ > 0
 # define __deprecated		__attribute__((deprecated))
 #endif
Index: linux-2.6.15/include/linux/compiler-gcc4.h
===================================================================
--- linux-2.6.15.orig/include/linux/compiler-gcc4.h
+++ linux-2.6.15/include/linux/compiler-gcc4.h
@@ -6,6 +6,7 @@
 #define inline			inline		__attribute__((always_inline))
 #define __inline__		__inline__	__attribute__((always_inline))
 #define __inline		__inline	__attribute__((always_inline))
+#define __always_inline		inline __attribute__((always_inline))
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))


