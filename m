Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263139AbVBELFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbVBELFB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbVBELBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:01:45 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:48079 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266596AbVBEKoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:44:18 -0500
Date: Sat, 5 Feb 2005 11:44:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050205104405.GA1401@elf.ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c20502031443764fb4e5@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is a patch that exposes the IBM TrackPoint's extended properties
> as well as scroll wheel emulation.
> 
> 
> I would appreciate comments and suggestions to make this more acceptable.
> 
> 
> Stephen
> 
> 
> diff -uNr a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> --- a/drivers/input/mouse/Makefile	2005-02-03 17:30:40.000000000 -0500
> +++ b/drivers/input/mouse/Makefile	2005-02-03 17:29:42.000000000 -0500
> @@ -14,4 +14,4 @@
>  obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
>  
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o trackpoint.o
> diff -uNr a/drivers/input/mouse/psmouse-base.c
> b/drivers/input/mouse/psmouse-base.c
> --- a/drivers/input/mouse/psmouse-base.c	2005-02-03 17:30:40.000000000 -0500
> +++ b/drivers/input/mouse/psmouse-base.c	2005-02-03 17:29:42.000000000 -0500
> @@ -23,6 +23,7 @@
>  #include "psmouse.h"
>  #include "synaptics.h"
>  #include "logips2pp.h"
> +#include "trackpoint.h"
>  #include "alps.h"
>  
>  #define DRIVER_DESC	"PS/2 mouse driver"
> @@ -119,6 +120,13 @@
>  	}
>  
>  /*
> + * TrackPoint scroll simulation handler if the BTN_MIDDLE is down
> + */
> +
> +	if(psmouse->model == PSMOUSE_TRACKPOINT)
> +		trackpoint_sim_scroll(psmouse);
> +
> +/*
>   * Generic PS/2 Mouse
>   */
>  

Perhaps this should be done in userspace? It is probably usable on
non-trackpoint devices, too...
									Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
