Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSHEKKX>; Mon, 5 Aug 2002 06:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSHEKKV>; Mon, 5 Aug 2002 06:10:21 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:62373 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S318356AbSHEKKS>; Mon, 5 Aug 2002 06:10:18 -0400
Date: Mon, 5 Aug 2002 15:43:39 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-alpha@vger.kernel.org, <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.5.30 : __builtin_expect() cleanups in alpha code (rwsem.h)
Message-ID: <Pine.GSO.4.44.0208051542170.21895-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending with diffs inline ... please apply ..
diffs are straightforward. Should patch with "patch -p1"



--- linux-2.5.30/include/asm-alpha/rwsem.h~	Fri Aug  2 02:46:35 2002
+++ linux-2.5.30/include/asm-alpha/rwsem.h	Mon Aug  5 15:34:59 2002
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

