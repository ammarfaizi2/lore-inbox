Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUIIXZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUIIXZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIIXZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:25:40 -0400
Received: from 67-41-71-119.roch.qwest.net ([67.41.71.119]:13022 "EHLO
	jdub.homelinux.org") by vger.kernel.org with ESMTP id S268066AbUIIXWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:22:07 -0400
Subject: [PATCH Trivial] ppc64:  Use STACK_FRAME_OVERHEAD macro in misc.S
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: paulus@samba.org, anton@au.bim.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094772116.16444.81.camel@67-41-71-119.roch.qwest.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 18:21:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I found a couple places where a hardcoded value for the stack frame was
used instead of the STACK_FRAME_OVERHEAD macro.  The following patch
fixes that.

thx,
josh

Signed-off-by: Josh Boyer <jwboyer@jdub.homelinux.org>

diff -Naur linux-2.6.9-rc1/arch/ppc64/kernel/misc.S linux-2.6.9-rc1.jwb/arch/ppc64/kernel/misc.S
--- linux-2.6.9-rc1/arch/ppc64/kernel/misc.S	2004-08-14 00:37:40.000000000 -0500
+++ linux-2.6.9-rc1.jwb/arch/ppc64/kernel/misc.S	2004-09-09 18:07:56.038671384 -0500
@@ -107,7 +107,7 @@
 _GLOBAL(call_do_softirq)
 	mflr	r0
 	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-112(r3)
+	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3
 	bl	.__do_softirq
 	ld	r1,0(r1)
@@ -118,7 +118,7 @@
 _GLOBAL(call_handle_irq_event)
 	mflr	r0
 	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-112(r6)
+	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r6)
 	mr	r1,r6
 	bl	.handle_irq_event
 	ld	r1,0(r1)
