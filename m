Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283546AbRK3Hpd>; Fri, 30 Nov 2001 02:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283544AbRK3HpY>; Fri, 30 Nov 2001 02:45:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34066 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283546AbRK3HpU>;
	Fri, 30 Nov 2001 02:45:20 -0500
Date: Fri, 30 Nov 2001 08:44:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.1.4: fix rd.c build
Message-ID: <20011130084456.J16796@suse.de>
In-Reply-To: <20011130082855.E16796@suse.de> <Pine.GSO.4.21.0111300229570.13367-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111300229570.13367-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Alexander Viro wrote:
> 
> 
> On Fri, 30 Nov 2001, Jens Axboe wrote:
> 
> > On Fri, Nov 30 2001, Alexander Viro wrote:
> > > 
> > > 
> > > On Fri, 30 Nov 2001, Jens Axboe wrote:
> > > 
> > > > Actually, this is not even enough if rd receives a multi page bio.
> > > > Something like this should work, untested.
> > > > 
> > > > @@ -237,9 +238,9 @@
> > > >  	err = -EIO;
> > > 
> > > Make it err = 0...
> > 
> > Explain
> 
> Think what happens if you have all these pages in page cache.  Already.
> Returning -EIO is hardly a good idea in that case.  Look through the
> loop - we assign err in the body only if we have to allocate a new
> page.

Ah ok.

> -static int rd_blkdev_pagecache_IO(int rw, struct buffer_head * sbh, int minor)
> +static int rd_blkdev_pagecache_IO(int rw, struct bio *sbh, int minor)
>  {
>         struct address_space * mapping;
>         unsigned long index;
>         int offset, size, err;
>  
>         err = -EIO;
> -       err = 0;
>         mapping = rd_bdev[minor]->bd_inode->i_mapping;
> 
> Sure, one of these assignments had to go away.  You'd picked the wrong one,
> though...

Duh, merge error, don't even remembering making that change. Ok

kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre4/bio-pre4-2

should be ok.

-- 
Jens Axboe

