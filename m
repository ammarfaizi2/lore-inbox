Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSDDTP2>; Thu, 4 Apr 2002 14:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSDDTPG>; Thu, 4 Apr 2002 14:15:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293448AbSDDTO4>; Thu, 4 Apr 2002 14:14:56 -0500
Date: Thu, 4 Apr 2002 11:14:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <1017946309.22303.492.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Apr 2002, Robert Love wrote:
> 
> Thanks for the CC.  I've been looking into this problem.  I am not too
> sure why we require protection from concurrency via preemption and not
> via SMP.  In other words, why are we SMP-safe but not preempt-safe here.
> 
> I don't really have an answer.

The answer is that preempt_schedule() illegally sets 

	current->state = TASK_RUNNING;

without asking the process whether that's ok. The SMP code never does 
anything like that.

		Linus

