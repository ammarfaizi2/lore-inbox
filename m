Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTJ1Azk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTJ1Azk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:55:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33669 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263791AbTJ1Azh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:55:37 -0500
Date: Tue, 28 Oct 2003 01:55:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031028005525.GC2886@ucw.cz>
References: <20031027183856.GA1461@averell> <Pine.LNX.4.44.0310271054120.1636-100000@home.osdl.org> <20031027192950.GA2192@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027192950.GA2192@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 08:29:50PM +0100, Andi Kleen wrote:

> jOn Mon, Oct 27, 2003 at 10:56:16AM -0800, Linus Torvalds wrote:
> > 
> > Which makes no sense.
> 
> Ok new patch with this fixed.

Thanks, this one is good.

> 
> ---------------------------
> 
> Only set PS/2 mouse rate when the user specified a value.
> 
> Allow specifying it from the command line when the driver is compiled in.
> 
> Make rates[] static.
> 
> diff -u linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c
> --- linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c-o	2003-09-28 10:53:17.000000000 +0200
> +++ linux-2.6.0test9-averell/drivers/input/mouse/psmouse-base.c	2003-10-27 20:16:25.000000000 +0100
> @@ -40,7 +40,7 @@
>  
>  static int psmouse_noext;
>  int psmouse_resolution;
> -unsigned int psmouse_rate = 60;
> +unsigned int psmouse_rate = 0;
>  int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
>  unsigned int psmouse_resetafter;
>  
> @@ -451,9 +451,12 @@
>  
>  static void psmouse_set_rate(struct psmouse *psmouse)
>  {
> -	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
> +	static unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
>  	int i = 0;
>  
> +	if (!psmouse_rate)
> +		return; 
> +
>  	while (rates[i] > psmouse_rate) i++;
>  	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
>  }
> @@ -651,10 +654,17 @@
>  	return 1;
>  }
>  
> +static int __init psmouse_rate_setup(char *str)
> +{
> +	get_option(&str, &psmouse_rate);
> +	return 1;
> +}
> +
>  __setup("psmouse_noext", psmouse_noext_setup);
>  __setup("psmouse_resolution=", psmouse_resolution_setup);
>  __setup("psmouse_smartscroll=", psmouse_smartscroll_setup);
>  __setup("psmouse_resetafter=", psmouse_resetafter_setup);
> +__setup("psmouse_rate=", psmouse_rate_setup);
>  
>  #endif
>  

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
