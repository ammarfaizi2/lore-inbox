Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTI2RRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTI2RGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:06:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40631 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263798AbTI2RE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:58 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup SEP errata workaround.
Message-Id: <E1A41Rq-0000N1-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks a little simpler, and has the same effect.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/intel.c linux-2.5/arch/i386/kernel/cpu/intel.c
--- bk-linus/arch/i386/kernel/cpu/intel.c	2003-09-10 20:35:24.000000000 +0100
+++ linux-2.5/arch/i386/kernel/cpu/intel.c	2003-09-24 01:34:29.000000000 +0100
@@ -238,12 +269,9 @@ static void __init init_intel(struct cpu
 	}
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until model 3 mask 3 */
-	if ( c->x86 == 6) {
-		unsigned model_mask = (c->x86_model << 8) + c->x86_mask;
-		if (model_mask < 0x0303)
-			clear_bit(X86_FEATURE_SEP, c->x86_capability);
-	}
-	
+	if ((c->x86<<8 | c->x86_model<<4 | c->x86_mask) < 0x633)
+		clear_bit(X86_FEATURE_SEP, c->x86_capability);
+
 	/* Names for the Pentium II/Celeron processors 
 	   detectable only by also checking the cache size.
 	   Dixon is NOT a Celeron. */
