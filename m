Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289615AbSAOTqD>; Tue, 15 Jan 2002 14:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289619AbSAOTpZ>; Tue, 15 Jan 2002 14:45:25 -0500
Received: from mail.ivmg.net ([64.209.84.66]:1290 "EHLO pefw00.ivmg.net")
	by vger.kernel.org with ESMTP id <S289610AbSAOTpM>;
	Tue, 15 Jan 2002 14:45:12 -0500
Date: Tue, 15 Jan 2002 11:45:10 -0800 (PST)
From: Wilson Yeung <wilson@netvmg.com>
To: linux-kernel@vger.kernel.org
Subject: high resolution timer for packet timestamping
Message-ID: <Pine.LNX.4.44.0201151130130.18391-100000@pimx00.ivmg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This topic has been brought up before, but I'm wondering where the current
state of affairs is on this.

I have a need to perform high resolution timestamping on received packets
(traffic measurement).  I realize that interrupt latency may prevent me
from getting a truly accurate timestamp, but best effort here seems to be
better than not-so-best effort.

In the netif_rx() function of net/core/dev.c, the lines:

	if (skb->stamp.tv_sec == 0)
		get_fast_time(&skb->stamp);

could be replaced with something like:

	if (hires_rx_timestamp)
		do_gettimeofday(&skb->stamp);
	else
		get_fast_time(&skb->stamp);

where, say, "hires_rx_timestamp" is a sysctl tunable variable exposed via
/proc/sys/net/core/hires_rx_timestamp.

One of the drawbacks of this approach (I think) is that the runtime
configurable parameter has system level performance implications rather
than socket specific performance implications.

Alternatively, the high res timestamp can be done in the protocol layer,
but this makes it even further away from the device driver.

I'm at a bit of a loss regarding what the best approach is.  Would like
some feedback.  I'd be happy to submit a proper patch.

Thanks.

PS. I'm having some trouble successfully subscribing to the list, so for
the time being, please cc my email address.

