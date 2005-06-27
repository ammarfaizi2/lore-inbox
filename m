Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVF0ISa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVF0ISa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVF0ISa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:18:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17346 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261922AbVF0ISX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:18:23 -0400
Date: Mon, 27 Jun 2005 10:17:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050627081712.GB15096@elte.hu>
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu> <200506270143.47690.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506270143.47690.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> In the FWIW category, I booted 50-23 about an hour & a half ago, same 
> mode 3, no hardirq's, everything seems to be working fine except for 
> kmails total lack of threading causeing composer hangs while a mail 
> fetch/spamassassin run is in progress.  But thats not anything new to 
> this patchset, its an equal opportunity annoyer.

does the patch below make the kmail starvation go away?

	Ingo

Index: kernel/sched.c
===================================================================
--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -1055,7 +1055,7 @@ static int try_to_wake_up(task_t * p, un
 	/*
 	 * sync wakeups can increase wakeup latencies:
 	 */
-	if (rt_task(p))
+//	if (rt_task(p))
 		sync = 0;
 #endif
 	rq = task_rq_lock(p, &flags);
