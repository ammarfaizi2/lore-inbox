Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268308AbTCFS6q>; Thu, 6 Mar 2003 13:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268312AbTCFS6q>; Thu, 6 Mar 2003 13:58:46 -0500
Received: from ns.suse.de ([213.95.15.193]:32784 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268308AbTCFS6p>;
	Thu, 6 Mar 2003 13:58:45 -0500
Subject: Re: Better CLONE_SETTLS support for Hammer
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E679A55.4030701@redhat.com>
References: <3E664836.7040405@redhat.com>
	<20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com>
	<20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com>
	<20030306010517.GB17865@wotan.suse.de> <3E66CB1A.6020107@redhat.com>
	<20030306102720.GA23747@wotan.suse.de>  <3E679A55.4030701@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Mar 2003 20:09:16 +0100
Message-Id: <1046977757.1388.176.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 19:58, Ulrich Drepper wrote:

> 
> It's already part of the documented ABI.  Yes, if right now somebody
> said r11 or whatever is declared the thread register, we could change
> it.  But give it a few more weeks and it'll probably be impossible

It's already pretty much impossible.


> You don't understand threads.  There is nothing broken or NPTL-specific
> about the design.  Every thread creation mechanism must be signal save.
>  LinuxThreads's is not, which is a bit less of a problem since the
> signal handling is broken, too, and signals are unlikely to arrive at
> the new thread. Nevertheless, there are certainly spurious crashes which
> are hard to reproduce and explain which can be attributed to this problem.

I would have designed it with CLONE_BLOCKALLSIGNALS and then set it in
the target process before unblocking signals. This would be in the 
spirit of fork/exec and also what posix APIs do for similar
problems (like pselect)

But of course it's too late now. We'll have to live with this
ugly thing.

Just hope you won't run out of the argument registers for the next
round of enhancements ;)

-Andi


