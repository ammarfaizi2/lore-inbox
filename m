Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161922AbWKJSDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161922AbWKJSDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161923AbWKJSDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:03:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22720 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161922AbWKJSDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:03:54 -0500
Date: Fri, 10 Nov 2006 19:02:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <20061110180252.GA25694@elte.hu>
References: <20061001112829.630288000@frodo> <Pine.LNX.4.64.0610011336400.29459@frodo.shire> <20061110144916.GA19152@elte.hu> <20061110161657.GA19407@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110161657.GA19407@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on SMP i had to remove this assert:

Index: linux/kernel/rtmutex.c
===================================================================
--- linux.orig/kernel/rtmutex.c
+++ linux/kernel/rtmutex.c
@@ -823,7 +823,7 @@ rt_spin_lock_slowunlock(struct rt_mutex 
 	}
 	wakeup_next_waiter(lock, 1);
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
-	BUG_ON(current->boosting_prio != MAX_PRIO);
+//	BUG_ON(current->boosting_prio != MAX_PRIO);
 	/* Undo pi boosting.when necessary */
 	rt_mutex_adjust_prio(current);
 }

because it triggered almost immediately after bootup.

	Ingo
