Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318724AbSHAMno>; Thu, 1 Aug 2002 08:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHAMno>; Thu, 1 Aug 2002 08:43:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15110 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318724AbSHAMnn>; Thu, 1 Aug 2002 08:43:43 -0400
Message-ID: <3D492C9D.2050309@evision.ag>
Date: Thu, 01 Aug 2002 14:42:05 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [TRIVIAL] wait.h
Content-Type: multipart/mixed;
 boundary="------------060909040506010207080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909040506010207080209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- C99 conformance
- removal of nowhere used conditional wait queue add macro

--------------060909040506010207080209
Content-Type: text/plain;
 name="wait-2.5.29.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wait-2.5.29.diff"

diff -durNp -X /tmp/diff.z44e2S linux-2.5.29/include/linux/wait.h linux/include/linux/wait.h
--- linux-2.5.29/include/linux/wait.h	2002-07-27 04:58:24.000000000 +0200
+++ linux/include/linux/wait.h	2002-08-01 14:30:37.000000000 +0200
@@ -43,16 +43,16 @@ typedef struct __wait_queue_head wait_qu
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
@@ -103,22 +103,6 @@ static inline void __remove_wait_queue(w
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

--------------060909040506010207080209--

