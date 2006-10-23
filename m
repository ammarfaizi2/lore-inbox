Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWJWDmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWJWDmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJWDmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:42:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14026
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751401AbWJWDmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:42:18 -0400
Date: Sun, 22 Oct 2006 20:42:20 -0700 (PDT)
Message-Id: <20061022.204220.78710782.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] netpoll: use sk_buff_head for txq
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020153027.3bed8c86@dxpl.pdx.osdl.net>
References: <20061020134826.75dd1cba@freekitty>
	<20061020.140149.125893169.davem@davemloft.net>
	<20061020153027.3bed8c86@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 20 Oct 2006 15:30:27 -0700

> +		spin_lock_irqsave(&netpoll_txq.lock, flags);
> +		for (skb = (struct sk_buff *)netpoll_txq.next;
> +		     skb != (struct sk_buff *)&netpoll_txq; skb = next) {
> +			next = skb->next;
> +			if (skb->dev == dev)
> +				skb_unlink(skb, &netpoll_txq);
> +		}
> +		spin_unlock_irqrestore(&netpoll_txq.lock, flags);
>  	}

All SKBs removed here will be leaked, nothing frees them up.

Since #2 and #3 depend upon this patch, I'll hold off on those
until you fix this bug.

Thanks.
