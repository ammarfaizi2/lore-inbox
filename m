Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTHMKWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271739AbTHMKWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:22:13 -0400
Received: from [195.141.226.27] ([195.141.226.27]:52240 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S271738AbTHMKWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:22:11 -0400
Subject: Re: [Dri-devel] [PATCH] cpu_relax whilst in busy-wait loops.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davej@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <E19mCuO-0003dX-00@tetrachloride>
References: <E19mCuO-0003dX-00@tetrachloride>
Content-Type: text/plain; charset=UTF-8
Organization: Debian, XFree86
Message-Id: <1060770126.26452.142.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 12:22:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 15:40, davej@redhat.com wrote: 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/drm/gamma_dma.c linux-2.5/drivers/char/drm/gamma_dma.c
> -- bk-linus/drivers/char/drm/gamma_dma.c	2003-05-31 15:58:40.000000000 +0100
> +++ linux-2.5/drivers/char/drm/gamma_dma.c	2003-05-29 14:07:46.000000000 +0100
> @@ -44,9 +44,14 @@ static inline void gamma_dma_dispatch(dr
>  	drm_gamma_private_t *dev_priv =
>  				(drm_gamma_private_t *)dev->dev_private;
>  	mb();
> -	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2);
> +	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2)
> +		cpu_relax();
> +

[...]

Are you actually using the gamma driver? :) Something like this might be
useful in other drivers as well?


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

