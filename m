Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292584AbSBZBCD>; Mon, 25 Feb 2002 20:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292586AbSBZBBy>; Mon, 25 Feb 2002 20:01:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57250 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292584AbSBZBBn>;
	Mon, 25 Feb 2002 20:01:43 -0500
Date: Mon, 25 Feb 2002 16:59:14 -0800 (PST)
Message-Id: <20020225.165914.123908101.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to announce the first test release of a new Broadcom Tigon3
driver written by Jeff and myself.  Get it at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3.patch.gz

The patch is against 2.4.18 but there is no reason it should be
difficult to apply this patch to any other tree.

It is meant to replace Broadcom's driver because frankly their driver
is junk and would never be accepted into the tree.  For an example of
why their driver is junk, note that the resulting object file from our
driver is less than half the size of Broadcom's.  That kind of bloat
is simply unacceptable.  Next, Broadcom's driver is still way
non-portable, ioremap() pointers are still dereferenced directly among
other things.  Finally, their driver is just plain buggy, they have
code which tries to use page_address() on pages which are potentially
in highmem and that is guarenteed to oops.

There are other problems with their driver too, just ask as I'm in a
good mood to grind my axe about this stuff :-)

We would also like to give Broadcom a big "no thanks" because
their lawyers refused to give Jeff the documentation for the Tigon3
chipset using an NDA that would allow him to write a GPL'd driver
based upon said documentation.  This means that all that we know about
the hardware has been reverse engineered from Broadcom's GPL'd driver
plus some experimenting.  It is why this driver has taken so long to
finish, because it is hard to find incentive for this kind of brack
breaking work when the vendor is totally uncooperative.

I personally think Broadcom has some hidden agenda that requires that
their driver be "the one".  So instead of just complaining about such
stupid policy, we've done something about it by doing our own driver
with all the problems fixed.

We'd really appreciate if people would test this thing out as hard
as they can.  I can tell you that I've personally only been able to
test out the following scenerios so far:

1) Both big-endian and little-endian platforms.
2) 64-bit on big-endian side, 32-bit on little-endian side.
3) IOMMU based PCI dma platform on 64-bit/big-endian side,
   non-IOMMU based PCI dma platform on 32-bit little-endian side.
4) 10baseT half duplex, 100baseT full duplex
5) Copper based connectors, as that is all that Jeff and I have.

Gigabit and fibre are the big areas where our testing has been
lacking.  We have also not done any tuning of the driver at all,
although we do consider the driver feature complete.
