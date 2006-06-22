Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWFVBmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWFVBmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWFVBmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:42:05 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:21517 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030490AbWFVBmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:42:04 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: snakebyte@gmx.de (Eric Sesterhenn)
Subject: Re: Possible leaks in network drivers
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       kmliu@sis.com
Organization: Core
In-Reply-To: <1150912256.8784.4.camel@alice>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1FtECe-00064K-00@gondolin.me.apana.org.au>
Date: Thu, 22 Jun 2006 11:41:52 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn <snakebyte@gmx.de> wrote:
> 
> So something like this would be the correct fix for the example?
> 
> Fix skb leak found by coverity checker (id #628), skb_put() might
> return a new skb, which gets never freed when we return with
> NETDEV_TX_BUSY. This patch moves the check above the skb_put().

This is bogus.  NETDEV_TX_BUSY is meant to requeue the skb.
The real problem is that copying the skb is simply wrong.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
