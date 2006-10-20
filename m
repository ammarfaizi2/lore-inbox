Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946450AbWJTUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946450AbWJTUGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWJTUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:06:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:20925 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422784AbWJTUGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:06:43 -0400
Message-Id: <200610202005.k9KK54s1006910@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, Cedric Le Goater <clg@fr.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add-process_session-...-fix-warnings.patch fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Oct 2006 16:05:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
in -mm causes UML to hang at shutdown - init is sitting in a select on the 
initctl socket.

This patch fixes it for me.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/fs/proc/array.c
===================================================================
--- linux-2.6.17.orig/fs/proc/array.c	2006-10-20 16:01:05.000000000 -0400
+++ linux-2.6.17/fs/proc/array.c	2006-10-20 16:02:13.000000000 -0400
@@ -388,7 +388,7 @@ static int do_task_stat(struct task_stru
 			stime = cputime_add(stime, sig->stime);
 		}
 
-		signal_session(sig);
+		sid = signal_session(sig);
 		pgid = process_group(task);
 		ppid = rcu_dereference(task->real_parent)->tgid;

