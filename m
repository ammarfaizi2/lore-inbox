Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSKUBCU>; Wed, 20 Nov 2002 20:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbSKUBCU>; Wed, 20 Nov 2002 20:02:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:64644 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266250AbSKUBBb>; Wed, 20 Nov 2002 20:01:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 17:09:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [rfc] new poll callback'd wake up hell ...
In-Reply-To: <20021121002046.GD32715@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0211201707370.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Mark Mielke wrote:

> > 2) Use this infrastructure to perform safe poll wakeups
> > ...
> > static void ep_poll_safe_wakeup(struct poll_safewake *psw, wait_queue_head_t *wq)
> > {
> >         atomic_inc(&psw->count);
> >         do {
> >                 if (!xchg(&psw->wakedoor, 0))
> >                         break;
> >                 wake_up(wq);
> >                 xchg(&psw->wakedoor, 1);
> >         } while (!atomic_dec_and_test(&psw->count));
> > }
> > Does anyone foresee problem in this implementation ?
> > Another ( crappy ) solution might be to avoid the epoll fd to drop inside
> > its poll wait queue head, wait queues that has the function pointer != NULL
>
> Clever. (I think the second xchg() can just be atomic_set()) Without actually
> playing with it, it looks good to me.
>
> If the problem is too hard to solve - it isn't that bad if one can't
> epoll recursively. If the functionality was added later, it is
> doubtful that the API itself would need to change.

This should cover the wake_up() cycle case IMHO. We should be able to
stock epoll fds inside epoll fd. In theory ... :)




- Davide


