Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGVKyV>; Mon, 22 Jul 2002 06:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSGVKyU>; Mon, 22 Jul 2002 06:54:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25608 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316695AbSGVKxp>; Mon, 22 Jul 2002 06:53:45 -0400
Message-ID: <3D3BE3A9.4030704@evision.ag>
Date: Mon, 22 Jul 2002 12:51:21 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 wait
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------070401060900010707070900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401060900010707070900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Struct initializers are in C now.
- Remove unused add_wait_queue_cond() macro.

--------------070401060900010707070900
Content-Type: text/plain;
 name="wait-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wait-2.5.27.diff"

diff -urN linux-2.5.27/include/linux/wait.h linux/include/linux/wait.h
--- linux-2.5.27/include/linux/wait.h	2002-07-20 21:11:04.000000000 +0200
+++ linux/include/linux/wait.h	2002-07-22 00:02:30.000000000 +0200
@@ -43,16 +43,16 @@
  */
 
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
-	task:		tsk,						\
-	func:		default_wake_function,				\
-	task_list:	{ NULL, NULL } }
+	.task =		tsk,						\
+	.func =		default_wake_function,				\
+	.task_list =	{ NULL, NULL } }
 
 #define DECLARE_WAITQUEUE(name, tsk)					\
 	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
-	lock:		SPIN_LOCK_UNLOCKED,				\
-	task_list:	{ &(name).task_list, &(name).task_list } }
+	.lock =		SPIN_LOCK_UNLOCKED,				\
+	.task_list =	{ &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
@@ -103,22 +103,6 @@
 	list_del(&old->task_list);
 }
 
-#define add_wait_queue_cond(q, wait, cond) \
-	({							\
-		unsigned long flags;				\
-		int _raced = 0;					\
-		spin_lock_irqsave(&(q)->lock, flags);	\
-		(wait)->flags = 0;				\
-		__add_wait_queue((q), (wait));			\
-		rmb();						\
-		if (!(cond)) {					\
-			_raced = 1;				\
-			__remove_wait_queue((q), (wait));	\
-		}						\
-		spin_lock_irqrestore(&(q)->lock, flags);	\
-		_raced;						\
-	})
-
 #endif /* __KERNEL__ */
 
 #endif

--------------070401060900010707070900--

