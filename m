Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTADUAD>; Sat, 4 Jan 2003 15:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTADUAD>; Sat, 4 Jan 2003 15:00:03 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:47597 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261356AbTADUAC>;
	Sat, 4 Jan 2003 15:00:02 -0500
Date: Sat, 4 Jan 2003 21:07:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, parisc-linux@parisc-linux.org
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: add hwclock ioctls used in 2.4 for pa and in 2.5
In-Reply-To: <200301030232.h032WuM30725@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0301042101070.10261-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.925, 2003/01/02 21:03:29-02:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] PATCH: add hwclock ioctls used in 2.4 for pa and in 2.5
> 	
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.924   -> 1.925  
> #	  include/linux/kd.h	1.3     -> 1.4    
> #
> 
>  kd.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+)
> 
> 
> diff -Nru a/include/linux/kd.h b/include/linux/kd.h
> --- a/include/linux/kd.h	Thu Jan  2 18:32:57 2003
> +++ b/include/linux/kd.h	Thu Jan  2 18:32:57 2003
> @@ -132,6 +132,19 @@
>  
>  #define KDSIGACCEPT	0x4B4E	/* accept kbd generated signals */
>  
> +struct hwclk_time {
> +	unsigned	sec;	/* 0..59 */
> +	unsigned	min;	/* 0..59 */
> +	unsigned	hour;	/* 0..23 */
> +	unsigned	day;	/* 1..31 */
> +	unsigned	mon;	/* 0..11 */
> +	unsigned	year;	/* 70... */
> +	int		wday;	/* 0..6, 0 is Sunday, -1 means unknown/don't set */
> +};
> +
> +#define KDGHWCLK        0x4B50	/* get hardware clock */
> +#define KDSHWCLK        0x4B51  /* set hardware clock */
> +
>  struct kbd_repeat {
>  	int delay;	/* in msec; <= 0: don't change */
>  	int rate;	/* in msec; <= 0: don't change */

Ugh, and I was so happy to have them removed in 2.4.19 :-(
BTW, they were removed from 2.5.x in 2.5.15 as well.

ChangeSet log was:
| - Kill m68k-specific struct hwclk_time in favor of common struct rtc_time
| - Kill m68k-specific KD[GS]HWCLK ioctls() (the code for them was removed a
|   long time ago)

Wouldn't it be better to convert PA-RISC to use struct rtc_time as well?

And the KD[GS]HWCLK ioctl()s are obsolete anyway, use /dev/rtc to access the
hardware clock. On PA-RISC that should be done through genrtc, which I'm in the
process of cleaning up for submission to marcelo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


