Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSIIMCk>; Mon, 9 Sep 2002 08:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSIIMCk>; Mon, 9 Sep 2002 08:02:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3806 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317169AbSIIMCk>;
	Mon, 9 Sep 2002 08:02:40 -0400
Date: Mon, 9 Sep 2002 14:11:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] CLONE_DETACHED fix, BK-curr
Message-ID: <Pine.LNX.4.44.0209091408250.7712-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch avoids a crash that can be caused by a CLONE_DETACHED
thread.

	Ingo

--- linux/kernel/exit.c.orig	Mon Sep  9 14:06:05 2002
+++ linux/kernel/exit.c	Mon Sep  9 14:06:25 2002
@@ -532,7 +532,7 @@
 	 *	
 	 */
 	
-	if(current->exit_signal != SIGCHLD &&
+	if(current->exit_signal != SIGCHLD && current->exit_signal != -1 &&
 	    ( current->parent_exec_id != t->self_exec_id  ||
 	      current->self_exec_id != current->parent_exec_id) 
 	    && !capable(CAP_KILL))

