Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWHVABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWHVABy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWHVABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:01:53 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:27351
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750759AbWHVABx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:01:53 -0400
Date: Mon, 21 Aug 2006 17:01:10 -0700
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060822000110.GA31751@gnuppy.monkey.org>
References: <20060821170604.GA1640@oleg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821170604.GA1640@oleg>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 09:06:04PM +0400, Oleg Nesterov wrote:
> (Compile tested).
> 
> futex_find_get_task:
> 
> 	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
> 		return NULL;
> 
> I can't understand this. First, p->state can't be EXIT_ZOMBIE. The ->exit_state
> check looks strange too. Sub-threads or tasks whose ->parent ignores SIGCHLD go
> directly to EXIT_DEAD state (I am ignoring a ptrace case). Why EXIT_DEAD tasks
> should be ok? Yes, EXIT_ZOMBIE is more important (a task may stay zombie for a
> long time), but this doesn't mean we should explicitely ignore other EXIT_XXX
> states.

The p->state variable for EXIT_ZOMBIE is only live for some mystery architecture
in arch/xtensa/kernel/ptrace.c

It could be a typo under architecture so maybe it's better fixed there as well
with a "state" to "exit_state" change. I don't really know for sure since I don't
work under that architecure.

bill


