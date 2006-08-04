Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWHDIbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWHDIbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWHDIbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:31:39 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:18958 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161106AbWHDIb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:31:26 -0400
Date: Fri, 4 Aug 2006 10:31:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060804103135.77531faa.khali@linux-fr.org>
In-Reply-To: <200608030730.42458.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200608021218.30763.david-b@pacbell.net>
	<20060803111949.91e8e7bc.khali@linux-fr.org>
	<200608030730.42458.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> On Thursday 03 August 2006 2:19 am, Jean Delvare wrote:
> > The i2c core provides a mechanism to bypass the probing when you know
> > for sure what device is at a given address. For an embedded system, that
> > should work.
> 
> Unfortunately the mechanisms I'm aware of require either error-prone
> kernel command line parameters, or (not error prone, but inelegant)
> board-specific logic in the drivers, before driver registration, to
> do equivalent stuff.

I said it was possible, not that it was nice and elegant ;) I know it's
ugly at the moment - which is exactly why people have been asking for
an i2c-core conversion.

> It may help to see how the SPI core solves that problem.  Unlike I2C,
> SPI actually _can't_ probe (except in rare specialized cases), and when
> I did the SPI stuff I was thinking about models that could apply easily
> to help I2C avoid probing.  (Though not, at this point, code.)

I2C can't really probe either. We abuse a transaction type we known most
chips will reply to but otherwise ignore to achieve chip presence
detection. It did damage in the past (killing Thinkpad laptops) and
could do again in the future. So, having board-specific lists of chips
to avoid probing would help.

> That model of a table of board-specific declarations (with things like
> "I2C chip type X at address A, using interrupt I and platform_data P")
> should work for I2C too.

What we have in the works is "I2C chip type X at address A". No
interrupt nor platform data at this point. But once the conversion to
the device driver model is done, I guess it'll come naturally if needed.

-- 
Jean Delvare
