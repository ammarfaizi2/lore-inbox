Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbUKTMMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUKTMMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUKTMJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:09:46 -0500
Received: from coderock.org ([193.77.147.115]:52368 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262879AbUKTMIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:08:13 -0500
Date: Sat, 20 Nov 2004 13:07:23 +0100
From: Domen Puncer <domen@coderock.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: janitor@sternwelten.at, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c: fix subtle TASK_RUNNING compare
Message-ID: <20041120120722.GA3826@masina.coderock.org>
References: <E1CVL0H-0000SH-EN@sputnik> <20041120125355.GB8091@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120125355.GB8091@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/04 13:53 +0100, Ingo Molnar wrote:
> 
> * janitor@sternwelten.at <janitor@sternwelten.at> wrote:
> 
> >  	switch_count = &prev->nivcsw;
> > -	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
> > +	if (prev->state != TASK_RUNNING &&
> > +			!(preempt_count() & PREEMPT_ACTIVE)) {
> >  		switch_count = &prev->nvcsw;
> 
> nack. We inherently rely on the process state mask being a bitmask and
> TASK_RUNNING thus being zero.

Hmm... but other compares in sched.c are ok? ;-)
1211:   BUG_ON(p->state != TASK_RUNNING);
2550:   if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
3609:   if (state == TASK_RUNNING)
3640:   if (state != TASK_RUNNING)

Well, it just looks more readable to me. But i don't have too strong
feelings about this. :-)


	Domen
