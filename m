Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287319AbSAGWkN>; Mon, 7 Jan 2002 17:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287320AbSAGWkD>; Mon, 7 Jan 2002 17:40:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287319AbSAGWjz>; Mon, 7 Jan 2002 17:39:55 -0500
Date: Mon, 7 Jan 2002 14:38:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <Pine.LNX.4.33.0201072144110.8813-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.33.0201071412110.1064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Matthew Kirkwood wrote:
> >
> > Yes, I was going to just attach to the vma,
>
> Wouldn't that have to be an address_space, so separate maps
> of the same object will use the same count?  Or (not unlikely)
> am I misunderstanding the way these structures are laid out?

I would just mke the creator be special. The guy who creates the semaphore
owns it, and if he unmaps it, it's gone.

Note that there are other, potentially cleaner solutions. In particular,
some people like the "semaphore as file descriptor" approach, and I have
to say that I think they may be right. Then you just pass the file
descriptor along as the cookie, and you can do dup()/close() etc on it.

Mind trying that approach instead? It's not all that far off from your
current setup, and it would certainly have none of the security
implications..

		Linus

