Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136463AbRAHBl6>; Sun, 7 Jan 2001 20:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136512AbRAHBls>; Sun, 7 Jan 2001 20:41:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32904 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136463AbRAHBlk>;
	Sun, 7 Jan 2001 20:41:40 -0500
Date: Sun, 7 Jan 2001 17:24:24 -0800
Message-Id: <200101080124.RAA08134@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've put a patch up for testing on the kernel.org mirrors:

/pub/linux/kernel/people/davem/zerocopy-2.4.0-1.diff.gz

It provides a framework for zerocopy transmits and delayed
receive fragment coalescing.  TUX-1.01 uses this framework.

Zerocopy transmit requires some driver support, things run
as they did before for drivers which do not have the support
added.  Currently sg+csum driver support has been added to
Acenic, 3c59x, sunhme, and loopback drivers.  We had eepro100
support coded at one point, but it was removed because we didn't know
how to identify the cards which support hw csum assist vs. ones
which could not.

I would like people to test this hard and report bugs they may
discover.  _PLEASE_ try to see if 2.4.0 without this patch produces
the same problem, and if so report it is a 2.4.0 bug _not_ as a
bug in the zerocopy patch.  Thank you.

In particular, I am interested in hearing about any new breakage
caused by the zerocopy patches when using netfilter.  When reporting
bugs, please note what networking cards you are using as whether the
card actually is using hw csum assist and sg support is an important
data point.

Finally, regardless of networking card, there should be a measurable
performance boost for NFS clients with this patch due to the delayed
fragment coalescing.  KNFSD does not take full advantage of this
facility yet.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
