Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288173AbSAQHhx>; Thu, 17 Jan 2002 02:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288256AbSAQHhe>; Thu, 17 Jan 2002 02:37:34 -0500
Received: from [203.117.131.12] ([203.117.131.12]:9411 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S288255AbSAQHhc>; Thu, 17 Jan 2002 02:37:32 -0500
Message-ID: <3C467F34.30706@metaparadigm.com>
Date: Thu, 17 Jan 2002 15:37:24 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020112
MIME-Version: 1.0
To: reddog83@chartermi.net, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: [PATCH] radeonfb for kernel-2.4.18-pre1
In-Reply-To: <auto-000047991150@front1.chartermi.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is just a hack to get the driver to compile.

I've had success with the patch in the message referenced below which is
from the driver maintainer. It fixes the compile problem in a cleaner manner
by adding the required defines to the radeon.h header file.

   http://marc.theaimsgroup.com/?l=linux-kernel&m=101046020806692&w=2

BTW - Also, here is my patch to radeonfb to detect panel geometry using
radeon BIOS registers on Radeon Mobility M6 chipset.

   http://gort.metaparadigm.com/radeonfb/radeon-bios-dfpinfo-2.patch

radeonfb still needs DDC detection added for x86 (use OF on PPC to get EDID
info), although the BIOS detection is still required as not all panels
support DDC (such as the LCD panel in my laptop).

~mc

reddog83 wrote:

> Hi this patch fix's up the compiling issue with the Radeon Frame Buffer 
> driver. With this patch it should compile. I checked all over the LKML and 
> there has ben acouple of people who have sent the same patch in but have not 
> been acknowledged. Please apply this patch. Or Alan would you please include 
> this patch in your next ac release if you do have one? 
> Thank you Victor
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.4.18-pre1/drivers/video/radeonfb.c.orig   Sat Dec 29 20:48:07 2001
> +++ linux-2.4.18-pre1/drivers/video/radeonfb.c        Sat Dec 29 22:35:21 2001
> @@ -76,6 +76,7 @@
>  #include <video/fbcon-cfb32.h>
>  #include "radeon.h"
> +#define LVDS_STATE_MASK 0xFFFFFFFF
> 
>  #define DEBUG        0
> @@ -2280,7 +2281,7 @@
>       save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
>       save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
>       save->tmds_crc = INREG(TMDS_CRC);
> -     save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
> +/*   save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL); */
>  }
> 
> @@ -2557,8 +2558,8 @@
>               } else {
>                       /* DFP */
>                       newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
> -                     newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
> -                                                      ICHCSEL) & ~(TMDS_PLLRST);
> +/*                   newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
> +                                                      ICHCSEL) & ~(TMDS_PLLRST); */
>                       newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
>               }
>  @@ -2647,7 +2648,7 @@
>               OUTREG(FP_VERT_STRETCH, mode->fp_vert_stretch);
>               OUTREG(FP_GEN_CNTL, mode->fp_gen_cntl);
>               OUTREG(TMDS_CRC, mode->tmds_crc);
> -             OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
> +/*           OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl); */
>                if (primary_mon == MT_LCD) {
>                       unsigned int tmp = INREG(LVDS_GEN_CNTL);
> 


