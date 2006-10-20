Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992534AbWJTHP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992534AbWJTHP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992536AbWJTHP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:15:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58582
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992534AbWJTHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:15:28 -0400
Date: Fri, 20 Oct 2006 00:15:30 -0700 (PDT)
Message-Id: <20061020.001530.35664340.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019171814.281988608@osdl.org>
References: <20061019171541.062261760@osdl.org>
	<20061019171814.281988608@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 19 Oct 2006 10:15:43 -0700

> The original skb management for netpoll was a mess, it had two queue paths
> and a callback. This changes it to have a per-instance transmit queue
> and use a tasklet rather than a work queue for the congested case.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

I think you mis-diffed this one:

- 	WARN_ON(skb->protocol == 0);

That line doesn't exist in my copy of net/core/netpoll.c
even with your first patch applied.

Also, you forgot to remove the ->drop callback pointer
from struct netpoll, which you should do if it really
isn't used any more.

I think you might run into problems there, as I believe the netdump
stuff does make non-trivial use of the ->drop callback.  Indeed, it
uses the ->dump callback for invoking a special
netpoll_start_netdump() function.  I'm pretty sure ->dump was created
specifically to accomodate netdump.

So this is something else which will need to be worked out before we
can apply this patch.
