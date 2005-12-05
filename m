Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVLERCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVLERCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVLERCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:02:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36802 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932446AbVLERCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:02:35 -0500
Date: Mon, 5 Dec 2005 18:02:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Vrabel <dvrabel@cantab.net>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, John Lenz <lenz@cs.wisc.edu>
Subject: Re: [RFC PATCH 1/8] LED: Add LED Class
Message-ID: <20051205170234.GA25114@atrey.karlin.mff.cuni.cz>
References: <1133788166.8101.125.camel@localhost.localdomain> <439455BC.4080908@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439455BC.4080908@cantab.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This LED subsystem isn't usable with LEDs that are controlled by I2C
> GPIO devices.  Getting rid of (struct led_device).lock would go some way
> to making it work.  It's not clear to me why it's needed anyway.
> 
> Suspend and resume probably needs to be LED specific.
> 
> Richard Purdie wrote:
> > Index: linux-2.6.15-rc2/drivers/leds/Kconfig
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.15-rc2/drivers/leds/Kconfig	2005-12-05 11:29:19.000000000 +0000
> > @@ -0,0 +1,18 @@
> > +
> > +menu "LED devices"
> > +
> > +config NEW_LEDS
> 
> Is there a better name than NEW_LEDS?  It won't be 'new' for very long...

Well, there's chance to rename ARM leds to OLD_LEDS. :-).
 

> > Index: linux-2.6.15-rc2/include/linux/leds.h
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.15-rc2/include/linux/leds.h	2005-12-05 11:29:19.000000000 +0000
> > [...]
> > +	/* A function to set the brightness of the led.
> > +	 * Values are between 0-100 */
> > +	void (*brightness_set)(struct led_device *led_dev, int value);
> 
> 0-255 is probably a better range to use.  Might be worth having an enum
> like.

Well, don't overdo it, most LEDs are 0/1 anyway.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
