Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVBDRjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVBDRjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbVBDRhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:37:46 -0500
Received: from alhya.freenux.org ([81.56.176.87]:37034 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S262848AbVBDRhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:37:20 -0500
Message-ID: <4203B2CA.9050609@kde.org>
Date: Fri, 04 Feb 2005 18:37:14 +0100
From: Mickael Marchand <marchand@kde.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org> <1107407987.2097.18.camel@lb.loomes.de> <87is5a0wxm.fsf@bytesex.org> <1107428571.2068.4.camel@lb.loomes.de> <20050203113022.GK10602@bytesex> <4202798B.7000802@kde.org> <42035211.9030603@yahoo.fr>
In-Reply-To: <42035211.9030603@yahoo.fr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that did it for me too :)

seems Gerd Knorr already applied

thanks

Cheers,
Mik

Guillaume Chazarain wrote:
> Mickael Marchand wrote:
> 
>> Hello,
>>
>> I am having the same kind of troubles (can't tune and mt_set_frequency 
>> -121 errors) since 2.6.10 (it was working in 2.6.9) on amd64.
>> this patch did not help sadely.
> 
> 
> I have the same problem, but on x86, the attached patch fixed it for me.
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.11-rc3/drivers/media/video/tda9887.c
> +++ linux-2.6.11-rc3/drivers/media/video/tda9887.c
> @@ -545,19 +553,21 @@
>  	int rc;
>  
>  	memset(buf,0,sizeof(buf));
> +	tda9887_set_tvnorm(t,buf);
>  	buf[1] |= cOutputPort1Inactive;
>  	buf[1] |= cOutputPort2Inactive;
> -	tda9887_set_tvnorm(t,buf);
>  	if (UNSET != t->pinnacle_id) {
>  		tda9887_set_pinnacle(t,buf);
>  	}
>  	tda9887_set_config(t,buf);
>  	tda9887_set_insmod(t,buf);
>  
> +#if 0
>  	if (t->std & V4L2_STD_SECAM_L) {
>  		/* secam fixup (FIXME: move this to tvnorms array?) */
>  		buf[1] &= ~cOutputPort2Inactive;
>  	}
> +#endif
>  
>  	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
>  		buf[1],buf[2],buf[3]);

