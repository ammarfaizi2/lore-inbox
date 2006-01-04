Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWADU3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWADU3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWADU3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:29:00 -0500
Received: from xenotime.net ([66.160.160.81]:58019 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965252AbWADU27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:28:59 -0500
Date: Wed, 4 Jan 2006 12:28:59 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Stefan Rompf <stefan@loplof.de>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
In-Reply-To: <200601042126.47081.stefan@loplof.de>
Message-ID: <Pine.LNX.4.58.0601041228170.19134@shark.he.net>
References: <200601042108.04544.stefan@loplof.de> <1136405379.2839.46.camel@laptopd505.fenrus.org>
 <200601042126.47081.stefan@loplof.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Stefan Rompf wrote:

> Am Mittwoch 04 Januar 2006 21:09 schrieb Arjan van de Ven:
>
> > since a memset right before a free is a very unusual code pattern in the
> > kernel it may well be worth putting a short comment around it to prevent
> > someone later removing it as "optimization"
>
> Valid objection, here is an update (and see, I'm running 2.6.15 now ;-)

A reason "why" would be more helpful that a "what".


> Signed-off-by: Stefan Rompf <stefan@loplof.de>
> Acked-by: Clemens Fruhwirth <clemens@endorphin.org>
>
> --- linux-2.6.15/drivers/md/dm-crypt.c.orig	2006-01-04 01:01:16.000000000 +0100
> +++ linux-2.6.15/drivers/md/dm-crypt.c	2006-01-04 21:23:34.000000000 +0100
> @@ -690,6 +690,8 @@
>  bad2:
>  	crypto_free_tfm(tfm);
>  bad1:
> +	/* Must zero key material before freeing */
> +	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
>  	kfree(cc);
>  	return -EINVAL;
>  }
> @@ -706,6 +708,9 @@
>  		cc->iv_gen_ops->dtr(cc);
>  	crypto_free_tfm(cc->tfm);
>  	dm_put_device(ti, cc->dev);
> +
> +	/* Must zero key material before freeing */
> +	memset(cc, 0, sizeof(*cc) + cc->key_size * sizeof(u8));
>  	kfree(cc);
>  }
>
> -

-- 
~Randy
