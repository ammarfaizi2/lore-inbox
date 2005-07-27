Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVG0Osu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVG0Osu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVG0Osu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:48:50 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10735 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262098AbVG0OrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:47:18 -0400
Subject: [PATCH] safty check of MAX_RT_PRIO >= MAX_USER_RT_PRIO
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050727143318.GA26303@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <20050727141754.GA25356@elte.hu>
	 <1122474396.29823.65.camel@localhost.localdomain>
	 <20050727143318.GA26303@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 10:47:00 -0400
Message-Id: <1122475620.29823.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 16:33 +0200, Ingo Molnar wrote:
> i'm not excluding that this will become necessary in the future. We 
> should also add the safety check to sched.h - all i'm suggesting is to 
> not make it a .config option just now, because that tends to be fiddled 
> with.

So Ingo, would you agree that at least this patch should go in?

-- Steve

(Patched against 2.6.12.2)

Index: vanilla_kernel/include/linux/sched.h
===================================================================
--- vanilla_kernel/include/linux/sched.h	(revision 263)
+++ vanilla_kernel/include/linux/sched.h	(working copy)
@@ -392,6 +392,10 @@
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
+#if MAX_USER_RT_PRIO > MAX_RT_PRIO
+#error MAX_USER_RT_PRIO must not be greater than MAX_RT_PRIO
+#endif
+
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))


