Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWBRO7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWBRO7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBRO7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:59:40 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:43201 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751348AbWBRO7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:59:39 -0500
Date: Sat, 18 Feb 2006 15:59:38 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH/RFC] remove duplicate #includes, take II, part C
Message-ID: <20060218145938.GD32618@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Bastian Blank <bastian@waldi.eu.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Jean Delvare <khali@linux-fr.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20060218145525.GA32618@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145525.GA32618@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the wrong ones

---

diff -NurpP linux-2.6.16-rc4/mm/slab.c linux-2.6.16-rc4-rmd/mm/slab.c
--- linux-2.6.16-rc4/mm/slab.c	2006-02-18 14:40:38 +0100
+++ linux-2.6.16-rc4-rmd/mm/slab.c	2006-02-18 15:30:15 +0100
@@ -626,7 +626,6 @@ struct cache_names {
 
 static struct cache_names __initdata cache_names[] = {
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
-#include <linux/kmalloc_sizes.h>
 	{NULL,}
 #undef CACHE
 };
diff -NurpP linux-2.6.16-rc4/arch/um/sys-x86_64/syscall_table.c linux-2.6.16-rc4-rmd/arch/um/sys-x86_64/syscall_table.c
--- linux-2.6.16-rc4/arch/um/sys-x86_64/syscall_table.c	2005-06-22 02:38:01 +0200
+++ linux-2.6.16-rc4-rmd/arch/um/sys-x86_64/syscall_table.c	2006-02-18 15:30:09 +0100
@@ -55,5 +55,4 @@ extern void sys_ni_syscall(void);
 sys_call_ptr_t sys_call_table[__NR_syscall_max+1] __cacheline_aligned = {
 	/* Smells like a like a compiler bug -- it doesn't work when the & below is removed. */
 	[0 ... __NR_syscall_max] = &sys_ni_syscall,
-#include <asm-x86_64/unistd.h>
 };
diff -NurpP linux-2.6.16-rc4/arch/x86_64/kernel/syscall.c linux-2.6.16-rc4-rmd/arch/x86_64/kernel/syscall.c
--- linux-2.6.16-rc4/arch/x86_64/kernel/syscall.c	2006-02-18 14:39:50 +0100
+++ linux-2.6.16-rc4-rmd/arch/x86_64/kernel/syscall.c	2006-02-18 15:30:09 +0100
@@ -22,5 +22,4 @@ extern void sys_ni_syscall(void);
 const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/* Smells like a like a compiler bug -- it doesn't work when the & below is removed. */ 
 	[0 ... __NR_syscall_max] = &sys_ni_syscall,
-#include <asm-x86_64/unistd.h>
 };

