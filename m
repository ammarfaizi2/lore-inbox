Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUDSNdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbUDSNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:31:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26126 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264424AbUDSNXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:23:24 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, ak@suse.de,
       discuss@x86-64.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (x86_64)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYk0-00056V-M5@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:23:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/x86_64/ subtree.  This has not been compile tested, so
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

===== arch/x86_64/ia32/ia32_aout.c 1.3 vs edited =====
--- 1.3/arch/x86_64/ia32/ia32_aout.c	Mon Apr 12 18:54:53 2004
+++ edited/arch/x86_64/ia32/ia32_aout.c	Mon Apr 19 13:46:36 2004
@@ -28,7 +28,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/user32.h>
 
===== arch/x86_64/kernel/acpi/sleep.c 1.2 vs edited =====
--- 1.2/arch/x86_64/kernel/acpi/sleep.c	Wed Jan  7 07:25:08 2004
+++ edited/arch/x86_64/kernel/acpi/sleep.c	Mon Apr 19 13:46:36 2004
@@ -42,7 +42,6 @@
 #include <asm/apicdef.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include <asm/proto.h>
 #include <asm/tlbflush.h>
===== arch/x86_64/kernel/apic.c 1.28 vs edited =====
--- 1.28/arch/x86_64/kernel/apic.c	Thu Feb 26 23:55:11 2004
+++ edited/arch/x86_64/kernel/apic.c	Mon Apr 19 13:46:36 2004
@@ -31,7 +31,6 @@
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
 
 int disable_apic_timer __initdata;
 
===== arch/x86_64/kernel/irq.c 1.22 vs edited =====
--- 1.22/arch/x86_64/kernel/irq.c	Thu Feb 19 03:42:58 2004
+++ edited/arch/x86_64/kernel/irq.c	Mon Apr 19 13:46:36 2004
@@ -40,7 +40,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/irq.h>
===== arch/x86_64/kernel/mpparse.c 1.25 vs edited =====
--- 1.25/arch/x86_64/kernel/mpparse.c	Mon Apr 12 18:53:56 2004
+++ edited/arch/x86_64/kernel/mpparse.c	Mon Apr 19 13:46:36 2004
@@ -27,7 +27,6 @@
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include <asm/proto.h>
 
===== arch/x86_64/kernel/smp.c 1.18 vs edited =====
--- 1.18/arch/x86_64/kernel/smp.c	Sat Oct 25 22:35:55 2003
+++ edited/arch/x86_64/kernel/smp.c	Mon Apr 19 13:46:36 2004
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/mtrr.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /*
===== arch/x86_64/kernel/smpboot.c 1.26 vs edited =====
--- 1.26/arch/x86_64/kernel/smpboot.c	Wed Apr 14 03:46:21 2004
+++ edited/arch/x86_64/kernel/smpboot.c	Mon Apr 19 13:46:36 2004
@@ -47,7 +47,6 @@
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
 #include <asm/mtrr.h>
-#include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/kdebug.h>
 #include <asm/tlbflush.h>
===== arch/x86_64/kernel/traps.c 1.36 vs edited =====
--- 1.36/arch/x86_64/kernel/traps.c	Thu Mar 18 00:00:40 2004
+++ edited/arch/x86_64/kernel/traps.c	Mon Apr 19 13:46:36 2004
@@ -40,7 +40,6 @@
 #include <asm/processor.h>
 
 #include <asm/smp.h>
-#include <asm/pgalloc.h>
 #include <asm/pda.h>
 #include <asm/proto.h>
 
===== arch/x86_64/kernel/x8664_ksyms.c 1.30 vs edited =====
--- 1.30/arch/x86_64/kernel/x8664_ksyms.c	Wed Apr 14 03:46:21 2004
+++ edited/arch/x86_64/kernel/x8664_ksyms.c	Mon Apr 19 13:46:36 2004
@@ -27,7 +27,6 @@
 #include <asm/mmx.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/nmi.h>
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
===== arch/x86_64/mm/fault.c 1.22 vs edited =====
--- 1.22/arch/x86_64/mm/fault.c	Mon Mar  8 14:23:47 2004
+++ edited/arch/x86_64/mm/fault.c	Mon Apr 19 13:46:36 2004
@@ -26,7 +26,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
===== arch/x86_64/mm/init.c 1.28 vs edited =====
--- 1.28/arch/x86_64/mm/init.c	Mon Apr 12 18:53:56 2004
+++ edited/arch/x86_64/mm/init.c	Mon Apr 19 13:46:36 2004
@@ -27,7 +27,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/dma.h>
 #include <asm/fixmap.h>
 #include <asm/e820.h>
===== arch/x86_64/mm/ioremap.c 1.11 vs edited =====
--- 1.11/arch/x86_64/mm/ioremap.c	Thu Oct  2 08:11:59 2003
+++ edited/arch/x86_64/mm/ioremap.c	Mon Apr 19 13:46:36 2004
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
