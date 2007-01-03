Return-Path: <linux-kernel-owner+w=401wt.eu-S1751949AbXACApG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXACApG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbXACApG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:45:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:48271 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbXACApE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:45:04 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
In-Reply-To: <cdda01a9b094a86b24d8d192336f41e2@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
	 <20061231.124531.125895122.davem@davemloft.net>
	 <1167709406.6165.6.camel@localhost.localdomain>
	 <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
	 <1167768494.6165.63.camel@localhost.localdomain>
	 <459ABC7C.2030104@firmworks.com>
	 <1167770882.6165.76.camel@localhost.localdomain>
	 <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
	 <1167774438.6165.87.camel@localhost.localdomain>
	 <cdda01a9b094a86b24d8d192336f41e2@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 11:44:49 +1100
Message-Id: <1167785089.6165.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The biggest problem is the huge collection of workarounds we have
> for PowerPC alone already -- if that can be moved into some
> quirk collection thing, where certain quirks are only run on some
> systems, it might scale.

Well, if you notice, I've been moving most of such workarounds to
prom_init.c, that is, to the code that actually fetches the device-tree
from the firmware, which make things easier.

There are still a few, notably in prom_parse.c, but I'm pretty confident
they aren't too invasive (and I need to backport more fixes from david
there) and in macio_asic, but the later is specific enough to not be a
problem.

> You'll also have to deal with endianness finally (you can *not*
> access an integer property via an int*).

Yes, that's one big thing we'll need to do.

> It will be easiest to start with a biggish collection of hooks,
> that doesn't require too much code change, and slowly converge
> stuff.

Hooks ? How so ?

It's easier to start merging powerpc and sparc I reckon and then, "fix"
that so that it works on x86 :-)

> All properties can be changed, any new property can be created.
> Oh you mean after you killed OF -- yeah, it gets a bit harder
> then eh :-)

You know very well what I meant :-) The ones where it makes sense to
write them back to OF. On machines where OF dies, there are mecanism via
the nvram to store properties in /options (like boot-device etc...),
there are at least 2 such mecanisms (apple oldworld and chrp), and on
machines where OF is still alive, that should probably be an OF call of
some sort.

So we do want some sort of platform hook for -these-, but at the same
time, that's fairly low on the list. Currently, we have no code in the
kernel to deal with that on powerpc, it's all userland via /dev/nvram,
and I reckon it might just stay that way with platform specific userland
tools for a little longer.

Ben.
 

