Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUFYGJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUFYGJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUFYGJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:09:28 -0400
Received: from havoc.gtf.org ([216.162.42.101]:25540 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266218AbUFYGJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:09:26 -0400
Date: Fri, 25 Jun 2004 02:09:24 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
Subject: [PATCH] abs()/ppc build breakage fix
Message-ID: <20040625060924.GA9307@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Fix against current 2.6.7-bk)

include/linux/kernel.h now has abs() as a preprocessor macro.
This breaks some of the ppc build, as other headers define abs() 
as a function.  This patch fixes it for me.

-dte


diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	2004-06-18 08:41:08 +02:00
+++ b/arch/ppc/kernel/ppc_ksyms.c	2004-06-25 07:39:50 +02:00
@@ -68,7 +68,6 @@
 long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
-int abs(int);
 
 extern unsigned long mm_ptov (unsigned long paddr);
 
@@ -275,8 +274,6 @@
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
-
-EXPORT_SYMBOL(abs);
 
 #if defined(CONFIG_FB_VGA16_MODULE)
 EXPORT_SYMBOL(screen_info);
diff -Nru a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h	2004-06-18 08:41:08 +02:00
+++ b/include/asm-ppc/system.h	2004-06-25 07:35:12 +02:00
@@ -82,7 +82,6 @@
 extern void cvt_fd(float *from, double *to, unsigned long *fpscr);
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
-extern int abs(int);
 extern void cacheable_memzero(void *p, unsigned int nb);
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
