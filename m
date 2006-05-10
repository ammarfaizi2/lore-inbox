Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWEJC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWEJC4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWEJC4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:41 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:50493 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932398AbWEJC4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:20 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u8hl031773@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] sys_msgctl gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

ipc/msg.c: In function 'sys_msgctl':
ipc/msg.c:338: warning: 'setbuf.qbytes' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.mode' may be used uninitialized in this function

-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/ipc/msg.c
===================================================================
--- linux-2.6.16.orig/ipc/msg.c
+++ linux-2.6.16/ipc/msg.c
@@ -335,7 +335,7 @@ asmlinkage long sys_msgctl (int msqid, i
 {
 	int err, version;
 	struct msg_queue *msq;
-	struct msq_setbuf setbuf;
+	struct msq_setbuf setbuf = {0, 0, 0, 0};
 	struct kern_ipc_perm *ipcp;
 	
 	if (msqid < 0 || cmd < 0)
