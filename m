Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbREMQJu>; Sun, 13 May 2001 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbREMQJk>; Sun, 13 May 2001 12:09:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49422 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261289AbREMQJ3>;
	Sun, 13 May 2001 12:09:29 -0400
Date: Sun, 13 May 2001 13:08:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071921110.8237-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105131306020.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Linus Torvalds wrote:

> Which you MUST NOT do without holding the page lock.
> 
> Hint: it needs "page->index", and without holding the page lock you
> don't know what it could be.

Wouldn't that be the pagecache_lock ?

Remember that the semantics for find_swap_page() and
friends got changed recently to first test PageUptodate
and only try to lock the page if that didn't work out.

This means that the swapin path (and the same path for
other pagecache pages) doesn't take the page lock and
the page lock doesn't protect us from other people using
the page while we have it locked.

What _does_ protect us, however, is the fact that
reclaim_page() grabs the pagecache_lock...

[OTOH, I could be out to lunch here since I was away for
almost a week and haven't checked if the discussed changes
really were integrated into the kernel]

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

