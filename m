Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWJTPTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWJTPTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWJTPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751084AbWJTPTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:19:06 -0400
Date: Fri, 20 Oct 2006 08:18:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020081857.743b5eb7@localhost.localdomain>
In-Reply-To: <20061020.001530.35664340.davem@davemloft.net>
References: <20061019171541.062261760@osdl.org>
	<20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 00:15:30 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Thu, 19 Oct 2006 10:15:43 -0700
> 
> > The original skb management for netpoll was a mess, it had two queue paths
> > and a callback. This changes it to have a per-instance transmit queue
> > and use a tasklet rather than a work queue for the congested case.
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> 
> I think you mis-diffed this one:
> 
> - 	WARN_ON(skb->protocol == 0);
> 
> That line doesn't exist in my copy of net/core/netpoll.c
> even with your first patch applied.
> 
> Also, you forgot to remove the ->drop callback pointer
> from struct netpoll, which you should do if it really
> isn't used any more.
> 
> I think you might run into problems there, as I believe the netdump
> stuff does make non-trivial use of the ->drop callback.  Indeed, it
> uses the ->dump callback for invoking a special
> netpoll_start_netdump() function.  I'm pretty sure ->dump was created
> specifically to accomodate netdump.
> 

Netdump is not in the tree, so I can't fix it. Also netdump is pretty
much superseded by kdump.

> So this is something else which will need to be worked out before we
> can apply this patch.
