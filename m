Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbQLVDCO>; Thu, 21 Dec 2000 22:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbQLVDCF>; Thu, 21 Dec 2000 22:02:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41228 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131402AbQLVDB6>; Thu, 21 Dec 2000 22:01:58 -0500
Date: Thu, 21 Dec 2000 22:38:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <200012220220.eBM2Kpj19962@webber.adilger.net>
Message-ID: <Pine.LNX.4.21.0012212229190.2603-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Dec 2000, Andreas Dilger wrote:

> Marcelo Tosatti writes:
> > It seems your code has a problem with bh flush time.
> > 
> > In flush_dirty_buffers(), a buffer may (if being called from kupdate) only
> > be written in case its old enough. (bh->b_flushtime)
> > 
> > If the flush happens for an anonymous buffer, you'll end up writing all
> > buffers which are sitting on the same page (with block_write_anon_page),
> > but these other buffers are not necessarily old enough to be flushed.
> 
> This isn't really a "problem" however.  The page is the _maximum_ age of
> the buffer before it needs to be written.  If we can efficiently write it
> out with another buffer 


> (essentially for free if they are on the same spot on disk)

Are you sure this is true for buffer pages in most cases? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
