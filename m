Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbSKPIv7>; Sat, 16 Nov 2002 03:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbSKPIv7>; Sat, 16 Nov 2002 03:51:59 -0500
Received: from mailout.mbnet.fi ([194.100.161.24]:22534 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S267247AbSKPIv6> convert rfc822-to-8bit;
	Sat, 16 Nov 2002 03:51:58 -0500
Message-ID: <001501c28d51$aef73860$5ca464c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@suse.de>
Subject: [PATCH] wait.h cleanup
Date: Sat, 16 Nov 2002 11:22:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 16 Nov 2002 08:57:53.0878 (UTC) FILETIME=[3FE5B760:01C28D4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below slightly cleans up the waitqueue initialization macros and
removes a useless comment from the header (the macro names are clear enough).

Comments?

--------------------------------------------------------------------------------

diff -ur linux-2.5.47/include/linux/wait.h difflinux/include/linux/wait.h
--- linux-2.5.47/include/linux/wait.h 2002-11-05 00:30:31.000000000 +0200
+++ difflinux/include/linux/wait.h 2002-11-14 09:40:37.000000000 +0200
@@ -37,21 +37,16 @@
 };
 typedef struct __wait_queue_head wait_queue_head_t;
 
-
-/*
- * Macros for declaration and initialisaton of the datatypes
- */
-
-#define __WAITQUEUE_INITIALIZER(name, tsk) {    \
+#define __WAITQUEUE_INITIALIZER(tsk) {  \
  .task  = tsk,      \
- .func  = default_wake_function,   \
+ .func  = default_wake_function, \
  .task_list = { NULL, NULL } }
 
-#define DECLARE_WAITQUEUE(name, tsk)     \
- wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
+#define DECLARE_WAITQUEUE(name, tsk) \
+ wait_queue_t name = __WAITQUEUE_INITIALIZER(tsk)
 
-#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {    \
- .lock  = SPIN_LOCK_UNLOCKED,    \
+#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {     \
+ .lock  = SPIN_LOCK_UNLOCKED,       \
  .task_list = { &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \


