Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbTGHN4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbTGHNyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:54:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41697 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S267347AbTGHNxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:53:45 -0400
Date: Tue, 8 Jul 2003 16:08:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make synaptics support optional
Message-ID: <20030708160815.B22428@ucw.cz>
References: <20030708104551.GA209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030708104551.GA209@elf.ucw.cz>; from pavel@ucw.cz on Tue, Jul 08, 2003 at 12:45:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 12:45:51PM +0200, Pavel Machek wrote:
> Hi!
> 
> Synaptics support breaks mouse for me (HP omnibook xe3).

Read the kernel config help entry. If you mean external mouse, then
that's in the works.

> I guess it should have its own config option, and perhaps it should be
> marked experimental...

Probably yes.

> What about this patch?

Seems OK.

> 								Pavel
> 
> --- /usr/src/tmp/linux/drivers/input/mouse/Kconfig	2003-06-24 12:27:47.000000000 +0200
> +++ /usr/src/linux/drivers/input/mouse/Kconfig	2003-07-08 12:33:47.000000000 +0200
> @@ -30,6 +30,12 @@
>  	  The module will be called psmouse. If you want to compile it as a
>  	  module, say M here and read <file:Documentation/modules.txt>.
>  
> +config MOUSE_SYNAPTICS
> +	tristate "Synaptics touchpad support"
> +	depends on INPUT_MOUSE && MOUSE_PS2
> +	help
> +	  Say Y if you want your touchpad not to work any more.
> +
>  config MOUSE_SERIAL
>  	tristate "Serial mouse"
>  	depends on INPUT && INPUT_MOUSE && SERIO
> @@ -134,4 +140,3 @@
>  	  inserted in and removed from the running kernel whenever you want).
>  	  The module will be called logibm.o. If you want to compile it as a
>  	  module, say M here and read <file.:Documentation/modules.txt>.
> -
> --- /usr/src/tmp/linux/drivers/input/mouse/synaptics.c	2003-06-24 12:27:47.000000000 +0200
> +++ /usr/src/linux/drivers/input/mouse/synaptics.c	2003-07-08 12:32:36.000000000 +0200
> @@ -213,6 +213,9 @@
>  {
>  	struct synaptics_data *priv;
>  
> +#ifndef CONFIG_MOUSE_SYNAPTICS
> +	return -1;
> +#endif;
>  	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
>  	if (!priv)
>  		return -1;
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
