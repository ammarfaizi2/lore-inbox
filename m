Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWJKVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWJKVXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161414AbWJKVGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:62367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161413AbWJKVGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:22 -0400
Date: Wed, 11 Oct 2006 14:05:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Hirokazu Takata <takata@linux-m32r.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 27/67] Fix make headers_check on m32r
Message-ID: <20061011210543.GB16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0005-Fix-make-headers_check-on-m32r.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

> asm-m32r/page.h requires asm-generic/memory_model.h, which does not exist
> asm-m32r/ptrace.h requires asm/m32r.h, which does not exist
> asm-m32r/signal.h requires linux/linkage.h, which does not exist
> asm-m32r/unistd.h requires asm/syscall.h, which does not exist
> asm-m32r/user.h requires asm/processor.h, which does not exist

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-m32r/page.h   |    3 +--
 include/asm-m32r/ptrace.h |    4 ++--
 include/asm-m32r/signal.h |    1 -
 include/asm-m32r/unistd.h |    4 ++--
 include/asm-m32r/user.h   |    1 -
 5 files changed, 5 insertions(+), 8 deletions(-)

--- linux-2.6.18.orig/include/asm-m32r/page.h
+++ linux-2.6.18/include/asm-m32r/page.h
@@ -87,10 +87,9 @@ typedef struct { unsigned long pgprot; }
 
 #define devmem_is_allowed(x) 1
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
 #endif /* _ASM_M32R_PAGE_H */
 
--- linux-2.6.18.orig/include/asm-m32r/ptrace.h
+++ linux-2.6.18/include/asm-m32r/ptrace.h
@@ -12,8 +12,6 @@
  *   Copyright (C) 2001-2002, 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
-#include <asm/m32r.h>		/* M32R_PSW_BSM, M32R_PSW_BPM */
-
 /* 0 - 13 are integer registers (general purpose registers).  */
 #define PT_R4		0
 #define PT_R5		1
@@ -140,6 +138,8 @@ struct pt_regs {
 
 #ifdef __KERNEL__
 
+#include <asm/m32r.h>		/* M32R_PSW_BSM, M32R_PSW_BPM */
+
 #define __ARCH_SYS_PTRACE	1
 
 #if defined(CONFIG_ISA_M32R2) || defined(CONFIG_CHIP_VDEC2)
--- linux-2.6.18.orig/include/asm-m32r/signal.h
+++ linux-2.6.18/include/asm-m32r/signal.h
@@ -6,7 +6,6 @@
 /* orig : i386 2.4.18 */
 
 #include <linux/types.h>
-#include <linux/linkage.h>
 #include <linux/time.h>
 #include <linux/compiler.h>
 
--- linux-2.6.18.orig/include/asm-m32r/unistd.h
+++ linux-2.6.18/include/asm-m32r/unistd.h
@@ -3,8 +3,6 @@
 
 /* $Id$ */
 
-#include <asm/syscall.h>	/* SYSCALL_* */
-
 /*
  * This file contains the system call numbers.
  */
@@ -303,6 +301,8 @@
  * <asm-m32r/errno.h>
  */
 
+#include <asm/syscall.h>	/* SYSCALL_* */
+
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-(124 + 1))) { \
--- linux-2.6.18.orig/include/asm-m32r/user.h
+++ linux-2.6.18/include/asm-m32r/user.h
@@ -8,7 +8,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 

--
