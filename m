Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136069AbREHD0p>; Mon, 7 May 2001 23:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREHD0m>; Mon, 7 May 2001 23:26:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34575 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136069AbREHD0M>; Mon, 7 May 2001 23:26:12 -0400
Date: Mon, 7 May 2001 22:47:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.25990.868966.309506@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105072240581.7685-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, David S. Miller wrote:

> 
> Marcelo Tosatti writes:
>  > I just thought about this case:
>  >   
>  > We find a dead swap cache page, so dead_swap_page goes to 1.
>  > 
>  > We call swap_writepage(), but in the meantime the swapin readahead code   
>  > got a reference on the swap map for the page.
>  > 
>  > We write the page out because "(swap_count(page) > 1)", and we may
>  > not have __GFP_IO set in the gfp_mask. Boom.
> 
> Hmmm, can't this happen without my patch?

No. We will never call writepage() without __GFP_IO without your patch.

> Nothing stops people from getting references to the page
> between the "Page is or was in use?" test and the line
> which does "TryLockPage(page)".

I don't see any problem with people getting a reference to the page there.


