Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHNLWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHNLWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:22:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28363
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751987AbWHNLWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:22:09 -0400
Date: Mon, 14 Aug 2006 04:22:06 -0700 (PDT)
Message-Id: <20060814.042206.85411651.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060814110359.GA27704@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Mon, 14 Aug 2006 15:04:03 +0400

>  	/* These elements must be at the end, see alloc_skb() for details.  */
> -	unsigned int		truesize;
> +	unsigned int		truesize, __tsize;

There is no real need for new member.

> -		kfree(skb->head);
> +		avl_free(skb->head, skb->__tsize);

Just use "skb->end - skb->head + sizeof(struct skb_shared_info)"
as the size argument.

Then, there is no reason for skb->__tsize :-)
