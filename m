Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTEKKVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTEKKVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:21:34 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:16432 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261216AbTEKKV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:28 -0400
Date: Sun, 11 May 2003 12:30:58 +0200
Message-Id: <200305111030.h4BAUwda019658@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k ptrace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use ptrace_check_attach instead of doing the checks ourselves (from
Andreas Schwab).

--- linux-2.5.x/arch/m68k/kernel/ptrace.c	4 Nov 2002 23:39:45 -0000	1.1.1.4
+++ linux-m68k-2.5.x/arch/m68k/kernel/ptrace.c	22 Mar 2003 18:39:06 -0000
@@ -135,14 +135,9 @@
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
-	if (child->parent != current)
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
 		goto out_tsk;
 
 	switch (request) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
