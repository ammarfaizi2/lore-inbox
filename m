Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755198AbWKZX5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbWKZX5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbWKZX5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:57:06 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:19163 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1755198AbWKZX5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:57:03 -0500
Date: Sun, 26 Nov 2006 18:56:56 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PARISC] Fix incorrent type of flags in <asm/semaphore.h>
Message-ID: <20061126235656.GD14193@athena.road.mcmartin.ca>
References: <20061126224928.GA22285@linux-mips.org> <20061126234710.GC14193@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061126234710.GC14193@athena.road.mcmartin.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still think using BUILD_BUG_ON() is unacceptable, especially given how
vague the error message was.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
---
diff --git a/include/asm-parisc/semaphore.h b/include/asm-parisc/semaphore.h
index c9ee41c..d45827a 100644
--- a/include/asm-parisc/semaphore.h
+++ b/include/asm-parisc/semaphore.h
@@ -115,7 +115,8 @@ extern __inline__ int down_interruptible
  */
 extern __inline__ int down_trylock(struct semaphore * sem)
 {
-	int flags, count;
+	unsigned long flags;
+	int count;
 
 	spin_lock_irqsave(&sem->sentry, flags);
 	count = sem->count - 1;
@@ -131,7 +132,8 @@ extern __inline__ int down_trylock(struc
  */
 extern __inline__ void up(struct semaphore * sem)
 {
-	int flags;
+	unsigned long flags;
+
 	spin_lock_irqsave(&sem->sentry, flags);
 	if (sem->count < 0) {
 		__up(sem);
