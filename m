Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263023AbRE1KFm>; Mon, 28 May 2001 06:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbRE1KFc>; Mon, 28 May 2001 06:05:32 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:40785 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263023AbRE1KFT>; Mon, 28 May 2001 06:05:19 -0400
Date: Mon, 28 May 2001 13:05:07 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Masaru Kawashima <masaruk@gol.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        go@turbolinux.co.jp
Subject: Re: initrd oops with 2.4.5ac2: FIXED by Kawashima (the other oops may remain)
Message-ID: <20010528130507.P11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi> <20010528001220.M11981@niksula.cs.hut.fi> <20010528102551.N11981@niksula.cs.hut.fi> <20010528180254.380908d8.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528180254.380908d8.masaruk@gol.com>; from masaruk@gol.com on Mon, May 28, 2001 at 06:02:54PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 06:02:54PM +0900, you [Masaru Kawashima] claimed:
> On Mon, 28 May 2001 10:25:51 +0300
> Ville Herva <vherva@mail.niksula.cs.hut.fi> wrote:
> > The oops call trace seems to be the same as in 
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2
> > 
> > Any ideas?
> 
> Did you try the patch posted by Go Taniguchi <go@turbolinux.co.jp>?
> Following is the copy of his message and the patch itself.
> 
> --- linux/fs/block_dev.c.orig	Mon May 28 12:40:12 2001
> +++ linux/fs/block_dev.c	Mon May 28 12:40:12 2001
> @@ -602,6 +602,7 @@
>  	if (!bdev->bd_op->ioctl)
>  		return -EINVAL;
>  	inode_fake.i_rdev=rdev;
> +	inode_fake.i_bdev=bdev;
>  	init_waitqueue_head(&inode_fake.i_wait);
>  	set_fs(KERNEL_DS);
>  	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

Yes, I actually spotted the patch on l-k just a while ago and tried it.

It does fix the initrd case; I haven't tried the grub case, but I suspect it
still remains. Will try that as well asap.

Thanks,


-- v --

v@iki.fi
