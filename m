Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSJFTjp>; Sun, 6 Oct 2002 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJFTjo>; Sun, 6 Oct 2002 15:39:44 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:518
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262159AbSJFTjm>; Sun, 6 Oct 2002 15:39:42 -0400
Subject: [PATCH] 2.4: export scheduling information from /proc
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 15:45:17 -0400
Message-Id: <1033933518.742.4470.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menacing Marcelo,

Attached patch exports scheduling policy and real-time priority from
/proc/<pid>/stats.

This code is in 2.4-ac and 2.5.

This does _not_ break previous versions of procps -- there is no harm
and it is fully backward compatible.  New versions, starting with 2.0.8,
can parse this information.

Patch is against 2.4.20-pre9.  Please, apply.

	Robert Love

diff -urN linux-2.4.20-pre9/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.4.20-pre9/fs/proc/array.c	2002-10-06 14:57:17.000000000 -0400
+++ linux/fs/proc/array.c	2002-10-06 15:02:53.000000000 -0400
@@ -347,7 +347,7 @@
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -390,7 +390,9 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->processor);
+		task->processor,
+		task->rt_priority,
+		task->policy);
 	if(mm)
 		mmput(mm);
 	return res;

