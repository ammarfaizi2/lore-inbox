Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVKYSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVKYSBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVKYSBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 13:01:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751041AbVKYSBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 13:01:33 -0500
Date: Fri, 25 Nov 2005 10:01:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
In-Reply-To: <20051125051232.GB22230@elte.hu>
Message-ID: <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org>
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Nov 2005, Ingo Molnar wrote:
> > 
> > I think it is better to set EXIT_DEAD in do_exit(), along with PF_DEAD 
> > flag.
> 
> nice idea - your patch looks good to me.

I'm not entirely convinced.

The thing is, We used to have DEAD in the task state flags, ie TASK_ZOMBIE 
was it. 

We started using PF_DEAD in 2003 with this commit message:

Author: Linus Torvalds <torvalds@home.osdl.org>  2003-10-26 03:16:23

    Add a sticky "PF_DEAD" task flag to keep track of dead processes.
    
    Use this to simplify 'finish_task_switch', but perhaps more
    importantly we can use this to track down why some processes
    seem to sometimes not die properly even after having been
    marked as ZOMBIE. The "task->state" flags are too fluid to 
    allow that well.

ie the PF_DEAD flag was never really about is _needing_ it: it was all 
about being able to safely check it _without_ having to rely on 
task->state.

So putting it back into task->state is not wrong per se, but it kind of 
misses the point of why it was somewhere else in the first place (or 
rather, why it was there in the _second_ place, since it was in 
task->state in the first place and got moved out of there).

			Linus
