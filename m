Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVKYFMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVKYFMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVKYFMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:12:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53718 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751408AbVKYFMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:12:22 -0500
Date: Fri, 25 Nov 2005 06:12:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
Message-ID: <20051125051232.GB22230@elte.hu>
References: <4385E3FF.C99DBCF5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4385E3FF.C99DBCF5@tv-sign.ru>
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

> schedule() checks PF_DEAD on every context switch, and sets ->state = 
> EXIT_DEAD to ensure that exited task will be deactivated.
> 
> I think it is better to set EXIT_DEAD in do_exit(), along with PF_DEAD 
> flag.

nice idea - your patch looks good to me.

> It is safe to do without task_rq() locking, because concurrent 
> try_to_wake_up() can't change task's ->state: the 'state' argument of 
> try_to_wake_up() can't have EXIT_DEAD bit. And in case when 
> try_to_wake_up() sees stale value of ->state == TASK_RUNNING it will 
> do nothing.

we should really not be getting concurrent wakeups in this situation 
anyway - and you are right that even if we got, it should have no effect 
neither in the EXIT_DEAD nor in the TASK_RUNNING case.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
