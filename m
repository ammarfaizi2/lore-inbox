Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVBIVxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVBIVxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBIVxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:53:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:43431 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261936AbVBIVxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:53:06 -0500
Date: Wed, 9 Feb 2005 22:53:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209215335.GA2634@ucw.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209213930.GM10594@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 10:39:30PM +0100, Jan-Benedict Glaw wrote:
> On Wed, 2005-02-09 20:51:43 +0000, Paulo Marques <pmarques@grupopie.com>
> wrote in message <420A77DF.6040108@grupopie.com>:
> > Jan-Benedict Glaw wrote:
> > >On Wed, 2005-02-09 18:08:10 +0000, Paulo Marques <pmarques@grupopie.com>
> > >wrote in message <420A518A.9040500@grupopie.com>:
> > >That's IMHO not brain-damaged, but pure physics: just consider scratches
> > >or dust (or other substances) applied to the touch foil. This happens
> > >all the time, so the touch screen gets out of calibration. This won't
> > >happen on a screen used only twice a day. But think about a touch screen
> > >that's tortured all the day with pencils, finger rings, dirty fingers,
> > 
> > The brain-damaged part wasn't the calibration. It was the calibration 
> > being done in the touchscreen itself, instead of letting the PC handle 
> > it for them. We will always need calibration, of course.
> 
> Again, you cannot map 0..\inf Ohm or 0..\inf nF to a given set
> [0..0xffff] of coordinates. The physical characteristics of touchscreens
> *can* change, so you need to recalibrate the A/D converter itself.

Both 4-wire and 5-wire resistive touchscreens work as voltage dividers.

Thus the chip doesn't have to care about the total resistance, it just
applies voltage on two wires and the voltage on the other two
corresponds proportionally to the position. That's one axis measurement.
For the other axis, the role of the wires is simply swapped.

For capacitive touch sensors it's very much different, and the
controller usually is matched to the sensor, since the sensor usually has
several electrodes, so the controller 'knows' about the sensor because
they were manufactured together.

Regarding surface wave sensors, I'm not completely sure about the need
of calibration to get the range there. I'd assume that since they
measure wave reflections from reflector fins, and they know the number
of the fins (== number of reflections), that they'll be able to stretch
the range properly as well.

> > We let the touch screen send the widest range it can muster, so that we 
> > don't have quantization errors. We then calibrate in software as for any 
> > other touch screen, using the coordinates sent as "raw data".
> 
> That cannot be done. Just hit a resistor-based touchscreen once with a
> hammer. You'll probably see that you need a physical recalibration
> then... Or flood it with water-solved citronic acid and let is on the
> screen for some days. That's funny, but it's real life...

You'll need a new touchscreen most likely. The hammer will break the
glass if you hit it properly, and if the citric acid gets between the
resistive layers, you get nonlinear distortion of the resistivity and
that cannot be calibrated for.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
