Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUEYNpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUEYNpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbUEYNpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:45:49 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:21520 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S264763AbUEYNpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:45:47 -0400
Date: Tue, 25 May 2004 15:45:45 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: PCI / CardBus problems
Message-ID: <Pine.LNX.4.33.0405251450320.2442-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running out of (reasonable) ideas with this problem. The only thing I
can do now is to ask help from the Highest Summit:-)

Setup: an ARM PXA255 board with an IT8152 PCI companion chip and a PCI4520
cardbus controller. Kernel 2.4.21 (sorry...) A couple of devices on PCI-0:
IT8152-internal USB OHCI, a RTL8139 chip, a graphics controller, and the
cardbus.

Problem:
test 1. Run some load on USB, RTL, insert a 16-bit PCMCIA card in a
cardbus slot and put some load on it - everything works.

test 2. Do not load USB, RTL, insert a 32-bit CardBus card, e.g. a Xircom
eth, connect to 100MBps, put load - works.

test 3. Load USB, but do not put load, insert 32-bit Xircom, put load on
it. Works in the beginning, but then starts losing packets, slowly becomes
unusable. The higher the load - the faster it degrades.

test 4. Load USB, insert a CardBus USB2.0 (EHCI + OHCI) card, insert a
USB BT module in the card, configure it (hciconfig hci0 up), scan (hcitool
scan), so far everything works, but first by a l2ping attempt get a BUG()
in dma_to_ed_td(). Same in internal USB (OHCI too) works. Similarly, other
USB devices work "partly".

So, either PCI-0 alone (possibly with 16-bit PCMCIA in the cardbus), or
PCI-1 alone work. Simultaneously - not.

So, the question - what can it be? PCI misconfiguration? Timing?
Electrical problems on the bus?...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany



