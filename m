Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbUDSNc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUDSN3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:29:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19726 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264418AbUDSNW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:26 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, anton@au.ibm.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (ppc64)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYj8-00056D-3p@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:22:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/ppc64/ subtree.  This has not been compile tested, so
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

===== arch/ppc64/mm/hugetlbpage.c 1.23 vs edited =====
--- 1.23/arch/ppc64/mm/hugetlbpage.c	Sat Apr 17 19:19:31 2004
+++ edited/arch/ppc64/mm/hugetlbpage.c	Mon Apr 19 13:41:03 2004
@@ -18,7 +18,6 @@
 #include <linux/err.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
===== arch/ppc64/mm/imalloc.c 1.4 vs edited =====
--- 1.4/arch/ppc64/mm/imalloc.c	Fri Feb 27 05:25:17 2004
+++ edited/arch/ppc64/mm/imalloc.c	Mon Apr 19 13:41:03 2004
@@ -11,7 +11,6 @@
 #include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/semaphore.h>
 
===== arch/ppc64/mm/init.c 1.67 vs edited =====
--- 1.67/arch/ppc64/mm/init.c	Mon Apr 12 18:54:08 2004
+++ edited/arch/ppc64/mm/init.c	Mon Apr 19 13:41:03 2004
@@ -37,7 +37,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 
-#include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/abs_addr.h>
 #include <asm/prom.h>
