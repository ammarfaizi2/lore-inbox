Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992733AbWJTT1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992733AbWJTT1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992729AbWJTT1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:27:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53467
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992723AbWJTT1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:27:53 -0400
Date: Fri, 20 Oct 2006 12:27:53 -0700 (PDT)
Message-Id: <20061020.122753.45515833.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020084015.5c559326@localhost.localdomain>
References: <20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
	<20061020084015.5c559326@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 20 Oct 2006 08:40:15 -0700

> The only user of the drop hook was netconsole, and I fixed that path.
> This probably breaks netdump, but that is out of tree, so it needs
> to fix itself.

I believe that netdump needs to requeue things because dropping the
packet is simply not allowed, and the ->drop callback gives the
netdump code a way to handle things without actually dropping the
packet.  If that's true, you can't just free the SKB on it.

Are you sure your new TX strategy can avoid such drops properly?

Please take a quick peek at the netdump code, it's available, and make
some reasonable effort to determine whether it can still work with
your new code.
