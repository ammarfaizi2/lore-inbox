Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286319AbRLTS3t>; Thu, 20 Dec 2001 13:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286318AbRLTS3a>; Thu, 20 Dec 2001 13:29:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286317AbRLTS32>; Thu, 20 Dec 2001 13:29:28 -0500
Date: Thu, 20 Dec 2001 10:27:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Gergely Nagy <algernon@debian.org>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.17rc2aa1
In-Reply-To: <20011220192255.B1477@athlon.random>
Message-ID: <Pine.LNX.4.33.0112201026460.1101-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Dec 2001, Andrea Arcangeli wrote:
> Anyways here the fix (untested as usual :)
>
> --- 2.4.17rc2aa1/fs/buffer.c.~1~	Wed Dec 19 03:43:24 2001
> +++ 2.4.17rc2aa1/fs/buffer.c	Thu Dec 20 19:02:02 2001
> @@ -2337,7 +2337,7 @@
>  	struct buffer_head *bh;
>
>  	page = find_or_create_page(bdev->bd_inode->i_mapping, index, GFP_NOFS);
> -	if (IS_ERR(page))
> +	if (!page)

Isn't this in 2.4.17 already? Marcelo, please check.

> +++ 2.4.17rc2aa1/mm/filemap.c	Thu Dec 20 19:01:53 2001
> @@ -942,7 +942,7 @@
>  	spin_unlock(&pagecache_lock);
>  	if (!page) {
>  		struct page *newpage = alloc_page(gfp_mask);
> -		page = ERR_PTR(-ENOMEM);
> +		page = NULL;

Don't be silly, just remove the line (page _is_ NULL already, we just
checked).

		Linus

