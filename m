Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136049AbREHDZY>; Mon, 7 May 2001 23:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136069AbREHDZO>; Mon, 7 May 2001 23:25:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136049AbREHDY5>; Mon, 7 May 2001 23:24:57 -0400
Date: Mon, 7 May 2001 20:24:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.25990.868966.309506@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105072023180.8237-100000@penguin.transmeta.com>
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

Yes. That looks a lot easier to trigger than my "slow memory
leak" schenario.

> Hmmm, can't this happen without my patch?

No. The old code would never try to write anything if __GFP_IO wasn't set,
because "launder_loop" would never become non-zero.

			Linus

