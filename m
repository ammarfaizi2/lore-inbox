Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278180AbRJLWTk>; Fri, 12 Oct 2001 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278179AbRJLWTb>; Fri, 12 Oct 2001 18:19:31 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:42500 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S278184AbRJLWTQ>; Fri, 12 Oct 2001 18:19:16 -0400
Subject: Re: Updated preempt-kernel patches
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1002917978.957.86.camel@phantasy>
In-Reply-To: <1002917978.957.86.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 12 Oct 2001 18:19:52 -0400
Message-Id: <1002925193.868.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-12 at 16:19, Robert Love wrote:
> - fix compile on SMP in some configurations (ac tree only)

Looks like I forgot to merge that one.  Fix follows below (its needed by
some ac-tree users who also compile SMP).

diff -urN linux-2.4.12-ac1-preempt/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h 
--- linux-2.4.12-ac1-preempt/include/asm-i386/spinlock.h	Fri Oct 12 16:34:16 2001
+++ linux/include/asm-i386/spinlock.h	Fri Oct 12 18:16:05 2001
@@ -97,7 +97,7 @@
 		:"=q" (oldval), "=m" (lock->lock) \
 		:"0" (1) : "memory"
 
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	char oldval;
 #if SPINLOCK_DEBUG

	Robert Love

