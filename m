Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVBXHse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVBXHse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVBXHrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:47:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12185 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262124AbVBXHqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:46:39 -0500
Date: Thu, 24 Feb 2005 08:46:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] timestamp fixes
Message-ID: <20050224074624.GA7847@elte.hu>
References: <1109229293.5177.64.camel@npiggin-nld.site> <1109229362.5177.67.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109229362.5177.67.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 1/13
> 

ugh, has this been tested? It needs the patch below.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2704,11 +2704,11 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG))
+	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG)) {
 		run_time = now - prev->timestamp;
 		if (unlikely((long long)now - prev->timestamp < 0))
 			run_time = 0;
-	else
+	} else
 		run_time = NS_MAX_SLEEP_AVG;
 
 	/*
