Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUHGFIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUHGFIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHGFIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:08:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:36285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266227AbUHGFIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:08:30 -0400
Date: Fri, 6 Aug 2004 22:06:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Meyknecht <sm0407@nurfuerspam.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Message-Id: <20040806220654.5e857bed.akpm@osdl.org>
In-Reply-To: <200408061833.30751.sm0407@nurfuerspam.de>
References: <200408061833.30751.sm0407@nurfuerspam.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Meyknecht <sm0407@nurfuerspam.de> wrote:
>
> [PATCH] cdrom: MO-drive open write fix
> 
> Allow mounting mo-drives readwrite.
> 
> Please apply.
> 
> Stefan
> 
> 
> --- linux/drivers/cdrom/cdrom.c.orig	2004-08-06 18:04:16.269803330 +0200
> +++ linux/drivers/cdrom/cdrom.c	2004-08-06 18:04:33.570828588 +0200
> @@ -899,7 +899,7 @@ int cdrom_open(struct cdrom_device_info 
>  			ret = -EROFS;
>  			if (cdrom_open_write(cdi))
>  				goto err;
> -			if (!CDROM_CAN(CDC_RAM))
> +			if (!CDROM_CAN(CDC_RAM) && !CDROM_CAN(CDC_MO_DRIVE))
>  				goto err;
>  			ret = 0;
>  		}

I forwarded this to Jens last time you sent it and he said "Not really,
CDC_RAM is an umbrella that should already cover these devices.  I'll reply
to him."

So...  could you describe the actual bug which you're seeing - maybe
there's some different fix which we need.

