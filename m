Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTKCVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTKCVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:55:28 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:45211 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263434AbTKCVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:55:20 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Egger <degger@fhm.edu>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1067878624.7695.15.camel@sonja>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
Content-Type: text/plain
Message-Id: <1067896476.692.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 08:54:36 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Interesting, will try. I've a whole bunch of more pressing problems with
> my new baby, though. X is completely broken, no matter which X modelines
> I configure I get nothing but sizzle on the screen, it seems that the
> mode setup for the LVDS with the 9600 Mobility is bork.

It works with up to date stuffs. That is my latest 2.6 tree with
radeonfb and XFree from CVS. Part of the problem is that the firmware
sets up a tiled display. I updated my radeonfb to "clear" the
various SURFACE_* translation registers (among other fixes).

> The clock scaling of the CPU also doesn't work; interestingly at 867 MHz
> it's not much faster the my old Ti PB 500 in dnetc RC-5 though the
> overall system has a lot faster design.

Yup. I need to figure that out. It's possible that it does like a G5,
that is boot full speed when you auto-boot and low speed when you boot
via OF user interface. There may be need for some thermal control as
well.

> Also I cannot boot it automatically from network because holding down N
> at bootup will not pick up a DHCP address, so I have to type quite a bit
> in OF. :(

The "N" thing is normal. Apple hacked so that only DHCP servers which
know about some special Apple extensions can be used when doing that.

The easy work around is to use the syntax:

enet:x.x.x.x,file

where x.x.x.x is the IP address of the TFTP server and file is the
filename. With that in boot-device (or typing boot enet: etc....),
the machine will obtain it's local IP from any DHCP or BOOTP server and
will then TFTP from the specified host.

Ben.


