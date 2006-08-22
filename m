Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWHVOqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWHVOqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHVOqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:46:31 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:55198 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932282AbWHVOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:46:30 -0400
Date: Tue, 22 Aug 2006 23:10:37 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060822191037.GA493@oleg>
References: <20060821170604.GA1640@oleg> <20060822104327.GA28183@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822104327.GA28183@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22, Ingo Molnar wrote:
> 
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > (Compile tested).
> > 
> > futex_find_get_task:
> > 
> > 	if (p->state == EXIT_ZOMBIE || p->exit_state == EXIT_ZOMBIE)
> > 		return NULL;
> > 
> > I can't understand this. First, p->state can't be EXIT_ZOMBIE. The 
> > ->exit_state check looks strange too. Sub-threads or tasks whose 
> > ->parent ignores SIGCHLD go directly to EXIT_DEAD state (I am ignoring 
> > a ptrace case). Why EXIT_DEAD tasks should be ok? Yes, EXIT_ZOMBIE is 
> > more important (a task may stay zombie for a long time), but this 
> > doesn't mean we should explicitely ignore other EXIT_XXX states.
> > 
> > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> i believe this is a remnant of older times when EXIT_ZOMBIE was 
> introduced. We cloned that into the -rt tree, but then exit-state got 
> cleaned up (by you)

No, no, it was Roland.

But probably you are talking about these patches

	http://marc.theaimsgroup.com/?t=113284375800003&r=1
	http://marc.theaimsgroup.com/?t=113284375800005&r=1

? It was abandoned by Linus. It is not clear was he convinced or not,
but I'd be happy to re-send this patch (on weekend) if you wish.

Oleg.

