Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129931AbRASAAu>; Thu, 18 Jan 2001 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbRASAAl>; Thu, 18 Jan 2001 19:00:41 -0500
Received: from [129.94.172.186] ([129.94.172.186]:44797 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129931AbRASAAY>; Thu, 18 Jan 2001 19:00:24 -0500
Date: Thu, 18 Jan 2001 22:48:26 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <945ghp$att$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0101182245510.3368-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2001, Linus Torvalds wrote:
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >On Wed, 10 Jan 2001, Linus Torvalds wrote:
> >
> >> I looked at it a year or two ago myself, and came to the
> >> conclusion that I don't want to blow up our page table size by a
> >> factor of three or more, so I'm not personally interested any
> >> more. Maybe somebody else comes up with a better way to do it,
> >> or with a really compelling reason to.
> >
> >OTOH, it _would_ get rid of all the balancing issues in one
> >blow. And it would fix the aliasing issues and possibly the
> >memory fragmentation problem too.
>
> I totally disagree.

I still haven't seen anything that might get us a
"universally correct" balancing between swap_out()
and refill_inactive_scan().

We either scan both categories at the same relative
rate, which gives mapped pages an advantage because
they may get unmapped later than the unmapped pages
get deactivated.

Alternatively, you do the scanning between these two
at different rates, which gives an advantage to one
or the other.

(or am I overlooking something stupid here?)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
