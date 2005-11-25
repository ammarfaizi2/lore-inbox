Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbVKYFX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVKYFX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVKYFX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:23:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5307 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751410AbVKYFX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:23:26 -0500
Date: Fri, 25 Nov 2005 06:23:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] PF_DEAD: kill it
Message-ID: <20051125052337.GC22230@elte.hu>
References: <4385E402.3F0FFE07@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4385E402.3F0FFE07@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> After the previous change (->flags & PF_DEAD) <=> (->state == 
> EXIT_DEAD), so we can forget about PF_DEAD flag.
> 
> In my opinion PF_DEAD has nothing to do with process state, it is just 
> indication that task_struct should be freed after the last schedule.
> 
> Perhaps it makes sense to add new TASK_DEAD flag to use it instead of 
> EXIT_DEAD, while the latter should live only in ->exit_state.

yes, i'd suggest a followup patch to keep the two flag spaces totally 
disjunct - at least for testing in -mm. This area of code (when it was 
introduced) was pretty fragile and blew up under PREEMPT+SMP a couple of 
times. The separate handling of PF_DEAD was necessary until i fixed 
do_exit() to only have PF_DEAD in an atomic path up to the final 
schedule(). You are right that we can totally eliminate it now.

so your patch looks great to me! (I have also added this patch (and the 
previous patch) to the -rt tree, to give it some more testing in more 
extreme preemption scenarios.)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
