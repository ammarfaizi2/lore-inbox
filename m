Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289309AbSA1SWv>; Mon, 28 Jan 2002 13:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289311AbSA1SWm>; Mon, 28 Jan 2002 13:22:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289309AbSA1SW1>; Mon, 28 Jan 2002 13:22:27 -0500
Date: Mon, 28 Jan 2002 10:21:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33L.0201281558100.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Rik van Riel wrote:
>
> I'd be interested to know exactly how much overhead -rmap is
> causing for both page faults and fork   (but I'm sure one of
> the regular benchmarkers can figure that one out while I fix
> the RSS limit stuff ;))

I doubt it is noticeable on page faults (the cost of maintaining the list
at COW should be basically zero compared to all the other costs), but I've
seen several people reporting fork() overheads of ~300% or so.

Which is not that surprising, considering that most of the fork overhead
by _far_ is the work to copy the page tables, and rmap makes them three
times larger or so.

And I agree that COW'ing the page tables may not actually help. But it
might be worth it even _without_ rmap, so it's worth a look.

(Also, I'd like to understand why some people report so much better times
on dbench, and some people reports so much _worse_ times with dbench.
Admittedly dbench is a horrible benchmark, but still.. Is it just the
elevator breakage, or is it rmap itself?)

			Linus

