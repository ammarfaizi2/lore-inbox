Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSESWRM>; Sun, 19 May 2002 18:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSESWRM>; Sun, 19 May 2002 18:17:12 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:35316 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315278AbSESWRL>; Sun, 19 May 2002 18:17:11 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 19 May 2002 16:15:32 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/15] larger b_size, and misc fixlets
Message-ID: <20020519221532.GE26598@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CE7FF89.16AF9B93@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 19, 2002  12:39 -0700, Andrew Morton wrote:
> - make the printk in buffer_io_error() sector_t-aware.
> =====================================
> --- 2.5.16/fs/buffer.c~sector_t-printing	Sun May 19 11:49:47 2002
> +++ 2.5.16-akpm/fs/buffer.c	Sun May 19 12:02:57 2002
> @@ -179,8 +179,8 @@ __clear_page_buffers(struct page *page)
>  
>  static void buffer_io_error(struct buffer_head *bh)
>  {
> -	printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
> -			bdevname(bh->b_bdev), bh->b_blocknr);
> +	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Ld\n",
> +			bdevname(bh->b_bdev), (u64)bh->b_blocknr);
>  }

Not that I'm a 64-bit system user/developer, but it is my understanding
that u64 == long on a 64-bit platform, so your cast to u64 does not
actually change the type of b_blocknr as far as printk is concerned.
You would need to cast it to unsigned long long instead.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

