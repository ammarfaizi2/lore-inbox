Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRENXoH>; Mon, 14 May 2001 19:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbRENXn5>; Mon, 14 May 2001 19:43:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19465 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262584AbRENXnr>; Mon, 14 May 2001 19:43:47 -0400
Date: Mon, 14 May 2001 19:05:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131225300.20452-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105141904250.32493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 May 2001, Linus Torvalds wrote:

> 
> On Sun, 13 May 2001, Rik van Riel wrote:
> > 
> > This means that the swapin path (and the same path for
> > other pagecache pages) doesn't take the page lock and
> > the page lock doesn't protect us from other people using
> > the page while we have it locked.
> 
> You can test for swap cache deadness without holding the page cache lock:
> if the swap count is 1, then we know that nobody else has this swap entry
> in its page tables, and thus there can not be any concurrent lookups
> either.
> 
> Now, it may well be that we need to make sure that there is some proper
> ordering (nobody must decrement the swap count before they increment the
> page count or something). I think that is the case anyway (and I _think_
> that everybody that mucks with the swap count always hold the page count -
> this might be a good thing to check).

Swapin readahead _first_ increases the swap map count for the given page
and then increases the page count.


