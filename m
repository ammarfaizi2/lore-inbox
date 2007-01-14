Return-Path: <linux-kernel-owner+w=401wt.eu-S1751143AbXANHff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbXANHff (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXANHff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:35:35 -0500
Received: from www.osadl.org ([213.239.205.134]:57892 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751143AbXANHfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:35:34 -0500
Message-Id: <20070114081926.912658228@inhelltoy.tec.linutronix.de>
References: <20070114081905.135797900@inhelltoy.tec.linutronix.de>
User-Agent: quilt/0.46-1
Date: Sun, 14 Jan 2007 08:33:45 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/3] Scheduled removal of SA_xxx interrupt flags
Content-Disposition: inline;
	filename=sa-irqflags-scheduled-feature-removal.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The name space cleanup of the interrupt request flags (SA_xxx -> IRQF_xxx)
left a 6 month grace period for the old deprecated flags. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.20-rc3-mm1/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.20-rc3-mm1.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6.20-rc3-mm1/Documentation/feature-removal-schedule.txt
@@ -182,15 +182,6 @@ Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
 
-What:	Interrupt only SA_* flags
-When:	Januar 2007
-Why:	The interrupt related SA_* flags are replaced by IRQF_* to move them
-	out of the signal namespace.
-
-Who:	Thomas Gleixner <tglx@linutronix.de>
-
----------------------------
-
 What:	PHYSDEVPATH, PHYSDEVBUS, PHYSDEVDRIVER in the uevent environment
 When:	October 2008
 Why:	The stacking of class devices makes these values misleading and
Index: linux-2.6.20-rc3-mm1/include/linux/interrupt.h
===================================================================
--- linux-2.6.20-rc3-mm1.orig/include/linux/interrupt.h
+++ linux-2.6.20-rc3-mm1/include/linux/interrupt.h
@@ -49,22 +49,6 @@
 #define IRQF_TIMER		0x00000200
 #define IRQF_PERCPU		0x00000400
 
-/*
- * Migration helpers. Scheduled for removal in 1/2007
- * Do not use for new code !
- */
-#define SA_INTERRUPT		IRQF_DISABLED
-#define SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
-#define SA_SHIRQ		IRQF_SHARED
-#define SA_PROBEIRQ		IRQF_PROBE_SHARED
-#define SA_PERCPU		IRQF_PERCPU
-
-#define SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
-#define SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
-#define SA_TRIGGER_FALLING	IRQF_TRIGGER_FALLING
-#define SA_TRIGGER_RISING	IRQF_TRIGGER_RISING
-#define SA_TRIGGER_MASK		IRQF_TRIGGER_MASK
-
 typedef irqreturn_t (*irq_handler_t)(int, void *);
 
 struct irqaction {

-- 

