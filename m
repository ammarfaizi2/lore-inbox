Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTEVKZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 06:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTEVKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 06:25:30 -0400
Received: from dp.samba.org ([66.70.73.150]:39341 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262657AbTEVKZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 06:25:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       pthreads-devel <pthreads-devel@www-124.southbury.usf.ibm.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Thu, 22 May 2003 11:15:20 +0200."
             <Pine.LNX.4.44.0305221052590.4549-100000@localhost.localdomain> 
Date: Thu, 22 May 2003 20:35:53 +1000
Message-Id: <20030522103833.ED5532C0F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305221052590.4549-100000@localhost.localdomain> you write:
> really, i dont see what your problem with the new syscalls are.

That's clear.  But I just changed my mind 8)

Because if you're going to demux the syscall, it might be worth
looking at FUTEX_FD: an "expected val" arg there might be worthwhile,
because to use it currently I think NPTL does:

	try to get futex
	fd = sys_futex(FUTEX_FD...)
	try to get futex again because of race

Have the futex_fd act like futex_wait, ie. return -EWOULDBLOCK if the
value != expected value.

> all that is needed now is some actual review of the new APIs from the
> conceptual angle (i've done that and i think they are okay, but more eyes
> see more), so that we make sure these are good and we wont need to discard
> any aspect of them anytime soon.

Sorry, I didn't comment because I thought your explanation, concept,
analysis and code were all very neat.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
