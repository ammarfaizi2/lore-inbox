Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUFFMMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUFFMMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUFFMMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:12:21 -0400
Received: from mail2-116.ewetel.de ([212.6.122.116]:51959 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S263370AbUFFMMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:12:07 -0400
Date: Sun, 6 Jun 2004 14:11:57 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest
 errors?
In-Reply-To: <20040606092825.GD2733@suse.de>
Message-ID: <Pine.LNX.4.58.0406061408090.202@neptune.local>
References: <200406060007.10150.kernel@kolivas.org> <20040606092825.GD2733@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004, Jens Axboe wrote:

> Interesting, and 2.6.2 works flawlessly? The only change in 2.6.3 wrt
> ide-cd is the addition of the != 2kB sector size support from Pascal
> Schmidt. A quick guess would be that blocklen isn't set, does this
> change anything for you?

Hmmm, another thing that just occured to me is that maybe some broken
drive might return the raw sector size, despite what the standard says.

> ===== drivers/ide/ide-cd.c 1.83 vs edited =====
> --- 1.83/drivers/ide/ide-cd.c	2004-05-29 19:04:42 +02:00
> +++ edited/drivers/ide/ide-cd.c	2004-06-06 11:27:51 +02:00
> @@ -2205,6 +2205,8 @@
>  		*capacity = 1 + be32_to_cpu(capbuf.lba);
>  		*sectors_per_frame =
>  			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
> +		if (*sectors_per_frame == 0)
> +			*sectors_per_frame = SECTORS_PER_FRAME;
>  	}
>
>  	return stat;

If this turns out to be the cause, maybe we should check that blocklen
isn't 0 and divisible by 512.

-- 
Ciao,
Pascal
