Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWAJVKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWAJVKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWAJVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:10:24 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38315 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932663AbWAJVKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:10:24 -0500
Date: Tue, 10 Jan 2006 22:10:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] mark mutex_lock*() as might_sleep()
Message-ID: <20060110211036.GA9460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mark mutex_lock() and mutex_lock_interruptible() as might_sleep()
functions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -81,6 +81,7 @@ __mutex_lock_slowpath(atomic_t *lock_cou
  */
 void fastcall __sched mutex_lock(struct mutex *lock)
 {
+	might_sleep();
 	/*
 	 * The locking fastpath is the 1->0 transition from
 	 * 'unlocked' into 'locked' state.
@@ -253,6 +254,7 @@ __mutex_lock_interruptible_slowpath(atom
  */
 int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
 {
+	might_sleep();
 	return __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_slowpath);
 }
