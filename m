Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbULXXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbULXXln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbULXXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:41:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:57809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261463AbULXXlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:41:42 -0500
Date: Fri, 24 Dec 2004 15:41:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
In-Reply-To: <20041224182219.GH13747@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org>
References: <20041224174156.GE13747@dualathlon.random>
 <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
> 
> If those old cpus really supported smp in linux, then fixing this bit is
> trivial, just change it to short. Do they support short at least?

It's not even about SMP. "byte" and "short" are not IRQ-safe or even 
preemption-safe (although I guess alpha doesn't support CONFIG_PREEMPT 
right now anyway) on pre-byte-access alphas.

Just don't do it. Maybe we'll never see another chip try what alpha did 
(it was arguably the single biggest mistake the early alphas had, and 
caused tons of system design trouble), but just use an "int".

That said, I'd suggest putting it in the thread structure instead. We 
already have thread-safe flags there, just use one of the bits. Yes, 
you'll need to use locked accesses to set it, but hey, how often does 
something like this get set anyway? And then you just do ti _right_, using 
set_thread_flag/clear_thread_flag etc..

		Linus
