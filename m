Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVBIR3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVBIR3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVBIR3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:29:55 -0500
Received: from styx.suse.cz ([82.119.242.94]:29073 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261855AbVBIR3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:29:25 -0500
Date: Wed, 9 Feb 2005 18:30:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209173026.GA17797@ucw.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209171438.GI10594@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 06:14:38PM +0100, Jan-Benedict Glaw wrote:

> > I want serious support for ALL touchscreens in Linux.
> 
> Maybe I'd write drivers for the T-Sharc and fujitsu controllers, too.
> These are in a lot of POS hardware, too, and sometimes they're a pain to
> use (esp. calibration).

Well, if you write them, send them my way. :)

> If I find a minute, I'll possibly give it a test run. I've got actual
> hardware around.

Thanks!

> > > Also, I've already seen touchscreens where the POS manufacturer got the 
> > > pin-out wrong (or something like that) so the touch reports the X 
> > > coordinate where the Y should be, and vice-versa. I really don't know 
> > > where this should be handled (driver, input layer, application?), but it 
> > > must be handled somewhere for the applications to work.
> > 
> > I think the best place would be in the X event driver, if X is used, or
> > the graphics toolkit, and worst case the application.
> 
> First of all, we need a really properly working Linux event driver in
> XFree86/X.Org.  I'm not sure if this is already the case.

There is 'evtouch'. It's probably not perfect, but a good start.

> > I don't believe the mirroring/flipping is kernel's job, since it tries
> > to always pass the data with the least amount of transformation applied
> > to achieve hardware abstraction.
> 
> ACK. Should be handled by XFree86's driver.
> 
> Additionally, there are two other things that need to be addressed (and
> I'm willing to actually write code for this, but need input from other
> parties, too:)
> 
> 	- Touchscreen calibration
> 		Basically all these touchscreens are capable of being
> 		calibrated. It's not done with just pushing the X/Y
> 		values the kernel receives into the Input API. These
> 		beasts may get physically mis-calibrated and eg. report
> 		things like (xmax - xmin) <= 20, so resolution would be
> 		really bad and kernel reported min/max values were only
> 		"theoretical" values, based on the protocol specs.
> 
> 		I think about a simple X11 program for this. Comments?

How would the program communicate with the devices?

> 	- POS keyboards
> 		These are real beasties. Next to LEDs and keycaps, they
> 		can contain barcode scanners, magnetic card readers and
> 		displays. Right now, there's no good API to pass
> 		something as complex as "three-track magnetic stripe
> 		data" or a whole scanned EAN barcode. Also, some
> 		keyboards can be written to (change display contents,
> 		switch on/off scanners, ...).

We probably don't want magnetic stripe data to go through the input
event stream (although it is possible to do that), so a new interface
would be most likely necessary.

> 		This is usually "solved" with a little patch that allows
> 		userspace to write to the keyboard (/dev/psaux like),
> 		but this is a bad hack (just look at the patches
> 		floating around for this...).


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
