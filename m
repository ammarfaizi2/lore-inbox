Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUHBTWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUHBTWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUHBTWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:22:31 -0400
Received: from motgate.mot.com ([129.188.136.100]:61351 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S262322AbUHBTWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:22:23 -0400
Date: Mon, 2 Aug 2004 14:22:19 -0500 (CDT)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: torvalds@osdl.org
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH][PPC32] Fix e500 SPE saving of context
Message-ID: <Pine.LNX.4.44.0408021416300.23034-100000@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Fix the fact that we were not the signal processing engine status 
and control register (SPEFSCR) on giveup_spe.  Causes problems when
the kernel tries to read or modify the SPEFSCR.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-08-02 13:24:48 -05:00
+++ b/arch/ppc/kernel/head_e500.S	2004-08-02 13:24:48 -05:00
@@ -1177,6 +1177,8 @@
 	evmwumiaa evr6, evr6, evr6	/* evr6 <- ACC = 0 * 0 + ACC */
 	li	r4,THREAD_ACC
    	evstddx	evr6, r4, r3		/* save off accumulator */
+	mfspr	r6,SPRN_SPEFSCR
+	stw	r6,THREAD_SPEFSCR(r3)	/* save spefscr register value */
 	beq	1f
 	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	lis	r3,MSR_SPE@h

