Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSLMLEg>; Fri, 13 Dec 2002 06:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSLMLEg>; Fri, 13 Dec 2002 06:04:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:41460
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261908AbSLMLEf>; Fri, 13 Dec 2002 06:04:35 -0500
Date: Fri, 13 Dec 2002 06:15:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH][2.5][CFT] ad1848 PnP updates + fixes
In-Reply-To: <Pine.LNX.4.50.0212122048590.6931-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0212130612330.12366-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0212122048590.6931-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,
	I had the following hunk from the previous patch to this file, do
we really want to disable that device here?

On Thu, 12 Dec 2002, Zwane Mwaikambo wrote:

>  #ifdef CONFIG_PNP
> -	if(ad1848_dev){
> -		if(audio_activated)
> -			pnp_disable_dev(ad1848_dev);
> -		put_device(&ad1848_dev->dev);
> +{
> +	ad1848_info *p;
> +
> +	if (audio_activated == 0)
> +		return;
> +
> +	while (--nr_ad1848_devs >= 0) {
> +		p = &adev_info[nr_ad1848_devs];
> +		pnp_disable_dev(p->pnp_dev);	/* XXX Should this be done here? */
> +		put_device(&p->pnp_dev->dev);
>  	}
> +	pnp_unregister_driver(&ad1848_driver);
> +}
>  #endif

-- 
function.linuxpower.ca
