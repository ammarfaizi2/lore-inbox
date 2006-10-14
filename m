Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWJNMOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWJNMOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWJNMOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:14:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932189AbWJNMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:14:51 -0400
Date: Sat, 14 Oct 2006 14:14:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Michael Krufky <mkrufky@linuxtv.org>
Subject: Re: [PATCH 07/18] V4L/DVB (4733): Tda10086: fix frontend selection for dvb_attach
Message-ID: <20061014121448.GM30596@stusta.de>
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS67662400007@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014120050.PS67662400007@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 09:00:50AM -0300, mchehab@infradead.org wrote:
> 
> From: Michael Krufky <mkrufky@linuxtv.org>
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
> 
>  drivers/media/dvb/frontends/tda10086.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/dvb/frontends/tda10086.h b/drivers/media/dvb/frontends/tda10086.h
> index e8061db..18457ad 100644
> --- a/drivers/media/dvb/frontends/tda10086.h
> +++ b/drivers/media/dvb/frontends/tda10086.h
> @@ -35,7 +35,16 @@ struct tda10086_config
>  	u8 invert;
>  };
>  
> +#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
>  extern struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
>  					    struct i2c_adapter* i2c);
> +#else
> +static inline struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
> +						   struct i2c_adapter* i2c)
> +{
> +	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
> +	return NULL;
> +}
> +#endif // CONFIG_DVB_TDA10086

As already said:
This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA10086=m.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

