Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSLDVUc>; Wed, 4 Dec 2002 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSLDVUc>; Wed, 4 Dec 2002 16:20:32 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:5270 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267096AbSLDVU2>; Wed, 4 Dec 2002 16:20:28 -0500
Date: Wed, 4 Dec 2002 14:20:45 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Andreas Oberritter <obi@saftware.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] recognize ATI M3 & M4 video bios on Dell notebooks
In-Reply-To: <1038038729.13725.6.camel@shiva>
Message-ID: <Pine.LNX.4.33.0212041420310.1533-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied to fbdev BK tree. Thanks.


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On 23 Nov 2002, Andreas Oberritter wrote:

> Hi,
>
>
> This patch makes aty128fb find the video bios on a Latitude C600 (M3)
> and Inspiron 8000 (M4).
>
> If you reply, then please CC to me. I am not subscribed to the lkml.
>
> Regards,
> Andreas
>
>
>
> diff -u -r1.26 aty128fb.c
> --- drivers/video/aty128fb.c	2002/11/04 18:51:29	1.26
> +++ drivers/video/aty128fb.c	2002/11/23 07:46:58
> @@ -2134,9 +2134,12 @@
>  	char *rom_base;
>  	char *rom;
>  	int  stage;
> -	int  i;
> +	int  i,j;
>  	char aty_rom_sig[] = "761295520";   /* ATI ROM Signature      */
> -	char R128_sig[] = "R128";           /* Rage128 ROM identifier */
> +	char *R128_sig[] = {
> +		"R128",           /* Rage128 ROM identifier */
> +		"128b"
> +	};
>
>  	for (segstart=0x000c0000; segstart<0x000f0000; segstart+=0x00001000) {
>          	stage = 1;
> @@ -2167,10 +2170,14 @@
>
>  		/* ATI signature found.  Let's see if it's a Rage128 */
>  		for (i = 0; (i < 512) && (stage != 4); i++) {
> -			if (R128_sig[0] == *rom)
> -				if (strncmp(R128_sig, rom,
> -						strlen(R128_sig)) == 0)
> -					stage = 4;
> +		    for(j = 0;j < sizeof(R128_sig)/sizeof(char *);j++) {
> +			if (R128_sig[j][0] == *rom)
> +				if (strncmp(R128_sig[j], rom,
> +					    strlen(R128_sig[j])) == 0) {
> +					      stage = 4;
> +					      break;
> +				            }
> +		    }
>  			rom++;
>  		}
>  		if (stage != 4) {
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

