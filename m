Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTAKOqx>; Sat, 11 Jan 2003 09:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAKOqx>; Sat, 11 Jan 2003 09:46:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38362 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267274AbTAKOqw>;
	Sat, 11 Jan 2003 09:46:52 -0500
Date: Sat, 11 Jan 2003 16:01:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: [patch] ptrace-fix-2.5.56-A0
Message-ID: <Pine.LNX.4.44.0301111558560.8697-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, from Roland McGrath, against BK-curr, fixes a
threading related ptrace bug: PTRACE_ATTACH should not stop everybody for
each thread attached.

	Ingo

--- linux/kernel/ptrace.c.orig	2003-01-11 16:52:48.000000000 +0100
+++ linux/kernel/ptrace.c	2003-01-11 16:53:08.000000000 +0100
@@ -115,7 +115,7 @@
 	__ptrace_link(task, current);
 	write_unlock_irq(&tasklist_lock);
 
-	send_sig(SIGSTOP, task, 1);
+	force_sig_specific(SIGSTOP, task, 1);
 	return 0;
 
 bad:

