Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUF1Vee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUF1Vee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUF1Vee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:34:34 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:41686 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265228AbUF1Vec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:34:32 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Jun 2004 14:34:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] signal handler defaulting fix ...
Message-ID: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following up from the other thread (2.6.x signal handler bug) this bring 
2.4 behaviour in 2.6.


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>



- Davide



--- a/kernel/signal.c	2004-06-28 14:28:51.000000000 -0700
+++ b/kernel/signal.c	2004-06-28 14:29:31.000000000 -0700
@@ -820,8 +820,9 @@
 	int ret;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
+	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
+	if (sigismember(&t->blocked, sig)) {
 		sigdelset(&t->blocked, sig);
 		recalc_sigpending_tsk(t);
 	}
