Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRHOFSB>; Wed, 15 Aug 2001 01:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271027AbRHOFRv>; Wed, 15 Aug 2001 01:17:51 -0400
Received: from d127.as16.nwbl1.wi.voyager.net ([169.207.90.129]:37893 "EHLO
	udcnet.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271018AbRHOFRk>; Wed, 15 Aug 2001 01:17:40 -0400
Date: Wed, 15 Aug 2001 00:17:50 -0500 (CDT)
From: root <root@udcnet.dyn.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: Pegasus driver fails to initialize when not a module
Message-ID: <Pine.LNX.4.30.0108142347420.16594-100000@udcnet.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chipsets: VIA KT133, VIA MVP4
Adapter: DLink DSB-650 (pegasus version, NOT the klsi one).
Drivers Used: usb-uhci -or- uhci, pegasus
Kernel Versions: 2.4.3, 2.4.6, 2.4.8, 2.4.8-ac2 (at least as far as I've tested).

Problem:
I've got a DLink DSB-650 USB net adapter based on the pegasus chipset. It
works fine when the driver is compiled as a module, but when the driver is
linked into the kernel, it fails to detect the adapter. The USB layer
initializes ok, and my USB keyboard and mouse are detected (although
doing this on a system with a PS/2 or AT kb/mouse changes nothing), but
the NIC is not, even though the pegasus driver prints out  it's loading
string and copyright message.

--ex--
pegasus.c: v0.4.19 2001/06/07 (C) 1999-2001:ADMtek AN986 Pegasus USB
Ethernet driver
usb.c: registered new driver pegasus
--ex--

After this, the kernel loads the net drivers, and (in my case) horks
because there is no eth0 to autoconfigure and mount a nfsroot filesystem
from.

However, on the same system with the same BIOS settings, and the only
change being that pagasus.c is compiled as a module (and not into the
kernel) it works perfectly, and I can use the USB adapter without trouble.

 This happens under either UHCI driver, and regardless of what USB options
are set. With debug on, I get a 'set_configuration_failed()' message from
pegasus under 'normal' uhci, and no notable error message under uhci-je.

My best guess is that either (a) something's wrong with the driver that
makes it not work when linked in, or (b) the driver is working, but is
dong it's initialization in the background, and is not
finishing in time to have eth0 ready for autoconfig/nfsroot (i.e. eth0
would appear some time after 'init' kicked off.

Any suggestions?

- Dave Acklam
  dackl@post.com

P.S. Yes, I read the lkml faq, the kernel docs, the source for
pegasus.c/pegasus.h, et al... Please don't shoot the first-time poster...

If you need the kernel config, I'll be happy to e-mail it to you

