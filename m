Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbULKWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbULKWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbULKWE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 17:04:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37640 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262029AbULKWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 17:04:03 -0500
Date: Sat, 11 Dec 2004 23:03:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 semaphore.c: make 4 functions static
Message-ID: <20041211220355.GF22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes four needlessly global functions static.


diffstat output:
 arch/i386/kernel/semaphore.c |    8 ++++----
 include/asm-i386/semaphore.h |    5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-i386/semaphore.h.old	2004-12-11 20:49:58.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/semaphore.h	2004-12-11 20:50:12.000000000 +0100
@@ -92,11 +92,6 @@
 fastcall int  __down_failed_trylock(void  /* params in registers */);
 fastcall void __up_wakeup(void /* special register calling convention */);
 
-fastcall void __down(struct semaphore * sem);
-fastcall int  __down_interruptible(struct semaphore * sem);
-fastcall int  __down_trylock(struct semaphore * sem);
-fastcall void __up(struct semaphore * sem);
-
 /*
  * This is ugly, but we want the default case to fall through.
  * "__down_failed" is a special asm handler that calls the C
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/semaphore.c.old	2004-12-07 02:30:44.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/semaphore.c	2004-12-11 21:47:26.000000000 +0100
@@ -49,12 +49,12 @@
  *    we cannot lose wakeup events.
  */
 
-fastcall void __up(struct semaphore *sem)
+static fastcall void __attribute_used__  __up(struct semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-fastcall void __sched __down(struct semaphore * sem)
+static fastcall void __attribute_used__ __sched __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +91,7 @@
 	tsk->state = TASK_RUNNING;
 }
 
-fastcall int __sched __down_interruptible(struct semaphore * sem)
+static fastcall int __attribute_used__ __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -154,7 +154,7 @@
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-fastcall int __down_trylock(struct semaphore * sem)
+static fastcall int __attribute_used__ __down_trylock(struct semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;

