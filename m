Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVG3OVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVG3OVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 10:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVG3OVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 10:21:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20703 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261227AbVG3OVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 10:21:48 -0400
Date: Sat, 30 Jul 2005 16:21:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
Message-ID: <20050730142141.GH1830@elf.ucw.cz>
References: <20050725054642.GA6651@elf.ucw.cz> <20050725062242.GA3292@elf.ucw.cz> <20050730102656.C9652@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730102656.C9652@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 30-07-05 10:26:56, Russell King wrote:
> On Mon, Jul 25, 2005 at 08:22:42AM +0200, Pavel Machek wrote:
> > I replaced sharp functions with ucb_1x00 functions this way; I hope I
> > did not mess it up.
> > 
> > diff --git a/arch/arm/mach-sa1100/battery-collie.c b/arch/arm/mach-sa1100/battery-collie.c
> > --- a/arch/arm/mach-sa1100/battery-collie.c
> > +++ b/arch/arm/mach-sa1100/battery-collie.c
> > -
> > -  	ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_LOW);
> > -  	ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_HIGH);
> > -	voltage = ucb1200_get_adc_value(ADC_REQ_ID, COLLIE_TC35143_ADC_BAT_VOL);
> > +	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_BBAT_ON);
> > +	ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_MBAT_ON, 0);
> > +	voltage = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);
> 
> This won't work.  You can't pass NULL to functions that take a pointer
> and expect them to work.  Look back at my patch set, at the way the
> ucb1x00-assabet patch does this.

I did some quick hack for now, thanks.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
