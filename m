Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUDSNdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264431AbUDSN3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:29:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20750 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264414AbUDSNWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:37 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com,
       linux-390@vm.marist.edu
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (s390)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYjG-00056G-ET@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:22:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/s390/ subtree.  This has not been compile tested, so
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

===== arch/s390/kernel/compat_exec.c 1.4 vs edited =====
--- 1.4/arch/s390/kernel/compat_exec.c	Mon Apr 12 18:54:53 2004
+++ edited/arch/s390/kernel/compat_exec.c	Mon Apr 19 13:41:44 2004
@@ -26,7 +26,6 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 
 #ifdef CONFIG_KMOD
===== arch/s390/kernel/ptrace.c 1.22 vs edited =====
--- 1.22/arch/s390/kernel/ptrace.c	Thu Apr 15 02:37:53 2004
+++ edited/arch/s390/kernel/ptrace.c	Mon Apr 19 13:41:44 2004
@@ -35,7 +35,6 @@
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
===== arch/s390/kernel/s390_ksyms.c 1.22 vs edited =====
--- 1.22/arch/s390/kernel/s390_ksyms.c	Sat Mar 27 11:40:46 2004
+++ edited/arch/s390/kernel/s390_ksyms.c	Mon Apr 19 13:41:44 2004
@@ -14,7 +14,6 @@
 #include <asm/checksum.h>
 #include <asm/cpcmd.h>
 #include <asm/delay.h>
-#include <asm/pgalloc.h>
 #include <asm/setup.h>
 #ifdef CONFIG_IP_MULTICAST
 #include <net/arp.h>
===== arch/s390/kernel/smp.c 1.33 vs edited =====
--- 1.33/arch/s390/kernel/smp.c	Tue Mar  2 03:01:23 2004
+++ edited/arch/s390/kernel/smp.c	Mon Apr 19 13:41:44 2004
@@ -33,7 +33,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/sigp.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/s390_ext.h>
 #include <asm/cpcmd.h>
===== arch/s390/mm/cmm.c 1.2 vs edited =====
--- 1.2/arch/s390/mm/cmm.c	Tue Mar  2 03:01:23 2004
+++ edited/arch/s390/mm/cmm.c	Mon Apr 19 13:41:44 2004
@@ -17,7 +17,6 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
 #include "../../../drivers/s390/net/smsgiucv.h"
===== arch/s390/mm/ioremap.c 1.8 vs edited =====
--- 1.8/arch/s390/mm/ioremap.c	Thu Oct  2 08:11:59 2003
+++ edited/arch/s390/mm/ioremap.c	Mon Apr 19 13:41:44 2004
@@ -16,7 +16,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
