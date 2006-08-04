Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWHDBGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWHDBGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWHDBGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:06:25 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:30985 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751275AbWHDBGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:06:24 -0400
Date: Fri, 4 Aug 2006 11:05:50 +1000
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060804010550.GA12085@gondor.apana.org.au>
References: <E1G8der-0001fm-00@gondolin.me.apana.org.au> <44D214D2.70206@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D214D2.70206@linux.intel.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:22:58AM -0700, Arjan van de Ven wrote:
>
> however I'm not quite yet convinced that this patch is going to solve
> this particular deadlock.
> (I agree with the principle of it and I think it's really needed,
> I just don't yet see how it's going to solve this specific deadlock. But
> then again it's early and I've not had sufficient coffee yet so I could
> well be wrong)

Well it solves the dead lock by breaking the chain that links the
netlink system with the jungle of wireless locking :)

The spin lock in sk_buff_head acts as a mediator.  We only feed the
skb to the netlink system once that spin lock has been dropped.
 
> it's not just about irq context, it's about being called with any lock 
> that's
> used in IRQ context; that is what makes this double nasty...

Yes it is nasty.  However, so far wireless seems to be the only offender.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
