Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUDSN1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUDSN13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:27:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13326 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264412AbUDSNVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:21:35 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, jes@trained-monkey.org,
       linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68k)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/m68k/ subtree.  This has not been compile tested, so
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

===== arch/m68k/kernel/m68k_ksyms.c 1.11 vs edited =====
--- 1.11/arch/m68k/kernel/m68k_ksyms.c	Mon Mar 31 23:29:49 2003
+++ edited/arch/m68k/kernel/m68k_ksyms.c	Mon Apr 19 13:37:04 2004
@@ -11,7 +11,6 @@
 
 #include <asm/setup.h>
 #include <asm/machdep.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
===== arch/m68k/kernel/traps.c 1.18 vs edited =====
--- 1.18/arch/m68k/kernel/traps.c	Sun Mar 21 19:44:20 2004
+++ edited/arch/m68k/kernel/traps.c	Mon Apr 19 13:37:04 2004
@@ -37,7 +37,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/traps.h>
-#include <asm/pgalloc.h>
 #include <asm/machdep.h>
 #include <asm/siginfo.h>
 
===== arch/m68k/mm/fault.c 1.4 vs edited =====
--- 1.4/arch/m68k/mm/fault.c	Thu Jan  9 14:02:02 2003
+++ edited/arch/m68k/mm/fault.c	Mon Apr 19 13:37:04 2004
@@ -15,7 +15,6 @@
 #include <asm/traps.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 
 extern void die_if_kernel(char *, struct pt_regs *, long);
 extern const int frame_extra_sizes[]; /* in m68k/kernel/signal.c */
===== arch/m68k/mm/init.c 1.12 vs edited =====
--- 1.12/arch/m68k/mm/init.c	Mon Feb 23 05:24:04 2004
+++ edited/arch/m68k/mm/init.c	Mon Apr 19 13:37:04 2004
@@ -21,7 +21,6 @@
 #include <asm/setup.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
===== arch/m68k/mm/kmap.c 1.4 vs edited =====
--- 1.4/arch/m68k/mm/kmap.c	Sun Mar 21 21:29:28 2004
+++ edited/arch/m68k/mm/kmap.c	Mon Apr 19 13:37:04 2004
@@ -18,7 +18,6 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
===== arch/m68k/mm/memory.c 1.13 vs edited =====
--- 1.13/arch/m68k/mm/memory.c	Mon Apr 12 18:54:39 2004
+++ edited/arch/m68k/mm/memory.c	Mon Apr 19 13:37:04 2004
@@ -16,7 +16,6 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
===== arch/m68k/mm/motorola.c 1.10 vs edited =====
--- 1.10/arch/m68k/mm/motorola.c	Sun Mar 21 21:22:15 2004
+++ edited/arch/m68k/mm/motorola.c	Mon Apr 19 13:37:04 2004
@@ -23,7 +23,6 @@
 #include <asm/setup.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
===== arch/m68k/sun3x/dvma.c 1.3 vs edited =====
--- 1.3/arch/m68k/sun3x/dvma.c	Mon May 20 14:43:35 2002
+++ edited/arch/m68k/sun3x/dvma.c	Mon Apr 19 13:37:04 2004
@@ -23,7 +23,6 @@
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 /* IOMMU support */
 
