Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266071AbUGJBHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUGJBHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUGJBHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:07:51 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:39859 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266071AbUGJBHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:07:49 -0400
Date: Sat, 10 Jul 2004 03:07:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040710010738.GX20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org> <20040709044205.GF20947@dualathlon.random> <20040708215645.16d0f227.akpm@osdl.org> <20040710001600.GT20947@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710001600.GT20947@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 02:16:00AM +0200, Andrea Arcangeli wrote:
> I hope this time I'm done with it.

I'm not after more thinking it seems the below is not a bug.

I'm lost since I can't find bugs anymore in this function but I need to
find something.

> 
> --- sles/fs/mpage.c.~1~	2004-07-09 23:48:33.233205496 +0200
> +++ sles/fs/mpage.c	2004-07-10 02:11:59.922789800 +0200
> @@ -460,7 +460,7 @@ mpage_writepage(struct bio *bio, struct 
>  	 */
>  	BUG_ON(!PageUptodate(page));
>  	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
> -	last_block = (i_size_read(inode) - 1) >> blkbits;
> +	last_block = (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits;
>  	map_bh.b_page = page;
>  	for (page_block = 0; page_block < blocks_per_page; ) {
>  
