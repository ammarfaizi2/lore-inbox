Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVLNIoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVLNIoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVLNIoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:44:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15552 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932143AbVLNIoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:44:20 -0500
Date: Wed, 14 Dec 2005 09:43:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution patches
Message-ID: <20051214084333.GA20284@elte.hu>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de> <1134507927.18921.26.camel@localhost.localdomain> <20051214084019.GA18708@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214084019.GA18708@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> hm, in that case it should be base->running that protects against this 
> case. Did you run an UP PREEMPT_RT kernel? In that case could you 
> check whether the fix below resolves the crash too?

try the patch below instead. (Thomas pointed out that the correct 
dependency in this case is PREEMPT_SOFTIRQS)

	Ingo

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -118,7 +118,7 @@ static DEFINE_PER_CPU(struct hrtimer_bas
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 
 #define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
 
