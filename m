Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317831AbSFSJby>; Wed, 19 Jun 2002 05:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317832AbSFSJbx>; Wed, 19 Jun 2002 05:31:53 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:40368 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S317831AbSFSJbw>; Wed, 19 Jun 2002 05:31:52 -0400
Date: Wed, 19 Jun 2002 15:01:37 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: (off 2.5.22) replacing __builtin_expect with unlikely in
 Alpha header
Message-ID: <Pine.GSO.4.44.0206191500390.19689-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks adrian and paul for the correction . Here are the diffs with the
typo fixed ..... Please apply against latest 2.5....


diff -u -U 6 -r include/asm-alpha/rwsem.h /home/manik/linux-2.5.22/include/asm-alpha/rwsem.h
--- include/asm-alpha/rwsem.h	Mon Jun 17 08:01:35 2002
+++ /home/manik/linux-2.5.22/include/asm-alpha/rwsem.h	Wed Jun 19 14:48:08 2002
@@ -80,13 +80,13 @@
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount < 0, 0))
+	if (unlikely(oldcount < 0))
 		rwsem_down_read_failed(sem);
 }

 static inline void __down_write(struct rw_semaphore *sem)
 {
 	long oldcount;
@@ -104,13 +104,13 @@
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount, 0))
+	if (unlikely(oldcount))
 		rwsem_down_write_failed(sem);
 }

 static inline void __up_read(struct rw_semaphore *sem)
 {
 	long oldcount;
@@ -128,13 +128,13 @@
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(oldcount < 0, 0))
+	if (unlikely(oldcount < 0))
 		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
 			rwsem_wake(sem);
 }

 static inline void __up_write(struct rw_semaphore *sem)
 {
@@ -154,13 +154,13 @@
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
 	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
 #endif
-	if (__builtin_expect(count, 0))
+	if (unlikely(count))
 		if ((int)count == 0)
 			rwsem_wake(sem);
 }

 static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
 {


