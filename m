Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946057AbWKADvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946057AbWKADvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 22:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423936AbWKADvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 22:51:15 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:47883 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1423933AbWKADvO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 22:51:14 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: andy@greyhouse.net (Andy Gospodarek)
Subject: Re: [PATCH] 2.6.19-rc4 - netlink messages created with bad flags in soft_irq context
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <20061031220559.GA10119@gospo.rdu.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Gf77x-0002Qt-00@gondolin.me.apana.org.au>
Date: Wed, 01 Nov 2006 14:50:57 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gospodarek <andy@greyhouse.net> wrote:
> I've got a kernel built where 
> 
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> 
> is in the config and I've noticed some interesting behavior when
> bringing up bonds in balance-alb mode.  When I start to enslave devices
> to a bond I get the following in the ring buffer:
> 
> BUG: sleeping function called from invalid context at mm/slab.c:3007
> in_atomic():1, irqs_disabled():0
> 
> along with a nice backtrace of the error that pointed to the cause of
> this message.  The bonding code was calling for the device to set its
> MAC address and the netlink message that would be send as a result of
> this notification was being created with the flag GFP_KERNEL instead of
> GFP_ATOMIC.  

The bonding driver is known to be broken in places where it tries to
call into the network stack in atomic contexts where it shouldn't.

So please verify whether this is the case here before changing netlink.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
