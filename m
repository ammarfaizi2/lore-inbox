Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWBXHJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWBXHJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWBXHJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:09:37 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:38347 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750762AbWBXHJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:09:37 -0500
Date: Fri, 24 Feb 2006 02:09:21 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rt17
In-Reply-To: <20060224063822.GC1431@elte.hu>
Message-ID: <Pine.LNX.4.58.0602240206200.19538@gandalf.stny.rr.com>
References: <20060221155548.GA30146@elte.hu> <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
 <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com> <20060224063822.GC1431@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Feb 2006, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > +	printk("| This is not a BUG\n");
> > +	printk("| turn off CONFIG_DEBUG_STACK_OVERFLOW if you don't want this\n");
>
> i added the patch below - we want to know about too high stack
> footprints.

Yeah you're right, those should be reported.

>
>  		MAX_STACK-worst_stack_left, (long)MAX_STACK);
> +	fill_ratio = (MAX_STACK-worst_stack_left)*100/(long)MAX_STACK;
> +	printk("| Stack fill ratio: %02ld%%", fill_ratio);
> +	if (fill_ratio >= 90)
> +		printk(" - BUG: that's quite high, please report this!\n");
> +	else
> +		printk(" - that's still OK, no need to report this.\n");
>  	printk("------------|\n");

On the non bug case, I would still state the way to turn it off.  It
becomes quite annoying if there are no bugs, and a non kernel hacker may
not know how to disable it.

-- Steve


