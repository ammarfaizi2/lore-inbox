Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTKQVNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKQVNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:13:33 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:26550 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261950AbTKQVNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:13:17 -0500
Date: Mon, 17 Nov 2003 21:13:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-ID: <20031117211304.GA20118@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <20031117064832.GA16597@mail.shareable.org> <Pine.GSO.4.58.0311171236420.29330@Juliusz> <20031117153323.GA18523@mail.shareable.org> <3FB91F22.6090805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB91F22.6090805@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> IMO, for 2.6 FUTEX_FD should be removed or disabled.  It doesn't work
> reliably.

It is useful for some things, but it isn't a suitable async
replacement for FUTEX_WAIT.  My way of judging it is to observe that
you can't build userspace scheduled FUTEX_WAIT-like interface out of
FUTEX_FD, so FUTEX_FD is flawed.

> As for later, and which extensions to add, Ingo and I discussed this
> quite a bit already.  One of the problems is that once you extend the
> basic set of operations the possible way are very numerous and the
> interfaces can explode in number.

I don't see an explosion, unless you mean several orthogonal bits in
the op word.  A lot can be built on top of FUTEX_WAIT+FUTEX_WAKE; the
explosion of more complex operators is mostly up to userspace.

One thing I thought might be useful is to another argument to
FUTEX_WAKE which is returned to the woken waiter.

> I am not sure that this list is the adequate forum for discussing the
> futex extensions.  If somebody says where it should take place and
> somebody actually declares willingness to work on the implementation
> side, I can write down my thoughts and post it.

So far, this or phil-list are the only place I've seen any futex
discussion.  I'm willing to work on implementation if you have
thoughts to share; I did the most recent batch of futex changes, after
all.  (Btw, do you have any benchmark results for the current code?)

Feel free to share your thoughts privately if you don't want to share
with the list just yet; although I think it is good to let whoever may
be interested see the discussion, it is up to you.

-- Jamie
