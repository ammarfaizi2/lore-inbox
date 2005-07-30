Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVG3J1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVG3J1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVG3J1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:27:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51720 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263021AbVG3J1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:27:02 -0400
Date: Sat, 30 Jul 2005 10:26:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
Message-ID: <20050730102656.C9652@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050725054642.GA6651@elf.ucw.cz> <20050725062242.GA3292@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050725062242.GA3292@elf.ucw.cz>; from pavel@ucw.cz on Mon, Jul 25, 2005 at 08:22:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 08:22:42AM +0200, Pavel Machek wrote:
> I replaced sharp functions with ucb_1x00 functions this way; I hope I
> did not mess it up.
> 
> diff --git a/arch/arm/mach-sa1100/battery-collie.c b/arch/arm/mach-sa1100/battery-collie.c
> --- a/arch/arm/mach-sa1100/battery-collie.c
> +++ b/arch/arm/mach-sa1100/battery-collie.c
> -
> -  	ucb1200_set_io(COLLIE_TC35143_GPIO_BBAT_ON, COLLIE_TC35143_IODAT_LOW);
> -  	ucb1200_set_io(COLLIE_TC35143_GPIO_MBAT_ON, COLLIE_TC35143_IODAT_HIGH);
> -	voltage = ucb1200_get_adc_value(ADC_REQ_ID, COLLIE_TC35143_ADC_BAT_VOL);
> +	ucb1x00_io_write(NULL, 0, COLLIE_TC35143_GPIO_BBAT_ON);
> +	ucb1x00_io_write(NULL, COLLIE_TC35143_GPIO_MBAT_ON, 0);
> +	voltage = ucb1x00_adc_read(NULL, COLLIE_TC35143_ADC_BAT_VOL, UCB_SYNC);

This won't work.  You can't pass NULL to functions that take a pointer
and expect them to work.  Look back at my patch set, at the way the
ucb1x00-assabet patch does this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
