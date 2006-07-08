Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWGHSGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWGHSGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWGHSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:06:09 -0400
Received: from verein.lst.de ([213.95.11.210]:3560 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964932AbWGHSGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:06:08 -0400
Date: Sat, 8 Jul 2006 20:06:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] remove the tasklist_lock export
Message-ID: <20060708180603.GC7034@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As announced half a year ago this patch will remove the tasklist_lock
export.  The previous two patches got rid of the remaining modular
users.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2006-07-08 19:10:02.000000000 +0200
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2006-07-08 19:10:06.000000000 +0200
@@ -166,17 +166,6 @@
 
 ---------------------------
 
-What:	remove EXPORT_SYMBOL(tasklist_lock)
-When:	August 2006
-Files:	kernel/fork.c
-Why:	tasklist_lock protects the kernel internal task list.  Modules have
-	no business looking at it, and all instances in drivers have been due
-	to use of too-lowlevel APIs.  Having this symbol exported prevents
-	moving to more scalable locking schemes for the task list.
-Who:	Christoph Hellwig <hch@lst.de>
-
----------------------------
-
 What:	mount/umount uevents
 When:	February 2007
 Why:	These events are not correct, and do not properly let userspace know
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c	2006-07-08 19:10:02.000000000 +0200
+++ linux-2.6/kernel/fork.c	2006-07-08 19:10:06.000000000 +0200
@@ -61,9 +61,7 @@
 
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
- __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
-
-EXPORT_SYMBOL(tasklist_lock);
+__cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
 int nr_processes(void)
 {
