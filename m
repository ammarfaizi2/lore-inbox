Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUBOVwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 16:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUBOVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 16:52:21 -0500
Received: from [217.7.64.198] ([217.7.64.198]:45190 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S265207AbUBOVwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 16:52:19 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3
Date: Sun, 15 Feb 2004 22:52:17 +0100
User-Agent: KMail/1.6
Cc: Peter Osterlund <petero2@telia.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <200402152052.50596.earny@net4u.de> <m28yj42jcm.fsf@p4.localdomain>
In-Reply-To: <m28yj42jcm.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402152252.17301.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 15. Februar 2004 21:11, Peter Osterlund wrote:
> Ernst Herzberg <earny@net4u.de> writes:
> > Compile warnings with new driver:
> >
> > [...]
> > drivers/video/aty/radeon_base.c: In function
> > `radeon_probe_pll_params': drivers/video/aty/radeon_base.c:474:
> > warning: `xtal' might be used uninitialized in this function
>
> This looks like a real bug. I guess the patch below fixes it, but I
> can't test it because that code is not executed on my hardware. (And I
> doubt it will fix your problem.)
>
> --- linux/drivers/video/aty/radeon_base.c.old	2004-02-15
> 21:06:02.000000000 +0100 +++
> linux/drivers/video/aty/radeon_base.c	2004-02-15 20:57:22.000000000
> +0100 @@ -566,8 +566,9 @@
>  		break;
>  	}
>
> -	do_div(vclk, 1000);
> -	xtal = (xtal * denom) / num;
> +	vclk *= denom;
> +	do_div(vclk, 1000 * num);
> +	xtal = vclk;
>
>  	if ((xtal > 26900) && (xtal < 27100))
>  		xtal = 2700;
>
> > drivers/video/aty/radeon_base.c: In function `radeon_screen_blank':
> > drivers/video/aty/radeon_base.c:944: warning: `val2' might be used
> > uninitialized in this function drivers/video/aty/radeon_base.c: In
> > function `radeonfb_setcolreg': drivers/video/aty/radeon_base.c:1025:
> > warning: `vclk_cntl' might be used uninitialized in this function CC  
> >    net/sunrpc/timer.o
> > drivers/video/aty/radeon_base.c: In function `radeon_calc_pll_regs':
> > drivers/video/aty/radeon_base.c:1319: warning: `pll_output_freq' might
> > be used uninitialized in this function
>
> I think these warnings are harmless.


This patch does not help, the console is still blank. The monitor shows:

H. Freq 63.98 kHz
V. Freq 60.00 HZ
Pixel Clock 107.98 Mhz
Resolution 1280x1024
Belinea101705

.. but with a black screen...

~Earny
