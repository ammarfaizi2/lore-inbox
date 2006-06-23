Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932885AbWFWHq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbWFWHq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932923AbWFWHq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:46:28 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:16007 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932885AbWFWHq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:46:28 -0400
Date: Fri, 23 Jun 2006 03:40:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: cpu_relax() in crash.c and doublefault.c
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Dave Jones <davej@redhat.com>
Message-ID: <200606230343_MC3-1-C33B-67CA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu_relax() to infinite loops in crash.c and
doublefault.c.  This is the safest change.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-32.orig/arch/i386/kernel/crash.c
+++ 2.6.17-32/arch/i386/kernel/crash.c
@@ -114,7 +114,8 @@ static int crash_nmi_callback(struct pt_
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
-	for(;;);
+	for (;;)
+		cpu_relax();
 
 	return 1;
 }
--- 2.6.17-32.orig/arch/i386/kernel/doublefault.c
+++ 2.6.17-32/arch/i386/kernel/doublefault.c
@@ -44,7 +44,8 @@ static void doublefault_fn(void)
 		}
 	}
 
-	for (;;) /* nothing */;
+	for (;;)
+		cpu_relax();
 }
 
 struct tss_struct doublefault_tss __cacheline_aligned = {
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
