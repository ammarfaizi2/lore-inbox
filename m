Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVHBOxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVHBOxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVHBOxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:53:42 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38329 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261556AbVHBOxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:53:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730160345.GA3584@elte.hu>
References: <20050730160345.GA3584@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 10:53:00 -0400
Message-Id: <1122994380.1590.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch.  Remove redundant unlikely.

Side note. Ingo, I've also completed the softdeadlock update patch, and
I'm right now trying to trigger the kjournald deadlock by upping it to
FIFO 30 and having non RT tasks running find and compiles.  Since you
removed my inverted lock patch, this should cause the bug. This use to
cause the deadlock right away, but now I can't get it to lock.  Did you
change anything else? The jbd looks identical to 2.6.12.

-- Steve

Index: linux_realtime_ernie/kernel/latency.c
===================================================================
--- linux_realtime_ernie/kernel/latency.c	(revision 266)
+++ linux_realtime_ernie/kernel/latency.c	(working copy)
@@ -1481,7 +1481,7 @@
 	/*
 	 * Underflow?
 	 */
-	BUG_ON(unlikely(val > preempt_count_ti(ti)));
+	BUG_ON(val > preempt_count_ti(ti));
 
 	/*
 	 * Is the spinlock portion underflowing?


