Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWFJW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWFJW1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWFJW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:27:17 -0400
Received: from khc.piap.pl ([195.187.100.11]:57351 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1161035AbWFJW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:27:16 -0400
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA and SCL lines
References: <m34pyyz0e1.fsf@defiant.localdomain>
	<20060609110546.GA26073@jupiter.solarsys.private>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 11 Jun 2006 00:27:14 +0200
In-Reply-To: <20060609110546.GA26073@jupiter.solarsys.private> (Mark M. Hoffman's message of "Fri, 9 Jun 2006 07:05:46 -0400")
Message-ID: <m3lks4k5od.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Mark M. Hoffman" <mhoffman@lightlink.com> writes:

> SCL and SDA must be pulled high by hardware.  If a driver inits to
> setting them low, that's a bug in the driver.

Thanks for your response.

The question is rather who inits the lines: a) the hw driver,
b) the I2C algorithm driver.

With a) every hw driver has to know how to init them (duplicated
code but there might be positive side).

With b) I2C algorithm driver inits the lines and hw driver
doesn't worry about but it might have some limitations such
as unknown SCL state.

I understand the current case is a) - right?


The other question is _how_ to init the lines. There are 4 possible
hardware initial conditions:

  SCL SDA
a)  0   0 (outputs zeroed by default)
b)  0   1 (uncommon but may be left in this state by previous operations)
c)  1   0 (ditto)
d)  1   1 (I/O lines configured as input by default)

The internal state of devices connected to the bus is potentially
unknown. Some implementations just start with STOP to eliminate
this problem, I don't know what Linux driver is supposed to do.

(Other implementation I know are rather specialized and thus they
know their hardware init state, Linux I2C algorithm handles many
devices with potentially different initial state of hardware lines).


To summarize questions:
- is it the hw driver who has to init the bus
- how to init the bus (depending on init state)
-- 
Krzysztof Halasa
