Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283621AbRK3LQ4>; Fri, 30 Nov 2001 06:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283622AbRK3LQq>; Fri, 30 Nov 2001 06:16:46 -0500
Received: from [193.252.19.61] ([193.252.19.61]:56755 "EHLO
	mel-rta7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283621AbRK3LQf>; Fri, 30 Nov 2001 06:16:35 -0500
Date: Fri, 30 Nov 2001 11:56:03 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
cc: <pascal.lengard@wanadoo.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: dac960 broken ?
In-Reply-To: <200111292006.fATK6NMF021272@dandelion.com>
Message-ID: <Pine.LNX.4.33.0111301153460.20821-100000@h2o.chezmoi.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


working 2.4.7-10 from redhat includes definitions for devices rd/c0...
(not in #define(CONFIG_BLK_DEV_DAC960), patch is different)

broken 2.4.9-13 from redhat includes these also in the same way.
(so ...)

broken 2.4.16 does not define these devices in linux/init/main.c
I just tried your patch on 2.4.16. It went smoothly but the 2.4.16+patch
behaves exactly as before, same messages as without patch when booting ...
and kernel panic.

Pascal Lengard


On Thu, 29 Nov 2001, Leonard N. Zubkoff wrote:
> Hmmm.  Can you check if the following patch is present in the Linux kernel
> you're using:
> 
> --- linux/init/main.c-	Sat Oct  6 08:49:16 2001
> +++ linux/init/main.c	Wed Oct 10 09:06:07 2001
> @@ -221,6 +221,24 @@
>  	{ "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
>  	{ "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
>  #endif
> +#if defined(CONFIG_BLK_DEV_DAC960) || defined(CONFIG_BLK_DEV_DAC960_MODULE)
> +	{ "rd/c0d0p",0x3000 },
> +	{ "rd/c0d1p",0x3008 },
> +	{ "rd/c0d2p",0x3010 },
> +	{ "rd/c0d3p",0x3018 },
> +	{ "rd/c0d4p",0x3020 },
> +	{ "rd/c0d5p",0x3028 },
> +	{ "rd/c0d6p",0x3030 },
> +	{ "rd/c0d7p",0x3038 },
> +	{ "rd/c0d8p",0x3040 },
> +	{ "rd/c0d9p",0x3048 },
> +	{ "rd/c0d10p",0x3050 },
> +	{ "rd/c0d11p",0x3058 },
> +	{ "rd/c0d12p",0x3060 },
> +	{ "rd/c0d13p",0x3068 },
> +	{ "rd/c0d14p",0x3070 },
> +	{ "rd/c0d15p",0x3078 },
> +#endif
>  #if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
>  	{ "ida/c0d0p",0x4800 },
>  	{ "ida/c0d1p",0x4810 },
> 
> Without this patch, which Linux has repeatedly refused to include in the
> standard sources, it is entirely possible that the root= processing won't work
> correctly.
> 
> 		Leonard
> 

