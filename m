Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWGFNhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWGFNhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWGFNhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:37:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55704 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030259AbWGFNhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:37:13 -0400
Date: Thu, 6 Jul 2006 15:32:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: New PriorityInheritanceTest - bug in 2.6.17-rt7 confirmed
Message-ID: <20060706133238.GA13800@elte.hu>
References: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain> <1152189293.24611.146.camel@localhost.localdomain> <Pine.LNX.4.64.0607061443050.30970@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607061443050.30970@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <nielsen.esben@googlemail.com> wrote:

> It can run within try_to_wake_up(). But then it the whole lock chain 
> is traversed in an atomic section. That unpredictable overall system 
> latencies since the locks can be in userspace. So it has to run in 
> some task. That task has to be high priority enough to preempt the 
> boosted tasks, but it can't be so high priority that it bothers any 
> higher priority threads than those involved in this. So it can't be, 
> forinstance a general priority 99 task we just use for this. We thus 
> need something running at a slightly higher priority than the priority 
> to which the tasks are boosted, but not a full +1 priority. I.e. we 
> need to run it at priority "+0.5".

we could just queue the task in front of the other task in the runqueue, 
and mark that task for reschedule if it's running currently. (Doing this 
is not without precedent: we do something similar in wake_up_new_task() 
to implement child-runs-first logic.)

	Ingo
