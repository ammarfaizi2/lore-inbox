Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTH2Oui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbTH2Oui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:50:38 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:10290 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261276AbTH2Oug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:50:36 -0400
Date: Fri, 29 Aug 2003 16:49:40 +0200
Message-Id: <200308291449.h7TEne9K005808@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k ptrace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use ptrace_check_attach instead of doing the checks ourselves (from
Andreas Schwab).

--- linux-2.4.23-pre1/arch/m68k/kernel/ptrace.c	12 Nov 2001 20:04:34 -0000	1.2
+++ linux-m68k-2.4.23-pre1/arch/m68k/kernel/ptrace.c	22 Mar 2003 18:38:07 -0000
@@ -133,14 +133,9 @@
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
-	if (child->p_pptr != current)
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
