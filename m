Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUAJJ4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 04:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAJJ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 04:56:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:44261 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265061AbUAJJ4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 04:56:32 -0500
Date: Sat, 10 Jan 2004 10:56:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Synaptics rate switching
Message-ID: <20040110095607.GB19577@ucw.cz>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401100345.17211.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 03:45:13AM -0500, Dmitry Torokhov wrote:

> ===================================================================
> 
> 
> ChangeSet@1.1512, 2004-01-10 02:42:42-05:00, dtor_core@ameritech.net
>   Input: Allow switching between high and low reporting rate for Synaptics
>          touchpads in native mode. Synaptics support 2 report rates - 40
>          and 80 packets/sec; report rate must be set using Synaptics mode
>          set command. Rate is controlled by psmouse.rate parameter, values
>          greater or equal 80 will set 'high' rate. (psmouse.rate defaults
>          to 100)
>   
>          Using low report rate should help slower systems or systems
>          spending too much time in SCI (ACPI).
> 
> 
>  psmouse.h   |    1 +
>  synaptics.c |    4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> ===================================================================

Andrew, please apply these patches.

> diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> --- a/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
> +++ b/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
> @@ -67,6 +67,7 @@
>  int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
>  
>  extern int psmouse_smartscroll;
> +extern unsigned int psmouse_rate;
>  extern unsigned int psmouse_resetafter;
>  
>  #endif /* _PSMOUSE_H */
> diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> --- a/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
> +++ b/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
> @@ -214,7 +214,9 @@
>  {
>  	struct synaptics_data *priv = psmouse->private;
>  
> -	mode |= SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
> +	mode |= SYN_BIT_ABSOLUTE_MODE;
> +	if (psmouse_rate >= 80)
> +		mode |= SYN_BIT_HIGH_RATE;
>  	if (SYN_ID_MAJOR(priv->identity) >= 4)
>  		mode |= SYN_BIT_DISABLE_GESTURE;
>  	if (SYN_CAP_EXTENDED(priv->capabilities))

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
