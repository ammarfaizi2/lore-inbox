Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135901AbREIIn6>; Wed, 9 May 2001 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135906AbREIInt>; Wed, 9 May 2001 04:43:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25612 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S135901AbREIInn>; Wed, 9 May 2001 04:43:43 -0400
Message-ID: <3AF90324.EB4EA970@evision-ventures.com>
Date: Wed, 09 May 2001 10:43:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: page_launder() bug
In-Reply-To: <m14xJmW-001QgaC@mozart>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <15094.10942.592911.70443@pizda.ninka.net> you write:
> >
> > Jonathan Morton writes:
> >  > >-                  page_count(page) == (1 + !!page->buffers));
> >  >
> >  > Two inversions in a row?
> >
> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
> 
> Overall, I'd have to say that this:
> 
> -               dead_swap_page =
> -                       (PageSwapCache(page) &&
> -                        page_count(page) == (1 + !!page->buffers));
> -
> 
> Is nicer as:
> 
>                 int dead_swap_page = 0;
> 
>                 if (PageSwapCache(page)
>                     && page_count(page) == (page->buffers ? 1 : 2))
>                         dead_swap_page = 1;
> 
> After all, the second is what the code *means* (1 and 2 are magic
> numbers).
> 
> That said, anyone who doesn't understand the former should probably
> get some more C experience before commenting on others' code...

Basically Amen.

But there are may be better chances that the compiler does do
better job at branch prediction in the second case? 
Wenn anyway objdump -S should show it...
