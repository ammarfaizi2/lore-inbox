Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUAJTdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUAJTcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:32:10 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46502 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265338AbUAJTay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:30:54 -0500
Date: Sat, 10 Jan 2004 20:30:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110193039.GA22654@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110175930.GA1749@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 06:59:30PM +0100, Pavel Machek wrote:

> ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> is not really suitable to be enabled by default. You can not click by
> tapping the touchpad (well, unless you have very new X with right
> configuration, but than you can't go back to 2.4), and touchpad senses
> your finger even when it is not touching, doing spurious movements =>
> you can't hit anything on screen. Without synaptics extensions
> everything works just fine. You can reenable synaptics support using
> commandline.
> 
> Plus it documents psmouse_noext option.
> 
> Please apply,

No way. This also kills Logitech mouse detection and Genius and ...
... and those cannot be enabled via kernel command line parameters.

> 								Pavel
> 
> 
> 
> 
> --- tmp/linux/Documentation/kernel-parameters.txt	2004-01-10 18:51:13.000000000 +0100
> +++ linux/Documentation/kernel-parameters.txt	2004-01-10 16:15:31.000000000 +0100
> @@ -799,8 +799,10 @@
>  			before loading.
>  			See Documentation/ramdisk.txt.
>  
> +	psmouse_noext=  [HW,MOUSE,deprecated] Equivalent to psmouse_proto=bare
> +
>  	psmouse_proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
> -			probe for (bare|imps|exps).
> +			probe for (bare|imps|exps|synaptics).
>  
>  	psmouse_resetafter=
>  			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
> --- tmp/linux/drivers/input/mouse/psmouse-base.c	2004-01-09 20:24:19.000000000 +0100
> +++ linux/drivers/input/mouse/psmouse-base.c	2004-01-10 16:16:06.000000000 +0100
> @@ -31,7 +31,7 @@
>  MODULE_PARM_DESC(psmouse_noext, "[DEPRECATED] Disable any protocol extensions. Useful for KVM switches.");
>  
>  static char *psmouse_proto;
> -static unsigned int psmouse_max_proto = -1U;
> +static unsigned int psmouse_max_proto = PSMOUSE_IMEX;
>  module_param(psmouse_proto, charp, 0);
>  MODULE_PARM_DESC(psmouse_proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
>  
> @@ -678,6 +678,8 @@
>  			psmouse_max_proto = PSMOUSE_IMPS;
>  		else if (!strcmp(psmouse_proto, "exps"))
>  			psmouse_max_proto = PSMOUSE_IMEX;
> +		else if (!strcmp(psmouse_proto, "synaptics"))
> +			psmouse_max_proto = PSMOUSE_SYNAPTICS;
>  		else
>  			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
>  	}
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
