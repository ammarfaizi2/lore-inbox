Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVJEHki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVJEHki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVJEHki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:40:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25578 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932567AbVJEHkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:40:37 -0400
Date: Wed, 5 Oct 2005 09:41:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Knecht <markknecht@gmail.com>, Steven Rostedt <rostedt@kihontech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005074108.GC22873@elte.hu>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com> <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128458707.13057.68.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > > BUG: init/1: leaked RT prio 98 (116)?
> > >
> > > Steven, it goes away when deadlock detection is enabled. Any pointers 
> 
> Thats actually a red hering caused by asymetric accounting which only
> happens when
> 
> CONFIG_DEBUG_PREEMPT=y 
> and 
> # CONFIG_RT_DEADLOCK_DETECT is not set

>  #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPT_RT)
> +	owner->lock_count--;
>  	if (owner->lock_count < 0 || owner->lock_count >= MAX_LOCK_STACK) {
>  		TRACE_OFF();
>  		printk("BUG: %s/%d: lock count of %u\n",
>  			owner->comm, owner->pid, owner->lock_count);
>  		dump_stack();
>  	}
> -	owner->lock_count--;
>  	owner->owned_lock[owner->lock_count] = NULL;

ouch. Brown paperbag for me! Patch applied.

	Ingo
