Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286323AbRLTSdT>; Thu, 20 Dec 2001 13:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286320AbRLTSdA>; Thu, 20 Dec 2001 13:33:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286318AbRLTScw>; Thu, 20 Dec 2001 13:32:52 -0500
Date: Thu, 20 Dec 2001 19:32:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gergely Nagy <algernon@debian.org>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.17rc2aa1
Message-ID: <20011220193258.D1477@athlon.random>
In-Reply-To: <20011220192255.B1477@athlon.random> <Pine.LNX.4.33.0112201026460.1101-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0112201026460.1101-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 20, 2001 at 10:27:37AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 10:27:37AM -0800, Linus Torvalds wrote:
> 
> On Thu, 20 Dec 2001, Andrea Arcangeli wrote:
> > Anyways here the fix (untested as usual :)
> >
> > --- 2.4.17rc2aa1/fs/buffer.c.~1~	Wed Dec 19 03:43:24 2001
> > +++ 2.4.17rc2aa1/fs/buffer.c	Thu Dec 20 19:02:02 2001
> > @@ -2337,7 +2337,7 @@
> >  	struct buffer_head *bh;
> >
> >  	page = find_or_create_page(bdev->bd_inode->i_mapping, index, GFP_NOFS);
> > -	if (IS_ERR(page))
> > +	if (!page)
> 
> Isn't this in 2.4.17 already? Marcelo, please check.

it isn't in 2.4.17-rc2.

> 
> > +++ 2.4.17rc2aa1/mm/filemap.c	Thu Dec 20 19:01:53 2001
> > @@ -942,7 +942,7 @@
> >  	spin_unlock(&pagecache_lock);
> >  	if (!page) {
> >  		struct page *newpage = alloc_page(gfp_mask);
> > -		page = ERR_PTR(-ENOMEM);
> > +		page = NULL;
> 
> Don't be silly, just remove the line (page _is_ NULL already, we just
> checked).

indeed (compiler could optimize it away but nicer code to delete it).

Andrea
