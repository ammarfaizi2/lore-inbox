Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbSIPWKy>; Mon, 16 Sep 2002 18:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbSIPWKy>; Mon, 16 Sep 2002 18:10:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59921
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263147AbSIPWKx>; Mon, 16 Sep 2002 18:10:53 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209161438220.3732-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209161438220.3732-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 18:15:52 -0400
Message-Id: <1032214552.1203.55.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 17:41, Linus Torvalds wrote:

> Ok. Let's just make the masking explicit in in_atomic() then, like you 
> suggest:

OK.

But, ugh, more fun: we preempt_disable() in do_exit().  Every exiting
task hits the test.  My syslog is huge.

At least for now, can we please revert the check to in_interrupt() ?

	Robert Love

diff -urN linux-2.5.35/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.35/kernel/sched.c	Sun Sep 15 22:18:24 2002
+++ linux/kernel/sched.c	Mon Sep 16 18:17:06 2002
@@ -940,7 +940,7 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
+	if (unlikely(in_interrupt()))
 		BUG();
 
 #if CONFIG_DEBUG_HIGHMEM

