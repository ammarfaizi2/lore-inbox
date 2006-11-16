Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424554AbWKPX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424554AbWKPX0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424267AbWKPX0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:26:05 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:8584 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1424554AbWKPX0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:26:02 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] usb: generic calibration support
Date: Fri, 17 Nov 2006 00:24:32 +0100
User-Agent: KMail/1.7.2
Cc: daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <200611161125.38901.hs4233@mail.mn-solutions.de>
In-Reply-To: <200611161125.38901.hs4233@mail.mn-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170024.33248.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1378;
	Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Thursday 16 November 2006 11.25, Holger Schurig wrote:
> From: Holger Schurig <hs4233@mail.mn-solutions.de>
> 
> Generic calibration support for usbtouchscreen.
> 
> Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>
> 
> ---
> 
> With build-in calibration support, the "swap_xy" kernel parameter
> vanishes and usbtouchscreen instead gains a new kernel-parameter
> which holds 7 integers.
> 
> This is used to calibrate the resulting output of the driver. Let
> x_o and y_o be the original x,y coordinate, as reported from the
> device. Then x_r,y_r (the x,y coordinate reported to the input event
> subsystem) are:
> 
>     x_r = ( a*x_o + b*y_o + c ) / s
>     y_r = ( c*x_o + d*y_o + e ) / s
> 
> The default values for (a,b,c,d,e,s) are (1,0,0,0,1,0,1). To
> simulate swap_xy, one would set them to (0,1,0,1,0,0,1). Once can
> also use swap_x or swap_y alone, or define other, linear
> transpositions. The algorithm used is the same as in Qt/Embedded
> 3.x for the QWSCalibratedMouseHandler.
> 
> This interface allows re-calibration at runtime, without
> restarting the X-Server or any other event consumer.
> 
> 
> Please review this patch and schedule it for inclusion once 
> 2.6.19 comes out.

sorry, but i have to give you a big NACK on that one:
- no more modparam: it should be per-device sysfs attributes
  (swap_xy is basically only for touchkitusb compatibility and shoud be
   converted to per-device sysfs attribute as well. i just never got to
   do it)
- calibration can be handled in userspace just fine
- even for in-kernel it's in the wrong place. there are other devices
  that report raw absolute data...so it would belong to the input layer

Cc'ing Dmitry Torokhov as he might have some comments about calibration
support in the input layer.

thanks, rgds
-daniel
