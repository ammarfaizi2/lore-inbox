Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUEUUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUEUUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUEUUJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:09:27 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:21495 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266002AbUEUUJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:09:25 -0400
Date: Fri, 21 May 2004 16:10:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] drivers/block/floppy.c: Premature blk_queue_max_sectors()
In-Reply-To: <20040521195934.GA17681@mars>
Message-ID: <Pine.LNX.4.58.0405211610050.2864@montezuma.fsmlabs.com>
References: <20040521195934.GA17681@mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, Arthur Othieno wrote:

> We're prematurely pampering the request queue before
> checking whether it was indeed allocated successfully.
>
> Against 2.6.6. Thanks.
>
>
>  floppy.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/block/floppy.c	2004-05-20 23:48:04.000000000 +0200
> +++ b/drivers/block/floppy.c	2004-05-21 21:29:33.000000000 +0200
> @@ -4271,11 +4271,11 @@
>  		goto out;
>
>  	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
> -	blk_queue_max_sectors(floppy_queue, 64);
>  	if (!floppy_queue) {
>  		err = -ENOMEM;
>  		goto fail_queue;
>  	}
> +	blk_queue_max_sectors(floppy_queue, 64);
>
>  	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
>  			    floppy_find, NULL, NULL);

ooh nice.

