Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbREHSPt>; Tue, 8 May 2001 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbREHSPj>; Tue, 8 May 2001 14:15:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29198 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S133040AbREHSPd>; Tue, 8 May 2001 14:15:33 -0400
Date: Tue, 8 May 2001 20:15:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE flash problem found
Message-ID: <20010508201522.A10738@atrey.karlin.mff.cuni.cz>
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678EA9@mail-in.comverse-in.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678EA9@mail-in.comverse-in.com>; from Vassilii.Khachaturov@comverse.com on Tue, May 08, 2001 at 02:05:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why did not you take care of the request_region() call and just disabled it?
> The ports will be considered free by the system, and another device might 
> grab them later on!

Because it was one of changes between 2.4.0 and 2.4.4. Ignore that.

								Pavel
> 
> Vassilii
> 
> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz]
> Sent: Tuesday, May 08, 2001 8:14 AM
> To: kernel list
> Subject: PCMCIA IDE flash problem found
> 
> 
> Hi!
> 
> 2.4.[123] changed name of ide-cs module, which means your pcmcia setup
> breaks... This is how to undo the damage. Works for me, do *not* apply
> into anything official.
> 
> 								Pavel
> 
> --- clean/drivers/ide/ide-cs.c	Sun Apr  1 00:23:29 2001
> +++ linux/drivers/ide/ide-cs.c	Tue May  8 14:06:09 2001
> @@ -95,7 +96,7 @@
>  static int ide_event(event_t event, int priority,
>  		     event_callback_args_t *args);
>  
> -static dev_info_t dev_info = "ide-cs";
> +static dev_info_t dev_info = "ide_cs";
>  
>  static dev_link_t *ide_attach(void);
>  static void ide_detach(dev_link_t *);
> @@ -388,9 +389,12 @@
>  	MOD_DEC_USE_COUNT;
>      }
>  
> +#if 0
>      request_region(link->io.BasePort1, link->io.NumPorts1,"ide-cs");
>      if (link->io.NumPorts2)
>  	request_region(link->io.BasePort2, link->io.NumPorts2,"ide-cs");
> +#endif
> +    printk("Should call request_region\n");
>      
>      info->ndev = 0;
>      link->dev = NULL;

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
