Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUD1IOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUD1IOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbUD1IOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:14:19 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:42214 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264685AbUD1IOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:14:12 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 10:13:57 +0200
From: stefan.eletzhofer@eletztrick.de
To: Greg KH <greg@kroah.com>, stefan.eletzhofer@eletztrick.de,
       linux-kernel@vger.kernel.org
Subject: Re: i2c_get_client() missing?
Message-ID: <20040428081357.GA11274@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040427150144.GA2517@gonzo.local> <20040427153512.GA19633@kroah.com> <20040427192119.A21965@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427192119.A21965@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 07:21:19PM +0100, Russell King wrote:
> On Tue, Apr 27, 2004 at 08:35:12AM -0700, Greg KH wrote:
> > Where do you need to access it from?  Why do all of the current drivers
> > not need it?
> 
> The "traditional Linux" i2c model is one where the i2c bus is local to
> the card, so the overall driver knows where the bus is, and what devices
> to expect, and it's all nicely encapsulated.
> 
> The variant on that is the i2c sensor stuff, where the individual i2c
> bus device drivers export data to userspace themselves.
> 
> However, there's another class, where the i2c bus contains things like
> RTC and system control stuff, which can be found on embedded devices.
> Such an i2c bus is often shared between multiple parts of the system,
> and lumping them all together into one massive driver does not make
> sense.

Thats exactly what I tried to say with my other post. Thanks for spelling
it more precisely.

> 
> For instance, one platform I have here has an i2c bus with a RTC on,
> and optionally a couple of EEPROMs giving the dimentions of the memory
> on a couple of expansion boards.  It doesn't make sense to lump the
> RTC code along side the memory controller configuration code, along
> with the i2c bus driver.

Again, exatly what I thought when I split up I2C RTC chip access and
higher level RTC device handling stuff.

> 
> I2C is much much more than sensors and graphics capture chips.

Definitely.

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
