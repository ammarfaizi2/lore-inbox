Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSDDTRf>; Thu, 4 Apr 2002 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDDTRV>; Thu, 4 Apr 2002 14:17:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:36871 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293596AbSDDTQj>;
	Thu, 4 Apr 2002 14:16:39 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot time
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041108040.12895-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 14:16:35 -0500
Message-Id: <1017947795.22303.516.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 14:13, Linus Torvalds wrote:

> I think the real fix is to make sure that preemption never hits while 
> current->state == TASK_ZOMBIE.
> 
> In other words, I think the _correct_ fix is to just make 
> preempt_schedule() check for something like
> 
> 	if (current->state != TASK_RUNNING)
> 		return;
> 
> and just getting rid of the current "unconditionally set state to
> running".
> 
> (Side note: if the state isn't running, we're most likely going to
> reschedule in a controlled manner soon anyway. Sure, there are some loops 
> which set state to non-runnable early for race avoidance, but is it a 
> _problem_?)

Eh, maybe - what about all the code that sets non-running before putting
itself on a wait queue?

	Robert Love

