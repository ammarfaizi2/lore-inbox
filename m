Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbTAJTRG>; Fri, 10 Jan 2003 14:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTAJTRG>; Fri, 10 Jan 2003 14:17:06 -0500
Received: from mail.zmailer.org ([62.240.94.4]:34463 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266353AbTAJTRF>;
	Fri, 10 Jan 2003 14:17:05 -0500
Date: Fri, 10 Jan 2003 21:25:46 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.55 fix etherleak in 8390.c [rescued]
Message-ID: <20030110192546.GI27709@mea-ext.zmailer.org>
References: <200301101835.h0AIZA704332@mail.intergenia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301101835.h0AIZA704332@mail.intergenia.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 07:35:10PM +0100, Rudmer van Dijk wrote:
> this is the fix which went in 2.4.21-pre3-ac2, rediffed against 2.5.55
> 	Rudmer

  That  scratch[]  allocation is 60 bytes, taken off the stack.
  It isn't very large, and isn't recursive, but still...

> --- linux-2.5.55/drivers/net/8390.c.orig	2003-01-10 16:23:44.000000000 +0100
> +++ linux-2.5.55/drivers/net/8390.c	2003-01-10 16:23:00.000000000 +0100
> @@ -270,6 +270,7 @@
>  	struct ei_device *ei_local = (struct ei_device *) dev->priv;
>  	int length, send_length, output_page;
>  	unsigned long flags;
> +	char scratch[ETH_ZLEN];
>  
>  	length = skb->len;


/Matti Aarnio
