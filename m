Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267166AbUFZNDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbUFZNDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUFZNDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 09:03:52 -0400
Received: from ozlabs.org ([203.10.76.45]:54424 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267166AbUFZNDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 09:03:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16605.29745.932062.225051@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jun 2004 23:03:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix compilation for ppc32
In-Reply-To: <20040626122935.GA15896@lst.de>
References: <20040626122935.GA15896@lst.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> PPC has an out of line and exported abs() that gives lots of nice and
> wierd compilation erorrs.  Also kill the duplicate cpu_online() in
> asm-ppc/smp.h.

Looks good, Andrew or Linus, please apply.  I never understood why we
kept that abs thing floating around.

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
