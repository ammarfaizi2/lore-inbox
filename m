Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWFTFCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWFTFCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFTFCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:02:52 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:53947 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751086AbWFTFCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:02:51 -0400
Date: Tue, 20 Jun 2006 00:55:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: halt the CPU on serious errors
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>
Message-ID: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Halt the CPU when serious errors are encountered and we
deliberately go into an infinite loop.

Suggested by Andreas Mohr.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-32.orig/arch/i386/kernel/crash.c
+++ 2.6.17-32/arch/i386/kernel/crash.c
@@ -113,8 +113,8 @@ static int crash_nmi_callback(struct pt_
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
-	halt();
-	for(;;);
+	for (;;)
+		halt();
 
 	return 1;
 }
--- 2.6.17-32.orig/arch/i386/kernel/doublefault.c
+++ 2.6.17-32/arch/i386/kernel/doublefault.c
@@ -44,7 +44,8 @@ static void doublefault_fn(void)
 		}
 	}
 
-	for (;;) /* nothing */;
+	for (;;)
+		halt();
 }
 
 struct tss_struct doublefault_tss __cacheline_aligned = {
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
