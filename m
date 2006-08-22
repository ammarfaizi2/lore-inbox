Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWHVKvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWHVKvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWHVKvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:51:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16868 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932163AbWHVKvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:51:08 -0400
Date: Tue, 22 Aug 2006 12:43:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060822104327.GA28183@elte.hu>
References: <20060821170604.GA1640@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821170604.GA1640@oleg>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> (Compile tested).
> 
> futex_find_get_task:
> 
> 	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
> 		return NULL;
> 
> I can't understand this. First, p->state can't be EXIT_ZOMBIE. The 
> ->exit_state check looks strange too. Sub-threads or tasks whose 
> ->parent ignores SIGCHLD go directly to EXIT_DEAD state (I am ignoring 
> a ptrace case). Why EXIT_DEAD tasks should be ok? Yes, EXIT_ZOMBIE is 
> more important (a task may stay zombie for a long time), but this 
> doesn't mean we should explicitely ignore other EXIT_XXX states.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

i believe this is a remnant of older times when EXIT_ZOMBIE was 
introduced. We cloned that into the -rt tree, but then exit-state got 
cleaned up (by you) upstream and that cleanup didnt propagate into the 
-rt tree. Andrew: i think this is a must-have fix for v2.6.18.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
