Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSE3NdP>; Thu, 30 May 2002 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSE3NdO>; Thu, 30 May 2002 09:33:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6635 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316637AbSE3NdN>;
	Thu, 30 May 2002 09:33:13 -0400
Date: Thu, 30 May 2002 15:33:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Wayne.Brown@altec.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: ufs compile error in 2.5.19
Message-ID: <20020530133311.GA841@suse.de>
In-Reply-To: <86256BC8.006DB41A.00@smtpnotes.altec.com> <20020529210938.DYLF24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29 2002, Skip Ford wrote:
> Wayne.Brown@altec.com wrote:
> > 
> > truncate.c: In function `ufs_truncate':
> > truncate.c:456: `tq_disk' undeclared (first use in this function)
> > truncate.c:456: (Each undeclared identifier is reported only once
> > truncate.c:456: for each function it appears in.)
> > make[2]: *** [truncate.o] Error 1
> > make[2]: Leaving directory `/usr/src/linux-2.5.19/fs/ufs'
> 
> I guess this is right...
> 
> --- linux/fs/ufs/truncate.c	Wed May 29 16:59:56 2002
> +++ linux/fs/ufs/truncate.c	Wed May 29 17:03:57 2002
> @@ -453,7 +453,7 @@
>  			break;
>  		if (IS_SYNC(inode) && (inode->i_state & I_DIRTY))
>  			ufs_sync_inode (inode);
> -		run_task_queue(&tq_disk);
> +		blk_run_queues();
>  		yield();
>  	}
>  	offset = inode->i_size & uspi->s_fshift;

Yeah it's right, and I see I missed exactly this change in the patch I
just sent to Linus a few hours ago... So I've sent this one on as well,
thanks.

-- 
Jens Axboe

