Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWCQD4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWCQD4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 22:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWCQD4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 22:56:23 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:1497 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751030AbWCQD4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 22:56:22 -0500
Date: Thu, 16 Mar 2006 22:56:16 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne_lorrain@yahoo.fr>,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] sis96x compiled in by error: delay of one minute at boot
Message-ID: <20060317035616.GA3446@jupiter.solarsys.private>
References: <20060316035916.GA10675@jupiter.solarsys.private> <3ZH07HE0.1142498811.4526410.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ZH07HE0.1142498811.4526410.khali@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean:

> On 2006-03-16, Mark M. Hoffman wrote:
> > Loading it with the default could be considered an accident by
> > definition. It takes ~6 seconds to load all of
> > kernel/drivers/hwmon/*.ko on a test box here with i2c-parport-light
> > present (but without any adapter hardware). With this patch, that
> > drops to ~1 second.

* Jean Delvare <khali@linux-fr.org> [2006-03-16 09:46:51 +0100]:
> Note that the same result could be achieved by using
> i2c_algo_bit.bit_test=1, which is why I was suggesting to make it the
> default. Doing so would also help the radeonfb driver users: this one
> creates up to 4 i2c busses and at least one does not work for me (I
> guess it depends on how the chip was wired on the graphics adapter),
> causing significant delays on when loading i2c chip drivers afterwards.
> 
> I wonder if i2c_algo_bit.bit_test=1 can cause problems. Why wasn't it
> made the default in the first place?

It doesn't look very reliable to me.  E.g. if there happens to be bus
traffic during the bus test, it fails.  If it gets past that, it gets
worse... 

	5. A START condition immediately followed by a STOP condition
	(void message) is an illegal format.
		- I2C Bus Specification, Version 2.1 (page 14)

Unless I read it wrong, that's exactly what the bus test will do.

> > This patch forces the user to specify what type of adapter is present
> > when loading i2c-parport or i2c-parport-light.  If none is specified,
> > the driver init simply fails - instead of assuming adapter type 0.
> >
> > This alleviates the sometimes lengthy boot time delays which can be
> > caused by accidentally building one of these into a kernel along with
> > several i2c slave drivers that have lengthy probe routines (e.g. hwmon
> > drivers).
> 
> This makes sense, no adapter type is more likely to be found than the
> others. So I like the patch and am willing to accept it. However, given
> that it changes the default behavior, and makes the "type" module
> parameter mandatory, a short notice in the documentation and/or Kconfig
> would be welcome, don't you think?

OK - patch to follow.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

