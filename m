Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUHQEaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUHQEaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUHQEaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:30:25 -0400
Received: from ozlabs.org ([203.10.76.45]:37528 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268094AbUHQEaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:30:23 -0400
Date: Tue, 17 Aug 2004 14:20:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PPC64] C99 initializers in INIT_THREAD
Message-ID: <20040817042011.GE9637@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly trivial PPC64 cleanup.  This patch makes the ppc64 INIT_THREAD
#define use C99 initializers, which will make it less likely to get
broken if we need to change thread_struct.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/processor.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/processor.h	2004-08-09 09:52:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/processor.h	2004-08-17 14:13:47.105566560 +1000
@@ -559,12 +559,12 @@
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 
 #define INIT_THREAD  { \
-	INIT_SP, /* ksp */ \
-	(struct pt_regs *)INIT_SP - 1, /* regs */ \
-	KERNEL_DS, /*fs*/ \
-	{0}, /* fpr */ \
-	0, /* fpscr */ \
-	MSR_FE0|MSR_FE1, /* fpexc_mode */ \
+	.ksp = INIT_SP, \
+	.regs = (struct pt_regs *)INIT_SP - 1, \
+	.fs = KERNEL_DS, \
+	.fpr = {0}, \
+	.fpscr = 0, \
+	.fpexc_mode = MSR_FE0|MSR_FE1, \
 }
 
 /*


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
