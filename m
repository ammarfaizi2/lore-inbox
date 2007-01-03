Return-Path: <linux-kernel-owner+w=401wt.eu-S1752476AbXACFFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbXACFFv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 00:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXACFFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 00:05:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:35746 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXACFFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 00:05:51 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: jengelh@linux01.gwdg.de, segher@kernel.crashing.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, wmb@firmworks.com,
       jg@laptop.org
In-Reply-To: <20070102.203828.70220767.davem@davemloft.net>
References: <20070102.140749.104035927.davem@davemloft.net>
	 <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
	 <Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr>
	 <20070102.203828.70220767.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 16:05:31 +1100
Message-Id: <1167800731.6165.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In fact, the 'ok' prompt is an ENORMOUS pain in the ass to support
> on machines with USB keyboards, because sharing the USB host
> controller is beyond non-trivial.  I've never implemented support
> for that on sparc64 and I frankly have no desire to do the work
> necessary to support that.  It simply is not worth it.

I was wondering about that .... :-)

Device sharing with a "live" OF is just an absolute pain in the ass and
I'm actually pretty happy not to have to do it. Segher and I, and more
recently, paulus and I, have been discussing about ways to deal with it
or make a version of SLOF (segher's pet OF implementation) that could
stay alive but the more I think about the burden, the more I'm inclined
to just give up...

There have been a recurring need for system vendors to provide
"firmware" type code to be called from the OS or to co-exist with the OS
though. Wether that's a good idea or not or wether those vendor
justifications for that are valid or not is of course debatable ;-)

Some of those attemptes resulted in horrors ranging from SMM BIOSes to
RTAS, via ACPI AML stuff or even worse, Apple's platform function
"scripts" in the device-tree.

I think every single of these approaches have proven that it actually
caused more problems than it solves.

Most of the time, the goal is to actually ease the OS work by
abstracting dodgy motherboard bits, like all the random IOs to toggle to
enable clocks on a given bus for power management etc... But every time,
it's been abused as a way to hide implementation details or hardware
specs, and everytime, bugs in those "firmware" provided blobs have
proven more damageable than having clear documentation for the HW and
proper driver code to deal with it.
 
Ben.

