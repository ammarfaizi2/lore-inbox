Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbUKLVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbUKLVpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKLVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:44:59 -0500
Received: from aun.it.uu.se ([130.238.12.36]:18902 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262622AbUKLVox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:44:53 -0500
Date: Fri, 12 Nov 2004 22:44:35 +0100 (MET)
Message-Id: <200411122144.iACLiZoE004330@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm5][1/3] perfctr x86 driver cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86 driver cleanup to be applied on top of yesterday's perfctr
interrupt fixes patches:
- Provide API function for checking for pending interrupts.
  Avoids direct structure access in higher levels, which is
  required for ppc32.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/asm-i386/perfctr.h |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -rupN linux-2.6.10-rc1-mm5/include/asm-i386/perfctr.h linux-2.6.10-rc1-mm5.perfctr-x86-driver-update2/include/asm-i386/perfctr.h
--- linux-2.6.10-rc1-mm5/include/asm-i386/perfctr.h	2004-11-12 21:42:57.000000000 +0100
+++ linux-2.6.10-rc1-mm5.perfctr-x86-driver-update2/include/asm-i386/perfctr.h	2004-11-12 21:43:08.000000000 +0100
@@ -179,8 +179,16 @@ typedef void (*perfctr_ihandler_t)(unsig
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
 extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+static inline int perfctr_cpu_has_pending_interrupt(const struct perfctr_cpu_state *state)
+{
+	return state->pending_interrupt;
+}
 #else
 static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
+static inline int perfctr_cpu_has_pending_interrupt(const struct perfctr_cpu_state *state)
+{
+	return 0;
+}
 #endif
 
 #endif	/* CONFIG_PERFCTR */
