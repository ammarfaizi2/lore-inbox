Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289309AbSAIJeb>; Wed, 9 Jan 2002 04:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJeW>; Wed, 9 Jan 2002 04:34:22 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:10492 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289307AbSAIJeE>;
	Wed, 9 Jan 2002 04:34:04 -0500
Date: Wed, 9 Jan 2002 02:32:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Oops with eject and cdrom affects 2.4 & 2.5
Message-ID: <20020109023243.G769@lynx.adilger.int>
Mail-Followup-To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Jens Axboe <axboe@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020109091217.K19814@suse.de> <Pine.LNX.4.33.0201091023380.8076-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201091023380.8076-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Wed, Jan 09, 2002 at 11:07:33AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, 2002  11:07 +0200, Zwane Mwaikambo wrote:
> On Wed, 9 Jan 2002, Jens Axboe wrote:
> > Yes, just kill the printk instead.
> 
> Here are patches for 2.5.2-pre10 and 2.4.18-pre2 respectively
> 
> --- linux-2.5.2-pre10/drivers/ide/ide-cd.c.orig	Wed Jan  9 10:18:40 2002
> +++ linux-2.5.2-pre10/drivers/ide/ide-cd.c	Wed Jan  9 10:28:22 2002
> @@ -1398,11 +1398,8 @@
>  		ide_init_drive_cmd (&req);
>  		req.flags = REQ_PC;
>  		req.special = (char *) pc;
> -		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
> -			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
> -				drive->name, req.buffer[0], req.buffer[1]);
> -			/* FIXME: we should probably abort/retry or something */
> -		}
> +		ide_do_drive_cmd (drive, &req, ide_wait);
> +

Hmm, it would appear that this patch is "losing information", about the
fact that there could be an error here, and the FIXME that it should be
retried.  If anything, I would just remove the printk and leave the FIXME.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

