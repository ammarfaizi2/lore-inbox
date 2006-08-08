Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWHHS1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWHHS1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWHHS1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:27:08 -0400
Received: from possum.icir.org ([192.150.187.67]:17671 "EHLO possum.icir.org")
	by vger.kernel.org with ESMTP id S1750840AbWHHS1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:27:07 -0400
Message-Id: <200608081826.k78IQiZM084824@possum.icir.org>
To: David Miller <davem@davemloft.net>
cc: pavlin@icir.org, linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: Bug in the RTM_SETLINK kernel API for setting MAC address 
In-Reply-To: Message from David Miller <davem@davemloft.net> 
   of "Mon, 07 Aug 2006 23:35:29 PDT." <20060807.233529.58454613.davem@davemloft.net> 
Date: Tue, 08 Aug 2006 11:26:44 -0700
From: Pavlin Radoslavov <pavlin@icir.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> > The real mismatch is that ida[IFLA_ADDRESS - 1] is (as you say)
> > suppose to be a MAC address, but the set_mac_address() functions
> > for each device assume that the RTA_DATA(ida[IFLA_ADDRESS - 1])
> > payload is a sockaddr.
> 
> That's because ->set_mac_address() is usually invoked via
> dev_set_mac_address() which in turn is invoked from places
> SIOCSIFHWADDR ioctl() processing which does want the sockaddr
> wrapped around the MAC address.
> 
> So the netlink code is definitely doing the wrong thing if
> it wants merely the MAC address in the attribute.
> 
> Since changing all the drivers is a pain, what we probably
> should do is have the netlink code allocate a sockaddr,
> place the MAC address attribute in to that allocated sockaddr,
> and pass it into ->set_mac_address().
> 
> This patch should do the trick, can you test it out?

Yes, it works.

Can I presume that the fix will be in the next kernel release
(2.6.17.8 or 2.6.18), so we will know to reverse our userland
work-around changes when the kernel is out.

Thanks,
Pavlin
