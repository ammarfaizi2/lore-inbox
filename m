Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262551AbSI0RZ7>; Fri, 27 Sep 2002 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262540AbSI0RZ7>; Fri, 27 Sep 2002 13:25:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15375 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262552AbSI0RZd>; Fri, 27 Sep 2002 13:25:33 -0400
Date: Fri, 27 Sep 2002 10:32:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271921481.15791-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209271029290.14685-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Ingo Molnar wrote:
> 
> the problem is that we want to catch all COW events of the virtual
> address, *and* we want to have a correct (physpage,offset) futex hash.

So?

	spin_lock(&futex_lock);

>         q.page = NULL;
>         attach_vcache(&q.vcache, uaddr, current->mm, futex_vcache_callback);
> 
>         page = pin_page(uaddr - offset);
>         ret = IS_ERR(page);
>         if (ret)
>                 goto out;
>         head = hash_futex(page, offset);
>         set_current_state(TASK_INTERRUPTIBLE);
>         init_waitqueue_head(&q.waiters);
>         add_wait_queue(&q.waiters, &wait);
>         queue_me(head, &q, page, offset, -1, NULL, uaddr);

	spin_unlock(&futex_lock);

And get the futex_lock in the callback.

		Linus

