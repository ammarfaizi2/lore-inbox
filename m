Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265448AbTLHR6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbTLHR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:58:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21649 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265448AbTLHR6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:58:35 -0500
Date: Mon, 8 Dec 2003 18:57:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <20031207201715.GD19412@krispykreme>
Message-ID: <Pine.LNX.4.58.0312081852570.8510@earth>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
 <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0312071433300.28463@earth> <20031207163914.GB19412@krispykreme>
 <1039560000.1070817418@[10.10.2.4]> <20031207201715.GD19412@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no, SpamAssassin (score=-4.9, required 5.9,
	BAYES_00 -4.90)
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Dec 2003, Anton Blanchard wrote:

> running on cpu 1
> mapping CPU#1's runqueue to CPU#0's runqueue.
> kernel BUG in sched_map_runqueue at kernel/sched.c:1460!
> 
> ie:
> 
> BUG_ON(rq1 == rq2 || rq2->nr_running || rq_idx(cpu1) != cpu1);
>                      ^^^
> 
> We should bounce ourselves off cpu2 before merging the runqueues.

hm, a bad assumption about where the boot code runs. Could you try to just
do something like this prior that BUG_ON():

	set_cpus_allowed(current, cpumask_of_cpu(cpu1));

does this fix the crash?

	Ingo
