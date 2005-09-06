Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVIFVxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVIFVxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVIFVxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:53:46 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:41118 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750990AbVIFVxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:53:45 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=dVbnnqm2YkXVNqKwPgUG4ojNZBeAtkgEPqVtWgBhH1w1x2pN2yRVych9z9LkoDg0h
	WIJrJFYQElM8/fAX9IhxA==
Date: Tue, 06 Sep 2005 14:53:25 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com
References: <20050906201001.68988.qmail@web30312.mail.mud.yahoo.com>
In-Reply-To: <20050906201001.68988.qmail@web30312.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050906215325.813B1BF3C8@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With my subsystem that would look like:
>
> static const struct spi_cs_table
> platform_spi1_cs_table[] = {
>  {
>   .name  = "touchscreen",
>   .cs_no  = 1,
>   .platform_data = NULL,
>   .flags  = SPI_CS_IDLE_HIGH,
>   .cs_data = 0,
>  },
>  {
>   .name  = "flash",
>   .cs_no  = 3,
>   .platform_data = NULL,
>   .flags  = SPI_CS_IDLE_HIGH,
>   .cs_data = 0,
>  },
> };

The problem scenario was that only one configuration
is valid at a time ... it would have been clearer if
both the add-on boards used CS1, so that device would
be either ads7864 _or_ at25640a, but not both.



> As far as I can see most SPI devices have fixed
> wirering to an adapter as SPI is not really a hotplug
> bus.

That wiring can be through an expansion connector though, which
is what I meant when I wrote that it's "vaguely hotplug-ish".
Example, the mainboard could have some SPI devices hard-wired,
on CS0 and CS2, while each different plugin board might add very
different devices on CS1 and/or CS3.

In any case, you were the one who also wanted to ship sample USB
peripherals that acted as adapters to various SPI chips... so that
bus adapters would really need to hotplug! :)


> The subsystem does allow you to add extra devices that
> aren't in the cs table if you want by calling
> spi_device_register in which case you have to setup
> the spi_device with the correct information.

Right, but as I had explained, the scenario is that the
SPI devices are on some easily-swapped add-on card.
That's a common physical arrangement for small embeddable
boards, because it takes so few wires per device.

Swapping those SPI connectors shouldn't involve changing
the declaration of the controller on the mainboard ...


> > One reason I posted this driver-model-only patch was
> > to highlight how
> > minimal an SPI core can be if it reuses the driver
> > model core.  I'm
> > not a fan of much "mid-layer" infrastructure in
> > driver stacks.
> > 
>
> This is what my SPI core tries to do. I would like to
> make at 'as small as possible and no smaller'

I'll post a refresh of my patch that seems to me to be
a much better match for those goals.  The refresh includes
some tweaks based on what you sent, but it's still just
one KByte of overhead in the target ROM.  :)

- Dave

