Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSDDXnl>; Thu, 4 Apr 2002 18:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDDXnc>; Thu, 4 Apr 2002 18:43:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16145 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311948AbSDDXnZ>; Thu, 4 Apr 2002 18:43:25 -0500
Date: Thu, 4 Apr 2002 15:42:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@zip.com.au>, Roger Larsson <roger.larsson@norran.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot  time
In-Reply-To: <1017961694.23629.649.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0204041541500.26177-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Apr 2002, Robert Love wrote:
> 
> Curiously, what is wrong with the way we did it in the original patch? 
> I.e. set a bit in preempt_count and use that to skip to pick_next_task
> in schedule.  This allows us to preempt any task of any state ...

Because that requires that every user of "set_task_state()" needs to know 
about preemption.

Btw, I think entry.S should just call preempt_schedule() instead, instead 
of knowing about these details.

		Linus

