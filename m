Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUIQNmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUIQNmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268757AbUIQNmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:42:09 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:41955 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268756AbUIQNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:41:56 -0400
Date: Fri, 17 Sep 2004 15:41:45 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stelian Pop <stelian@popies.net>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917134145.GT15426@dualathlon.random>
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr> <20040917131523.GQ15426@dualathlon.random> <20040917133656.GF3089@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917133656.GF3089@crusoe.alcove-fr>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:36:58PM +0200, Stelian Pop wrote:
> What about leaving kfifo_alloc as is (using kmalloc) and adding
> 	struct kfifo *kfifo_init(unsigned char *buffer, spinlock_t *lock);
> 	
> which let's you specify the buffer and the spinlock you want to use.
> Of course, one should not call kfifo_free() on such a struct kfifo...

I guess you need to pass down the size of the buffer too.

> 
> As a special case, the spinlock can be NULL and in this case it 
> allocates it. But in this case we should also make a kfifo_delete()
> to deallocate the lock...

that's fine with me, but allocating a lock dynamically? then probably
you should force the caller to allocate it, and force it to pass it down
either in the alloc or in the init function, the caller is going to have
a bigger data structure where it will embed the kfifo structure, so it'd
be normally zerocost for the caller to allocate a lock outside the
kfifo, even if the API becomes a bit uglier, but I don't see the need of
separate slab allocation for a single spinlock. 

> that just protecting the fifo. Unfortunately we cannot hide the
> internal spinlock from the users, this is just C.

indeed ;) (should be in theory a private field)

thanks.
