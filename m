Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266644AbUF3MTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266644AbUF3MTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266645AbUF3MTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:19:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:41374 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266644AbUF3MTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:19:18 -0400
Date: Wed, 30 Jun 2004 14:19:11 +0200 (MEST)
Message-Id: <200406301219.i5UCJBBq014036@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 1/6: fix linkage error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- fix linkage error caused by drivers/perfctr/x86_tests.c
  using apic_write() even when !CONFIG_X86_LOCAL_APIC

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/x86_tests.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/x86_tests.c	2004-06-29 13:26:26.000000000 +0200
@@ -44,6 +44,11 @@
 #define CR4MOV	"movl"
 #endif
 
+#ifndef PERFCTR_INTERRUPT_SUPPORT
+#undef apic_write
+#define apic_write(reg,vector)			do{}while(0)
+#endif
+
 static void __init do_rdpmc(unsigned pmc, unsigned unused2)
 {
 	unsigned i;
