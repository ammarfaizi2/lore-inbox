Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUI0Un5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUI0Un5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUI0UnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:43:03 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:13441 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S267362AbUI0UkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:40:25 -0400
Subject: thinkpad issue --No PCMCIA hotplug activity when onboard nic
	(e1000) down
From: Dax Kelson <dax@gurulabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com,
       dahinds@users.sourceforge.net
Content-Type: text/plain
Message-Id: <1096317629.4075.65.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 14:40:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Myself and a co-worker have two ThinkPads bought a few months apart. The
two model numbers are:

2373-KUU -- T42p 14" LCD
2373-CXU -- T42 15" LCD

Both have the following onboard NIC and cardbus controller
02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)

The issue:

Observed on both Laptops, under multiple distributions (Fedora
1/2/rawhide, SUSE 9.1, Debian Sarge) including 2.6.9-rc2.

Inserting a PCMCIA/Cardbus device (tried a few different cards) results
in no activity, dmesg output, or hotplug event. In order to recognize
the card, a manual invocation of "cardctl insert" must occur.

First (really strange) datapoint:

If the onboard nic has an IP address and is UP, then PCMCIA hotplug
works great! I can unplug and plug cards in, the drivers load, hotplug
runs and everything works as expected.

If I turn down the onboard NIC, "ifconfig eth0 down", then PCMCIA
hotplug stops working, bring the onboard NIC back up "ifconfig eth0 up",
then PCMCIA hotplug starts working again.

The IP address may be irrelevant, it may just need to be "up", but I
haven't tested that.

It took a long time to stumble on to this correlation.

Second datapoint:

If the card is inserted before powering on the laptop, the card will be
detected and drivers loaded during boot as expected independent of the
status of the onboard NIC.


Third datapoint:

Out of the box, nearly everything is using IRQ 11. I've spread things
around, but no change in behavior.

Fourth datapoint:

Running "cardctl insert" doesn't always work. The driver for the
PCMCIA/Cardbus devices seems to load partway (not all of the normal
printk's are seen), and any attempt to access the device (with ifconfig,
iwconfig, etc) results in a hang of that command. A reboot is required
to clear things up.

Fifth datpoint:

Windows XP has no troubles with PCMCIA.

Any and all help greatly appreciated,

Dax Kelson

