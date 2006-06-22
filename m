Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWFVI3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWFVI3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWFVI3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:29:43 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:55044 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932346AbWFVI3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:29:42 -0400
Date: Thu, 22 Jun 2006 18:29:31 +1000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, snakebyte@gmx.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: Memory corruption in 8390.c ? (was Re: Possible leaks in network drivers)
Message-ID: <20060622082931.GA26083@gondor.apana.org.au>
References: <1150909982.15275.100.camel@localhost.localdomain> <E1FtDU0-0005nd-00@gondolin.me.apana.org.au> <20060622023029.GA6156@gondor.apana.org.au> <449A533E.4090201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449A533E.4090201@pobox.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:22:22AM -0400, Jeff Garzik wrote:
> 
> >it if needed.  Actually, someone should sift through every instance of
> >skb_pad on a non-linear skb as they do not fit the reasons why this was
> >originally created.
> 
> Non-linear skbs smaller than ETH_ZLEN seem unlikely.

When I was grepping it seems that a few drivers were using it with
a length other than ETH_ZLEN.  I've just done another grep and here
are the potential suspects:

cassini.c
starfire.c
yellowfin.c

Also, the skb_pad in drivers/s390/net/claw.c didn't check for errors
at all.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
