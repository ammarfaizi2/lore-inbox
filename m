Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVAZOvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVAZOvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVAZOvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:51:05 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:57993 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262320AbVAZOuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:50:46 -0500
Date: Wed, 26 Jan 2005 08:50:27 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] ppc32: back out idle patch for non-powersaving CPU's
Message-ID: <Pine.LNX.4.61.0501260843340.28993@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back out previous patch to ppc idle that handled CPU's that did not have 
powersavings.  Ingo's fixes to cpu_rest, cause this fix to no longer be 
needed.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
--- a/arch/ppc/kernel/idle.c	2005-01-26 08:39:59 -06:00
+++ b/arch/ppc/kernel/idle.c	2005-01-26 08:39:59 -06:00
@@ -41,17 +41,14 @@
 	if (!need_resched()) {
 		if (powersave != NULL && !irqs_disabled())
 			powersave();
-		else {
 #ifdef CONFIG_SMP
+		else {
 			set_thread_flag(TIF_POLLING_NRFLAG);
-			local_irq_enable();
 			while (!need_resched())
 				barrier();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
-#else
-			local_irq_enable();
-#endif
 		}
+#endif
 	}
 	if (need_resched())
 		schedule();
