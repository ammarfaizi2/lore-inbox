Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWHPHRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWHPHRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWHPHRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:17:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750960AbWHPHRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:17:15 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] has_stopped_jobs cleanup
Message-Id: <20060816071710.2AD36180063@magilla.sf.frob.com>
Date: Wed, 16 Aug 2006 00:17:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This check has been obsolete since the introduction of TASK_TRACED.
Now TASK_STOPPED always means job control stop.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 kernel/exit.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index dba194a..3783e5a 100644  
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -249,17 +249,6 @@ static int has_stopped_jobs(int pgrp)
 	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
 		if (p->state != TASK_STOPPED)
 			continue;
-
-		/* If p is stopped by a debugger on a signal that won't
-		   stop it, then don't count p as stopped.  This isn't
-		   perfect but it's a good approximation.  */
-		if (unlikely (p->ptrace)
-		    && p->exit_code != SIGSTOP
-		    && p->exit_code != SIGTSTP
-		    && p->exit_code != SIGTTOU
-		    && p->exit_code != SIGTTIN)
-			continue;
-
 		retval = 1;
 		break;
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
