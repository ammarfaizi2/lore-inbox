Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbREQTtu>; Thu, 17 May 2001 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbREQTtm>; Thu, 17 May 2001 15:49:42 -0400
Received: from HIC-SR2.hickam.af.mil ([131.38.214.17]:14799 "EHLO
	hic-sr2.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S261866AbREQTtb>; Thu, 17 May 2001 15:49:31 -0400
Message-ID: <4CDA8A6D03EFD411A1D300D0B7E83E8F697326@FSKNMD07.hickam.af.mil>
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, richbaum@acm.org
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: RE: [PATCH] 2.4.5pre3 warning fixes
Date: Thu, 17 May 2001 19:49:05 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks to me like it's adding { and } on each side of the
"c->devices->prev=d;" statement... so changing from:

if (c->devices != NULL)
	c->devices->prev=d;

to 

if (c->devices != NULL){
	c->devices->prev=d;
}

I assume the new compiler likes the if to have explicit brackets instead of
using the next statement...

	Sam Bingner

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, May 17, 2001 9:40 AM
To: richbaum@acm.org
Cc: linux-kernel@vger.kernel.org; torvalds@transmeta.com;
alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] 2.4.5pre3 warning fixes


> --- linux/drivers/i2o/i2o_core.c	Thu May 17 11:38:28 2001
> +++ rb/drivers/i2o/i2o_core.c	Thu May 17 11:48:08 2001
> @@ -380,8 +380,9 @@
>  	d->owner=NULL;
>  	d->next=c->devices;
>  	d->prev=NULL;
> -	if (c->devices != NULL)
> +	if (c->devices != NULL){
>  		c->devices->prev=d;
> +	}

What does this have to do with gcc compiler warnings ?????

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
