Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSESWtk>; Sun, 19 May 2002 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSESWtj>; Sun, 19 May 2002 18:49:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53254 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315476AbSESWti>;
	Sun, 19 May 2002 18:49:38 -0400
Message-ID: <3CE82CDD.21A125DA@zip.com.au>
Date: Sun, 19 May 2002 15:53:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/15] larger b_size, and misc fixlets
In-Reply-To: <3CE7FF89.16AF9B93@zip.com.au> <20020519221532.GE26598@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On May 19, 2002  12:39 -0700, Andrew Morton wrote:
> > - make the printk in buffer_io_error() sector_t-aware.
> > =====================================
> > --- 2.5.16/fs/buffer.c~sector_t-printing      Sun May 19 11:49:47 2002
> > +++ 2.5.16-akpm/fs/buffer.c   Sun May 19 12:02:57 2002
> > @@ -179,8 +179,8 @@ __clear_page_buffers(struct page *page)
> >
> >  static void buffer_io_error(struct buffer_head *bh)
> >  {
> > -     printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
> > -                     bdevname(bh->b_bdev), bh->b_blocknr);
> > +     printk(KERN_ERR "Buffer I/O error on device %s, logical block %Ld\n",
> > +                     bdevname(bh->b_bdev), (u64)bh->b_blocknr);
> >  }
> 
> Not that I'm a 64-bit system user/developer, but it is my understanding
> that u64 == long on a 64-bit platform, so your cast to u64 does not
> actually change the type of b_blocknr as far as printk is concerned.
> You would need to cast it to unsigned long long instead.
> 

Yes, I suppose so.  That more closely matches what "%L" does.

-
