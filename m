Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVBIQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVBIQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 11:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVBIQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 11:59:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:51855 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261850AbVBIQ7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 11:59:11 -0500
Date: Wed, 9 Feb 2005 18:00:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209170015.GC16670@ucw.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A0ECF.3090406@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 01:23:27PM +0000, Paulo Marques wrote:
> Vojtech Pavlik wrote:
> >Hi!
> >
> >I've written a driver for probably the most common touchscreen type -
> >the serial Elo touchscreen.
> 
> If we are serious about getting support for serial touchscreens into the 
> kernel, I can certainly give a hand there.

I want serious support for ALL touchscreens in Linux.

> I work for a company that develops software for restaurants, and we have 
> a Linux port of our main application running in actual restaurants with 
> a custom made Linux distribution for about 2 years now.
> 
> We had to support a number of touchscreens, and we do it in the 
> application itself, reading the serial port and processing the data.
> 
> If this could go into the kernel, then our application needed only to 
> read the input device, and handle events, no matter what touch screen 
> was there. That would be a great improvement :)

And I'm glad there is interest. :)

> I have one that uses the 10 byte protocol (I've never seen one ELOtouch 
> that used one of the other protocols). I can give you some feedback as 
> soon as I have some time to test it.
> 
> >[...]
> >+		case 9:
> >+			if (elo->csum) {
> >+				input_regs(dev, regs);
> >+				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
> >+				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
> >+				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
> >+				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
> 
> This one is weird. In my code I have this:
> 
> >            button = ((buf[2] & 0x03) != 0);

My documentation doesn't seem to say anything about the Status (buf[2])
byte. If a touch bit is reported there, then great, I'll change the
driver to use that.

Right now the driver uses the Z value to tell if the screen is touched
or not.

> So maybe, ELO touchscreens that don't have pressure sense output, only 
> send "touch down / up" information on the 2 LSB's of the third byte(?)

That's very likely.

> Anyway, inputattach should have a command line option to set the 
> baudrate manually, as some of these touchscreens have configurable 
> baudrates, and some POS manufacturers set them to non-default values.

That's rather easy to do.

> Also, I've already seen touchscreens where the POS manufacturer got the 
> pin-out wrong (or something like that) so the touch reports the X 
> coordinate where the Y should be, and vice-versa. I really don't know 
> where this should be handled (driver, input layer, application?), but it 
> must be handled somewhere for the applications to work.

I think the best place would be in the X event driver, if X is used, or
the graphics toolkit, and worst case the application.

I don't believe the mirroring/flipping is kernel's job, since it tries
to always pass the data with the least amount of transformation applied
to achieve hardware abstraction.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
