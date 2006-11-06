Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753061AbWKFNMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbWKFNMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbWKFNMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:12:54 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:18852 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1753059AbWKFNMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:12:53 -0500
Date: Mon, 6 Nov 2006 17:15:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
Message-ID: <20061106141502.GA164@oleg>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.58.0611060729370.14553@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611060729370.14553@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06, Steven Rostedt wrote:
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks.

But on the other hand we probably have a similar code (set condition +
wake_up_process()) in other places too, and __wake_up(wait_queue_head_t)
has (in theory) the same problem. Probably we can add something like

	smp_wmb_unless_spin_lock_implies_memory_barrier_on_this_arch()

somewhere in try_to_wake_up(). I dunno.

Oleg.

