Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUC2Ftd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbUC2Ftd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:49:33 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:35916 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262689AbUC2Ftb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:49:31 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.5-rc2 __WAITQUEUE_INITIALIZER
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Mar 2004 15:49:13 +1000
Message-ID: <5648.1080539353@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When struct __wait_queue is on stack or you reuse an existing
waitqueue, you get garbage in the flags.

Index: 5-rc2.1/include/linux/wait.h
--- 5-rc2.1/include/linux/wait.h Thu, 18 Dec 2003 16:46:13 +1100 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
+++ 5-rc2.1(w)/include/linux/wait.h Mon, 29 Mar 2004 15:36:39 +1000 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
@@ -40,6 +40,7 @@ typedef struct __wait_queue_head wait_qu
  */
 
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
+	.flags		= 0,						\
 	.task		= tsk,						\
 	.func		= default_wake_function,			\
 	.task_list	= { NULL, NULL } }

