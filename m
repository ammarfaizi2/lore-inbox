Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWHBU1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWHBU1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWHBU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:27:36 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:22206 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932151AbWHBU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:27:35 -0400
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Wed, 2 Aug 2006 12:18:29 -0700
User-Agent: KMail/1.7.1
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607311653.48240.david-b@pacbell.net> <20060802175044.3d47d85b.khali@linux-fr.org>
In-Reply-To: <20060802175044.3d47d85b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608021218.30763.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 8:50 am, Jean Delvare wrote:

> >  - The FIXME about choosing the address is very low priority,
> >    ...
> 
> Given that the slave mode isn't supported by Linux at the moment, I
> don't even see how this is relevant. (So I agree with you that this is
> very low priority - I would even kill that part of the code.)

Killing it might be the right thing to do, but someone should double
check against omap 1510 errata ... on first principles that should be
either a workaround for a very old erratum, or else a bug that's been
sitting around for a long time.  (Possibly making one of your other
points!)  The earliest versions of that driver were pretty crappy,
and I could imagine that mechanism was left unchanged since, unlike
a lot of stuf you didn't see, this wasn't actively buggy.


> >  - Likewise with the REVISIT for the bus speed to use.  They'd
> >    be fixed with the same patch.
> 
> I don't see any relation with the slave address mechanism. The bus
> speed is a simple parameter, internal to the device (i2c-core doesn't
> care) so it should be very easy to move it to platform data. Not that I
> really care, though.

The relation is that they'd both be per-board mechanisms that
belong better with platform data.  (Unless of course setting that
one address is not really needed.)


> >  - The REVISIT about maybe a better way to probe is also low
> >    priority; someone with a board that needs better probing
> >    could address it at that time.  (Then restest any changes
> >    on multiple generations of silicion ... which IMO is the
> >    role the linux-omap tree should play.)
> 
> No, it's not low priority, it's a blocker. I can't let that code go in.
> The driver must do what it is told to do. If it can't, it must fail.

Well for the record that's not been reported as a problem ... that is,
nobody's reported a board where that matters.  We'd have to see if the
driver is even usable without that, since the I2C stack overall seemed
to require probing to work.

(There's a separate issue about how the I2C stack doesn't just have a
mechanism to just declare "this board has these chips, these addresses",
so I2C drivers have needless reliance on probing...)


> Yes, this means no (in-kernel) probing on this bus at the moment. Blame
> it on the hardware manufacturer (if the chip actually can't do it.) In
> user-space, i2cdetect can be told to use byte reads for probing.

The spec does say it's tested for zero after decrementing the count,
so a value of zero gives a 65536 byte transfer.

 
> >  - The revisit about adap->retries is still up in the air,
> >    and was a question in my submission from last year.
> >    How exactly is that supposed to be used?  Right now
> >    it's neither initialized (except to zero) nor tested.
> 
> This is an optional feature, most i2c adapter drivers don't implement
> it. I'm fine without it, this can always be implemented later if needed.

Good.  Komal, please update the comment accordingly ... it'd be
handy if kerneldoc or Documentation/i2c/* said that adap->retries
is optional, and said what it's supposed to do.


> I just sent my own review of the code. As you can see, I had quite a
> few comments. Hopefully you now agree that pushing that code to Linus
> right away wouldn't have been wise.

My main concern was that the process had stalled, for an essential
driver.  It's not stalled any more, assuming Komal makes time to
address those comments!

- Dave

