Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760143AbWLFFPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760143AbWLFFPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760123AbWLFFPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:15:12 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:35676 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760113AbWLFFPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:15:08 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: parisc-linux@parisc-linux.org, Matthew Wilcox <matthew@wil.cx>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] Delete unused irq functions on powerpc
Date: Tue,  5 Dec 2006 22:15:05 -0700
Message-Id: <11653821071704-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ack_irq macro is unused and conflicts with James' work to template
the generic irq code.  mask_irq and unmask_irq are also unused, so delete
those macros too.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 include/asm-powerpc/hw_irq.h |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index d604863..9e4dd98 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -107,25 +107,6 @@ static inline void local_irq_save_ptr(un
 
 #endif /* CONFIG_PPC64 */
 
-#define mask_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->chip && desc->chip->disable)	\
-			desc->chip->disable(irq);		\
-	})
-#define unmask_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->chip && desc->chip->enable)	\
-			desc->chip->enable(irq);		\
-	})
-#define ack_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->chip && desc->chip->ack)	\
-			desc->chip->ack(irq);		\
-	})
-
 /*
  * interrupt-retrigger: should we handle this via lost interrupts and IPIs
  * or should we not care like we do now ? --BenH.
-- 
1.4.3.3

