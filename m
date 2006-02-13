Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWBMPIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWBMPIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBMPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:08:21 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:41940 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751250AbWBMPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:08:20 -0500
Subject: [PATCH] 2.6.16-rc2-mm1 -
	repair-ipc-semaphore-comments-and-variables
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Mon, 13 Feb 2006 10:08:00 -0500
Message-Id: <1139843280.5381.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while perusing the diffs:

An apparent global find/replace of 'semphore' to 'mutex' in ipc/sem.c
modified several comments and variables that refer to the so called
"SysV IPC semphores".  The user interface objects remain "semaphores". 
The name of the file is still 'ipc/sem.c' This patch attempts to revert
just those comments and variables that refer to the "SysV IPC
semphores".

Note that several of these comments contain 10+ year old revision notes
that could possibly be removed at some time.

Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>

Index: Linux/ipc/sem.c
===================================================================
--- Linux.orig/ipc/sem.c	2006-02-09 16:16:46.000000000 -0500
+++ Linux/ipc/sem.c	2006-02-09 16:41:23.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * linux/ipc/mutex.c
+ * linux/ipc/sem.c
  * Copyright (C) 1992 Krishna Balasubramanian
  * Copyright (C) 1995 Eric Schenk, Bruno Haible
  *
@@ -10,13 +10,13 @@
  * value went to 0 and was then incremented rapidly enough. In solving
  * this problem I have also modified the implementation so that it
  * processes pending operations in a FIFO manner, thus give a guarantee
- * that processes waiting for a lock on the mutex won't starve
+ * that processes waiting for a lock on the semaphore won't starve
  * unless another locking process fails to unlock.
  * In addition the following two changes in behavior have been
introduced:
  * - The original implementation of semop returned the value
- *   last mutex element examined on success. This does not
+ *   last semaphore element examined on success. This does not
  *   match the manual page specifications, and effectively
- *   allows the user to read the mutex even if they do not
+ *   allows the user to read the semaphore even if they do not
  *   have read permissions. The implementation now returns 0
  *   on success as stated in the manual page.
  * - There is some confusion over whether the set of undo adjustments
@@ -34,15 +34,15 @@
  * - The POSIX standard says, that the undo adjustments simply should
  *   redo. So the current implementation is o.K.
  * - The previous code had two flaws:
- *   1) It actively gave the mutex to the next waiting process
- *      sleeping on the mutex. Since this process did not have the
+ *   1) It actively gave the semaphore to the next waiting process
+ *      sleeping on the semaphore. Since this process did not have the
  *      cpu this led to many unnecessary context switches and bad
  *      performance. Now we only check which process should be able to
- *      get the mutex and if this process wants to reduce some
- *      mutex value we simply wake it up without doing the
+ *      get the semaphore and if this process wants to reduce some
+ *      semaphore value we simply wake it up without doing the
  *      operation. So it has to try to get it later. Thus e.g. the
- *      running process may reacquire the mutex during the current
- *      time slice. If it only waits for zero or increases the mutex,
+ *      running process may reacquire the semaphore during the current
+ *      time slice. If it only waits for zero or increases the
semaphore,
  *      we do the operation in advance and wake it up.
  *   2) It did not wake up all zero waiting processes. We try to do
  *      better but only get the semops right which only wait for zero
or
@@ -53,7 +53,7 @@
  * check/retry algorithm for waking up blocked processes as the new
scheduler
  * is better at handling thread switch than the old one.
  *
- * /proc/sysvipc/mutex support (c) 1999 Dragos Acostachioaie
<dragos@iname.com>
+ * /proc/sysvipc/sem support (c) 1999 Dragos Acostachioaie
<dragos@iname.com>
  *
  * SMP-threaded, sysctl's added
  * (c) 1999 Manfred Spraul <manfred@colorfullife.com>
@@ -281,7 +281,7 @@ static inline void remove_from_queue (st
 }
 
 /*
- * Determine whether a sequence of mutex operations would succeed
+ * Determine whether a sequence of semaphore operations would succeed
  * all at once. Return 0 if yes, 1 if need to sleep, else return error
code.
  */
 
@@ -347,7 +347,7 @@ undo:
 	return result;
 }
 
-/* Go through the pending queue for the indicated mutex
+/* Go through the pending queue for the indicated semaphore
  * looking for tasks that can be completed.
  */
 static void update_queue (struct sem_array * sma)
