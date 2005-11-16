Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbVKPVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbVKPVfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbVKPVfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:35:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4088 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030503AbVKPVfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:35:50 -0500
Date: Wed, 16 Nov 2005 14:36:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Jean Delvare <khali@linux-fr.org>, "Mark A. Greer" <mgreer@mvista.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-ID: <20051116213623.GF30014@mag.az.mvista.com>
References: <6dEExmJ9.1132154398.1580970.khali@localhost> <437B61B1.50003@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437B61B1.50003@varma-el.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 07:43:29PM +0300, Andrey Volkov wrote:

<snip>

> > Same reasonment holds for the m41t00 vs. m41t85 choice. You can't decide
> > at compilation time. If we go for a common driver, it has to support
> > both devices at the same time. Mark suggested to use platform-specific
> > data. I'm not familiar with this, but it sounds reasonable.
> It's pity, but all chips of m41xx family (approx. 20 members) have same
> i2c slave address (0x68) and have not some hwd model specific id
> registers. Hence I couldn't made any clue about chip specific
> regs/pins/... at run-time

The hope is that your platform determines the type of rtc chip and then
passes that into the m41txx driver.  If your platform can have different
rtc chips and no way to determine which one is there at runtime, we have
a problem.

> (and couldn't use two or more chips in one i2c subnet :)).
> And the situation worsens, as various chips have various
> time regs offsets, as ex. REG_SEC of m41t00 have offset 0, but
> in m41t85 _SAME_ REG_SEC have offset 1, etc (God, who in ST was so,
> hm, ...., so made such decision?).

I'll peruse the datasheets to see how feasible it is to merge.  At this
point, I think its possible but that may be my ignorance talking.

> So I coldn't see any suitable run-time method of detection which
> function driver could use for current "unknown" m41xx chip (from driver
> probe point of view) whithout Kconfig/module parameter prompting.

See above.

> > I don't know for sure at this point whether having a single driver is
> > the right choice, I'll let you and Mark check it out and decide. But
> > the right way to determine this is definitely not through the use of
> > #if/#endif preprocessing stuff.
> IMHO - single driver for all m41xx will be nice thing, but I'm not
> sure that it will not be monster- alike when it be released.

Understood.  I'll see what I can come up with.  If it looks reasonable,
I'll run it past everyone.

Mark
