Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315399AbSEGLA3>; Tue, 7 May 2002 07:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315405AbSEGLA2>; Tue, 7 May 2002 07:00:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12552 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315399AbSEGLA1>; Tue, 7 May 2002 07:00:27 -0400
Message-ID: <3CD7A500.8030509@evision-ventures.com>
Date: Tue, 07 May 2002 11:57:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Osamu Tomita <tomita@cinet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE CD-ROM PIO mode
In-Reply-To: <3CD79586.63E17164@cinet.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Osamu Tomita napisa?:
> I could not use CD-ROM drive [PIO mode] on 2.5.14.
> Error messeges are follows.
> 
> May  7 11:05:03 sarah kernel: hdc: cdrom_read_intr: data underrun (4294967292 blocks)
> May  7 11:05:03 sarah kernel: end_request: I/O error, dev 16:00, sector 92
> May  7 11:05:03 sarah kernel: Buffer I/O error on device ide1(22,0), logical block 22
> 
> This patch works fine for me. Please check it.

Indeed this makes very much of sense. I will take it.
How did you see it "hawkeye"?

> --- linux/drivers/ide/ide-cd.c.orig	Mon May  6 12:38:01 2002
> +++ linux/drivers/ide/ide-cd.c	Tue May  7 16:43:51 2002
> @@ -962,7 +962,7 @@
>  
>  	/* First, figure out if we need to bit-bucket
>  	   any of the leading sectors. */
> -	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
> +	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
>  
>  	while (nskip > 0) {
>  		/* We need to throw away a sector. */

