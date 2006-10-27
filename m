Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946473AbWJ0P2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946473AbWJ0P2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbWJ0P2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:28:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41999 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1752308AbWJ0P2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:28:10 -0400
Date: Fri, 27 Oct 2006 11:28:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] workqueue: update kerneldoc
Message-ID: <Pine.LNX.4.44L0.0610271116350.6443-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as812) changes the kerneldoc comments explaining the
return values from queue_work(), queue_delayed_work(), and
queue_delayed_work_on().  The updated comments explain more
accurately the meaning of the return code and avoid suggesting that a
0 value means the routine was unsuccessful.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Andrew:

After seeing how queue_work() and schedule_work() are used in practice,
and in view of the recent discussion (concerning the PCI MWI routine)  
about when it's appropriate to return an error code as opposed to just
returning a non-zero value, I decided there wasn't any need to change
queue_work() and friends.

The 0 value they return is not a sign of an error; it simply means 
that the work_struct had already been added to a workqueue.  The best way 
to clear up any confusion is simply to improve the kerneldoc comment.

Alan Stern


Index: usb-2.6/kernel/workqueue.c
===================================================================
--- usb-2.6.orig/kernel/workqueue.c
+++ usb-2.6/kernel/workqueue.c
@@ -99,7 +99,7 @@ static void __queue_work(struct cpu_work
  * @wq: workqueue to use
  * @work: work to queue
  *
- * Returns non-zero if it was successfully added.
+ * Returns 0 if @work was already on a queue, non-zero otherwise.
  *
  * We queue the work to the CPU it was submitted, but there is no
  * guarantee that it will be processed by that CPU.
@@ -138,7 +138,7 @@ void delayed_work_timer_fn(unsigned long
  * @work: work to queue
  * @delay: number of jiffies to wait before queueing
  *
- * Returns non-zero if it was successfully added.
+ * Returns 0 if @work was already on a queue, non-zero otherwise.
  */
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
 				struct work_struct *work, unsigned long delay)
@@ -170,7 +170,7 @@ EXPORT_SYMBOL_GPL(queue_delayed_work);
  * @work: work to queue
  * @delay: number of jiffies to wait before queueing
  *
- * Returns non-zero if it was successfully added.
+ * Returns 0 if @work was already on a queue, non-zero otherwise.
  */
 int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)

