Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUICHSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUICHSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269385AbUICHRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:17:37 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:14537 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S269327AbUICHQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:16:28 -0400
Date: Fri, 3 Sep 2004 15:17:15 +0200
From: Robert Schwebel <robert@schwebel.de>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903131715.GG1369@pengutronix.de>
References: <1094157190l.4235l.2l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1094157190l.4235l.2l@hydra>
User-Agent: Mutt/1.4i
X-Scan-Signature: 42bbff9a49f37f2d9c570ea1dc2e49e3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John, 

On Thu, Sep 02, 2004 at 08:33:10PM +0000, John Lenz wrote:
> This is an attempt to provide an alternative to the current arm
> specific led interface. This arm interface does not integrate well
> with the device model and sysfs.

I have written a GPIO device class driver for the same purpose; before
this goes into the kernel I think we should try to merge your attempts
with mine.

On embedded systems you normally have several things which are similar
to LEDs; embedded processors have quite a lot of general purpose I/O
pins. Normally you want some of the pins being used from userspace (like
'echo 1 > /sys/class/gpio/gpio5/level'), others are used from device
drivers. My framework offers a request_gpio() function similar to
request_gpio(), so the kernel can administrate these ressources. 

I suppose it is not too difficult to unify our drivers in a way that the
base mechanism is more abstract then LEDs (a GPIO pin can also represent
a power switch or whatever) and still can support your LED levels. 

I'll pull the gpio patch out of my working tree and post it here for
discussion. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
