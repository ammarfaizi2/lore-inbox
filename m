Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264405AbRFHXx3>; Fri, 8 Jun 2001 19:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264408AbRFHXxU>; Fri, 8 Jun 2001 19:53:20 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:58869 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S264405AbRFHXxP>;
	Fri, 8 Jun 2001 19:53:15 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: temperature standard - global config option?
Date: Fri, 8 Jun 2001 19:53:06 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGMEOOCIAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010608191600.A12143@alcove.wittsend.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Snip] (Mike writes a bunch a good stuff)

> 	Yes, bits are free, sort of...  That's why an extra decimal
> place is "ok".  Keeping precision within an order of magnitude of
> accuracy is within the realm of reasonable.  Running out to two decimal
> places for this particular application is just silly.  If it were for
> calibrated lab equipment, fine.  But not for CPU temperatures.
>
> 	Yes, APIs are difficult to change.  But can you honestly say
> that, even if we magically get off the shelf economical
> temperature sensors
> that are two orders of magnitude more accurate (without need of constant
> tracible recalibration - these things DO drift), that this level of
> precision would have any real meaning at all?  I would expect the
> CPU temperature to vary by a few hundreths of a degree just by how
> many people were sweating in the cube next to me.
>
[snip]
>
> 	Now...  That I can agree with and it would make absolute sense.
> Especially if we were discussing lab grade or scientific grade measure
> equipment and measurements.  In fact, that would be a requirement for
> any validity to be attached to measurements of that level of precision.
> But that's not what we are talking about here, is it?  We're not talking
> about a lab grade instrumentation API here, are we?  If we are, then
> everything changes.
>
> 	Mike

As someone who has been intimately involved in temperature measurement of
electronics, Mike has pretty much thoroughly addressed the issue.  Allow me
to add this:  You can go buy 12 "calibrated" temperature sensors
(commercial, not lab quality), and you will get 12 different temperatures.

When sampling the sensor (usually a thermocouple) in a motherboard, you have
at best 1% resistors being used in the surrounding support components,
+20%/-10% capacitors, A/Ds with +-1 LSB resolution, and worst of all, a
coupling to the CPU that is about as bad as it can get.  You've got an epoxy
housing of an inconsistent shape in contact with ceramic.  The actual
contact point is miniscule.  There's no thermal paste, and often, I've seen
the sensors not quite raised high enough to contact the chip (you should be
able to rack a business card across the empty socket and feel a slight
"bump" as you touch the sensor.  If not, you need to bend it up slightly, to
give better physical contact to the CPU).

But in spite of all this, you're not really measure the critical
temperature, which is junction tempature.  Yes, case tempature has *some*
correlation, but it's not ratiometric.  It can be affected by the mounting
of the motherboard (believe it or not, you can see over 1C different in
temperature between a vertical and horizontally mounted motherboard just
because of convection out from under the socket.

Yea, we would all love to truly know the CPU tempature down to a fraction of
a degree.  But it's useless information.  Kinda of like knowing your fan
speed to less than 100 RPM.  Voltages fluctuations of .1 volts can cause a
100+ RPM change in the fan speed.  All you really need to know that it's
turning a lot less than when it first was.  But I digress.

Temperature measurement is an art.  It requires having good sensors, good
conversion electronics, and good mechanical coupling (if you really doubt
this, look at the networks required to properly compensate any standard JK
thermocouple).  On top of ALL this mess, you have values being passed back
from the hardware that are improperly converted.  Ever wonder why the  BIOS
never exactly matches what you see from the 'sensors' program?  It's because
the adjustment factors in the config file are a best guess.

For the record, in the course of a normal day, I see my temperatures
fluctuate from 48C with the house A/C set to 73, to 56C when I open the
doors, and let it get up to 76 in the house.  That's 8C (14.4F) over a 3F
change in ambient.

--John

