Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264296AbSIQPmw>; Tue, 17 Sep 2002 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264311AbSIQPmw>; Tue, 17 Sep 2002 11:42:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16066 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264296AbSIQPmv>;
	Tue, 17 Sep 2002 11:42:51 -0400
Date: Tue, 17 Sep 2002 17:54:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <Pine.LNX.4.44.0209170834210.4144-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209171754320.4292-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ie. for the time being, something like:

--- linux/kernel/sched.c.orig	Tue Sep 17 17:53:31 2002
+++ linux/kernel/sched.c	Tue Sep 17 17:54:10 2002
@@ -940,8 +940,9 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	if (likely(current->state != TASK_ZOMBIE))
+		if (unlikely(in_atomic()))
+			BUG();
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();

