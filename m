Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317821AbSFSJJl>; Wed, 19 Jun 2002 05:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317822AbSFSJJk>; Wed, 19 Jun 2002 05:09:40 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:28355 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317821AbSFSJJj>; Wed, 19 Jun 2002 05:09:39 -0400
Message-ID: <3D104A50.24C00206@cisco.com>
Date: Wed, 19 Jun 2002 14:39:36 +0530
From: Manik Raina <manik@cisco.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: (off 2.5.22) replacing __builtin_expect with unlikely in Alpha 
 headers 
Content-Type: multipart/mixed;
 boundary="------------10DFFC3DF2A702B8FCAB56DD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------10DFFC3DF2A702B8FCAB56DD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


    This fix should remove __builtin_expect () and replace it with
unlikely ()  in include/asm-alpha/rwsem.h
    This should be cool since rwsem.h already includes
include/linux/compiler.h

    Files changed :

    include/asm-alpha/rwsem.h



--------------10DFFC3DF2A702B8FCAB56DD
Content-Type: text/plain; charset=us-ascii;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

diff -u -U 6 -r include/asm-alpha/rwsem.h /home/manik/linux-2.5.22/include/asm-alpha/rwsem.h
--- include/asm-alpha/rwsem.h	Mon Jun 17 08:01:35 2002
+++ /home/manik/linux-2.5.22/include/asm-alpha/rwsem.h	Wed Jun 19 14:25:03 2002
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
+	if (unlikely(count, 0))
 		if ((int)count == 0)
 			rwsem_wake(sem);
 }
 
 static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
 {
Only in /home/manik/linux-2.5.22/include/asm-alpha/: rwsem.h~

--------------10DFFC3DF2A702B8FCAB56DD--

