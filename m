Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWAOOth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWAOOth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 09:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWAOOth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 09:49:37 -0500
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:30605 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932068AbWAOOth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 09:49:37 -0500
Subject: Re: [PATCH] Fix zoran_card compilation warning
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
In-Reply-To: <20060115131313.04657ef5.khali@linux-fr.org>
References: <20060112213437.3eb3f370.khali@linux-fr.org>
	 <20060115131313.04657ef5.khali@linux-fr.org>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 09:44:39 -0500
Message-Id: <1137336280.7095.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus/Andrew,

On Sun, 2006-01-15 at 13:13 +0100, Jean Delvare wrote:
>   CC [M]  drivers/media/video/zoran_card.o
> drivers/media/video/zoran_card.c: In function `zr36057_init':
> drivers/media/video/zoran_card.c:1053: warning: assignment makes integer from pointer without a cast
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/media/video/zoran_card.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.15-git.orig/drivers/media/video/zoran_card.c	2006-01-12 20:34:54.000000000 +0100
> +++ linux-2.6.15-git/drivers/media/video/zoran_card.c	2006-01-12 20:47:26.000000000 +0100
> @@ -995,7 +995,7 @@
>  static int __devinit
>  zr36057_init (struct zoran *zr)
>  {
> -	unsigned long mem;
> +	u32 *mem;
>  	void *vdev;
>  	unsigned mem_needed;
>  	int j;
> @@ -1058,10 +1058,10 @@
>  			"%s: zr36057_init() - kmalloc (STAT_COM) failed\n",
>  			ZR_DEVNAME(zr));
>  		kfree(vdev);
> -		kfree((void *)mem);
> +		kfree(mem);
>  		return -ENOMEM;
>  	}
> -	zr->stat_com = (u32 *) mem;
> +	zr->stat_com = mem;
>  	for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
>  		zr->stat_com[j] = 1;	/* mark as unavailable to zr36057 */
>  	}
> 

I support this change, please apply it. It's something left-over from
the time that all computers were 32-bit. Apart from this warning (which
nobody really cared about), the driver was already tested to work fine
on AMD64 computers in 64-bit mode.

Thank you,
Ronald

