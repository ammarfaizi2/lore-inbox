Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVFABTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVFABTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVFABTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:19:48 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:10625 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261162AbVFABTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:19:46 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] SPI core
Date: Tue, 31 May 2005 18:19:40 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311819.41105.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I've been wondering why there's not an SPI core too.

Couldn't this code look a lot more like standard driver model
code?  Sure, probing and init should work a bit differently
(probably driven mostly by static "this board has this chip
at this chipselect" declarations, like platform_device) but
I never got the impression the I2C model was expected to grow
into new subsystems ...

How does this compare to the AT91 SPI and spidev interfaces?
(I'm picking on those only because I know they exist and seemed
to work nicely when I tested them a while back.  And they're
a rather direct analogue of this "core" patch.)


Quoth NZG <ngustavson at emacinc.com>
> SPI is serial-peripheral interface. A very common 3 wire bus in embedded 
> systems, especially m68k arch's. That fact that it's not there already is 
> actually a little weird IMHO.

Also on ARM ... PXA, OMAP, AT91, and others support it.

MMC cards can be accessed using SPI, as can serial flash chips
including notably DataFlash (over which JFFS2 works, though not
yet in the kernel.org MMC code).

It'd make sense to me to have for example the DataFlash driver
(in the AT91 patches) work using such a standard API.  Likewise
to have a few basic chip drivers working in the framework before
it's merged.

What other drivers do you see getting added "soon" to this
framework?  That is, SPI drivers that's currently in use in 2.6
and so should arguably switch to shared infrastructure to
help get more review and code reuse.

- Dave

