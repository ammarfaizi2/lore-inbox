Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQL1AMZ>; Wed, 27 Dec 2000 19:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQL1AMO>; Wed, 27 Dec 2000 19:12:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129267AbQL1AMA>; Wed, 27 Dec 2000 19:12:00 -0500
Date: Wed, 27 Dec 2000 15:41:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Dan Aloni <karrde@callisto.yi.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012271537260.10485-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2000, Rik van Riel wrote:
> 
> The (trivial) patch below should fix this problem.

It must be wrong.

If we have a dirty page on the LRU lists, that page _must_ have a mapping.

What semantics would you say a non-mapped page has? What are the LRU
routines supposed to do with such a page? 

The bug is somewhere else, and your patch is just papering it over. We
should not have a page without a mapping on the LRU lists in the first
place, except if the page has anonymous buffers (and such a page cannot
legally be dirty as things are in the standard kernel - Chris Mason has
been working on stuff that would make that a normal thing, but it would
also make the page have a mapping).

We'd better add a debug check that makes sure that we don't have
non-mapped non-buffer pages on the LRU lists, and figure out how such a
thing could happen.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
