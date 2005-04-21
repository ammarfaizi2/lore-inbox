Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVDUEg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVDUEg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 00:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVDUEg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 00:36:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15625 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261215AbVDUEgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 00:36:31 -0400
Date: Thu, 21 Apr 2005 06:36:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: bcrl@kvack.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/aio.c: make some code static
Message-ID: <20050421043630.GC3828@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/aio.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/aio.c.old	2005-04-20 23:03:19.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/aio.c	2005-04-20 23:05:56.000000000 +0200
@@ -40,8 +40,8 @@
 #define dprintk(x...)	do { ; } while (0)
 #endif
 
-long aio_run = 0; /* for testing only */
-long aio_wakeups = 0; /* for testing only */
+static long aio_run = 0; /* for testing only */
+static long aio_wakeups = 0; /* for testing only */
 
 /*------ sysctl variables----*/
 atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
@@ -58,7 +58,7 @@
 static DECLARE_WORK(fput_work, aio_fput_routine, NULL);
 
 static DEFINE_SPINLOCK(fput_lock);
-LIST_HEAD(fput_head);
+static LIST_HEAD(fput_head);
 
 static void aio_kick_handler(void *);
 
@@ -290,7 +290,7 @@
 	spin_unlock_irq(&ctx->ctx_lock);
 }
 
-void wait_for_all_aios(struct kioctx *ctx)
+static void wait_for_all_aios(struct kioctx *ctx)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -592,7 +592,7 @@
  * Comments: Called with ctx->ctx_lock held. This nests
  * task_lock instead ctx_lock.
  */
-void unuse_mm(struct mm_struct *mm)
+static void unuse_mm(struct mm_struct *mm)
 {
 	struct task_struct *tsk = current;
 
@@ -879,7 +879,7 @@
  * and if required activate the aio work queue to process
  * it
  */
-void queue_kicked_iocb(struct kiocb *iocb)
+static void queue_kicked_iocb(struct kiocb *iocb)
 {
  	struct kioctx	*ctx = iocb->ki_ctx;
 	unsigned long flags;
@@ -1401,7 +1401,7 @@
  *	Performs the initial checks and aio retry method
  *	setup for the kiocb at the time of io submission.
  */
-ssize_t aio_setup_iocb(struct kiocb *kiocb)
+static ssize_t aio_setup_iocb(struct kiocb *kiocb)
 {
 	struct file *file = kiocb->ki_filp;
 	ssize_t ret = 0;
@@ -1470,7 +1470,8 @@
  * because this callback isn't used for wait queues which
  * are nested inside ioctx lock (i.e. ctx->wait)
  */
-int aio_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+static int aio_wake_function(wait_queue_t *wait, unsigned mode,
+			     int sync, void *key)
 {
 	struct kiocb *iocb = container_of(wait, struct kiocb, ki_wait);
 
@@ -1620,7 +1621,8 @@
  *	Finds a given iocb for cancellation.
  *	MUST be called with ctx->ctx_lock held.
  */
-struct kiocb *lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb, u32 key)
+static struct kiocb *lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb,
+				  u32 key)
 {
 	struct list_head *pos;
 	/* TODO: use a hash or array, this sucks. */

