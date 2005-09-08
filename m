Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVIHO6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVIHO6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVIHO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:58:06 -0400
Received: from tim.rpsys.net ([194.106.48.114]:1187 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932521AbVIHO6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:58:05 -0400
Subject: Re: [-mm patch 3/5] SharpSL: Abstract c7x0 specifics from Corgi
	Touchscreen driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050908131028.B31595@flint.arm.linux.org.uk>
References: <1126007630.8338.128.camel@localhost.localdomain>
	 <20050908131028.B31595@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 15:56:43 +0100
Message-Id: <1126191403.8147.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 13:10 +0100, Russell King wrote: 
> On Tue, Sep 06, 2005 at 12:53:50PM +0100, Richard Purdie wrote:
> > Separate out the Sharp Zaurus c7x0 series specific code from the Corgi
> > Touchscreen driver. Use the new functions in corgi_lcd.c via sharpsl.h
> > for hsync handling and pass the IRQ as a platform device resource. Move
> > a function prototype into the w100fb header file where it belongs.
> 
> This patch looks a little confused.
> 
> > +	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);
> 
> So irq_gpio is an IRQ number.
> 
> > @@ -313,14 +324,14 @@
> >  	input_register_device(&corgi_ts->input);
> >  	corgi_ts->power_mode = PWR_MODE_ACTIVE;
> >  
> > -	if (request_irq(CORGI_IRQ_GPIO_TP_INT, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
> > +	if (request_irq(IRQ_GPIO(corgi_ts->irq_gpio), ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
> 
> Or is it.  It _should_ be an IRQ number.

This is a problem because of this code:

if ((GPLR(corgi_ts->irq_gpio) & GPIO_bit(corgi_ts->irq_gpio)) == 0) {

which needs the GPIO number. Perhaps we need to add a IRQ_TO_GPIO define
in pxa-regs.h to deal with this? Would that be acceptable?

Richard

