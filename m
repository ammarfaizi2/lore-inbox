Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSIWVDH>; Mon, 23 Sep 2002 17:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSIWVDG>; Mon, 23 Sep 2002 17:03:06 -0400
Received: from smtpout.mac.com ([204.179.120.85]:19943 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261391AbSIWVDD>;
	Mon, 23 Sep 2002 17:03:03 -0400
Message-ID: <3D8F82E5.90A64E8@mac.com>
Date: Mon, 23 Sep 2002 23:08:53 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.20-pre7 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar schrieb:
> 
> On Mon, 23 Sep 2002, Peter Waechtler wrote:
> 
> > Getting into kernel is not the same as a context switch. Return EAGAIN
> > or EWOULDBLOCK is definetly _not_ causing a context switch.
> 
> this is a common misunderstanding. When switching from thread to thread in
> the 1:1 model, most of the cost comes from entering/exiting the kernel. So
> *once* we are in the kernel the cheapest way is not to piggyback to
> userspace to do some userspace context-switch - but to do it right in the
> kernel.
> 
> in the kernel we can do much higher quality scheduling decisions than in
> userspace. SMP affinity, various statistics are right available in
> kernel-space - userspace does not have any of that. Not to talk about
> preemption.
> 

I'm already almost convinced on the NPT way of doing threading.
But still: the timeslice is per process (and kernel thread).
You still have other processes running.
With 1:1 on "hitting" a blocking condition the kernel will
switch to a different beast (yes, a thread gets a bonus for
using the same MM and the same cpu).
But on M:N the "user process" makes some more progress in its
timeslice (does it get even punished for eating up its 
timeslice?) I would think that it tends to cause less context
switches but tends to do more syscalls :-(

I already had a closer look at NGPT before reading Ulrich's
comments on the phil-list and on his website. I already thought
"puh, that's a complicated beast", and as I saw the
fcntl(GETFL);fcntl(O_NONBLOCK);write();fcntl(oldflags); thingy..

Well, with an O(1) scheduler, faster thread creation and exit
NPT has good chances to perform faster.

Now I'm just curious about the argument about context switch
times. Is Linux really that much faster than Solaris, Irix etc.?

Do you have numbers (or a hint) on comparable (ideal: identical) 
hardware? Is LMbench a good starting point?
