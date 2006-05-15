Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWEOIj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWEOIj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWEOIj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:39:58 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10169 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964832AbWEOIj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:39:57 -0400
Date: Mon, 15 May 2006 04:39:49 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm 02/02] Update rt-mutex-design.txt per Randy Dunlap
In-Reply-To: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150438360.12114@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605150431190.12114@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes some indentation to rt-mutex-design.txt.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-15 04:04:48.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-15 04:04:52.000000000 -0400
@@ -596,47 +596,47 @@ mutex, we check to see if we can take th
 mutex doesn't have a owner, or if we can steal the mutex from a pending
 owner.  Let's look at the situations we have here.

-1) Has owner that is pending
-----------------------------
-The mutex has a owner, but it hasn't woken up and the mutex flag
-"Pending Owner" is set.  The first check is to see if the owner isn't the
-current task.  This is because this function is also used for the pending
-owner to grab the mutex.  When a pending owner wakes up, it checks to see
-if it can take the mutex, and this is done if the owner is already set to
-itself.  If so, we succeed and leave the function, clearing the "Pending
-Owner" bit.
-
-If the pending owner is not current, we check to see if the current priority is
-higher than the pending owner.  If not, we fail the function and return.
-
-There's also something special about a pending owner.  That is a pending owner
-is never blocked on a mutex.  So there is no PI chain to worry about.  It also
-means that if the mutex doesn't have any waiters, there's no accounting needed
-to update the pending owner's pi_list, since we only worry about processes
-blocked on the current mutex.
-
-If there are waiters on this mutex, and we just stole the ownership, we need
-to take the top waiter, remove it from the pi_list of the pending owner, and
-add it to the current pi_list.  Note that at this moment, the pending owner
-is no longer on the list of waiters.  This is fine, since the pending owner
-would add itself back when it realizes that it had the ownership stolen
-from itself.  When the pending owner tries to grab the mutex, it will fail
-in try_to_take_rt_mutex if the owner field points to another process.
-
-2) No owner
------------
-
-If there is no owner (or we successfully stole the lock), we set the owner
-of the mutex to current, and set the flag of "Has Waiters" if the current
-mutex actually has waiters, or we clear the flag if it doesn't.  See, it was
-OK that we set that flag early, since now it is cleared.
-
-3) Failed to grab ownership
----------------------------
-
-The most interesting case is when we fail to take ownership. This means that
-there exists an owner, or there's a pending owner with equal or higher
-priority than the current task.
+  1) Has owner that is pending
+  ----------------------------
+  The mutex has a owner, but it hasn't woken up and the mutex flag
+  "Pending Owner" is set.  The first check is to see if the owner isn't the
+  current task.  This is because this function is also used for the pending
+  owner to grab the mutex.  When a pending owner wakes up, it checks to see
+  if it can take the mutex, and this is done if the owner is already set to
+  itself.  If so, we succeed and leave the function, clearing the "Pending
+  Owner" bit.
+
+  If the pending owner is not current, we check to see if the current priority is
+  higher than the pending owner.  If not, we fail the function and return.
+
+  There's also something special about a pending owner.  That is a pending owner
+  is never blocked on a mutex.  So there is no PI chain to worry about.  It also
+  means that if the mutex doesn't have any waiters, there's no accounting needed
+  to update the pending owner's pi_list, since we only worry about processes
+  blocked on the current mutex.
+
+  If there are waiters on this mutex, and we just stole the ownership, we need
+  to take the top waiter, remove it from the pi_list of the pending owner, and
+  add it to the current pi_list.  Note that at this moment, the pending owner
+  is no longer on the list of waiters.  This is fine, since the pending owner
+  would add itself back when it realizes that it had the ownership stolen
+  from itself.  When the pending owner tries to grab the mutex, it will fail
+  in try_to_take_rt_mutex if the owner field points to another process.
+
+  2) No owner
+  -----------
+
+  If there is no owner (or we successfully stole the lock), we set the owner
+  of the mutex to current, and set the flag of "Has Waiters" if the current
+  mutex actually has waiters, or we clear the flag if it doesn't.  See, it was
+  OK that we set that flag early, since now it is cleared.
+
+  3) Failed to grab ownership
+  ---------------------------
+
+  The most interesting case is when we fail to take ownership. This means that
+  there exists an owner, or there's a pending owner with equal or higher
+  priority than the current task.

 We'll continue on the failed case.


