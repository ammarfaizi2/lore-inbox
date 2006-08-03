Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWHCPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWHCPhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWHCPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:37:21 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:6802 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964797AbWHCPhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:37:20 -0400
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Thu, 3 Aug 2006 07:30:40 -0700
User-Agent: KMail/1.7.1
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200608021218.30763.david-b@pacbell.net> <20060803111949.91e8e7bc.khali@linux-fr.org>
In-Reply-To: <20060803111949.91e8e7bc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030730.42458.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 2:19 am, Jean Delvare wrote:
> The i2c core provides a mechanism to bypass the probing when you know
> for sure what device is at a given address. For an embedded system, that
> should work.

Unfortunately the mechanisms I'm aware of require either error-prone
kernel command line parameters, or (not error prone, but inelegant)
board-specific logic in the drivers, before driver registration, to
do equivalent stuff.


> > (There's a separate issue about how the I2C stack doesn't just have a
> > mechanism to just declare "this board has these chips, these addresses",
> > so I2C drivers have needless reliance on probing...)
> 
> This is being (slowly) addressed by Nathan Lutchansky and Mark M.
> Hoffman. The best solution implies converting the i2c subsystem to the
> device driver model - a non-trivial task.

Glad to hear that fixes are in the works.  That's the same conclusion
I reached:  that I2C needed those non-trivial changes.

It may help to see how the SPI core solves that problem.  Unlike I2C,
SPI actually _can't_ probe (except in rare specialized cases), and when
I did the SPI stuff I was thinking about models that could apply easily
to help I2C avoid probing.  (Though not, at this point, code.)

That model of a table of board-specific declarations (with things like
"I2C chip type X at address A, using interrupt I and platform_data P")
should work for I2C too.

- Dave

