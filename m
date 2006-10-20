Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946466AbWJTUOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946466AbWJTUOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422980AbWJTUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:14:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422887AbWJTUOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:14:17 -0400
Date: Fri, 20 Oct 2006 13:14:09 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020131409.0a336a56@freekitty>
In-Reply-To: <20061020.125226.59656580.davem@davemloft.net>
References: <20061020081857.743b5eb7@localhost.localdomain>
	<20061020.122427.55507415.davem@davemloft.net>
	<20061020122527.56292b56@dxpl.pdx.osdl.net>
	<20061020.125226.59656580.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 12:52:26 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 20 Oct 2006 12:25:27 -0700
> 
> > Sorry, but why should we treat out-of-tree vendor code any
> > differently than out-of-tree other code.
> 
> I think what netdump was trying to do, provide a way to
> requeue instead of fully drop the SKB, is quite reasonable.
> Don't you think?

Yes, but the queued vs non-queued stuff showed up out of order.
The queued messages go through the wrong Tx path. ie. they end up
going into to NIT etc, since the deferred send uses a work queue
it wouldn't work for last-gasp messages or netdump since getting
a work queue to run requires going back to scheduler and processes
running... and it should use skb_buff_head instead
of roll your own queueing.

The other alternative would be to make the send logic non-blocking
and fully push retry to the caller.

I'll make a fix to netdump, if I can find it.

-- 
Stephen Hemminger <shemminger@osdl.org>
