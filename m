Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTAKQvh>; Sat, 11 Jan 2003 11:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267283AbTAKQvh>; Sat, 11 Jan 2003 11:51:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7906 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267291AbTAKQvg>;
	Sat, 11 Jan 2003 11:51:36 -0500
Date: Sat, 11 Jan 2003 18:05:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] ptrace-fix-2.5.56-A0
In-Reply-To: <Pine.LNX.4.44.0301111558560.8697-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301111805320.10432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the correct patch is:

--- linux/kernel/ptrace.c.orig2	2003-01-11 16:52:48.000000000 +0100
+++ linux/kernel/ptrace.c	2003-01-11 18:59:32.000000000 +0100
@@ -115,7 +115,7 @@
 	__ptrace_link(task, current);
 	write_unlock_irq(&tasklist_lock);
 
-	send_sig(SIGSTOP, task, 1);
+	force_sig_specific(SIGSTOP, task);
 	return 0;
 
 bad:

