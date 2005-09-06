Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVIFMK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVIFMK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVIFMK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:10:56 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:55339 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964832AbVIFMK4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:10:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U/tjb9Gw3jLka/Oiw4AuKW+eEZltyQ8cXnhAj28dd4Tlf313zuzy7JaV5xPyVrUqf62EqctuxWmM+g/aH/1z2RAVHfsCyoJCVLMT8E4IIA8/XMmMv/XGAAvmvYuv7RTEdojbhikbfOI+6MQrXam1i2g7Vohv2Cy3h3LU1Y47RuA=
Message-ID: <84144f0205090605107a76dd78@mail.gmail.com>
Date: Tue, 6 Sep 2005 15:10:47 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [-mm patch 2/5] SharpSL: Add cxx00 support to the Corgi LCD driver
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1126007628.8338.127.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1126007628.8338.127.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Richard Purdie <rpurdie@rpsys.net> wrote:
> +/*
> + * Corgi/Spitz Touchscreen to LCD interface
> + */
> +unsigned long inline corgi_get_hsync_len(void)
> +{
> +       if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
> +#ifdef CONFIG_PXA_SHARP_C7xx
> +               return w100fb_get_hsynclen(&corgifb_device.dev);
> +#endif
> +       } else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
> +#ifdef CONFIG_PXA_SHARP_Cxx00
> +               return pxafb_get_hsync_time(&pxafb_device.dev);
> +#endif
> +       }
> +       return 0;
> +}

Please consider making two version of corgi_get_hsync_len() instead
for both config options. The above is hard to read.

                               Pekka
