Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264257AbUD0SYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUD0SYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUD0SYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:24:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38418 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264257AbUD0SVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:21:24 -0400
Date: Tue, 27 Apr 2004 19:21:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org
Subject: Re: i2c_get_client() missing?
Message-ID: <20040427192119.A21965@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, stefan.eletzhofer@eletztrick.de,
	linux-kernel@vger.kernel.org
References: <20040427150144.GA2517@gonzo.local> <20040427153512.GA19633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040427153512.GA19633@kroah.com>; from greg@kroah.com on Tue, Apr 27, 2004 at 08:35:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 08:35:12AM -0700, Greg KH wrote:
> Where do you need to access it from?  Why do all of the current drivers
> not need it?

The "traditional Linux" i2c model is one where the i2c bus is local to
the card, so the overall driver knows where the bus is, and what devices
to expect, and it's all nicely encapsulated.

The variant on that is the i2c sensor stuff, where the individual i2c
bus device drivers export data to userspace themselves.

However, there's another class, where the i2c bus contains things like
RTC and system control stuff, which can be found on embedded devices.
Such an i2c bus is often shared between multiple parts of the system,
and lumping them all together into one massive driver does not make
sense.

For instance, one platform I have here has an i2c bus with a RTC on,
and optionally a couple of EEPROMs giving the dimentions of the memory
on a couple of expansion boards.  It doesn't make sense to lump the
RTC code along side the memory controller configuration code, along
with the i2c bus driver.

I2C is much much more than sensors and graphics capture chips.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
