Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbRDSAm1>; Wed, 18 Apr 2001 20:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135492AbRDSAmR>; Wed, 18 Apr 2001 20:42:17 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:15549 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S135491AbRDSAmH>;
	Wed, 18 Apr 2001 20:42:07 -0400
Date: Thu, 19 Apr 2001 09:42:01 +0900 (JST)
Message-Id: <200104190042.JAA23614@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: linux-kernel@vger.kernel.org
Subject: ARP handling in case of having multiple interfaces on same segment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime, we have setting like following (say, in the migration
process of changing IP networks, or perhaps wrong way of load
balancing):

	+----------+
	|eth0 eth1 |
	+----------+
	   |   |
    -------+---+------------

Current implementation of Linux doesn't handle this case.  The problem
is ARP handling.  When ARP broadcast packet comes to the host, both
interfaces receive the packet, and regardless of the device, we reply
to that packet.  I think that we should not reply if the packet is not
related to that interface.  If the ARP request is for eth1's address, 
we should not send reply from eth0.

IIRC, I had fixed this issue six years ago, but now see same thing.
Kind a dejagnu...

How do you think?  For me, this is bug.
-- 
