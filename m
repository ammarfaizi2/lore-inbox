Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUDSNdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264421AbUDSNbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:31:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24334 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264423AbUDSNXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:23:04 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, davem@redhat.com,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sparc64)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYjk-00056P-Nl@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:23:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/sparc64/ subtree.  This has not been compile tested, so
needs the architecture maintainers (or willing volunteers) to
test.

Please ensure that at least the first two patches have already
been applied to your tree; they can be found at:

	http://lkml.org/lkml/2004/4/18/86
	http://lkml.org/lkml/2004/4/18/87

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

In the event that any of these files fails to build, chances are
you need to include some other header file rather than pgalloc.h.
Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
or asm/tlbflush.h.

===== arch/sparc64/kernel/binfmt_aout32.c 1.9 vs edited =====
--- 1.9/arch/sparc64/kernel/binfmt_aout32.c	Mon Apr 12 18:54:53 2004
+++ edited/arch/sparc64/kernel/binfmt_aout32.c	Mon Apr 19 13:45:03 2004
@@ -30,7 +30,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 
 static int load_aout32_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout32_library(struct file*);
===== arch/sparc64/kernel/sparc64_ksyms.c 1.66 vs edited =====
--- 1.66/arch/sparc64/kernel/sparc64_ksyms.c	Tue Mar 30 23:23:37 2004
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	Mon Apr 19 13:45:03 2004
@@ -45,7 +45,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/fpumacro.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #ifdef CONFIG_SBUS
 #include <asm/sbus.h>
===== arch/sparc64/mm/generic.c 1.11 vs edited =====
--- 1.11/arch/sparc64/mm/generic.c	Thu Jun  6 11:27:18 2002
+++ edited/arch/sparc64/mm/generic.c	Mon Apr 19 13:45:03 2004
@@ -10,7 +10,6 @@
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
===== arch/sparc64/mm/hugetlbpage.c 1.14 vs edited =====
--- 1.14/arch/sparc64/mm/hugetlbpage.c	Tue Apr 13 03:30:00 2004
+++ edited/arch/sparc64/mm/hugetlbpage.c	Mon Apr 19 13:45:03 2004
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
