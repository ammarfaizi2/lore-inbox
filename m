Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135759AbRDSXhV>; Thu, 19 Apr 2001 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135758AbRDSXhF>; Thu, 19 Apr 2001 19:37:05 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:54281
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S135759AbRDSXgw>; Thu, 19 Apr 2001 19:36:52 -0400
Date: Thu, 19 Apr 2001 19:36:44 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
cc: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] reiserfs should daemonize
Message-ID: <848950000.987723404@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

The reiserfs commit thread needs to daemonize.  This patch
was actually from Andi Kleen eons ago (but blame me if 
it breaks).  Please apply.

Against 2.4.3:

--- linux/fs/reiserfs/journal.c	Thu Apr 19 14:02:56 2001
+++ linux/fs/reiserfs/journal.c	Thu Apr 19 18:11:57 2001
@@ -1814,16 +1814,14 @@
 ** then run the per filesystem commit task queue when we wakeup.
 */
 static int reiserfs_journal_commit_thread(void *nullp) {
-  exit_files(current);
-  exit_mm(current);
+
+  daemonize() ;
 
   spin_lock_irq(&current->sigmask_lock);
   sigfillset(&current->blocked);
   recalc_sigpending(current);
   spin_unlock_irq(&current->sigmask_lock);
 
-  current->session = 1;
-  current->pgrp = 1;
   sprintf(current->comm, "kreiserfsd") ;
   lock_kernel() ;
   while(1) {


