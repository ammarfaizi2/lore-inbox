Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317918AbSGKWCJ>; Thu, 11 Jul 2002 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317919AbSGKWCI>; Thu, 11 Jul 2002 18:02:08 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:60681 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317918AbSGKWCI>;
	Thu, 11 Jul 2002 18:02:08 -0400
Message-ID: <3D2E019F.5561E609@tv-sign.ru>
Date: Fri, 12 Jul 2002 02:07:27 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: Q: preemptible kernel and interrupts consistency.
References: <3D2DEB91.57FA34E6@tv-sign.ru>
		<1026420107.1178.279.camel@sinai>  <3D2DF64D.838BD6D6@tv-sign.ru> <1026422904.1244.294.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am sorry, may be i do not understand something obvious.

Robert Love wrote:
> That was my point, aside from interrupt handlers all the
> need_resched-touching code is in sched.c and both Ingo and I verified
> everything is locked.
> 
> If interrupts are disabled, there are no interrupts handlers.  And if
> you are in an interrupt handler, preemption is already disabled.

Is it legal to call wake_up_process(some_task) from process context,
with irqs disabled, and current->preempt_count == 0 ?

Then current may have need_resched flag set, and task_rq_unlock() falls
into schedule().

Oleg.
