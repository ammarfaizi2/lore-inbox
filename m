Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWGaVXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWGaVXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWGaVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:23:25 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:19681 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1030464AbWGaVXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:23:24 -0400
Message-ID: <44CE74CA.8070504@bootc.net>
Date: Mon, 31 Jul 2006 22:23:22 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Ben Dooks <ben@fluff.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <20060730220200.GB8907@home.fluff.org> <44CE2B90.5030905@bootc.net> <20060731201735.GZ10495@pengutronix.de>
In-Reply-To: <20060731201735.GZ10495@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> On Mon, Jul 31, 2006 at 05:10:56PM +0100, Chris Boot wrote:
>> My current idea is to divide the interfaces by GPIO device and port.
>> I've so far not seen a GPIO device that couldn't be divided into ports
>> of <= 32 bits. How wide can a 'port' actually become?
> 
> Not all GPIOs can be abstracted into "ports" in a sane way. For example,
> the PXAs have something like 80 GPIOs, which might be randomly divided
> into alternate functions and "real" GPIOs.

Hmm, now that does complicate things then. :-/

>> Somehow I think that a separate device/file for each pin or possibly
>> even port might not be a wise idea. For example, twiddling individual
>> pins on a GPIO when you connect an LCD, I2C, or SPI interface seems
>> extremely inefficient...
> 
> I think you have to take care about two things: a) a registration
> infrastructure (which GPIO pin was requested, similar to mem and irq)
> and b) an access API. For slow things like LEDs you might want to have
> unified access functions, but for fast GPIOs (bitbanging i2c etc) you
> want to directly manipulate the registers once you've requested them.

Yes I was thinking that a GPIO is a resource a little like an IRQ and thinking 
of a registration and ownership system as well. I'm glad somebody came up with 
that suggestion!

The access API is, as you say, more difficult. The access methods for slow GPIOs 
is indeed very simple but I can't think of any way to provide (near-)direct 
access for faster accesses in a portable way. Does anyone have any suggestions?

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
