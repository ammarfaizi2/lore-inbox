Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSJ1Vxu>; Mon, 28 Oct 2002 16:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSJ1Vxu>; Mon, 28 Oct 2002 16:53:50 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:47122 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S261527AbSJ1Vxs>; Mon, 28 Oct 2002 16:53:48 -0500
Message-ID: <3DBDB33B.6000200@ixiacom.com>
Date: Mon, 28 Oct 2002 13:59:23 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] epoll more scalable than poll
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:
> On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:
>> 	The results of our testing show not only does the system call 
>> interface to epoll perform as well as the /dev interface but also that epoll 
>> is many times better than standard poll. No other implementations of poll 
>> have performed as well as epoll in any measure. Testing details and results 
>> are published here, please take a minute to check it out: 
 >> http://lse.sourceforge.net/epoll/index.html
 >
> how does this compare to the kqueue mechanism found in {Free,Net}BSD?
> (see http://people.freebsd.org/~jlemon/papers/kqueue.pdf)
> 
> i especially like their combined event update/event wait,
> needing only one syscall per poll while building a changelist in
> userspace...
> 
> a replacement for poll/select is _really_ needed.
> but i think we should use existing interfaces if possible,
> to reduce the changes needed in userspace.

I'd kinda like to see a unified event queue object
used uniformly for everything.  You might instantiate
several of them in one process (so e.g. libraries could have
their own).

The idea of using the kqueue interface was discussed once before.  See
http://marc.theaimsgroup.com/?l=linux-kernel&m=97236943118139&w=2
for Linus' opinion of kqueues (he doesn't like them much).

Another existing event queue for readiness notification to
be delivered via is Ben's AIO completion notification queue,
but I haven't heard a definitive story about whether
epoll events could be delivered that way.  (The discussion
seems to always veer into a discussion of asynchronous
poll, which is something else.)
- Dan


