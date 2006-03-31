Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCaKOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCaKOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWCaKOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:14:10 -0500
Received: from tim.rpsys.net ([194.106.48.114]:17326 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932089AbWCaKOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:14:08 -0500
Subject: Re: Hook collie frontlight into sysfs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, Bompart Cedric <cedric.bompart@thales-is.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060331082352.GF1663@elf.ucw.cz>
References: <6CE648B340455F479A7AE27769282663018A276F@gva0013.ch.intra>
	 <20060331082352.GF1663@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 11:13:45 +0100
Message-Id: <1143800026.6443.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 10:23 +0200, Pavel Machek wrote:
> Hi!
> 
> > During our test with Richard, we've been thinking can you implement the
> > full range of brightness intensity values? For example for the others
> > Zaurus, I think the range is between 0 and 63. So the userspace can
> 
> Well, I'm not sure if other values are "legal". They could damage
> frontlight long-term or just eat too much power...

For what its worth, these back/frontlight controllers are normally PWM
driven so the LED is always at full brightness and just the percentage
of time its turned on varies. These numbers in the driver control the
duty cycle of the PWM.

The original code for corgi/spitz only had a limited number of values
and I exposed the whole range into userspace. I doubt you can damage the
hardware with the different values. There are probably optimal points
for power consumption which is perhaps why Sharp limited the values
exposed. My view is that its up to userspace to limit the values for
optimal power consumption :).

> > adjust a wider range of levels for the backlight. Another thing, I
> > didn't see anything different visually between the value 3 and 4.
> 
> You are right, the code to go brightness 4 is attached. It probably
> needs to be converted to writel/readl...

This makes sense as on corgi/spitz there is also this magic bit to set
for the second level of brightness settings...

I'll have a look at these patches and perhaps combine/convert them to
the replacement backlight interface, then we can submit them to Antonino
Daplas/Andrew so all the backlight patches are in one place (currently
-mm).

Given what I've said above, would you be happy to expose the full range
of values to userspace?

Richard

