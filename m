Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUEUUF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUEUUF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUEUUF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:05:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265981AbUEUUFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:05:19 -0400
Message-ID: <40AE60DC.5030104@pobox.com>
Date: Fri, 21 May 2004 16:04:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arthur Othieno <a.othieno@bluewin.ch>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] drivers/block/floppy.c: Premature blk_queue_max_sectors()
References: <20040521195934.GA17681@mars>
In-Reply-To: <20040521195934.GA17681@mars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Othieno wrote:
> Hi,
> 
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


Good catch...

	Jeff


