Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTIHSwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTIHSwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:52:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:62373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263486AbTIHSwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:52:31 -0400
Date: Mon, 8 Sep 2003 11:52:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make futex waiters take an mm or inode reference
In-Reply-To: <20030908183416.GF27097@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309081144390.3202-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Jamie Lokier wrote:
> 
> This patch makes each futex waiter hold a reference to the mm or inode
> that a futex is keyed on.

I get the inode part, but let's think about the mm part a bit more.

In particular, passing off a futex that points to private memory to
somebody else just _doesn't_work_. It's insane. So I'd suggest saying that
an anonymous futex is only an <address,offset> pair, and drop the "mm"  
entirely. Let's make an anonymous futex _really_ anonymous, and document
that it's only an "address" - passing it off via UNIX domain sockets is
fine, it just doesn't do anything useful.

So is there any reason to really having "private.mm" AT ALL? From what I
can tell, it is not actually ever used (all "mm" users are "current->mm"),
so I don't see the point of incrementing a count for it either.

Or did I miss something?

			Linus

