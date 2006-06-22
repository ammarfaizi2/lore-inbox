Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWFVLAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWFVLAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbWFVLAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:00:10 -0400
Received: from fc-cn.com ([218.25.172.144]:20486 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1161063AbWFVLAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:00:08 -0400
Date: Thu, 22 Jun 2006 16:29:12 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au
Subject: [patch] cleanup: kthread workqueue rename
Message-ID: <20060622082912.GA6334@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup: rename kthread helper_wq to kthread_wq.

Signed-off-by: Qi Yong <qiyong@freeforge.net>
---
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c5f3c66..3184c94 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -19,7 +19,7 @@ #include <asm/semaphore.h>
  * We dont want to execute off keventd since it might
  * hold a semaphore our callers hold too:
  */
-static struct workqueue_struct *helper_wq;
+static struct workqueue_struct *kthread_wq;
 
 struct kthread_create_info
 {
@@ -138,10 +138,10 @@ struct task_struct *kthread_create(int (
 	/*
 	 * The workqueue needs to start up first:
 	 */
-	if (!helper_wq)
+	if (!kthread_wq)
 		work.func(work.data);
 	else {
-		queue_work(helper_wq, &work);
+		queue_work(kthread_wq, &work);
 		wait_for_completion(&create.done);
 	}
 	if (!IS_ERR(create.result)) {
@@ -203,12 +203,12 @@ int kthread_stop_sem(struct task_struct 
 }
 EXPORT_SYMBOL(kthread_stop_sem);
 
-static __init int helper_init(void)
+static __init int kthread_init(void)
 {
-	helper_wq = create_singlethread_workqueue("kthread");
-	BUG_ON(!helper_wq);
+	kthread_wq = create_singlethread_workqueue("kthread");
+	BUG_ON(!kthread_wq);
 
 	return 0;
 }
-core_initcall(helper_init);
+core_initcall(kthread_init);
 

-- 
Coywolf Qi Hunt
