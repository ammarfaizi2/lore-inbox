Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTIQVNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbTIQVNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:13:53 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:62375 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262821AbTIQVNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:13:01 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <Pine.LNX.4.44.0309172218210.25790-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309172218210.25790-100000@deadlock.et.tudelft.nl>
Message-Id: <1063833118.600.210.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 23:12:00 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The first thing to do is to check is if the clock programming code is the
> problem. Try to modprobe with "default_mclk=-1 default_xclk=-1" or use
> equivalent kernel command line options.

Trying video=atyfb:mclk:-1,xclk:-1, same result

Note that the xclk and mclk actually used by MacOS are 67.12Mhz, this
may be different from the values setup by the firmware, on those old
machines, the firmware uses 'approximative' values at best while the
MacOS driver has the optimal ones. (Those machines had MacOS partially
in ROM and never really went to the firmware for display except if
you use linux ;)


> If clock programming code should be blamed, the next step is to enable the
> debug define and check which clock registers are modified. You can
> try to revert my changes at mach64_ct.c line 375 and 433 to see if that
> changes something.

Reverting these didn't help neither

> If X corrects the display after starting, the problem might be due to the
> mode setting code. In that case the display should corrupt again when
> switching back to the console.

It does indeed.

Here's the debug output:

atyfb: using auxiliary register aperture
atyfb: 3D RAGE LT-G [0x4c47 rev 0x80] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 63 Mhz MCLK, 63 Mhz XCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF CLOCK_CNTL
7b23a040 87010182 003210b7 25000001     03000200      003807c0   00b00510   001a0a03
PLL cd d5 1a 14 72 03 40 fd 8e 9e 76 01 a6 00 00 00 06 a8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 cd d5 1a 14 72 03 40 fd
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
7b23a040 87010182 003210b7 25000001     03000200      003807c0   00b00510
PLL cd d5 1f 14 88 03 40 fd 8e 9e 76 01 a6 1b 00 00 06 a8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 cd d5 1f 14 88 03 40 fd
atyfb: monitor sense=51e, mode 7
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI


