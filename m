Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTCEA53>; Tue, 4 Mar 2003 19:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTCEA53>; Tue, 4 Mar 2003 19:57:29 -0500
Received: from [203.94.130.164] ([203.94.130.164]:32473 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S266987AbTCEA52>;
	Tue, 4 Mar 2003 19:57:28 -0500
Date: Wed, 5 Mar 2003 11:54:36 +1100 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Dominik Brodowski <linux@brodo.de>
cc: generica@email.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: pcmcia no worky in 2.5.6[32]
In-Reply-To: <20030303071855.GA1224@brodo.de>
Message-ID: <Pine.LNX.4.44.0303051153550.9291-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Dominik Brodowski wrote:

> > Hey,
> > 
> > since 2.5.62, I've not been able to get pcmcia working.
> > 
> > Hardware: toshiba 100CS
> > 
> > I've attached my .config for 2.5.63,
> > and a dmesg directly after boot for 2.5.61 and 2.5.63
> > 
> > any other details needed, please let me know
> > 
> > thanks,
> > 
> > 	/ Brett
> 
> Could you please try this patch? It *should* fix this problem:
> 

Sadly, it didn't do a thing
same dmesg/no pcmcia as vanilla 2.5.63

any other ideas ??

thanks,

	/ Brett

> --- linux/drivers/pcmcia/i82365.c.original	2003-02-26 09:45:00.000000000 +0100
> +++ linux/drivers/pcmcia/i82365.c	2003-03-03 08:14:29.000000000 +0100
> @@ -1628,11 +1628,11 @@
>  	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
>  #endif
>      
> -    platform_device_register(&i82365_device);
> -
>      i82365_data.nsock = sockets;
>      i82365_device.dev.class_data = &i82365_data;
> -    
> +
> +    platform_device_register(&i82365_device);
> +
>      /* Finally, schedule a polling interrupt */
>      if (poll_interval != 0) {
>  	poll_timer.function = pcic_interrupt_wrapper;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

