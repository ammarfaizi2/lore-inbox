Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbUDSN1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbUDSN0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:26:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9998 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264407AbUDSNUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:20:54 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, spyro@f2s.com
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (arm26)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYhe-00055m-8l@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:20:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/arm26/ subtree.  This has not been compile tested, so
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

===== kernel/armksyms.c 1.2 vs edited =====
--- 1.2/arch/arm26/kernel/armksyms.c	Wed Feb 25 10:31:13 2004
+++ edited/kernel/armksyms.c	Mon Apr 19 13:33:35 2004
@@ -27,7 +27,6 @@
 #include <asm/elf.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/pgalloc.h>
 //#include <asm/proc-fns.h>
 #include <asm/processor.h>
 #include <asm/semaphore.h>
===== kernel/ecard.c 1.3 vs edited =====
--- 1.3/arch/arm26/kernel/ecard.c	Wed Aug 27 01:27:45 2003
+++ edited/kernel/ecard.c	Mon Apr 19 13:33:35 2004
@@ -42,7 +42,6 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/irq.h>
 #include <asm/irqchip.h>
===== kernel/fiq.c 1.1 vs edited =====
--- 1.1/arch/arm26/kernel/fiq.c	Wed Jun  4 12:15:45 2003
+++ edited/kernel/fiq.c	Mon Apr 19 13:33:35 2004
@@ -46,7 +46,6 @@
 #include <asm/fiq.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
===== kernel/signal.c 1.1 vs edited =====
--- 1.1/arch/arm26/kernel/signal.c	Wed Jun  4 12:15:45 2003
+++ edited/kernel/signal.c	Mon Apr 19 13:33:35 2004
@@ -25,7 +25,6 @@
 #include <linux/binfmts.h>
 #include <linux/elf.h>
 
-#include <asm/pgalloc.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
===== kernel/traps.c 1.3 vs edited =====
--- 1.3/arch/arm26/kernel/traps.c	Wed Oct  8 03:53:37 2003
+++ edited/kernel/traps.c	Mon Apr 19 13:33:35 2004
@@ -28,7 +28,6 @@
 
 #include <asm/atomic.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
===== mm/init.c 1.5 vs edited =====
--- 1.5/arch/arm26/mm/init.c	Sun Sep  7 23:46:00 2003
+++ edited/mm/init.c	Mon Apr 19 13:33:35 2004
@@ -26,7 +26,6 @@
 
 #include <asm/segment.h>
 #include <asm/mach-types.h>
-#include <asm/pgalloc.h>
 #include <asm/dma.h>
 #include <asm/hardware.h>
 #include <asm/setup.h>
