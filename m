Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSIOLkc>; Sun, 15 Sep 2002 07:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSIOLkb>; Sun, 15 Sep 2002 07:40:31 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56300 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318018AbSIOLkb>;
	Sun, 15 Sep 2002 07:40:31 -0400
Date: Sun, 15 Sep 2002 13:52:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] init-fix-2.5.34-A0, BK-curr
Message-ID: <Pine.LNX.4.44.0209151350250.1525-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch makes all init-inherited kernel threads show up again
in the 'ps' process list on BK-curr (including init itself). I'm not quite
sure why CLONE_THREAD was added to CLONE_SIGNAL - is there any reason
kernel threads should not be separate entities?

	Ingo

--- linux/include/linux/sched.h.orig	Sun Sep 15 13:36:29 2002
+++ linux/include/linux/sched.h	Sun Sep 15 13:36:36 2002
@@ -51,7 +51,7 @@
 #define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
 #define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
 
-#define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
+#define CLONE_SIGNAL	CLONE_SIGHAND
 
 /*
  * These are the constant used to fake the fixed-point load-average

