Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUIGQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUIGQHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUIGPC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:02:26 -0400
Received: from verein.lst.de ([213.95.11.210]:20634 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267749AbUIGO6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:58:16 -0400
Date: Tue, 7 Sep 2004 16:58:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched.c gratious export removal
Message-ID: <20040907145809.GA9200@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched.c exports a few internal helpers although none of them is used in
modular code or code that could easily be made modular, nor would we
want modules to use them.


--- 1.345/kernel/sched.c	2004-09-04 04:28:36 +02:00
+++ edited/kernel/sched.c	2004-09-07 15:57:22 +02:00
@@ -1036,8 +1036,6 @@
 	preempt_enable();
 }
 
-EXPORT_SYMBOL_GPL(kick_process);
-
 /*
  * Return a low guess at the load of a migration-source cpu.
  *
@@ -2908,7 +2906,6 @@
 	__wake_up_common(q, mode, nr_exclusive, sync, NULL);
 	spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
 void fastcall complete(struct completion *x)
 {
@@ -3142,8 +3139,6 @@
 	return TASK_NICE(p);
 }
 
-EXPORT_SYMBOL(task_nice);
-
 /**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
@@ -3152,8 +3147,6 @@
 {
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
-
-EXPORT_SYMBOL_GPL(idle_cpu);
 
 /**
  * find_process_by_pid - find a process with a matching PID value.
