Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTJETSv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTJETSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:18:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61576 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263763AbTJETSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:18:50 -0400
Date: Sun, 5 Oct 2003 20:18:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       pwaechtler@mac.com, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
Message-ID: <20031005191821.GA27345@mail.shareable.org>
References: <Pine.GSO.4.58.0310051047560.12323@ultra60> <3F80484A.3030105@redhat.com> <20031005181630.GA26958@mail.shareable.org> <20031005143239.T26086@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005143239.T26086@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> > Speaking of librt - I should not have to link in pthreads and the
> > run-time overhead associated with it (locking stdio etc.) just so I
> > can use shm_open().  Any chance of fixing this?
> 
> That overhead is mostly gone in current glibcs (when using NPTL):
> a) e.g. locking is done unconditionally even when libpthread is not present
>    (it is just lock cmpxchgl, inlined)
> b) things like cancellation aware syscall wrappers for cancellable syscalls
>    and various other things are only done after first pthread_create has
>    been called, it doesn't matter whether libpthread is loaded or not

That's good.  I still don't like linking in pthreads when I'm not
using threads or any thread-using services, so I'll continue to use a
non-libc version of shm_open() in my own programs, particularly the
ones which use clone() directly.

Why isn't shm_open() simply part of libc?

-- Jamie
