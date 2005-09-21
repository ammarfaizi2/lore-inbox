Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVIUIPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVIUIPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIUIPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:15:46 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:45065 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750736AbVIUIPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:15:45 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: RFC: struct netdevice changes for IPoIB UC support
Cc: openib-general@openib.org, netdev@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, gdror@mellanox.co.il
Organization: Core
In-Reply-To: <20050921080230.GE18449@mellanox.co.il>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EHzlD-0004eE-00@gondolin.me.apana.org.au>
Date: Wed, 21 Sep 2005 18:15:23 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> Please comment on this approach: does it make sense to you guys?
> Please Cc me directly, I'm not on the list.

Sorry, this doesn't make sense.  
 
> static inline u32 dst_mtu(const struct dst_entry *dst)
> {
> -       u32 mtu = dst_metric(dst, RTAX_MTU);
> +       u32 mtu;
> +       if (dst->dev && dst->dev->get_mtu)
> +               mtu = dst->dev->get_mtu(dst->dev, dst->neighbour,
> +                                       dst_metric(dst, RTAX_MTU));
> +       else
> +               mtu = dst_metric(dst, RTAX_MTU);

>From this I gather that for a given dst the MTU is actually constant.
That is, it only varies across different dst's.

In this case you should calculate the correct MTU when the dst is
created rather than here.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
