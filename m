Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbREIC3A>; Tue, 8 May 2001 22:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbREIC2k>; Tue, 8 May 2001 22:28:40 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:27853 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S132580AbREIC20>; Tue, 8 May 2001 22:28:26 -0400
Message-Id: <m14xJmW-001QgaC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: page_launder() bug 
In-Reply-To: Your message of "Sun, 06 May 2001 21:55:26 MST."
             <15094.10942.592911.70443@pizda.ninka.net> 
Date: Wed, 09 May 2001 12:32:51 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15094.10942.592911.70443@pizda.ninka.net> you write:
> 
> Jonathan Morton writes:
>  > >-			 page_count(page) == (1 + !!page->buffers));
>  > 
>  > Two inversions in a row?
> 
> It is the most straightforward way to make a '1' or '0'
> integer from the NULL state of a pointer.

Overall, I'd have to say that this:

-		dead_swap_page =
-			(PageSwapCache(page) &&
-			 page_count(page) == (1 + !!page->buffers));
-

Is nicer as:

		int dead_swap_page = 0;

		if (PageSwapCache(page)
		    && page_count(page) == (page->buffers ? 1 : 2))
			dead_swap_page = 1;

After all, the second is what the code *means* (1 and 2 are magic
numbers).

That said, anyone who doesn't understand the former should probably
get some more C experience before commenting on others' code...

Rusty.
--
Premature optmztion is rt of all evl. --DK
