Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbSI2LH7>; Sun, 29 Sep 2002 07:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbSI2LH7>; Sun, 29 Sep 2002 07:07:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52872 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262444AbSI2LH6>;
	Sun, 29 Sep 2002 07:07:58 -0400
Date: Sun, 29 Sep 2002 13:22:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sigfix-2.5.39-C2
Message-ID: <Pine.LNX.4.44.0209291320060.22646-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes thread-group SIGSTOP handling - the SIGSTOP
notification was not propagated to the parent of the thread group leader.  
Now Ctrl-Z-ing of thread groups works again.

	Ingo

--- linux/kernel/signal.c.orig	Sun Sep 29 12:49:12 2002
+++ linux/kernel/signal.c	Sun Sep 29 13:17:44 2002
@@ -1127,8 +1127,6 @@
 	struct siginfo info;
 	int why, status;
 
-	if (!tsk->ptrace && delay_group_leader(tsk))
-		return;
 	if (sig == -1)
 		BUG();
 

