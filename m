Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281439AbRKTWZ0>; Tue, 20 Nov 2001 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281429AbRKTWZH>; Tue, 20 Nov 2001 17:25:07 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:18049 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S281439AbRKTWZF>; Tue, 20 Nov 2001 17:25:05 -0500
To: linux-kernel@vger.kernel.org
Subject: 3Com Carbus adapter need to be re-inserted before detection
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 21 Nov 2001 00:20:33 +0200
Message-ID: <87itc5axu6.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recall somebody reported, a month or a few ago, that he had 3Com
Cardbus ethernet-adapter, which needed to be inserted, removed and
then inserted again before network was set up properly. I didn't
follow that thread and wasn't able to find it now that I have exactly
the same problem. Did anybody have any solution to this?

I have experienced this problem with every kernel I have tried this
card with (2.4.9, 2.4.1[0-3]ac, 2.4.15pre[67]). When I boot my Dell
Latitude with the card (3CCFE575BT-D) inserted, it _does_ detect a
card in the socket:

Nov 21 00:01:00 puck cardmgr[188]: initializing socket 1
Nov 21 00:01:00 puck cardmgr[188]: socket 1: 3Com 3CCFE575B/3CXFE575B Fast EtherLink XL

At this point, the module 3c59x does not load. Also at this point the
adapter has 10BaseT led on, though my network is 100BaseT. 

Then I remove remove the card and insert it again:

Nov 21 00:02:07 puck kernel: cs: cb_free(bus 6)
Nov 21 00:02:07 puck cardmgr[188]: shutting down socket 1
Nov 21 00:02:07 puck /etc/hotplug/pci.agent: PCI remove event not supported
Nov 21 00:02:12 puck kernel: cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5157
Nov 21 00:02:12 puck kernel: PCI: Enabling device 06:00.0 (0000 -> 0003)
Nov 21 00:02:12 puck cardmgr[188]: initializing socket 1
Nov 21 00:02:12 puck cardmgr[188]: socket 1: 3Com 3CCFE575B/3CXFE575B Fast EtherLink XL
Nov 21 00:02:12 puck /etc/hotplug/pci.agent: Modprobe and setup 3c59x for PCI slot 06:00.0
Nov 21 00:02:12 puck kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Nov 21 00:02:12 puck kernel: 06:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x4800. Vers LK1.1.16
Nov 21 00:02:12 puck kernel: PCI: Setting latency timer of device 06:00.0 to 64
Nov 21 00:02:12 puck /etc/hotplug/net.agent: invoke ifup eth0

Now it now loads 3c59x and has the 100BaseT led on, but at this point
it still does not get the network up and running. (Meaning: ifconfig
still shows only loopback-interface up.)

So, let's remove and insert again:

Nov 21 00:02:24 puck kernel: cs: cb_free(bus 6)
Nov 21 00:02:24 puck cardmgr[188]: shutting down socket 1
Nov 21 00:02:24 puck /etc/hotplug/net.agent: invoke ifdown eth0
Nov 21 00:02:24 puck /etc/hotplug/pci.agent: PCI remove event not supported
Nov 21 00:02:26 puck kernel: cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5157
Nov 21 00:02:26 puck kernel: PCI: Enabling device 06:00.0 (0000 -> 0003)
Nov 21 00:02:26 puck kernel: 06:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x4800. Vers LK1.1.16
Nov 21 00:02:26 puck kernel: PCI: Setting latency timer of device 06:00.0 to 64
Nov 21 00:02:26 puck cardmgr[188]: initializing socket 1
Nov 21 00:02:26 puck cardmgr[188]: socket 1: 3Com 3CCFE575B/3CXFE575B Fast EtherLink XL
Nov 21 00:02:26 puck /etc/hotplug/net.agent: invoke ifup eth0
Nov 21 00:02:26 puck /etc/hotplug/pci.agent: Modprobe and setup 3c59x for PCI slot 06:00.0
Nov 21 00:02:29 puck kernel: eth0: Setting full-duplex based on MII #0 link partner capability of 45e1.

Now everything works like a charm.

What should I look at in order to find out what's going on here?

The current kernel is 2.4.15pre7 and the hotplug-utilities are from
Debian package with versioned as 0.0.20010919-2.

Suonp‰‰...
