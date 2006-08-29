Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWH2Th1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWH2Th1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWH2ThW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:37:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48136 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751219AbWH2ThU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:37:20 -0400
Date: Tue, 29 Aug 2006 15:37:18 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jonathan Corbet <corbet@lwn.net>
cc: linux-kernel@vger.kernel.org,
       SCSI development list <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] export the queue_work wrappers GPL-only
Message-ID: <Pine.LNX.4.44L0.0608291448380.3753-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as777) fixes an oversight in a couple of earlier patches.  Now 
the wrapper routines:

	queue_work(), queue_delayed_work(), queue_delayed_work_on(),
	schedule_work(), schedule_delayed_work(), and
	schedule_delayed_work_on()

are exported GPL-only, just as the originals used to be.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Tue, 29 Aug 2006, Jonathan Corbet wrote:

> One little thing I just noticed.  The old queue_work() functions were
> exported GPL-only.  And the new ones are too:
> 
> > -EXPORT_SYMBOL_GPL(queue_work);
> > +EXPORT_SYMBOL_GPL(add_work_to_q);
> 
> But the new wrappers are not:
> 
> > +EXPORT_SYMBOL(queue_work);
> 
> They should probably be exported in the same mode as before.

You're right...  I don't know how I managed to miss that.

> Also, should there be an entry added to
> Documentation/feature-removal-schedule.txt?

It's a question of whether anyone feels the need to remove the legacy
routines.

Andrew, if you think that after (say) a year's time those WARN_ON()s no
longer serve any useful purpose, I could do a big search-and-replace to
get rid of those old functions entirely.  I assume there's no problem with
accepting patches that change hundreds of files.

Alan Stern


Index: mm/kernel/workqueue.c
===================================================================
--- mm.orig/kernel/workqueue.c
+++ mm/kernel/workqueue.c
@@ -501,7 +501,7 @@ void fastcall queue_work(struct workqueu
 	rc = add_work_to_q(wq, work);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(queue_work);
+EXPORT_SYMBOL_GPL(queue_work);
 
 void fastcall queue_delayed_work(struct workqueue_struct *wq,
 		struct work_struct *work, unsigned long delay)
@@ -511,7 +511,7 @@ void fastcall queue_delayed_work(struct 
 	rc = add_delayed_work_to_q(wq, work, delay);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(queue_delayed_work);
+EXPORT_SYMBOL_GPL(queue_delayed_work);
 
 void queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 		struct work_struct *work, unsigned long delay)
@@ -521,7 +521,7 @@ void queue_delayed_work_on(int cpu, stru
 	rc = add_delayed_work_to_q_on(cpu, wq, work, delay);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(queue_delayed_work_on);
+EXPORT_SYMBOL_GPL(queue_delayed_work_on);
 
 void fastcall schedule_work(struct work_struct *work)
 {
@@ -530,7 +530,7 @@ void fastcall schedule_work(struct work_
 	rc = add_work_to_q(keventd_wq, work);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(schedule_work);
+EXPORT_SYMBOL_GPL(schedule_work);
 
 void fastcall schedule_delayed_work(struct work_struct *work,
 		unsigned long delay)
@@ -540,7 +540,7 @@ void fastcall schedule_delayed_work(stru
 	rc = add_delayed_work_to_q(keventd_wq, work, delay);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(schedule_delayed_work);
+EXPORT_SYMBOL_GPL(schedule_delayed_work);
 
 void schedule_delayed_work_on(int cpu, struct work_struct *work,
 		unsigned long delay)
@@ -550,7 +550,7 @@ void schedule_delayed_work_on(int cpu, s
 	rc = add_delayed_work_to_q_on(cpu, keventd_wq, work, delay);
 	WARN_ON(rc < 0);
 }
-EXPORT_SYMBOL(schedule_delayed_work_on);
+EXPORT_SYMBOL_GPL(schedule_delayed_work_on);
 
 /**
  * schedule_on_each_cpu - call a function on each online CPU from keventd

