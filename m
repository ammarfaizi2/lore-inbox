Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267307AbSLRSQQ>; Wed, 18 Dec 2002 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbSLRSQQ>; Wed, 18 Dec 2002 13:16:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8465 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267307AbSLRSQO>;
	Wed, 18 Dec 2002 13:16:14 -0500
Date: Wed, 18 Dec 2002 10:21:35 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: ALSA update
Message-ID: <20021218182135.GD31197@kroah.com>
References: <200212181807.gBII7Wn28845@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212181807.gBII7Wn28845@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet 1.885.1.5, 2002/12/18 10:13:22+01:00, perex@suse.cz

<snip>

> diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
> --- a/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> +++ b/sound/usb/usbaudio.c	Wed Dec 18 10:07:34 2002
> @@ -526,7 +526,11 @@
>  /*
>   * complete callback from data urb
>   */
> +#ifndef OLD_USB
>  static void snd_complete_urb(struct urb *urb, struct pt_regs *regs)
> +#else
> +static void snd_complete_urb(struct urb *urb)
> +#endif
>  {
>  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
>  	snd_usb_substream_t *subs = ctx->subs;
> @@ -551,7 +555,11 @@
>  /*
>   * complete callback from sync urb
>   */
> +#ifndef OLD_USB
>  static void snd_complete_sync_urb(struct urb *urb, struct pt_regs *regs)
> +#else
> +static void snd_complete_sync_urb(struct urb *urb)
> +#endif
>  {
>  	snd_urb_ctx_t *ctx = (snd_urb_ctx_t *)urb->context;
>  	snd_usb_substream_t *subs = ctx->subs;
> @@ -583,6 +591,9 @@

Ick, you're kidding me, right?  Why do this?  Are you trying to keep a
common code base with 2.4 and 2.5 USB drivers?  If so, I don't recommend
it, as the code will be sprinkled with these ifdef's...

thanks,

greg k-h
