Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVIHMKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVIHMKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVIHMKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:10:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65290 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932425AbVIHMKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:10:33 -0400
Date: Thu, 8 Sep 2005 13:10:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 3/5] SharpSL: Abstract c7x0 specifics from Corgi Touchscreen driver
Message-ID: <20050908131028.B31595@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007630.8338.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126007630.8338.128.camel@localhost.localdomain>; from rpurdie@rpsys.net on Tue, Sep 06, 2005 at 12:53:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:53:50PM +0100, Richard Purdie wrote:
> Separate out the Sharp Zaurus c7x0 series specific code from the Corgi
> Touchscreen driver. Use the new functions in corgi_lcd.c via sharpsl.h
> for hsync handling and pass the IRQ as a platform device resource. Move
> a function prototype into the w100fb header file where it belongs.

This patch looks a little confused.

> +	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);

So irq_gpio is an IRQ number.

> @@ -313,14 +324,14 @@
>  	input_register_device(&corgi_ts->input);
>  	corgi_ts->power_mode = PWR_MODE_ACTIVE;
>  
> -	if (request_irq(CORGI_IRQ_GPIO_TP_INT, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
> +	if (request_irq(IRQ_GPIO(corgi_ts->irq_gpio), ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {

Or is it.  It _should_ be an IRQ number.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
