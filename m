Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUGNMPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUGNMPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267315AbUGNMPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:15:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9945 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267291AbUGNMPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:15:17 -0400
Date: Wed, 14 Jul 2004 14:15:09 +0200 (MEST)
Message-Id: <200407141215.i6ECF9Z9008323@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] arch/i386/kernel/smp.c gcc341 inlining fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at arch/i386/kernel/smp.c:

arch/i386/kernel/smp.c: In function `flush_tlb_others':
arch/i386/kernel/smp.c:161: sorry, unimplemented: inlining failed in call to 'send_IPI_mask_bitmask': function not considered for inlining
arch/i386/kernel/smp.c:9: sorry, unimplemented: called from here
make[1]: *** [arch/i386/kernel/smp.o] Error 1
make: *** [arch/i386/kernel] Error 2

The <mach_ipi.h> inlines depend on functions defined further
down in smp.c. Moving the #include eliminates the problem.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.8-rc1-mm1/arch/i386/kernel/smp.c.~1~	2004-07-14 12:59:20.000000000 +0200
+++ linux-2.6.8-rc1-mm1/arch/i386/kernel/smp.c	2004-07-14 13:31:01.000000000 +0200
@@ -22,7 +22,6 @@
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
-#include <mach_ipi.h>
 #include <mach_apic.h>
 
 /*
@@ -230,6 +229,8 @@
 	local_irq_restore(flags);
 }
 
+#include <mach_ipi.h> /* must come after the send_IPI functions above for inlining */
+
 /*
  *	Smarter SMP flushing macros. 
  *		c/o Linus Torvalds.
