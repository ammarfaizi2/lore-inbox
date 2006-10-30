Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965499AbWJ3KqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965499AbWJ3KqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWJ3KqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:46:04 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:4299 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965499AbWJ3Kpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:45:50 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 05:43:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] semaphore.h: add missing "sleepers = 0" initialization
Message-ID: <Pine.LNX.4.64.0610300540140.7056@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Add the missing initialization of "sleepers" to 0 in two semaphore
initialization macros.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
index d5dc624..08657e6 100644
--- a/include/asm-arm/semaphore.h
+++ b/include/asm-arm/semaphore.h
@@ -18,10 +18,11 @@ struct semaphore {
 	wait_queue_head_t wait;
 };

-#define __SEMAPHORE_INIT(name, cnt)				\
-{								\
-	.count	= ATOMIC_INIT(cnt),				\
-	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+#define __SEMAPHORE_INIT(name, cnt)					\
+{									\
+	.count		= ATOMIC_INIT(cnt),				\
+	.sleepers	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }

 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
diff --git a/include/asm-avr32/semaphore.h b/include/asm-avr32/semaphore.h
index ef99ddc..c15ecde 100644
--- a/include/asm-avr32/semaphore.h
+++ b/include/asm-avr32/semaphore.h
@@ -29,6 +29,7 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
+	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

