Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVBJE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVBJE6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBJE6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:58:15 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:32015 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262022AbVBJE6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:58:10 -0500
Date: Thu, 10 Feb 2005 15:56:47 +1100
To: Werner Almesberger <wa@almesberger.net>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, okir@suse.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050210045647.GA15552@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203150821.2321130b.davem@davemloft.net> <20050204113305.GA12764@gondor.apana.org.au> <20050204154855.79340cdb.davem@davemloft.net> <20050204222428.1a13a482.davem@davemloft.net> <20050210012304.E25338@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210012304.E25338@almesberger.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 01:23:04AM -0300, Werner Almesberger wrote:
> 
> What happens if the operation could return a value, but the user
> ignores it ? E.g. if I don't like smp_mb__*, could I just use
> 
> 	atomic_inc_and_test(foo);
> 
> instead of
> 
> 	smp_mb__before_atomic_inc();
> 	atomic_inc(foo);
> 	smp_mb__after_atomic_dec();

Yes you can.

> ? If yes, is this a good idea ?

Dave mentioned that on sparc64, atomic_inc_and_test is much more
expensive than the second variant.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
