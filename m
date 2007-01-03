Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbXACP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXACP7T (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbXACP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:59:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:54355 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbXACP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:59:18 -0500
In-Reply-To: <1167800731.6165.110.camel@localhost.localdomain>
References: <20070102.140749.104035927.davem@davemloft.net> <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org> <Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr> <20070102.203828.70220767.davem@davemloft.net> <1167800731.6165.110.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8550b245c633c112d13a0aa7c764eadb@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 16:59:40 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In fact, the 'ok' prompt is an ENORMOUS pain in the ass to support
>> on machines with USB keyboards, because sharing the USB host
>> controller is beyond non-trivial.  I've never implemented support
>> for that on sparc64 and I frankly have no desire to do the work
>> necessary to support that.  It simply is not worth it.
>
> I was wondering about that .... :-)
>
> Device sharing with a "live" OF is just an absolute pain in the ass and
> I'm actually pretty happy not to have to do it.

Yep.  The sane thing to do is to simply _not_ share devices,
use some debug serial / enet / whatever port exclusively for
OF, and/or only share easily sharable devices.  Some resources
_have_ to be shared of course (CPU, memory, MMU, system timer),
but there are OF bindings that describe how to do that in detail.

It gets bloody hard to do things at all if some OF implementation
c.q. some OS implementation doesn't play along of course :-/

> Segher and I, and more
> recently, paulus and I, have been discussing about ways to deal with it
> or make a version of SLOF (segher's pet OF implementation)

I object to the word "pet".  And it's not my property, anyway.

> that could
> stay alive but the more I think about the burden, the more I'm inclined
> to just give up...

But I'm not.  All I'm asking for is that you don't needlessly
make things hard / impossible for me.  It's a bit of an
engineering challenge already ;-)

> There have been a recurring need for system vendors to provide
> "firmware" type code to be called from the OS or to co-exist with the 
> OS
> though. Wether that's a good idea or not or wether those vendor
> justifications for that are valid or not is of course debatable ;-)
>
> Some of those attemptes resulted in horrors ranging from SMM BIOSes to
> RTAS, via ACPI AML stuff or even worse, Apple's platform function
> "scripts" in the device-tree.

All those things essentially work like a black box; you have no
idea what they do, what resources they use, etc.

> I think every single of these approaches have proven that it actually
> caused more problems than it solves.

Yes exactly.

> Most of the time, the goal is to actually ease the OS work by
> abstracting dodgy motherboard bits, like all the random IOs to toggle 
> to
> enable clocks on a given bus for power management etc... But every 
> time,
> it's been abused as a way to hide implementation details or hardware
> specs,

Yes.

> and everytime, bugs in those "firmware" provided blobs have
> proven more damageable than having clear documentation for the HW and
> proper driver code to deal with it.

And partially it's because you're just not calling them correctly --
not necessarily your fault, documentation tends to be severely
lacking.


Segher

