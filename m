Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbTISHla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTISHla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:41:30 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:16603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261420AbTISHlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:41:24 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0309190902480.17132-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309190902480.17132-100000@deadlock.et.tudelft.nl>
Message-Id: <1063957248.603.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 09:40:48 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Indeed, we cannot change clocks because of results of only one machine. It
> just makes me wonder. Perhaps the best thing to do is to check this with
> ATi too.

I need a brown paper bag here. A while ago (maybe 3 years), ATI send me
a list of RefClk/MCLK/XCLK for their entire line of Mac chips with the
Open Firmware node name so we could identify them. Some way, I lost that
list (disk crash)... It was covering all "Mac" mach64 boards and a bunch
of the r128 ones iirc. We don't need that as badly on recent machines as
recent ATI cards provide the RefClk in the device-tree and we don't need
to mess with the MLCK/XCLK any more on radeons.

> Okay.... By the way, how shall we get the powermanagement code to work on
> x86? As far as I saw that register backlight procedure exists only on PowerPC.

The backlight "core" is a simple thing I did for PowerBook (since the
backlight can be either done by the ATI chip or by some other uController
on the motherboard). This current implementation is only suitable for
a single panel and isn't something worth extending I beleive.

Better would be to add proper backlight/frontlight/contrast control to
2.6 via the generic monitor infrastructure, maybe via sysfs. This covers
more than just laptops: Flat panels on ADC/DVI can have USB controlled
backlight, things like CRT iMacs have a chip that allow to control
brightness & all of the geometry settings via i2c etc... We would need
a common interface to userland for these at least, even if the actual
implementation in the drivers is full of platform specific hooks, there
is not much we can do about it for now I'm afraid.

The sleep code is something specific to the way those chips are put
to sleep on Macs. AFAIK, their clock is removed but not their power.
I don't know if that can be useful on any x86 laptop...

Ben.


