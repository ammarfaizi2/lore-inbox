Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSGOIOo>; Mon, 15 Jul 2002 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSGOIOn>; Mon, 15 Jul 2002 04:14:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:33236 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317371AbSGOIOn>;
	Mon, 15 Jul 2002 04:14:43 -0400
Date: Mon, 15 Jul 2002 10:17:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
In-Reply-To: <20020712221744.GG11007@kroah.com>
Message-ID: <Pine.GSO.4.21.0207151016530.12594-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Greg KH wrote:
> Dave Jones found a bug in this patch that causes the driver to try to
> bind to multiple busses :(
> 
> This patch seems to fix this problem.
> 
> thanks,
> 
> greg k-h
> 
> 
> diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
> --- a/drivers/char/agp/agpgart_be.c	Fri Jul 12 14:57:41 2002
> +++ b/drivers/char/agp/agpgart_be.c	Fri Jul 12 14:57:41 2002
> @@ -47,7 +47,7 @@
>  EXPORT_SYMBOL(agp_backend_acquire);
>  EXPORT_SYMBOL(agp_backend_release);
>  
> -struct agp_bridge_data agp_bridge;
> +struct agp_bridge_data agp_bridge = { type: NOT_SUPPORTED };
>  static int agp_try_unsupported __initdata = 0;
>  
>  int agp_backend_acquire(void)
> @@ -1593,6 +1593,11 @@
>  static int agp_probe (struct pci_dev *dev, const struct pci_device_id *ent)
>  {
>  	int ret_val;
> +
> +	if (agp_bridge.type != NOT_SUPPORTED) {
> +		printk (KERN_DEBUG "Oops, don't init a 2nd agpgard device.\n");
                                                           ^^^^^^^
							   agpgart?

> +		return -ENODEV;
> +	}
>  
>  	ret_val = agp_backend_initialize(dev);
>  	if (ret_val) {
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

