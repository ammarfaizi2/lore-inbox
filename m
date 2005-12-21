Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVLUJhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLUJhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVLUJhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:37:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44267 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932336AbVLUJhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:37:00 -0500
Date: Wed, 21 Dec 2005 10:36:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cpu scheduler: unsquish dynamic priorities
Message-ID: <20051221093629.GA19867@elte.hu>
References: <43A78E33.7040307@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A78E33.7040307@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> The problem:
> 
> The current scheduler implementation maps 40 nice values and 10 bonus 
> values into only 40 priority slots on the run queues.  This results in 
> the dynamic priorities of tasks at either end of the nice scale being 
> squished up.  E.g. all tasks with nice in the range -20 to -16 and the 
> maximum of 10 bonus points will end up with a dynamic priority of 
> MAX_RT_PRIO and all tasks with nice in the range 15 to 19 and no bonus 
> points will end up with a dynamic priority of MAX_PRIO - 1.
> 
> Although the fact that niceness is primarily implemented by time slice 
> size means that this will have little or no adverse effect on the long 
> term allocation of CPU resources due to niceness, it could adversely 
> effect latency as it will interfere with preemption.

this property of the priority distribution was intentional from me, i 
wanted to have an easy way to test 'no priority boosting downwards' 
(nice +19) and 'no priority boosting upwards' (nice -20) conditions. But 
i like your patch, because it simplifies effective_prio() a bit, and 
with SCHED_BATCH we'll have the 'no boosting' property anyway. Could you 
redo the patch against the current scheduler queue in -mm, so that we 
can try it out in -mm?

Btw., another user-visible effect is that task_prio() will return the 
new range, which will be visible in e.g. 'top'. I dont think it will be 
confusing though.

	Ingo
