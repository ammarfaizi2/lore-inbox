Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135276AbREHDNd>; Mon, 7 May 2001 23:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135580AbREHDNY>; Mon, 7 May 2001 23:13:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62734 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135276AbREHDNN>; Mon, 7 May 2001 23:13:13 -0400
Date: Mon, 7 May 2001 22:34:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.24153.737361.998494@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105072231470.7685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, David S. Miller wrote:

> 
> Linus Torvalds writes:
>  > YOUR HEURISTIC IS WRONG!
> 
> Please start the conversation this way next time.
> 
>  > I call that a bug. You don't. Fine.
> 
> You made it sound like a data corrupter, a kernel crasher, and that
> any bug against a kernel with that patch indicates my patch caused it.
> There is an important distinction between "this is doing something
> silly" and "this will scramble your disk and crash the kernel".
> 
> The latter is the conclusion several people came to.
> 
> And I wanted a clarification on this, nothing more.
> 
> I wanted this clarification from you _BECAUSE_ the original posting in
> this thread saw data corruption which went away after reverting my
> patch.  But there is no possible connection between my patch and the
> crashes he saw.

Ugh, there is.

I just thought about this case:
  
We find a dead swap cache page, so dead_swap_page goes to 1.

We call swap_writepage(), but in the meantime the swapin readahead code   
got a reference on the swap map for the page.

We write the page out because "(swap_count(page) > 1)", and we may
not have __GFP_IO set in the gfp_mask. Boom.



