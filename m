Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWFWSmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWFWSmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWFWSlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15823 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751906AbWFWSlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:49 -0400
Message-Id: <20060623183909.483825000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:30:58 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] fix constraints of the signal functions and some cleanup
Content-Disposition: inline; filename=0002-M68K-fix-constraints-of-the-signal-functions-and-some-cleanup.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/signal.h |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

5bc06b9ae874f25bf2fd68ecd1aabcd09518d189
diff --git a/include/asm-m68k/signal.h b/include/asm-m68k/signal.h
index b7b7ea2..85037a3 100644
--- a/include/asm-m68k/signal.h
+++ b/include/asm-m68k/signal.h
@@ -156,13 +156,17 @@ #define __HAVE_ARCH_SIG_BITOPS
 
 static inline void sigaddset(sigset_t *set, int _sig)
 {
-	__asm__("bfset %0{%1,#1}" : "=m" (*set) : "id" ((_sig - 1) ^ 31)
+	asm ("bfset %0{%1,#1}"
+		: "+od" (*set)
+		: "id" ((_sig - 1) ^ 31)
 		: "cc");
 }
 
 static inline void sigdelset(sigset_t *set, int _sig)
 {
-	__asm__("bfclr %0{%1,#1}" : "=m"(*set) : "id"((_sig - 1) ^ 31)
+	asm ("bfclr %0{%1,#1}"
+		: "+od" (*set)
+		: "id" ((_sig - 1) ^ 31)
 		: "cc");
 }
 
@@ -175,8 +179,10 @@ static inline int __const_sigismember(si
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	int ret;
-	__asm__("bfextu %1{%2,#1},%0"
-		: "=d"(ret) : "m"(*set), "id"((_sig-1) ^ 31));
+	asm ("bfextu %1{%2,#1},%0"
+		: "=d" (ret)
+		: "od" (*set), "id" ((_sig-1) ^ 31)
+		: "cc");
 	return ret;
 }
 
@@ -187,7 +193,10 @@ #define sigismember(set,sig)			\
 
 static inline int sigfindinword(unsigned long word)
 {
-	__asm__("bfffo %1{#0,#0},%0" : "=d"(word) : "d"(word & -word) : "cc");
+	asm ("bfffo %1{#0,#0},%0"
+		: "=d" (word)
+		: "d" (word & -word)
+		: "cc");
 	return word ^ 31;
 }
 
-- 
1.3.3

--

