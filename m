Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVJ2D1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJ2D1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVJ2D1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:27:11 -0400
Received: from mail22.bluewin.ch ([195.186.19.66]:47794 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1751123AbVJ2D1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:27:10 -0400
Date: Fri, 28 Oct 2005 23:26:35 -0400
To: akpm@osdl.org
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: struct semaphore.sleepers initialization
Message-ID: <20051029032635.GA1870@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No one may sleep on us until we've been down()'d. So on allocation,
initialize `sleepers' to 0, just like everyone else (including arm26).

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 include/asm-arm/semaphore.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

bbf19d06faa9dc51fe084cc8d0b7fac933771528
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
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
+	.sleepers 	= 0,						\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }
 
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
