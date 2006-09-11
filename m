Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWIKIVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWIKIVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWIKIVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:21:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:64934 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751255AbWIKIVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:21:04 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1157953925.31071.413.camel@localhost.localdomain>
References: <1551EAE59135BE47B544934E30FC4FC093FB2C@NT-IRVA-0751.brcm.ad.broadcom.com>
	 <1157953925.31071.413.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 18:20:48 +1000
Message-Id: <1157962848.3879.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it seems like we might have more than just the missing barrier in
TG3. Possibly some IOMMU problems on some machines as well.
Unfortunately, I don't have a tg3 on a PCI-X or PCI-E card to test on a
pSeries or some other machine.

[Olof: I've disabled the new U4 DART invalidate code (reverted to the
old one) and added an unconditional barrier to dart_flush and I yet have
to reproduce the problem. I suspect a problem with the DART invalidate
one thingy, maybe a HW problem with the U4 chip. Now regarding the
barrier in flush, we'll talk about it later, I think we might have a
problem with the way we do the DART accesses (they might leak out of the
lock) though I yet have to see that cause a problem in practice due to
the round-robin nature of our allocation algorithm.]

Ben.


