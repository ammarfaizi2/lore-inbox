Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWGaURq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWGaURq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWGaURq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:17:46 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:1959 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932485AbWGaURq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:17:46 -0400
Date: Mon, 31 Jul 2006 22:17:35 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Chris Boot <bootc@bootc.net>
Cc: Ben Dooks <ben@fluff.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060731201735.GZ10495@pengutronix.de>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <20060730220200.GB8907@home.fluff.org> <44CE2B90.5030905@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <44CE2B90.5030905@bootc.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 05:10:56PM +0100, Chris Boot wrote:
> My current idea is to divide the interfaces by GPIO device and port.
> I've so far not seen a GPIO device that couldn't be divided into ports
> of <= 32 bits. How wide can a 'port' actually become?

Not all GPIOs can be abstracted into "ports" in a sane way. For example,
the PXAs have something like 80 GPIOs, which might be randomly divided
into alternate functions and "real" GPIOs.

> Somehow I think that a separate device/file for each pin or possibly
> even port might not be a wise idea. For example, twiddling individual
> pins on a GPIO when you connect an LCD, I2C, or SPI interface seems
> extremely inefficient...

I think you have to take care about two things: a) a registration
infrastructure (which GPIO pin was requested, similar to mem and irq)
and b) an access API. For slow things like LEDs you might want to have
unified access functions, but for fast GPIOs (bitbanging i2c etc) you
want to directly manipulate the registers once you've requested them.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

