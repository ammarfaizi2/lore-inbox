Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTDHLiP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTDHLiP (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:38:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33185 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261842AbTDHLiM (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 07:38:12 -0400
Date: Tue, 8 Apr 2003 13:46:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, dwmw2@redhat.com,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] fix drivers/mtd/mtdblock.c compile
Message-ID: <20030408114642.GX786@suse.de>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com> <20030408114446.GF5046@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408114446.GF5046@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08 2003, Adrian Bunk wrote:
> On Mon, Apr 07, 2003 at 10:53:43AM -0700, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.66 to v2.5.67
> > ============================================
> >...
> > Jens Axboe:
> >...
> >   o kill blk_queue_empty()
> >...
> 
> This patch causes the following compile error:
> 
> <--  snip  -->
> 
> ..
>   gcc -Wp,-MD,drivers/mtd/.mtdblock.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6 
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=mtdblock -DKBUILD_MODNAME=mtdblock -c -o 
> drivers/mtd/mtdblock.o drivers/mtd/mtdblock.c
> drivers/mtd/mtdblock.c: In function `handle_mtdblock_request':
> drivers/mtd/mtdblock.c:391: warning: assignment makes pointer from 
> integer without a cast
> drivers/mtd/mtdblock.c:391: syntax error before '{' token
> drivers/mtd/mtdblock.c:394: `p' undeclared (first use in this function)
> drivers/mtd/mtdblock.c:394: (Each undeclared identifier is reported only once
> drivers/mtd/mtdblock.c:394: for each function it appears in.)
> drivers/mtd/mtdblock.c: At top level:
> drivers/mtd/mtdblock.c:442: syntax error before '}' token
> make[2]: *** [drivers/mtd/mtdblock.o] Error 1
> 
> <--  snip  -->
> 
> 
> The fix is simple:
> 
> --- linux-2.5.67-notfull/drivers/mtd/mtdblock.c.old	2003-04-08 13:39:46.000000000 +0200
> +++ linux-2.5.67-notfull/drivers/mtd/mtdblock.c	2003-04-08 13:41:43.000000000 +0200
> @@ -388,7 +388,7 @@
>  	struct mtdblk_dev *mtdblk;
>  	unsigned int res;
>  
> -	while ((req = elv_next_request(&mtd_queue) != NULL) {
> +	while ((req = elv_next_request(&mtd_queue)) != NULL) {
>  		struct mtdblk_dev **p = req->rq_disk->private_data;
>  		spin_unlock_irq(mtd_queue.queue_lock);
>  		mtdblk = *p;

Thanks, obviously correct!

-- 
Jens Axboe