@@ -372,7 +372,7 @@ static void update_queue (struct sem_arr
 			 * - if the operation modified the array, then
 			 *   restart from the head of the queue and
 			 *   check for threads that might be waiting
-			 *   for mutex values to become 0.
+			 *   for semaphore values to become 0.
 			 * - if the operation didn't modify the array,
 			 *   then just continue.
 			 */
@@ -393,11 +393,11 @@ static void update_queue (struct sem_arr
 	}
 }
 
-/* The following counts are associated to each mutex:
+/* The following counts are associated to each semaphore:
  *   semncnt        number of tasks waiting on semval being nonzero
  *   semzcnt        number of tasks waiting on semval being zero
- * This model assumes that a task waits on exactly one mutex.
- * Since mutex operations are to be performed atomically, tasks
actually
+ * This model assumes that a task waits on exactly one semaphore.
+ * Since semaphore operations are to be performed atomically, tasks
actually
  * wait on a whole sequence of semaphores simultaneously.
  * The counts we return here are a rough approximation, but still
  * warrant that semncnt+semzcnt>0 if the task is on the pending queue.
@@ -439,8 +439,8 @@ static int count_semzcnt (struct sem_arr
 	return semzcnt;
 }
 
-/* Free a mutex set. freeary() is called with sem_ids.mutex down and
- * the spinlock for this mutex set hold. sem_ids.mutex remains locked
+/* Free a semaphore set. freeary() is called with sem_ids.mutex locked
and
+ * the spinlock for this semaphore set hold. sem_ids.mutex remains
locked
  * on exit.
  */
 static void freeary (struct sem_array *sma, int id)
@@ -449,7 +449,7 @@ static void freeary (struct sem_array *s
 	struct sem_queue *q;
 	int size;
 
-	/* Invalidate the existing undo structures for this mutex set.
+	/* Invalidate the existing undo structures for this semaphore set.
 	 * (They will be freed without any further action in exit_sem()
 	 * or during the next semop.)
 	 */
@@ -470,7 +470,7 @@ static void freeary (struct sem_array *s
 		q = n;
 	}
 
-	/* Remove the mutex set from the ID array*/
+	/* Remove the semaphore set from the ID array*/
 	sma = sem_rmid(id);
 	sem_unlock(sma);
 
@@ -1245,7 +1245,7 @@ int copy_semundo(unsigned long clone_fla
 
 /*
  * add semadj values to semaphores, free undo structures.
- * undo structures are not freed when mutex arrays are destroyed
+ * undo structures are not freed when semaphore arrays are destroyed
  * so some of them may be out of date.
  * IMPLEMENTATION NOTE: There is some confusion over whether the
  * set of adjustments that needs to be done should be done in an atomic
@@ -1301,27 +1301,27 @@ found:
 		/* perform adjustments registered in u */
 		nsems = sma->sem_nsems;
 		for (i = 0; i < nsems; i++) {
-			struct sem * mutex = &sma->sem_base[i];
+			struct sem * semaphore = &sma->sem_base[i];
 			if (u->semadj[i]) {
-				mutex->semval += u->semadj[i];
+				semaphore->semval += u->semadj[i];
 				/*
-				 * Range checks of the new mutex value,
+				 * Range checks of the new semaphore value,
 				 * not defined by sus:
 				 * - Some unices ignore the undo entirely
 				 *   (e.g. HP UX 11i 11.22, Tru64 V5.1)
 				 * - some cap the value (e.g. FreeBSD caps
 				 *   at 0, but doesn't enforce SEMVMX)
 				 *
-				 * Linux caps the mutex value, both at 0
+				 * Linux caps the semaphore value, both at 0
 				 * and at SEMVMX.
 				 *
 				 * 	Manfred <manfred@colorfullife.com>
 				 */
-				if (mutex->semval < 0)
-					mutex->semval = 0;
-				if (mutex->semval > SEMVMX)
-					mutex->semval = SEMVMX;
-				mutex->sempid = current->tgid;
+				if (semaphore->semval < 0)
+					semaphore->semval = 0;
+				if (semaphore->semval > SEMVMX)
+					semaphore->semval = SEMVMX;
+				semaphore->sempid = current->tgid;
 			}
 		}
 		sma->sem_otime = get_seconds();



