Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSJ1WVS>; Mon, 28 Oct 2002 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJ1WVS>; Mon, 28 Oct 2002 17:21:18 -0500
Received: from dp.samba.org ([66.70.73.150]:51113 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261560AbSJ1WVQ>;
	Mon, 28 Oct 2002 17:21:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@gamebox.net
Cc: Hugh Dickins <hugh@veritas.com>, Mingming Cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Tue, 29 Oct 2002 01:30:59 +0530."
             <20021029013059.A13287@dikhow> 
Date: Tue, 29 Oct 2002 08:41:19 +1100
Message-Id: <20021028222738.3316B2C4D9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021029013059.A13287@dikhow> you write:
> Hi Rusty,
> 
> I am pathologically late in catching up lkml, so if I missed some
> context here, I apologize in advance. I have just started looking
> at mm6 ipc code and I want to point out a few things.

That's OK, I'm still 1500 behind 8(

	If all current uses are embedded, can we remove the "void
*arg" and reduce the size of struct rcu_head by 25%?  Users can always
embed it in their own struct which has a "void *arg", but if that's
the uncommon case, it'd be nice to slim it a little.

	It'd also be nice to change the double linked list to a single
too: as far as I can tell the only issue is the list_add_tail in
call_rcu(): how important is this ordering?  It can be done by keeping
a head as well as a tail pointer if required.

I'd be happy to prepare a patch, to avoid more complaints of bloat 8)

> That said, it seems that Ming/Hugh's patch does allocate
> the rcu_head at the time of *growing* the array. It is just
> that they allocate it for the freeing array rather than the
> allocated array. I don't see how this is semantically different
> from clubbing the two allocations other than the fact that
> smaller number of allocation calls would likely reduce the
> likelyhood of allocation failures.

We must be looking at different variants of the patch.  This one does:
IPC_RMID -> freeary() -> ipc_rcu_free -> kmalloc.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
