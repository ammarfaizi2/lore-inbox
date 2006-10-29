Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWJ2BFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWJ2BFb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 21:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWJ2BFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 21:05:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28632 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751452AbWJ2BFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 21:05:30 -0400
Date: Sat, 28 Oct 2006 18:05:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/7] Move idle stat calculation into rebalance_tick()
In-Reply-To: <20061028105727.A9917@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0610281804370.14100@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
 <20061028024138.10809.27755.sendpatchset@schroedinger.engr.sgi.com>
 <20061028105727.A9917@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Siddha, Suresh B wrote:

> comment needs to be fixed and also please mention that in case of SMT nice,
> nr_running will determine if the processor is idle or not(rather than
> checking for current task is idle)

Ah.. Thanks! Would this be okay?

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-28 20:00:07.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-28 20:04:08.721364884 -0500
@@ -2869,10 +2869,10 @@ static void rebalance_domains(unsigned l
 	unsigned long interval;
 	struct sched_domain *sd;
 	/*
-	 * A task is idle if this is the idle queue
-	 * and we have no runnable task
+	 * We are idle if there are no processes running. This
+	 * is valid even if we are the idle process (SMT).
 	 */
-	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
+	enum idle_type idle = !this_rq->nr_running ?
 				SCHED_IDLE : NOT_IDLE;
 	/* Earliest time when we have to call rebalance_domains again */
 	unsigned long next_balance = jiffies + 60*HZ;

