Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135683AbRDXPle>; Tue, 24 Apr 2001 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbRDXPlY>; Tue, 24 Apr 2001 11:41:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:31248 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135680AbRDXPlL>; Tue, 24 Apr 2001 11:41:11 -0400
Date: Tue, 24 Apr 2001 08:40:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rw_semaphores, optimisations try #3 
In-Reply-To: <6182.988106720@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.21.0104240838040.15642-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Apr 2001, David Howells wrote:
> 
> Yes but the "struct rwsem_waiter" batch would have to be entirely deleted from
> the list before any of them are woken, otherwise the waking processes may
> destroy their "rwsem_waiter" blocks before they are dequeued (this destruction
> is not guarded by a spinlock).

Look again.

Yes, they may destroy the list, but nobody cares.

Why?

 - nobody will look up the list because we do have the spinlock at this
   point, so a destroyed list doesn't actually _matter_ to anybody

   You were actually depending on this earlier, although maybe not on
   purpose.

 - list_remove_between() doesn't care about the integrity of the entries
   it destroys. It only uses, and only changes, the entries that are still
   on the list.

Subtlety is fine. It might warrant a comment, though.

		Linus

