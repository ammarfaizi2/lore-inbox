Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRDWW1Q>; Mon, 23 Apr 2001 18:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRDWW0K>; Mon, 23 Apr 2001 18:26:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39941 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132413AbRDWWYN>; Mon, 23 Apr 2001 18:24:13 -0400
Date: Mon, 23 Apr 2001 15:23:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
cc: <linux-kernel@vger.kernel.org>, <dhowells@redhat.com>, <andrea@suse.de>,
        <davem@redhat.com>
Subject: Re: [PATCH] rw_semaphores, optimisations try #3
In-Reply-To: <01042321353400.00801@orion.ddi.co.uk>
Message-ID: <Pine.LNX.4.31.0104231519120.13672-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, D.W.Howells wrote:
>
> Linus, you suggested that the generic list handling stuff would be faster (2
> unconditional stores) than mine (1 unconditional store and 1 conditional
> store and branch to jump round it). You are both right and wrong. The generic
> code does two stores per _process_ woken up (list_del) mine does the 1 or 2
> stores per _batch_ of processes woken up. So the generic way is better when
> the queue is an even mixture of readers or writers and my way is better when
> there are far greater numbers of waiting readers. However, that said, there
> is not much in it either way, so I've reverted it to the generic list stuff.

Note that the generic list structure already has support for "batching".
It only does it for multiple adds right now (see the "list_splice"
merging code), but there is nothing to stop people from doing it for
multiple deletions too. The code is something like

	static inline void list_remove_between(x,y)
	{
		n->next = y;
		y->prev = x;
	}

and notice how it's still just two unconditional stores for _any_ number
of deleted entries.

Anyway, I've already applied your #2, how about a patch relative to that?

		Linus

