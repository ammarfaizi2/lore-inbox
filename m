Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133000AbRANS47>; Sun, 14 Jan 2001 13:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133092AbRANS4t>; Sun, 14 Jan 2001 13:56:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34569 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133000AbRANS4l>; Sun, 14 Jan 2001 13:56:41 -0500
Date: Sun, 14 Jan 2001 10:56:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: set_page_dirty/page_launder deadlock
In-Reply-To: <14945.43345.483744.954137@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10101141054530.4086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, David S. Miller wrote:
> 
> Marcelo Tosatti writes:
>  > 
>  > While taking a look at page_launder()...
> 
>  ...
> 
>  > set_page_dirty() may lock the pagecache_lock which means potential
>  > deadlock since we have the pagemap_lru_lock locked.
> 
> Indeed, the following should work as a fix:

Well, as the new shm code doesn't return 1 any more, the whole locked page
handling should just be deleted. ramfs always just re-marked the page
dirty in its own "writepage()" function, so it was only shmfs that ever
returned this special case, and because of other issues it already got
excised by Christoph..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
