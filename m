Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135757AbRDSXfL>; Thu, 19 Apr 2001 19:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135756AbRDSXfB>; Thu, 19 Apr 2001 19:35:01 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:28830 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S135755AbRDSXez>;
	Thu, 19 Apr 2001 19:34:55 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_J3C298T12LWTFAM22NBO"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: torvalds@transmeta.com
Subject: [PATCH] generic rw_semaphores, compile warnings patch
Date: Fri, 20 Apr 2001 00:33:19 +0100
X-Mailer: KMail [version 1.2]
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042000331901.01311@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J3C298T12LWTFAM22NBO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch (made against linux-2.4.4-pre4) gets rid of some warnings obtained 
when using the generic rwsem implementation.

David


--------------Boundary-00=_J3C298T12LWTFAM22NBO
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rwsem-cw.diff"
Content-Transfer-Encoding: 8bit
Content-Description: rwsem compile warnings patch
Content-Disposition: attachment; filename="rwsem-cw.diff"

diff -uNr linux-2.4.4-pre4/include/linux/rwsem.h linux/include/linux/rwsem.h
--- linux-2.4.4-pre4/include/linux/rwsem.h	Thu Apr 19 22:07:49 2001
+++ linux/include/linux/rwsem.h	Thu Apr 19 23:52:41 2001
@@ -42,20 +42,24 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 
-#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
-#else
-#include <asm/rwsem.h> /* use an arch-specific implementation */
-#endif
+struct rw_semaphore;
 
 /* defined contention handler functions for the generic case
  * - these are also used for the exchange-and-add based algorithm
  */
-#if defined(CONFIG_RWSEM_GENERIC) || defined(CONFIG_RWSEM_XCHGADD_ALGORITHM)
+#if defined(CONFIG_RWSEM_GENERIC_SPINLOCK) || defined(CONFIG_RWSEM_XCHGADD_ALGORITHM)
 /* we use FASTCALL convention for the helpers */
 extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *sem));
+#endif
+
+/* access the actual implementation of the rwsems
+ */
+#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
+#include <linux/rwsem-spinlock.h> /* use a generic implementation */
+#else
+#include <asm/rwsem.h> /* use an arch-specific implementation */
 #endif
 
 #ifndef rwsemtrace

--------------Boundary-00=_J3C298T12LWTFAM22NBO--
