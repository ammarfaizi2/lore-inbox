Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSJ3UVQ>; Wed, 30 Oct 2002 15:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSJ3UVQ>; Wed, 30 Oct 2002 15:21:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:45971 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264875AbSJ3UVN>; Wed, 30 Oct 2002 15:21:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 12:37:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Janet Morgan <janetmor@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <200210302014.g9UKEr204332@eng4.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0210301228430.1446-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Janet Morgan wrote:

> > Thanks to Andrew and John suggestions I coded another version of the
> > sys_epoll patch ( 0.13 skipped ... superstition :) ). I won't send the
> > patch to not waste bandwidth, the patch is available here :
> >
> > http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff
> >
> > Comments are welcome ...
>
>
> The previous and current versions of the sys_epoll patch are performing
> comparably and continue to far exceed the results from standard poll.
> Hopefully this is another endorsement for it's inclusion in the 2.5 kernel.
>
> We re-ran the SMP tests that were used to collect the sys_epoll performance
> data recently posted at http://lse.sourceforge.net/epoll/.  Detailed data
> follows for those who want a closer look, or check out the website for
> more information.

Thank you very much Janet for doing performance and stability test.
Working with Andrew we agreed to remove the main hash table since, by
using in full the fcblist.c capabilities, it is not needed any more. Hash
allocation was a big Andrew concern because of its dimension and because
it was allocated with vmalloc() that might fail when fragmentation
increase. The new patch will have a reviewed locking behavior and will
introduce a slab allocator inside fs/fcblist.c. My plan is to release 0.16
today so that you guys can run regression test on it. To test the locking
"goodness" it should be run on an SMP system, with multiple copies of
ephttpd running on different ports, each one stressed either by httperf
or the sys_epoll HTTP blaster. Also, building an threaded application that
makes "bad use" of the interface might help in checking the API robustness
against every condition. Also, the usual performance test should be run to
check if we loose something along the path ...




- Davide


