Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWEMR3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWEMR3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWEMR3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:29:50 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:50369 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932115AbWEMR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:29:49 -0400
Date: Sat, 13 May 2006 13:29:36 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] unnecessary long index i in sched
Message-ID: <Pine.LNX.4.58.0605131311590.27751@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless we expect to have more than 4294967295 CPUs, there's no reason to
have 'i' as a long long here.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-13 13:08:42.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 13:09:59.000000000 -0400
@@ -1829,7 +1829,8 @@ unsigned long nr_uninterruptible(void)

 unsigned long long nr_context_switches(void)
 {
-	unsigned long long i, sum = 0;
+	int i;
+	unsigned long long sum = 0;

 	for_each_possible_cpu(i)
 		sum += cpu_rq(i)->nr_switches;

