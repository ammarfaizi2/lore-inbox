Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265962AbUFIU4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUFIU4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUFIU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:56:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56249 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265962AbUFIUwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:52:13 -0400
Date: Wed, 9 Jun 2004 22:52:07 +0200 (MEST)
Message-Id: <200406092052.i59Kq7DQ000633@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-rc3-mm1] perfctr #if/#ifdef cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up #if/#ifdef confusion in <asm-i386/perfctr.h>.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.7-rc3-mm1/include/asm-i386/perfctr.h linux-2.6.7-rc3-mm1.perfctr-update/include/asm-i386/perfctr.h
--- linux-2.6.7-rc3-mm1/include/asm-i386/perfctr.h	2004-06-09 19:38:39.000000000 +0200
+++ linux-2.6.7-rc3-mm1.perfctr-update/include/asm-i386/perfctr.h	2004-06-09 21:04:33.000000000 +0200
@@ -168,7 +168,7 @@
 #define PERFCTR_INTERRUPT_SUPPORT 1
 #endif
 
-#if PERFCTR_INTERRUPT_SUPPORT
+#ifdef PERFCTR_INTERRUPT_SUPPORT
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
 extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
@@ -187,7 +187,7 @@
 
 #endif	/* CONFIG_PERFCTR */
 
-#if defined(CONFIG_PERFCTR) && PERFCTR_INTERRUPT_SUPPORT
+#if defined(CONFIG_PERFCTR) && defined(PERFCTR_INTERRUPT_SUPPORT)
 asmlinkage void perfctr_interrupt(struct pt_regs*);
 #define perfctr_vector_init()	\
 	set_intr_gate(LOCAL_PERFCTR_VECTOR, perfctr_interrupt)
