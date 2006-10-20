Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992736AbWJTTbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992736AbWJTTbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992739AbWJTTbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:31:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992738AbWJTTbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:31:41 -0400
Date: Fri, 20 Oct 2006 12:31:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020123137.3cd765af@freekitty>
In-Reply-To: <20061020.122753.45515833.davem@davemloft.net>
References: <20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
	<20061020084015.5c559326@localhost.localdomain>
	<20061020.122753.45515833.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 12:27:53 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 20 Oct 2006 08:40:15 -0700
> 
> > The only user of the drop hook was netconsole, and I fixed that path.
> > This probably breaks netdump, but that is out of tree, so it needs
> > to fix itself.
> 
> I believe that netdump needs to requeue things because dropping the
> packet is simply not allowed, and the ->drop callback gives the
> netdump code a way to handle things without actually dropping the
> packet.  If that's true, you can't just free the SKB on it.
> 
> Are you sure your new TX strategy can avoid such drops properly?

Yes, it has a queue. if it can't send it waits and retries.

> 
> Please take a quick peek at the netdump code, it's available, and make
> some reasonable effort to determine whether it can still work with
> your new code.

Where, I'm not digging in side some RHEL rpm patch pile to find it.

-- 
Stephen Hemminger <shemminger@osdl.org>
