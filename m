Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTK2Noc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 08:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTK2Noc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 08:44:32 -0500
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:57742 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S263769AbTK2Noa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 08:44:30 -0500
Date: Sat, 29 Nov 2003 14:42:20 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-rc5-pac1 released
In-Reply-To: <1070053162.12656.180.camel@pegasus>
Message-ID: <Pine.LNX.4.58.0311291431320.29214@dot.kde.org>
References: <Pine.LNX.4.58.0311281912290.20775@dot.kde.org>
 <1070053162.12656.180.camel@pegasus>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Nov 2003, Marcel Holtmann wrote:

> Hi Bernhard,
> 
> > - Increase timeout in firmware_class.c [several people reported timeout
> >   related problems with Netgear WG511 cards]
> 
> please tell me more about it.

Extract from the syslog of a user trying to use a Netgear WG511 with the 
prism54.org drivers in a Dell SmartStep 250N:

Nov 18 15:14:52 rumsfeldsux kernel: cs: cb_alloc(bus 4): vendor 0x1260, device 0x3890
Nov 18 15:14:52 rumsfeldsux kernel: PCI: Enabling device 04:00.0 (0000 -> 0002)
Nov 18 15:14:52 rumsfeldsux cardmgr[1098]: socket 1: CardBus hotplug device
Nov 18 15:14:52 rumsfeldsux default.hotplug[1837]: ======= START HOTPLUG FOR PID 1837 =======
Nov 18 15:14:53 rumsfeldsux kernel: Loaded prism54 driver, version 1.0.2.2
Nov 18 15:14:53 rumsfeldsux default.hotplug[1862]: ======= START HOTPLUG FOR PID 1862 =======
Nov 18 15:14:53 rumsfeldsux default.hotplug[1870]: ======= START HOTPLUG FOR PID 1870 =======
Nov 18 15:15:03 rumsfeldsux kernel: prism54: request_firmware() failed for 'isl3890'
Nov 18 15:15:03 rumsfeldsux kernel: eth1: could not upload firmware ('isl3890')

We got a similar report from someone using the same card in an Asus 
Pundit, and another from someone using a D-Link DWL-g650 A1 in a 
Gericom notebook.

Telling the users to

echo 100 >/proc/driver/firmware/timeout

and try again fixed it for all of them.

All 3 are using Ark Linux Dockyard, meaning 2.4.23-rcsomething-pacwhatever 
with a couple of extra patches and a fairly recent userland hotplug.

Due to lack of hardware I haven't yet figured out what the exact problem 
is (I'm suspecting either the prism54 driver takes forever to handle the 
firmware, or the hotplug scripts cause delays where they shouldn't), but 
increasing the timeout definitely solves the problem for our users.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
