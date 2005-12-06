Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbVLFNWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbVLFNWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLFNWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:22:45 -0500
Received: from mail.renesas.com ([202.234.163.13]:50618 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751664AbVLFNWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:22:44 -0500
Date: Tue, 06 Dec 2005 22:22:41 +0900 (JST)
Message-Id: <20051206.222241.1005850474.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, inaoka@linux-m32r.org, takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm1] m32r: Update syscall macros for MMU-less
 targets
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for updating m32r's MMU-less support.

Some legacy MMU-less m32r chips cannot return from a trap handler to 
the right-hand side 16-bit halfword code of a 32-bit instrucion
code pair, because a "trap" instruction specification was expanded
in M32R-II ISA.

This modification forces "trap" instructions to be placed in
word alignment location with a parallel "nop" code.

Signed-off-by: Kazuhiro Inaoka <inaoka@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/unistd.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.15-rc5-mm1/include/asm-m32r/unistd.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/unistd.h	2005-12-06 10:36:03.181901232 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/unistd.h	2005-12-06 21:02:56.932741944 +0900
@@ -319,7 +319,7 @@ type name(void) \
 register long __scno __asm__ ("r7") = __NR_##name; \
 register long __res __asm__("r0"); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno) \
 	: "memory"); \
@@ -332,7 +332,7 @@ type name(type1 arg1) \
 register long __scno __asm__ ("r7") = __NR_##name; \
 register long __res __asm__ ("r0") = (long)(arg1); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno), "0" (__res) \
 	: "memory"); \
@@ -346,7 +346,7 @@ register long __scno __asm__ ("r7") = __
 register long __arg2 __asm__ ("r1") = (long)(arg2); \
 register long __res __asm__ ("r0") = (long)(arg1); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno), "0" (__res), "r" (__arg2) \
 	: "memory"); \
@@ -361,7 +361,7 @@ register long __arg3 __asm__ ("r2") = (l
 register long __arg2 __asm__ ("r1") = (long)(arg2); \
 register long __res __asm__ ("r0") = (long)(arg1); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno), "0" (__res), "r" (__arg2), \
 		"r" (__arg3) \
@@ -378,7 +378,7 @@ register long __arg3 __asm__ ("r2") = (l
 register long __arg2 __asm__ ("r1") = (long)(arg2); \
 register long __res __asm__ ("r0") = (long)(arg1); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno), "0" (__res), "r" (__arg2), \
 		"r" (__arg3), "r" (__arg4) \
@@ -397,7 +397,7 @@ register long __arg3 __asm__ ("r2") = (l
 register long __arg2 __asm__ ("r1") = (long)(arg2); \
 register long __res __asm__ ("r0") = (long)(arg1); \
 __asm__ __volatile__ (\
-	"trap #" SYSCALL_VECTOR \
+	"trap #" SYSCALL_VECTOR "|| nop"\
 	: "=r" (__res) \
 	: "r" (__scno), "0" (__res), "r" (__arg2), \
 		"r" (__arg3), "r" (__arg4), "r" (__arg5) \

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
