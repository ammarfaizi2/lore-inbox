Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWIROJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWIROJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWIROJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:09:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49868
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965246AbWIROJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:09:12 -0400
Date: Mon, 18 Sep 2006 07:09:05 -0700 (PDT)
Message-Id: <20060918.070905.98863400.davem@davemloft.net>
To: ak@suse.de
Cc: master@sectorb.msk.ru, hawk@diku.dk, harry@atmos.washington.edu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
From: David Miller <davem@davemloft.net>
In-Reply-To: <p73eju94htu.fsf@verdi.suse.de>
References: <p73k6414lnp.fsf@verdi.suse.de>
	<20060918090330.GA9850@tentacle.sectorb.msk.ru>
	<p73eju94htu.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 11:58:21 +0200

> For netdev: I'm more and more thinking we should just avoid the
> problem completely and switch to "true end2end" timestamps. This
> means don't time stamp when a packet is received, but only when it
> is delivered to a socket. The timestamp at receiving is a lie
> anyways because the network hardware can add an arbitary long delay
> before the driver interrupt handler runs. Then the problem above
> would completely disappear.

I don't think this is wise.

People who run tcpdump want "wire" timestamps as close as possible.
Yes, things get delayed with the IRQ path, DMA delays, IRQ
mitigation and whatnot, but it's an order of magnitude worse if
you delay to user read() since that introduces also the delay of
the packet copies to userspace which are significantly larger than
these hardware level delays.  If tcpdump gets swapped out, the
timestamp delay can be on the order of several seconds making it
totally useless.

Andi, you will need to find another solution to this problem :-)

