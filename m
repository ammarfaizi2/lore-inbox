Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTESSJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTESSJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:09:42 -0400
Received: from h-64-105-35-70.SNVACAID.covad.net ([64.105.35.70]:15488 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S262609AbTESSJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:09:40 -0400
Date: Mon, 19 May 2003 11:21:47 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305191821.h4JILlE12026@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk1[23] kconfig loop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        If I run "make oldconfig" under linux-2.5.69-bk12
and select "m" for CONFIG_USB_GADGET, I am asked a question
or two about USB gadget interfaces that I might want, and
then the build process gets into an infinite loop.  If I set
CONFIG_USB_GADGET to "n", then everything is fine.

        I expect there is no input that is supposed to cause
"make oldconfig" to go into an infinite loop, so this must at
least be a kconfig bug.  Here is a transcript of the interation
that leads to the infinite loop:


Support for USB Gadgets (USB_GADGET) [N/m/y/?] (NEW) m
  USB Peripheral Controller Support
    NetChip 2280 USB Peripheral Controller (USB_NET2280) [N/m/?] (NEW) m
  USB Gadget Drivers
    Gadget Zero (DEVELOPMENT) (USB_ZERO) [N/m/?] (NEW) m
    Ethernet Gadget (USB_ETH) [N/m/?] (NEW) m
[Infinite loop starts here.  The following lines repeat forever,
non-interactively.  They just go scrolling by.]
*
* Restart config...
*
*
* Support for USB Gadgets
*
Support for USB Gadgets (USB_GADGET) [M/n/y/?] m
  USB Peripheral Controller Support
    NetChip 2280 USB Peripheral Controller (USB_NET2280) [M/n/?] m
  USB Gadget Drivers
    Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
make: *** [oldconfig] Interrupt


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
