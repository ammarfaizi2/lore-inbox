Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbSIWUXG>; Mon, 23 Sep 2002 16:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSIWUXG>; Mon, 23 Sep 2002 16:23:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19634 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261359AbSIWUXG>;
	Mon, 23 Sep 2002 16:23:06 -0400
Date: Mon, 23 Sep 2002 22:36:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       <linux-kernel@vger.kernel.org>, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <F425930C-CF2E-11D6-8873-00039387C942@mac.com>
Message-ID: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Peter Waechtler wrote:

> Getting into kernel is not the same as a context switch. Return EAGAIN
> or EWOULDBLOCK is definetly _not_ causing a context switch.

this is a common misunderstanding. When switching from thread to thread in
the 1:1 model, most of the cost comes from entering/exiting the kernel. So
*once* we are in the kernel the cheapest way is not to piggyback to
userspace to do some userspace context-switch - but to do it right in the
kernel.

in the kernel we can do much higher quality scheduling decisions than in
userspace. SMP affinity, various statistics are right available in
kernel-space - userspace does not have any of that. Not to talk about
preemption.

	Ingo

