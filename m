Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWHNLdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWHNLdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWHNLdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:33:23 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:24793 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752001AbWHNLdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:33:21 -0400
Date: Mon, 14 Aug 2006 15:32:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060814113256.GB27132@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <20060814.042206.85411651.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060814.042206.85411651.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 15:33:00 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 04:22:06AM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Mon, 14 Aug 2006 15:04:03 +0400
> 
> >  	/* These elements must be at the end, see alloc_skb() for details.  */
> > -	unsigned int		truesize;
> > +	unsigned int		truesize, __tsize;
> 
> There is no real need for new member.
> 
> > -		kfree(skb->head);
> > +		avl_free(skb->head, skb->__tsize);
> 
> Just use "skb->end - skb->head + sizeof(struct skb_shared_info)"
> as the size argument.
> 
> Then, there is no reason for skb->__tsize :-)

Oh, my fault - that simple calculation dropped out of my head...

-- 
	Evgeniy Polyakov
