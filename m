Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVILPG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVILPG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVILPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:06:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:38340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751389AbVILPGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:06:22 -0400
X-Authenticated: #271361
Date: Mon, 12 Sep 2005 17:06:18 +0200
From: Edgar Toernig <froese@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [udev/vcs] tons of creating/removing /dev/vcs* during boot
Message-Id: <20050912170618.69e18341.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

switching from SuSE's 2.6.11.4 to vanilla 2.6.13 I noticed
that I get tons of these lines in the log during boot:

udev[2124]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
udev[2121]: creating device node '/dev/vcs5'
udev[2124]: creating device node '/dev/vcsa3'
udev[2140]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
udev[2144]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
udev[2140]: creating device node '/dev/vcs3'
udev[2144]: creating device node '/dev/vcsa6'
udev[2147]: removing device node '/dev/vcs6'
udev[2149]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ...
udev[2158]: removing device node '/dev/vcs4'
udev[2157]: removing device node '/dev/vcsa3'
udev[2149]: creating device node '/dev/vcsa5'
udev[2172]: configured rule in '/etc/udev/rules.d/50-udev.rules[98]' ....
udev[2171]: removing device node '/dev/vcsa2'
udev[2172]: creating device node '/dev/vcs5'

It's caused by various loadkeys, setleds, etc performed early in an
init script.  It seems, that every open/close of a tty generates
a hotplug event for the appropriate vcs/vcsa device.  It stops at
the moment gettys are spawned.

Looking at the 2.6.11.4 source of drivers/char/vc_screen.c I see
that hotplug events are explicitly disabled for the vcs and vcsa
devices (not sure whether this was done by SuSE).  In 2.6.13 all
of that code is gone, including the class_simple that was used to
disable hotplug events.

How can I avoid all of these hotplug events?  Best would be of
course to generate only a single event at the same time the
tty device is create.  But I could also live with no hotplug
events for vcs* at all.

Ciao, ET.
