Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTKBTXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTKBTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:23:42 -0500
Received: from badenpowell.cs.ubc.ca ([142.103.6.71]:2514 "EHLO
	badenpowell.cs.ubc.ca") by vger.kernel.org with ESMTP
	id S261782AbTKBTXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:23:41 -0500
Date: Sun, 2 Nov 2003 11:23:40 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: linux-kernel@vger.kernel.org
Subject: No backlight control on PowerBook G4
Message-ID: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.4 BAYES_01,USER_AGENT_PINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just bought a new PowerBook G4 and installed Linux on it.  Now the
tweaking begins!  One of the first orders of business is getting power
management working, and I'm a bit stuck.

I'm running kernel version 2.4.22 with Ben Herrenschmidt's 2.4.23-pre5
patches.

On startup, arch/ppc/platform/pmac_backlight.c doesn't recognize the
backlight controller.  It checks compatibility with a couple of specific
machines, and then checks compatibility with the backlight controller.
This appears to be the same check that is performed in the Darwin/xnu
kernel (at least the version that I found...).

I've got a bit of experience with kernel hacking so I'd be very happy to
help figure out what's going on and how to fix it, but I'm also new to
this platform and I don't know how one goes about finding hardware
documentation and other useful sorts of resources.

Any (non-null) pointers would be appreciated!

Cheers,
dstn.


Here are some details from /proc/device-tree that might be relevant (I've
used "/" as token separator):

in /:
model = PowerBook6,2
compatible = PowerBook6,2/MacRISC3/Power Macintosh

in /pci@f2000000/:
model = AAPL,UniNorth
compatible = uni-north

in /pci@f2000000/mac-io@17/:
model = AAPL,Keylargo
compatible = Keylargo

in /pci@f2000000/mac-io@17/backlight@f300/:
name = backlight
device_type = backlight
backlight-control = mnca               <---- ack!

in /pci@f2000000/mac-io@17/via-pmu@16000/:
name = via-pmu
compatible = pmu

in /pci@f2000000/mac-io@17/via-pmu@16000/power-mgt/:
compatible = via-pmu-99

