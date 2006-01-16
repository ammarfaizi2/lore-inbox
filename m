Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWAPJ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWAPJ7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAPJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:59:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2488 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932307AbWAPJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:59:20 -0500
Date: Mon, 16 Jan 2006 10:59:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] kernel/hrtimer.c sparse warning fix
Message-ID: <20060116095941.GA25736@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following Sparse warning:

 kernel/hrtimer.c:665:34: warning: incorrect type in argument 2 (different address spaces)
 kernel/hrtimer.c:665:34:    expected void const *from
 kernel/hrtimer.c:665:34:    got struct timespec [noderef] *<noident><asn:1>
 kernel/hrtimer.c:664:2: warning: dereference of noderef expression

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/hrtimer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -644,7 +644,8 @@ schedule_hrtimer_interruptible(struct hr
 static long __sched
 nanosleep_restart(struct restart_block *restart, clockid_t clockid)
 {
-	struct timespec __user *rmtp, tu;
+	struct timespec __user *rmtp;
+	struct timespec tu;
 	void *rfn_save = restart->fn;
 	struct hrtimer timer;
 	ktime_t rem;
