Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWHBPuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWHBPuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHBPuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:50:39 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:16394 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751223AbWHBPui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:50:38 -0400
Date: Wed, 2 Aug 2006 17:50:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060802175044.3d47d85b.khali@linux-fr.org>
In-Reply-To: <200607311653.48240.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200607310733.09125.david-b@pacbell.net>
	<20060731181327.d54ce1d0.khali@linux-fr.org>
	<200607311653.48240.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
> >	 If you want things to improve, please help by
> > reviewing Komal's driver. I think I understand you already commented on
> > it, but I'd like you to really review it, and add a formal approval to
> > it (e.g. Signed-off-by or Acked-by). Then I'll review it for merge.
> 
> The issues noted in the code are still almost all low priority
> (non-blocking).
> 
>  - The FIXME about choosing the address is very low priority,
>    and would affect only multi-master systems.  The fix would
>    involve defining a new i2c-specific struct for platform_data,
>    updating various boards to use it (e.g. OSK can use 400 MHz),
>    and wouldn't change behavior for any board I've ever seen.

Given that the slave mode isn't supported by Linux at the moment, I
don't even see how this is relevant. (So I agree with you that this is
very low priority - I would even kill that part of the code.)

> 
>  - Likewise with the REVISIT for the bus speed to use.  They'd
>    be fixed with the same patch.

I don't see any relation with the slave address mechanism. The bus
speed is a simple parameter, internal to the device (i2c-core doesn't
care) so it should be very easy to move it to platform data. Not that I
really care, though.

>  - The REVISIT about maybe a better way to probe is also low
>    priority; someone with a board that needs better probing
>    could address it at that time.  (Then restest any changes
>    on multiple generations of silicion ... which IMO is the
>    role the linux-omap tree should play.)

No, it's not low priority, it's a blocker. I can't let that code go in.
The driver must do what it is told to do. If it can't, it must fail.
Yes, this means no (in-kernel) probing on this bus at the moment. Blame
it on the hardware manufacturer (if the chip actually can't do it.) In
user-space, i2cdetect can be told to use byte reads for probing.

>  - The revisit about adap->retries is still up in the air,
>    and was a question in my submission from last year.
>    How exactly is that supposed to be used?  Right now
>    it's neither initialized (except to zero) nor tested.

This is an optional feature, most i2c adapter drivers don't implement
it. I'm fine without it, this can always be implemented later if needed.

I just sent my own review of the code. As you can see, I had quite a
few comments. Hopefully you now agree that pushing that code to Linus
right away wouldn't have been wise.

Thanks,
-- 
Jean Delvare
