Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUFZM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUFZM3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267168AbUFZM3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 08:29:47 -0400
Received: from verein.lst.de ([212.34.189.10]:46054 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267165AbUFZM3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 08:29:44 -0400
Date: Sat, 26 Jun 2004 14:29:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix compilation for ppc32
Message-ID: <20040626122935.GA15896@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	paulus@samba.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC has an out of line and exported abs() that gives lots of nice and
wierd compilation erorrs.  Also kill the duplicate cpu_online() in
asm-ppc/smp.h.


--- 1.59/arch/ppc/kernel/ppc_ksyms.c	2004-06-18 08:41:08 +02:00
+++ edited/arch/ppc/kernel/ppc_ksyms.c	2004-06-25 14:52:53 +02:00
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
--- 1.15/include/asm-ppc/smp.h	2004-01-19 07:32:52 +01:00
+++ edited/include/asm-ppc/smp.h	2004-06-25 14:51:47 +02:00
@@ -47,8 +47,6 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-
 extern int __cpu_up(unsigned int cpu);
 
 extern int smp_hw_index[];
--- 1.24/include/asm-ppc/system.h	2004-06-18 08:41:08 +02:00
+++ edited/include/asm-ppc/system.h	2004-06-25 14:51:29 +02:00
@@ -82,7 +82,6 @@
 extern void cvt_fd(float *from, double *to, unsigned long *fpscr);
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
-extern int abs(int);
 extern void cacheable_memzero(void *p, unsigned int nb);
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
