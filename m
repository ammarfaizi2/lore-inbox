Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJJGl5>; Wed, 10 Oct 2001 02:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274972AbRJJGlr>; Wed, 10 Oct 2001 02:41:47 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:18193 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S274951AbRJJGli>; Wed, 10 Oct 2001 02:41:38 -0400
Date: Wed, 10 Oct 2001 08:41:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Toby Milne <toby@svector.co.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.10-ac9 CDRW Packet Fix
Message-ID: <20011010084157.B3254@suse.de>
In-Reply-To: <E15qgFQ-0004pk-00@avalon.svector.gotadsl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15qgFQ-0004pk-00@avalon.svector.gotadsl.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08 2001, Toby Milne wrote:
> The ac tree is missing some braces - without these the userspace buffer 
> contents never get copied into the kernel buffer.
> 
> --- linux/drivers/cdrom/cdrom.c	Mon Oct  8 19:20:56 2001
> +++ linux-2.4.10-ac9/drivers/cdrom/cdrom.c	Mon Oct  8 19:19:04 2001
> @@ -1983,10 +1983,10 @@
>  	if (usense && !access_ok(VERIFY_WRITE, usense, sizeof(*usense)))
>  		goto out;
> 
> -	if (cgc->data_direction == CGC_DATA_READ)
> +	if (cgc->data_direction == CGC_DATA_READ) {
>  		if (!access_ok(VERIFY_READ, ubuf, cgc->buflen))
>  			goto out;
> -	else if (cgc->data_direction == CGC_DATA_WRITE)
> +	} else if (cgc->data_direction == CGC_DATA_WRITE)
>  		if (copy_from_user(cgc->buffer, ubuf, cgc->buflen))
>  			goto out;

Thanks, definitely a braino!

-- 
Jens Axboe

